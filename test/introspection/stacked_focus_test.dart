import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_shared/stacked_introspection.dart';

class _ScreenVm extends BaseViewModel {
  int count = 0;
  void increment() {
    count++;
    notifyListeners();
  }
}

class _SecondVm extends BaseViewModel {}

class _DialogVm extends BaseViewModel {}

class _ChildVm extends BaseViewModel {}

class _UnregisteredVm extends BaseViewModel {}

/// The ViewModel of a page that builds its own ViewModelBuilder instead of
/// extending StackedView, so the generator describes it as a widget.
class _PageVm extends BaseViewModel {}

class _FakeProvider extends LentActionProvider {
  @override
  String get id => 'fake';

  @override
  bool get isActive => true;

  @override
  Map<String, Object?>? get overlay => {'type': 'fake'};

  @override
  List<ActionSpec> get actions => [
        ActionSpec(name: 'ping', invoke: (_) {}),
      ];
}

void _registerAll() {
  StackedIntrospector.instance.register<_ScreenVm>(IntrospectionEntry(
    kind: NodeKind.route,
    describe: (vm) => StackedNode(
      name: '_ScreenVm',
      kind: NodeKind.route,
      state: {'count': vm.count},
      actions: [ActionSpec(name: 'increment', invoke: (_) => vm.increment())],
    ),
  ));
  StackedIntrospector.instance.register<_SecondVm>(IntrospectionEntry(
    kind: NodeKind.route,
    describe: (vm) =>
        const StackedNode(name: '_SecondVm', kind: NodeKind.route),
  ));
  StackedIntrospector.instance.register<_DialogVm>(IntrospectionEntry(
    kind: NodeKind.dialog,
    describe: (vm) =>
        const StackedNode(name: '_DialogVm', kind: NodeKind.dialog),
  ));
  StackedIntrospector.instance.register<_PageVm>(IntrospectionEntry(
    kind: NodeKind.widget,
    describe: (vm) => const StackedNode(name: '_PageVm', kind: NodeKind.widget),
  ));
  StackedIntrospector.instance.register<_ChildVm>(IntrospectionEntry(
    kind: NodeKind.widget,
    describe: (vm) =>
        const StackedNode(name: '_ChildVm', kind: NodeKind.widget),
  ));
}

class _ScreenView extends StatelessWidget {
  const _ScreenView({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<_ScreenVm>.reactive(
      viewModelBuilder: () => _ScreenVm(),
      builder: (context, model, _) => Column(
        children: [
          Text('count ${model.count}'),
          if (child != null) child!,
        ],
      ),
    );
  }
}

Widget _builderPage() => ViewModelBuilder<_PageVm>.reactive(
      viewModelBuilder: () => _PageVm(),
      builder: (context, model, _) => Column(
        children: [
          _vmWidget<_ChildVm>(() => _ChildVm()),
          _vmWidget<_UnregisteredVm>(() => _UnregisteredVm()),
        ],
      ),
    );

Widget _vmWidget<T extends BaseViewModel>(T Function() create) =>
    ViewModelBuilder<T>.reactive(
      viewModelBuilder: create,
      builder: (context, model, child) => Text(T.toString()),
    );

void main() {
  setUp(() {
    StackedIntrospector.instance.reset();
    LentActionProviders.reset();
    ViewModelRegistry.instance.reset();
    ViewModelRegistry.enabled = true;
    _registerAll();
  });

  tearDown(() {
    StackedIntrospector.instance.reset();
    LentActionProviders.reset();
    ViewModelRegistry.instance.reset();
  });

  testWidgets('single screen', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: _ScreenView()));

