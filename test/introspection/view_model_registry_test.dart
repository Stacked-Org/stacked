import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';

class _Vm extends BaseViewModel {}

Widget _app(Widget child) => MaterialApp(home: child);

Widget _screen() => ViewModelBuilder<_Vm>.reactive(
      viewModelBuilder: () => _Vm(),
      builder: (context, model, child) => const Text('screen'),
    );

void main() {
  setUp(() {
    ViewModelRegistry.instance.reset();
    ViewModelRegistry.enabled = true;
  });

  tearDown(() {
    ViewModelRegistry.enabled = true;
    ViewModelRegistry.instance.reset();
  });

  testWidgets('registers a ViewModel when its builder is pumped',
      (tester) async {
    await tester.pumpWidget(_app(_screen()));

    final mounted = ViewModelRegistry.instance.mounted;
    expect(mounted, hasLength(1));
    expect(mounted.single.viewModel, isA<_Vm>());
  });

  testWidgets('unregisters when the widget is removed', (tester) async {
    await tester.pumpWidget(_app(_screen()));
    expect(ViewModelRegistry.instance.mounted, hasLength(1));

    await tester.pumpWidget(_app(const Text('gone')));
    expect(ViewModelRegistry.instance.mounted, isEmpty);
  });

  testWidgets('registers nothing when disabled', (tester) async {
    ViewModelRegistry.enabled = false;

    await tester.pumpWidget(_app(_screen()));

    expect(ViewModelRegistry.instance.mounted, isEmpty);
  });

  testWidgets('keeps registration order', (tester) async {
    await tester.pumpWidget(_app(Column(children: [_screen(), _screen()])));

    final orders =
        ViewModelRegistry.instance.mounted.map((e) => e.order).toList();
    expect(orders, hasLength(2));
    expect(orders[0], lessThan(orders[1]));
  });
}
