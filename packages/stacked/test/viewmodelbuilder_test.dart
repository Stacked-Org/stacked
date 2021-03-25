import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';

class TestViewModel extends BaseViewModel {}

Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}

void main() {
  group('ViewModelBuilder', () {
    group('Reactivity Tests', () {
      testWidgets(
          'When constructed with nonReactive shouldn\'t rebuild when notifyListerens is called',
          (WidgetTester tester) async {
        int buildCounter = 0;
        var testViewModel = TestViewModel();
        var widget =
            buildTestableWidget(ViewModelBuilder<TestViewModel>.nonReactive(
                builder: (context, model, child) {
                  buildCounter++;
                  return Scaffold();
                },
                viewModelBuilder: () => testViewModel));

        await tester.pumpWidget(widget);
        testViewModel.notifyListeners();
        await tester.pumpWidget(widget);
        testViewModel.notifyListeners();
        await tester.pumpWidget(widget);
        testViewModel.notifyListeners();
        await tester.pumpWidget(widget);
        testViewModel.notifyListeners();
        await tester.pumpWidget(widget);
        testViewModel.notifyListeners();
        await tester.pumpWidget(widget);
        testViewModel.notifyListeners();
        await tester.pumpWidget(widget);

        expect(buildCounter, 1);
      });

      testWidgets(
          'When constructed with reactive rebuild when notifyListerens is called',
          (WidgetTester tester) async {
        int buildCounter = 0;
        var testViewModel = TestViewModel();
        var widget =
            buildTestableWidget(ViewModelBuilder<TestViewModel>.reactive(
                builder: (context, model, child) {
                  buildCounter++;
                  return Scaffold();
                },
                viewModelBuilder: () => testViewModel));
        await tester.pumpWidget(widget);
        testViewModel.notifyListeners();
        await tester.pumpWidget(widget);
        testViewModel.notifyListeners();
        await tester.pumpWidget(widget);
        testViewModel.notifyListeners();
        await tester.pumpWidget(widget);

        expect(buildCounter, 4);
      });

      testWidgets(
          'When constructed after dispose, should trigger viewmodel builder again',
          (WidgetTester tester) async {
        final stateKey = GlobalKey<State<ViewModelBuilder<TestViewModel>>>();
        int buildCounter = 0;
        var testViewModel = TestViewModel();
        var widget = ViewModelBuilder<TestViewModel>.reactive(
          builder: (context, model, child) {
            return Container();
          },
          viewModelBuilder: () {
            buildCounter++;
            return testViewModel;
          },
          key: stateKey,
        );
        await tester.pumpWidget(widget);

        stateKey.currentState!.dispose();
        await tester.pumpWidget(widget);

        stateKey.currentState!.reassemble();
        await tester.pumpWidget(widget);

        stateKey.currentState!.initState();
        await tester.pumpWidget(widget);

        expect(buildCounter, 2);
      }, skip: true);
    });
  });
}
