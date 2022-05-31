import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:example/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Test', () {
    testWidgets('Ensure all stacked integrations still work as expected',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      app.main();
      await tester.pumpAndSettle();

      // Arrange

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

      // Example Form View Widgets
      final exampleFormTitle = find.text('Example Form View');
      final formLoremText = find.text('Lorem');
      final formPasswordTextField = find.byKey(const ValueKey('passwordField'));
      final passwordErrorText = find.text('Password should not be empty');
      final dobButton = find.text('Select your Date of birth');
      final date = DateTime(DateTime.now().year, DateTime.now().month, 11);
      final dateString = date.toString();
      final dropDownButton = find.byKey(const ValueKey('dropdownField'));
      final dropDownItem = find.text('No').last;
      final dropDownButtonNo = find.text('No');

      // Bottom Navigation Bar Widgets
      final bottomNavigationBar = find.byType(BottomNavigationBar);
      final bottomNavigationBarItemOne = find.text('Favorites');
      final bottomNavigationBarItemTwo = find.text('History');
      final bottomNavigationBarItemThree = find.text('Profile');
      final profileView = find.text('Profile');

      // General Widget
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
      tester.printToConsole('Emulating tap on widget one button 3 times');
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
      tester.printToConsole(
          'Emulating tap on fab button to navigate to the second view');
      await tester.tap(fab);
      // Trigger a frame.
      await tester.pumpAndSettle();

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

      // Stream Counter View Test
      tester.printToConsole('Stream Counter view Testing');

      // Verify the widgets are present.
      tester.printToConsole('Verify the widgets are present');
      expect(streamCounterTitle, findsOneWidget);
      expect(streamSourceButton, findsOneWidget);
      expect(streamSlowSourceText, findsOneWidget);
      expect(fab, findsOneWidget);

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

      // Emulate a tap on the Go to stream counter button.
      tester.printToConsole('Emulating tap on the Go to stream counter button');
      await tester.tap(goToStreamCounterButton);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Emulate a tap on the FAB button.
      tester.printToConsole('Emulating tap on the FAB button');
      await tester.tap(fab);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Example Form View Test
      tester.printToConsole('Example Form View Testing');

      // Verify the widgets are present.
      tester.printToConsole('Verify the widgets are present');

      expect(exampleFormTitle, findsOneWidget);
      expect(formLoremText, findsOneWidget);
      expect(formPasswordTextField, findsOneWidget);
      expect(dobButton, findsOneWidget);
      expect(dropDownButton, findsOneWidget);

      // Emulate a tap on the dob button.
      tester.printToConsole('Emulating tap on the dob button');
      await tester.tap(dobButton);
      // Trigger a frame.
      await tester.pumpAndSettle();
      await tester.tap(find.text('11'));
      await tester.tap(find.text('OK'));
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the dob button has been updated.
      tester.printToConsole('Verify the dob button has been updated');
      expect(find.text(dateString), findsOneWidget);

      // Emulate a tap on the drop down button.
      tester.printToConsole('Emulating tap on the drop down button');
      await tester.tap(dropDownButton);
      // Trigger a frame.
      await tester.pumpAndSettle();
      await tester.tap(dropDownItem);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the drop down button has been updated.
      tester.printToConsole('Verify the drop down button has been updated');
      expect(dropDownButtonNo, findsOneWidget);

      // Emulate entering text into the password text field.
      tester.printToConsole(
          'Emulating entering text into the password text field');
      await tester.enterText(formPasswordTextField, 'password123');
      // Enter empty string in password text field.
      tester.printToConsole(
          'Emulating entering empty string into the password text field');
      await tester.enterText(formPasswordTextField, '');
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the password text field has been updated to empty string.
      tester.printToConsole(
          'Verify the password text field has been updated to empty string');

      expect(find.text('password123'), findsNothing);
      expect(passwordErrorText, findsOneWidget);

      // Emulate navigating to bottom navigation bar view.
      tester
          .printToConsole('Emulating navigating to bottom navigation bar view');
      await tester.tap(fab);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the widgets are present.
      tester.printToConsole('Verify the widgets are present');
      expect(bottomNavigationBar, findsOneWidget);
      expect(bottomNavigationBarItemOne, findsOneWidget);
      expect(bottomNavigationBarItemTwo, findsOneWidget);
      expect(bottomNavigationBarItemThree, findsOneWidget);

      // Emulate a tap on the bottom navigation bar item one.
      tester.printToConsole(
          'Emulating tap on the bottom navigation bar item one');
      await tester.tap(bottomNavigationBarItemOne);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the widgets are present.
      tester.printToConsole('Verify the widgets are present');
      expect(find.text('999'), findsOneWidget);

      // Increase the counter.
      tester.printToConsole('Increasing the counter');
      await tester.tap(fab);
      await tester.tap(fab);
      await tester.tap(fab);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the counter has been increased.
      tester.printToConsole('Verify the counter has been increased');

      expect(find.text('1002'), findsOneWidget);

      // Emulate a tap on the bottom navigation bar item two.
      tester.printToConsole(
          'Emulating tap on the bottom navigation bar item two');
      await tester.tap(bottomNavigationBarItemTwo);
      // Trigger a frame.
      await tester.pump();

      // Verify circular progress indicator is present.
      tester.printToConsole('Verify circular progress indicator is present');
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Verify after 2 seconds the circular progress indicator is not present.
      tester.printToConsole(
          'Verify after 2 seconds the circular progress indicator is not present');
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('100'), findsOneWidget);

      // Emulate a tap on the bottom navigation bar item three.
      tester.printToConsole(
          'Emulating tap on the bottom navigation bar item three');

      await tester.tap(bottomNavigationBarItemThree);
      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the widgets are present.
      tester.printToConsole('Verify the widgets are present');

      expect(profileView, findsWidgets);

      tester.printToConsole('Test completed successfully 🎉');
    });
  });
}