    final node = StackedFocus.node();
    expect(node.name, '_ScreenVm');
    expect(node.kind, NodeKind.route);
    expect(node.state['count'], 0);
    expect(node.lent, isEmpty);
  });

  testWidgets('invoke runs the action', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: _ScreenView()));

    await StackedFocus.invoke('increment');
    await tester.pump();

    expect(StackedFocus.node().state['count'], 1);
  });

  testWidgets('unknown action throws ActionNotFound', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: _ScreenView()));

    expect(
      () => StackedFocus.invoke('nope'),
      throwsA(
        isA<ActionNotFound>()
            .having((e) => e.available, 'available', contains('increment')),
      ),
    );
  });

  testWidgets('pushed route is focused and goBack pops it', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: _ScreenView()));
    expect(StackedFocus.node().name, '_ScreenVm');

    final context = tester.element(find.byType(_ScreenView));
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => _vmWidget<_SecondVm>(() => _SecondVm()),
    ));
    await tester.pumpAndSettle();

    final node = StackedFocus.node();
    expect(node.name, '_SecondVm');
    final goBack = node.lent.where((a) => a.name == 'goBack');
    expect(goBack, hasLength(1));
    expect(goBack.single.from, 'navigator');

    await StackedFocus.invoke('goBack');
    await tester.pumpAndSettle();

    expect(StackedFocus.node().name, '_ScreenVm');
  });

  testWidgets('dialog ViewModel is focused', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: _ScreenView()));

    final context = tester.element(find.byType(_ScreenView));
    showDialog<void>(
      context: context,
      builder: (_) => Dialog(child: _vmWidget<_DialogVm>(() => _DialogVm())),
    );
    await tester.pumpAndSettle();

    final node = StackedFocus.node();
    expect(node.name, '_DialogVm');
    expect(node.kind, NodeKind.dialog);
  });

  testWidgets('nested widget ViewModels become children', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: _ScreenView(child: _vmWidget<_ChildVm>(() => _ChildVm())),
    ));

    final node = StackedFocus.node();
    expect(node.name, '_ScreenVm');
    expect(node.children, hasLength(1));
    expect(node.children.single.name, '_ChildVm');
    expect(node.availableActions, contains('increment'));
  });

  testWidgets('offstage ViewModel is not focused', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Column(
        children: [
          // Hidden one is registered last and would win a tie on order.
          const _ScreenView(),
          Offstage(
            offstage: true,
            child: _vmWidget<_SecondVm>(() => _SecondVm()),
          ),
        ],
      ),
    ));

    expect(StackedFocus.node().name, '_ScreenVm');
  });

  testWidgets('lent provider actions and overlay are included', (tester) async {
    LentActionProviders.register(_FakeProvider());
    await tester.pumpWidget(const MaterialApp(home: _ScreenView()));

    final node = StackedFocus.node();
    final ping = node.lent.where((a) => a.name == 'ping');
    expect(ping, hasLength(1));
    expect(ping.single.from, 'fake');
    expect(node.overlay, {'type': 'fake'});
  });

  testWidgets('no ViewModel on screen', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Text('x')));

    final node = StackedFocus.node();
    expect(node.name, '(none)');
    expect(node.warnings, contains('No ViewModel is on screen.'));
  });

  testWidgets('unregistered ViewModel falls back with a warning',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: _vmWidget<_UnregisteredVm>(() => _UnregisteredVm()),
    ));

    final node = StackedFocus.node();
    expect(node.name, '_UnregisteredVm');
    expect(
      node.warnings.any((w) => w.contains('No introspection generated')),
      isTrue,
    );
  });

  testWidgets(
      'page built with ViewModelBuilder is focused over its widget ViewModels',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: _builderPage()));

    final node = StackedFocus.node();
    expect(node.name, '_PageVm');
    expect(node.kind, NodeKind.route);
    expect(node.children.map((c) => c.name), ['_ChildVm', '_UnregisteredVm']);
  });

  testWidgets('pushed ViewModelBuilder page is focused over a StackedView page',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: _ScreenView()));

    final context = tester.element(find.byType(_ScreenView));
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => _builderPage(),
    ));
    await tester.pumpAndSettle();

    final node = StackedFocus.node();
    expect(node.name, '_PageVm');
    expect(node.kind, NodeKind.route);
    expect(node.lent.map((a) => a.name), contains('goBack'));
  });
}
