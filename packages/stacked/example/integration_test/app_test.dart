import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:new_architecture/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('app testing', (WidgetTester tester) async {
      // Arrange
      // Build our app and trigger a frame.
      app.main();
      await tester.pumpAndSettle();

      // Widgets and states text
      // Home View Widgets
      final initialisedText = find.text('Initialised');
      final widgetOne = find.text('Tap to increment');
      final widgetTwo = find.text('Tap to Reset');

      // Non Reactive View Widgets
      final nonReactiveTitle = find.text('Non Reactive View');
      final goToStreamCounterButton = find.text('Go to stream counter view');
      final title = find.text('This should not change');

      // Stream Counter View Widgets
      final streamCounterTitle = find.text('Stream Counter View');
      final streamSourceButton = find.text('Change Stream Sources');
      final streamSlowSourceText = find.text('Slow');
      final streamFastSourceText = find.text('Fast');

      // General Widgets
      final fab = find.byType(FloatingActionButton);

      // Home View Test
      tester.printToConsole('Home view Testing');

      // Verify the widgets are present.
      tester.printToConsole('Verify the widgets are present');
      expect(initialisedText, findsOneWidget);
      expect(widgetOne, findsOneWidget);
      expect(widgetTwo, findsOneWidget);
      expect(fab, findsOneWidget);

      // Emulate a tap on the widget one button 3 times.
      tester.printToConsole('Emulating tap on widget one button');
      await tester.tap(widgetOne);
      await tester.tap(widgetOne);
      await tester.tap(widgetOne);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the widget one and two text has been updated to 3.
      tester.printToConsole(
          'Verifying widget one and two text has been updated to 3');
      expect(find.text('3'), findsWidgets);

      // Emulate a tap on the widget two button to reset the counter.
      tester.printToConsole('Emulating tap on widget two button');
      await tester.tap(widgetTwo);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the widget one and two text has been updated to 0.
      tester.printToConsole(
          'Verifying widget one and two text has been updated to 0');
      expect(find.text('0'), findsWidgets);

      // Emulate a tap on the fab button to navigate to the second view.
      tester.printToConsole('Emulating tap on fab button');
      await tester.tap(fab);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the widget are not present.
      tester.printToConsole('Verify the widgets are not present');
      expect(widgetTwo, findsNothing);
      expect(widgetOne, findsNothing);

      // Non Reactive View Test
      tester.printToConsole('Non Reactive view Testing');

      // Verify the widgets are present.
      tester.printToConsole('Verify the widgets are present');
      expect(nonReactiveTitle, findsOneWidget);
      expect(goToStreamCounterButton, findsOneWidget);
      expect(title, findsOneWidget);
      expect(fab, findsOneWidget);

      // Emulate a tap on FAB button
      tester.printToConsole('Emulating tap on FAB button');
      await tester.tap(fab);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the title didn't update.
      tester.printToConsole('Verify the title didn\'t update');
      expect(title, findsOneWidget);

      // Emulate a tap on the go to stream counter button.
      tester.printToConsole('Emulating tap on the go to stream counter button');
      await tester.tap(goToStreamCounterButton);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the widgets are not present.
      tester.printToConsole('Verify the widgets are not present');
      expect(nonReactiveTitle, findsNothing);
      expect(goToStreamCounterButton, findsNothing);
      expect(title, findsNothing);

      // Stream Counter View Test
      tester.printToConsole('Stream Counter view Testing');

      // Verify the widgets are present.
      tester.printToConsole('Verify the widgets are present');
      expect(streamCounterTitle, findsOneWidget);
      expect(streamSourceButton, findsOneWidget);
      expect(streamSlowSourceText, findsOneWidget);

      // Emulate a tap on the stream source button.
      tester.printToConsole('Emulating tap on the stream source button');
      await tester.tap(streamSourceButton);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify it has changed to the fast source.
      tester.printToConsole('Verify it has changed to the fast source');
      expect(streamFastSourceText, findsOneWidget);
      expect(streamSlowSourceText, findsNothing);

      // Emulate a tap on the back button.
      tester.printToConsole('Emulating tap on the back button');
      await tester.pageBack();
      // Trigger a frame.
      await tester.pumpAndSettle();
      tester.printToConsole('Navigating back to non reactive view');

      // Verify the widgets are not present.
      tester.printToConsole('Verify the widgets are not present');
      expect(streamCounterTitle, findsNothing);
      expect(streamSourceButton, findsNothing);

      // Emulate a tap on the back button.
      tester.printToConsole('Emulating tap on the back button');
      await tester.pageBack();
      // Trigger a frame.
      await tester.pumpAndSettle();
      tester.printToConsole('Navigating back to home view');

      // Verify the home view widgets are present.
      tester.printToConsole('Verify the home view widgets are present');
      expect(widgetOne, findsOneWidget);
      expect(widgetTwo, findsOneWidget);

      // Emulate a tap on the widget one button
      tester.printToConsole('Emulating tap on the widget one button');
      await tester.tap(widgetOne);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the widget one and two text has been updated to 1.
      tester.printToConsole(
          'Verify the widget one and two text has been updated to 1');
      expect(find.text('1'), findsWidgets);

      tester.printToConsole('Test completed successfully 🎉');
    });
  });
}
