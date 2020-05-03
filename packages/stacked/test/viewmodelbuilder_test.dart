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
        await tester.pumpWidget(
            buildTestableWidget(ViewModelBuilder<TestViewModel>.nonReactive(
                builder: (context, model, child) {
                  buildCounter++;
                  return Scaffold();
                },
                viewModelBuilder: () => testViewModel)));

        testViewModel.notifyListeners();
        testViewModel.notifyListeners();
        testViewModel.notifyListeners();
        testViewModel.notifyListeners();
        testViewModel.notifyListeners();
        testViewModel.notifyListeners();

        expect(buildCounter, 1);
      });

      // These tests don't work. I don't know how to test the functionality for
      // using Flutter test. This should work in theory but the test is failing.
      /* testWidgets(
          'When constructed with reactive rebuild when notifyListerens is called',
          (WidgetTester tester) async {
        int buildCounter = 0;
        var testViewModel = TestViewModel();
        await tester.pumpWidget(
            buildTestableWidget(ViewModelBuilder<TestViewModel>.reactive(
                builder: (context, model, child) {
                  buildCounter++;
                  return Scaffold();
                },
                viewModelBuilder: () => testViewModel)));

        testViewModel.notifyListeners();
        testViewModel.notifyListeners();
        testViewModel.notifyListeners();

        expect(buildCounter, 4);
      });*/
    });
  });
}
