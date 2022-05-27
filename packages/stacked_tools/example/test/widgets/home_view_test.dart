import 'package:example/app/app.locator.dart';
import 'package:example/ui/views/home/home_view.dart';
import 'package:example/ui/views/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.dart';
import 'widget_wrapper.dart';

void main() {
  group('HomeView', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    testWidgets(
      'when initialized, should show a welcome message',
      (WidgetTester tester) async {
        final viewmodel = MockViewModel();
        await tester.pumpWidget(WidgetWrapper(
          view: HomeView.create(viewmodel: viewmodel),
        ));
        expect(
          find.text('Hello, STACKED!'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'when initialized, should show a MaterialButton with Show Dialog text',
      (WidgetTester tester) async {
        final viewmodel = MockViewModel();
        await tester.pumpWidget(WidgetWrapper(
          view: HomeView.create(viewmodel: viewmodel),
        ));
        expect(
          find.text('Show Dialog'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'when initialized, should show a MaterialButton with Show Bottom Sheet',
      (WidgetTester tester) async {
        final viewmodel = MockViewModel();
        await tester.pumpWidget(WidgetWrapper(
          view: HomeView.create(viewmodel: viewmodel),
        ));
        expect(
          find.text('Show Bottom Sheet'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'when initialized, should show a counter label message',
      (WidgetTester tester) async {
        final viewmodel = MockViewModel();
        await tester.pumpWidget(WidgetWrapper(
          view: HomeView.create(viewmodel: viewmodel),
        ));
        expect(
          find.text(viewmodel.counterLabel),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'when initialized, should show 3 MaterialButtons with Text',
      (WidgetTester tester) async {
        final viewmodel = MockViewModel();
        await tester.pumpWidget(WidgetWrapper(
          view: HomeView.create(viewmodel: viewmodel),
        ));
        expect(
          find.descendant(
            of: find.byType(MaterialButton),
            matching: find.byType(Text),
          ),
          findsNWidgets(3),
        );
      },
    );

    testWidgets(
      'when incrementCounter is tapped once, should show 1 as counter value',
      (WidgetTester tester) async {
        final viewmodel = MockViewModel();
        await tester.pumpWidget(WidgetWrapper(
          view: HomeView.create(viewmodel: viewmodel),
        ));
        expect(
          find.widgetWithText(MaterialButton, 'Counter is: 0'),
          findsOneWidget,
        );
        await tester.tap(find.widgetWithText(MaterialButton, 'Counter is: 0'));
        await tester.pump();
        expect(
          find.widgetWithText(MaterialButton, 'Counter is: 0'),
          findsNothing,
        );
        expect(
          find.widgetWithText(MaterialButton, 'Counter is: 1'),
          findsOneWidget,
        );
      },
    );
  });
}

class MockViewModel extends HomeViewModel {
  @override
  final bool isBusy;

  MockViewModel({this.isBusy = false});

  // ignore: prefer_final_fields
  int _counter = 0;

  @override
  String get counterLabel => 'Counter is: $_counter';

  @override
  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  @override
  void showDialog() {}

  @override
  void showBottomSheet() {}
}
