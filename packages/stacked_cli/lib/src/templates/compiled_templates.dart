/// NOTE: This is generated code from the compileTemplates command. Do not modify by hand
///       This file should be checked into source control.


// -------- StackedJsonStk Template Data ----------

const String kAppWebTemplateStackedJsonStkPath =
    'stacked.json.stk';

const String kAppWebTemplateStackedJsonStkContent = '''
{
    "stacked_app_file_path": "app/app.dart",
    "services_path": "services",
    "views_path": "ui/views",
    "bottom_sheets_path": "ui/bottom_sheets",
    "bottom_sheet_type_file_path": "enums/bottom_sheet_type.dart",
    "bottom_sheet_builder_file_path": "ui/setup/setup_bottom_sheet_ui.dart",
    "dialogs_path": "ui/dialogs",
    "dialog_type_file_path": "enums/dialog_type.dart",
    "dialog_builder_file_path": "ui/setup/setup_dialog_ui.dart",
    "test_helpers_file_path": "helpers/test_helpers.dart",
    "test_services_path": "services",
    "test_views_path": "viewmodels",
    "locator_name": "locator",
    "register_mocks_function": "registerServices",
    "v1": false,
    "line_length": 80,
    "prefer_web": true,
}
''';

// --------------------------------------------------


// -------- HomeViewmodelTest Template Data ----------

const String kAppWebTemplateHomeViewmodelTestPath =
    'test/viewmodels/home_viewmodel_test.dart.stk';

const String kAppWebTemplateHomeViewmodelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:{{packageName}}/{{{relativeBottomSheetFilePath}}}';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/ui/common/app_strings.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/home/home_viewmodel.dart';

import '{{{viewTestHelpersImport}}}';

void main() {
  HomeViewModel _getModel() => HomeViewModel();

  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('incrementCounter -', () {
      test('When called once should return  Counter is: 1', () {
        final model = _getModel();
        model.incrementCounter();
        expect(model.counterLabel, 'Counter is: 1');
      });
    });

    group('showBottomSheet -', () {
      test('When called, should show custom bottom sheet using notice variant',
          () {
        final bottomSheetService = getAndRegisterBottomSheetService();

        final model = _getModel();
        model.showBottomSheet();
        verify(bottomSheetService.showCustomSheet(
          variant: BottomSheetType.notice,
          title: ksHomeBottomSheetTitle,
          description: ksHomeBottomSheetDescription,
        ));
      });
    });
  });
}

''';

// --------------------------------------------------


// -------- NoticeSheetModelTest Template Data ----------

const String kAppWebTemplateNoticeSheetModelTestPath =
    'test/viewmodels/notice_sheet_model_test.dart.stk';

const String kAppWebTemplateNoticeSheetModelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('InfoAlertDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- InfoAlertDialogModelTest Template Data ----------

const String kAppWebTemplateInfoAlertDialogModelTestPath =
    'test/viewmodels/info_alert_dialog_model_test.dart.stk';

const String kAppWebTemplateInfoAlertDialogModelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('InfoAlertDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- TestHelpers Template Data ----------

const String kAppWebTemplateTestHelpersPath =
    'test/helpers/test_helpers.dart.stk';

const String kAppWebTemplateTestHelpersContent = '''
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<RouterService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  // @stacked-mock-spec
])
void registerServices() {
  getAndRegisterRouterService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  // @stacked-mock-register
}

MockRouterService getAndRegisterRouterService() {
  _removeRegistrationIfExists<RouterService>();
  final service = MockRouterService();
  locator.registerSingleton<RouterService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

''';

// --------------------------------------------------


// -------- BuildYamlStk Template Data ----------

const String kAppWebTemplateBuildYamlStkPath =
    'build.yaml.stk';

const String kAppWebTemplateBuildYamlStkContent = '''
targets:
  \$default:
    builders:
      stacked_generator|stackedRouterGenerator:
        options:
          navigator2: true
''';

// --------------------------------------------------


// -------- MainIconPngStk Template Data ----------

const String kAppWebTemplateMainIconPngStkPath =
    'web/main-icon.png.stk';

const String kAppWebTemplateMainIconPngStkContent = '''
iVBORw0KGgoAAAANSUhEUgAAALMAAACzCAYAAADCFC3zAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAN5SURBVHgB7daLjVNBDEDRF0QjVEIrdMLSAS3RyZZAByGWdqUQ5Z/5eGbOkSw3cC152wAAAAAAAAAAAAAAAACAjHZbYfuDDW77tdvt3raCvmzQXvGQg5hprUrIQcy0VC3kIGZaqRpyEDMtVA85iJnamoQcxExNzUIOYqaWpiEHMVND85CDmCmtS8hBzJTULeQgZkrpGnIQMyV0DzmImVelCDmImVekCTmImWelCjmImWekCzmImUelDDmImUekDTmImXulDjmImXukDzmImVuGCDmImWuGCTmImUuGCjmImXOGCzmImVNDhhzEzLFhQw5i5tPQIQcxE4YPOYiZKUIOYl7bNCEHMa9rqpCDmNc0XchBzOuZMuQg5rVMG3IQ8zqmDjmIeQ3ThxzEPL8lQg5intsyIQcxz2upkIOY57RcyEHM81ky5CDmuSwbchDzPJYOOYh5DsuHHMQ8PiF/EPPYhHxEzOMS8gkxj0nIZ4h5PEK+QMxjEfIVYh6HkG8Q8xiEfAcx5yfkO4k5NyE/QMx5CflBYs5JyE8Qcz5CfpKYcxHyC8Sch5BfJOYchFyAmPsTciFi7kvIBYm5HyEXJuY+hFyBmNsTciVibkvIFYm5HSFXttsK2+/3bxunvh/mz8axv4fj/r0VVDxm/nc47p+H9bZx6v0Q87etIG9GRUJuS8yVCLk9MVcg5D7EXJiQ+xFzQULuS8yFCLk/MRcg5BzE/CIh5yHmFwg5FzE/Scj5iPkJQs5JzA8Scl5ifoCQcxPznYScn5jvIOQxiPkGIY9DzFcIeSxivkDI4xHzGUIek5hPCHlcYj4i5LGJ+YOQxyfmTcizWD5mIc9j6ZiFPJdlYxbyfJaMWchzWi5mIc9rqZiFPLdlYhby/JaIWchrmD5mIa9j6piFvJZpYxbyeqaMWchrmi5mIa9rqpiFvLZpYhYyU8QsZMLwMQuZT0PHLGSODRuzkDk1ZMxC5pzhYhYylwwVs5C5ZpiYhcwtQ8QsZO6RPmYhc6/UMQuZR6SNWcg8KmXMQuYZ6WIWMs9KFbOQeUWamIXMq1LELGRK6B6zkCmla8xCpqRuMQuZ0rrELGRqaB6zkKmlacxCpqZmMQuZ2prELGRaqB6zkGmlasxCpqVqMQuZ1qrELGR6+LoVdgj5x2HFvG9w2fsGAAAAAAAAAAAAAAAAACzhH8sFZqawpyetAAAAAElFTkSuQmCC
''';

// --------------------------------------------------


// -------- IndexHtmlStk Template Data ----------

const String kAppWebTemplateIndexHtmlStkPath =
    'web/index.html.stk';

const String kAppWebTemplateIndexHtmlStkContent = '''
<!DOCTYPE html>
<html>
<head>
  <!--
    If you are serving your web app in a path other than the root, change the
    href value below to reflect the base path you are serving from.

    The path provided below has to start and end with a slash "/" in order for
    it to work correctly.

    For more details:
    * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base

    This is a placeholder for base href that will be replaced by the value of
    the `--base-href` argument provided to `flutter build`.
  -->
  <base href="\$FLUTTER_BASE_HREF">

  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="description" content="Stacke Application">

  <!-- iOS meta tags & icons -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="FilledStacks Academy">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">

  <!-- Favicon -->
  <link rel="icon" type="image/png" href="favicon.png"/>

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  
  <!-- Import the Open Sans Font from Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;600;700;800&display=swap" rel="stylesheet">

  <title>My Stacked Application</title>
  <link rel="manifest" href="manifest.json">

  <script>
    // The value below is injected by flutter build, do not touch.
    var serviceWorkerVersion = null;
  </script>
  <!-- This script adds the flutter initialization JS code -->
  <script src="flutter.js" defer></script>
</head>
<body>
  <style>
    body {
      background-color: #0A0A0A;
      height: 100vh;
      width: 100vw;
    }

    .main-content {
      height: 100%;
      width: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    img {
      width: 100px;
      height: 100px;
    }

    p {
      color: #fff;
    }

  </style>
  <script>
    window.addEventListener('load', function(ev) {
      // Download main.dart.js
      _flutter.loader.loadEntrypoint({
        serviceWorker: {
          serviceWorkerVersion: serviceWorkerVersion,
        }
      }).then(function(engineInitializer) {
        return engineInitializer.initializeEngine();
      }).then(function(appRunner) {
        return appRunner.runApp();
      });
    });
  </script>
  <div class="main-content">
    <img src="main-icon.png" />
  </div>
</body>
</html>

''';

// --------------------------------------------------


// -------- FaviconPngStk Template Data ----------

const String kAppWebTemplateFaviconPngStkPath =
    'web/favicon.png.stk';

const String kAppWebTemplateFaviconPngStkContent = '''
iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAHaSURBVHgBpVTNasJAEN7dxLQl+FNEFBRR8VCQgo+gryCkh9499CnUg/gMvo3eFWw9eBLS4sWT2oOHRLOdWWLYxkRT+8GS3cnkm28mM0tIMOhpwzmn7plKdurawz9EdLtdNhqNWKvVekyn0ynLsghjTPg4jsNt26a6rnO09/v9r2Qy6UwmkwOlwoX7yZVqtWqA07v78uqKx+NmsVhsw179Jc4wDKVcLrejEvkXCHlBDlmdlkgkPm8lhKw+arWahipRKikUCspqtSqe2FOpFKnX6+QSZrMZ2W63Yr/b7Z6htshl45kOh8MnOWKj0eCXAD8vSKmOf54ho6qqnEREr9fDbjizZzIZikBCut/v6X/IENBeQikSck3TrnFdJJMghJ3V0L86nc5ZHbHOsk82m9WFUCTEzg8DkEVRhpOE6jhD57CUo5IR4tVQpMyCUg5KM0LKorH5crn8lqNhY4/HY9JsNkMVYWPLWK/XXutRmJQHGPQ5uXH0cGxLpdK9SNeVe8jlcgNyI2CWB6ZpHjwDjgxGyOfzb3+5JIBoXqlUXuG2uSOnHpQCUSi0slgs7qCNVAwCEHXZbDZYV+8sZpYxJxaLHaFc1nQ6PYLZCcsAy6BIT0U6eza83X2CBH4AHNJFlWlQookAAAAASUVORK5CYII=
''';

// --------------------------------------------------


// -------- READMEMdStk Template Data ----------

const String kAppWebTemplateREADMEMdStkPath =
    'README.md.stk';

const String kAppWebTemplateREADMEMdStkContent = '''
# stacked_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

''';

// --------------------------------------------------


// -------- Main Template Data ----------

const String kAppWebTemplateMainPath =
    'lib/main.dart.stk';

const String kAppWebTemplateMainContent = '''
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:{{packageName}}/{{{relativeBottomSheetFilePath}}}';
import 'package:{{packageName}}/{{{relativeDialogFilePath}}}';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/{{{relativeRouterFilePath}}}';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  setupLocator(
    stackedRouter: stackedRouter,
  );
  setupDialogUi();
  setupBottomSheetUi();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(builder: (_) => MaterialApp.router(
        title: 'Stacked Application',
        theme: Theme.of(context).copyWith(
          primaryColor: kcBackgroundColor,
          focusColor: kcPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
              ),
        ),
        routerDelegate: stackedRouter.delegate(),
        routeInformationParser: stackedRouter.defaultRouteParser(),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- AppConstants Template Data ----------

const String kAppWebTemplateAppConstantsPath =
    'lib/ui/common/app_constants.dart.stk';

const String kAppWebTemplateAppConstantsContent = '''
/// The max width the content can ever take up on the screen
const double kdDesktopMaxContentWidth = 1150;

// The max height the homeview will take up
const double kdDesktopMaxContentHeight = 750;

''';

// --------------------------------------------------


// -------- UiHelpers Template Data ----------

const String kAppWebTemplateUiHelpersPath =
    'lib/ui/common/ui_helpers.dart.stk';

const String kAppWebTemplateUiHelpersContent = '''
import 'dart:math';

import 'package:flutter/material.dart';

const double _tinySize = 5.0;
const double _smallSize = 10.0;
const double _mediumSize = 25.0;
const double _largeSize = 50.0;
const double _massiveSize = 120.0;

const Widget horizontalSpaceTiny = SizedBox(width: _tinySize);
const Widget horizontalSpaceSmall = SizedBox(width: _smallSize);
const Widget horizontalSpaceMedium = SizedBox(width: _mediumSize);
const Widget horizontalSpaceLarge = SizedBox(width: _largeSize);

const Widget verticalSpaceTiny = SizedBox(height: _tinySize);
const Widget verticalSpaceSmall = SizedBox(height: _smallSize);
const Widget verticalSpaceMedium = SizedBox(height: _mediumSize);
const Widget verticalSpaceLarge = SizedBox(height: _largeSize);
const Widget verticalSpaceMassive = SizedBox(height: _massiveSize);

Widget spacedDivider = Column(
  children: const <Widget>[
    verticalSpaceMedium,
    Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenHeight(context) - offsetBy) / dividedBy, max);

double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenWidth(context) - offsetBy) / dividedBy, max);

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

double quarterScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 4);

double getResponsiveHorizontalSpaceMedium(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 10);
double getResponsiveSmallFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 14, max: 15);

double getResponsiveMediumFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 16, max: 17);

double getResponsiveLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 21, max: 31);

double getResponsiveExtraLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 25);

double getResponsiveMassiveFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 30);

double getResponsiveFontSize(BuildContext context,
    {double? fontSize, double? max}) {
  max ??= 100;

  var responsiveSize = min(
      screenWidthFraction(context, dividedBy: 10) * ((fontSize ?? 100) / 100),
      max);
  
  return responsiveSize;
}

''';

// --------------------------------------------------


// -------- AppStrings Template Data ----------

const String kAppWebTemplateAppStringsPath =
    'lib/ui/common/app_strings.dart.stk';

const String kAppWebTemplateAppStringsContent = '''
const String ksHomeBottomSheetTitle = 'Build Great Apps!';
const String ksHomeBottomSheetDescription =
    'Stacked is built to help you build better apps. Give us a chance and we\\'ll prove it to you. Check out stacked.filledstacks.com to learn more';

''';

// --------------------------------------------------


// -------- AppColors Template Data ----------

const String kAppWebTemplateAppColorsPath =
    'lib/ui/common/app_colors.dart.stk';

const String kAppWebTemplateAppColorsContent = '''
import 'package:flutter/material.dart';

const Color kcPrimaryColor = Color(0xFF9600FF);
const Color kcPrimaryColorDark = Color(0xFF300151);
const Color kcDarkGreyColor = Color(0xFF1A1B1E);
const Color kcMediumGrey = Color(0xFF474A54);
const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);
const Color kcVeryLightGrey = Color(0xFFE3E3E3);
const Color kcBackgroundColor = kcDarkGreyColor;

''';

// --------------------------------------------------


// -------- NoticeSheetModel Template Data ----------

const String kAppWebTemplateNoticeSheetModelPath =
    'lib/ui/bottom_sheets/notice/notice_sheet_model.dart.stk';

const String kAppWebTemplateNoticeSheetModelContent = '''
import 'package:stacked/stacked.dart';

class NoticeSheetModel extends BaseViewModel {}

''';

// --------------------------------------------------


// -------- NoticeSheet Template Data ----------

const String kAppWebTemplateNoticeSheetPath =
    'lib/ui/bottom_sheets/notice/notice_sheet.dart.stk';

const String kAppWebTemplateNoticeSheetContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'notice_sheet_model.dart';

class NoticeSheet extends StackedView<NoticeSheetModel> {
  final Function(SheetResponse)? completer;
  final SheetRequest request;
  const NoticeSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NoticeSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          verticalSpaceTiny,
          Text(
            request.description!,
            style: const TextStyle(fontSize: 14, color: kcMediumGrey),
            maxLines: 3,
            softWrap: true,
          ),
          verticalSpaceLarge,
        ],
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  @override
  NoticeSheetModel viewModelBuilder(BuildContext context) =>
      NoticeSheetModel();
}

''';

// --------------------------------------------------


// -------- InfoAlertDialogModel Template Data ----------

const String kAppWebTemplateInfoAlertDialogModelPath =
    'lib/ui/dialogs/info_alert/info_alert_dialog_model.dart.stk';

const String kAppWebTemplateInfoAlertDialogModelContent = '''
import 'package:stacked/stacked.dart';

class InfoAlertDialogModel extends BaseViewModel {}

''';

// --------------------------------------------------


// -------- InfoAlertDialog Template Data ----------

const String kAppWebTemplateInfoAlertDialogPath =
    'lib/ui/dialogs/info_alert/info_alert_dialog.dart.stk';

const String kAppWebTemplateInfoAlertDialogContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'info_alert_dialog_model.dart';

const double _graphicSize = 60;

class InfoAlertDialog extends StackedView<InfoAlertDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const InfoAlertDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InfoAlertDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                      verticalSpaceTiny,
                      Text(
                        request.description!,
                        style:
                            const TextStyle(fontSize: 14, color: kcMediumGrey),
                        maxLines: 3,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _graphicSize,
                  height: _graphicSize,
                  decoration: const BoxDecoration(
                    color: Color(0xffF6E7B0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_graphicSize / 2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '⭐️',
                    style: TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () => completer(DialogResponse(
                confirmed: true,
              )),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                child: const Text(
                  'Got it',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  InfoAlertDialogModel viewModelBuilder(BuildContext context) =>
      InfoAlertDialogModel();
}

''';

// --------------------------------------------------


// -------- HomeViewDesktop Template Data ----------

const String kAppWebTemplateHomeViewDesktopPath =
    'lib/ui/views/home/home_view.desktop.dart.stk';

const String kAppWebTemplateHomeViewDesktopContent = '''
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/app_constants.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewDesktop extends ViewModelWidget<HomeViewModel> {
  const HomeViewDesktop({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      body: Center(
            child: SizedBox(
              width: kdDesktopMaxContentWidth,
              height: kdDesktopMaxContentHeight,
              child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                verticalSpaceLarge,
                Column(
                  children: [
                    const Text(
                      'Hello, DESKTOP UI!',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    verticalSpaceMedium,
                    MaterialButton(
                      color: Colors.black,
                      onPressed: viewModel.incrementCounter,
                      child: Text(
                        viewModel.counterLabel,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: kcDarkGreyColor,
                      child: const Text(
                        'Show Dialog',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: viewModel.showDialog,
                    ),
                    MaterialButton(
                      color: kcDarkGreyColor,
                      child: const Text(
                        'Show Bottom Sheet',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: viewModel.showBottomSheet,
                    ),
                  ],
                )
              ],
            ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- HomeViewMobile Template Data ----------

const String kAppWebTemplateHomeViewMobilePath =
    'lib/ui/views/home/home_view.mobile.dart.stk';

const String kAppWebTemplateHomeViewMobileContent = '''
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewMobile extends ViewModelWidget<HomeViewModel> {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                verticalSpaceLarge,
                Column(
                  children: [
                    const Text(
                      'Hello, MOBILE UI!',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    verticalSpaceMedium,
                    MaterialButton(
                      color: Colors.black,
                      onPressed: viewModel.incrementCounter,
                      child: Text(
                        viewModel.counterLabel,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: kcDarkGreyColor,
                      child: const Text(
                        'Show Dialog',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: viewModel.showDialog,
                    ),
                    MaterialButton(
                      color: kcDarkGreyColor,
                      child: const Text(
                        'Show Bottom Sheet',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: viewModel.showBottomSheet,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- HomeView Template Data ----------

const String kAppWebTemplateHomeViewPath =
    'lib/ui/views/home/home_view.dart.stk';

const String kAppWebTemplateHomeViewContent = '''
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'home_view.desktop.dart';
import 'home_view.tablet.dart';
import 'home_view.mobile.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel  viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const HomeViewMobile(),
      tablet: (_) => const HomeViewTablet(),
      desktop: (_) => const HomeViewDesktop(),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
  HomeViewModel();
}

''';

// --------------------------------------------------


// -------- HomeViewmodel Template Data ----------

const String kAppWebTemplateHomeViewmodelPath =
    'lib/ui/views/home/home_viewmodel.dart.stk';

const String kAppWebTemplateHomeViewmodelContent = '''
import 'package:{{packageName}}/{{{relativeBottomSheetFilePath}}}';
import 'package:{{packageName}}/{{{relativeDialogFilePath}}}';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  String get counterLabel => 'Counter is: \$_counter';

  int _counter = 0;

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked \$_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}

''';

// --------------------------------------------------


// -------- HomeViewTablet Template Data ----------

const String kAppWebTemplateHomeViewTabletPath =
    'lib/ui/views/home/home_view.tablet.dart.stk';

const String kAppWebTemplateHomeViewTabletContent = '''
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewTablet extends ViewModelWidget<HomeViewModel> {
  const HomeViewTablet({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                verticalSpaceLarge,
                Column(
                  children: [
                    const Text(
                      'Hello, TABLET UI!',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    verticalSpaceMedium,
                    MaterialButton(
                      color: Colors.black,
                      onPressed: viewModel.incrementCounter,
                      child: Text(
                        viewModel.counterLabel,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: kcDarkGreyColor,
                      child: const Text(
                        'Show Dialog',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: viewModel.showDialog,
                    ),
                    MaterialButton(
                      color: kcDarkGreyColor,
                      child: const Text(
                        'Show Bottom Sheet',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: viewModel.showBottomSheet,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- StartupViewmodel Template Data ----------

const String kAppWebTemplateStartupViewmodelPath =
    'lib/ui/views/startup/startup_viewmodel.dart.stk';

const String kAppWebTemplateStartupViewmodelContent = '''
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/{{{relativeRouterFilePath}}}';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _routerService = locator<RouterService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    await _routerService.replaceWith(const HomeViewRoute());
  }
}

''';

// --------------------------------------------------


// -------- StartupView Template Data ----------

const String kAppWebTemplateStartupViewPath =
    'lib/ui/views/startup/startup_view.dart.stk';

const String kAppWebTemplateStartupViewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'STACKED',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Loading ...',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                horizontalSpaceSmall,
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 6,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}

''';

// --------------------------------------------------


// -------- ScaleOnHover Template Data ----------

const String kAppWebTemplateScaleOnHoverPath =
    'lib/ui/widgets/mouse_transforms/scale_on_hover.dart.stk';

const String kAppWebTemplateScaleOnHoverContent = '''
import 'package:flutter/material.dart';

class ScaleOnHover extends StatefulWidget {
  final double scale;
  final Widget child;
  // You can also pass the translation in here if you want to
  const ScaleOnHover({super.key, required this.child, this.scale = 1.1});

  @override
  _ScaleOnHoverState createState() => _ScaleOnHoverState();
}

class _ScaleOnHoverState extends State<ScaleOnHover> {
  final scaleTransform = Matrix4.identity()..scale(1.1);
  final noScaleTransform = Matrix4.identity()..scale(1.0);

  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCirc,
        child: widget.child,
        transform: _hovering ? scaleTransform : noScaleTransform,
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }
}

''';

// --------------------------------------------------


// -------- TranslateOnHover Template Data ----------

const String kAppWebTemplateTranslateOnHoverPath =
    'lib/ui/widgets/mouse_transforms/translate_on_hover.dart.stk';

const String kAppWebTemplateTranslateOnHoverContent = '''
import 'package:flutter/material.dart';

class TranslateOnHover extends StatefulWidget {
  final Widget child;
  final double? x;
  final double? y;
  // You can also pass the translation in here if you want to
  const TranslateOnHover({
    super.key,
    required this.child,
    this.x,
    this.y,
  });

  @override
  _TranslateOnHoverState createState() => _TranslateOnHoverState();
}

class _TranslateOnHoverState extends State<TranslateOnHover> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final nonHoverTransform = Matrix4.identity()..translate(0, 0, 0);
    final hoverTransform = Matrix4.identity()
      ..translate(
        widget.x ?? 0,
        widget.y ?? 0,
      );
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: widget.child,
        transform: _hovering ? hoverTransform : nonHoverTransform,
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }
}
''';

// --------------------------------------------------


// -------- App Template Data ----------

const String kAppWebTemplateAppPath =
    'lib/app/app.dart.stk';

const String kAppWebTemplateAppContent = '''
import 'package:{{packageName}}/{{{bottomSheetsPath}}}/notice/notice_sheet.dart';
import 'package:{{packageName}}/{{{dialogsPath}}}/info_alert/info_alert_dialog.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/home/home_view.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: RouterService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}

''';

// --------------------------------------------------


// -------- HoverExtensions Template Data ----------

const String kAppWebTemplateHoverExtensionsPath =
    'lib/extensions/hover_extensions.dart.stk';

const String kAppWebTemplateHoverExtensionsContent = '''
import 'package:{{packageName}}/ui/widgets/mouse_transforms/scale_on_hover.dart';
import 'package:{{packageName}}/ui/widgets/mouse_transforms/translate_on_hover.dart';
import 'package:flutter/material.dart';

extension HoverExtensions on Widget {
  Widget get showCursorOnHover {
    return MouseRegion(
      child: this,
      cursor: SystemMouseCursors.click,
    );
  }

  /// Moves the widget by x,y pixels on hover
  ///
  /// to move up use -y values, to move left use -x values
  Widget moveOnHover({double? x, double? y}) {
    return TranslateOnHover(
      x: x,
      y: y,
      child: this,
    );
  }

  /// Scales the widget by [scale] on hover
  Widget scaleOnHover({double scale = 1.1}) {
    return ScaleOnHover(
      child: this,
      scale: scale,
    );
  }
}

''';

// --------------------------------------------------


// -------- PubspecYamlStk Template Data ----------

const String kAppWebTemplatePubspecYamlStkPath =
    'pubspec.yaml.stk';

const String kAppWebTemplatePubspecYamlStkContent = '''
name: {{packageName}}
description: An app build with the stacked framework

# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
version: 1.0.0+1

environment:
  sdk: ">=2.17.0 <3.0.0"

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  
  stacked: ^3.2.0-beta.1
  stacked_services: ^1.0.0-beta.0
  url_strategy: ^0.2.0
  responsive_builder: ^0.6.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^1.0.0
  build_runner: ^2.2.0

  stacked_generator: 1.0.0-beta.0
  mockito: ^5.3.2

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  # assets:
  #   - images/a_dot_burr.jpeg
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/assets-and-images/#resolution-aware.

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/assets-and-images/#from-packages

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/custom-fonts/#from-packages

''';

// --------------------------------------------------


// -------- SettingsJsonStk Template Data ----------

const String kAppWebTemplateSettingsJsonStkPath =
    '.vscode/settings.json.stk';

const String kAppWebTemplateSettingsJsonStkContent = '''
{
    "explorer.fileNesting.enabled": true,
    "explorer.fileNesting.patterns": {
        "*.dart": "\${capture}.mobile.dart, \${capture}.tablet.dart, \${capture}.desktop.dart, \${capture}.form.dart"
    },
}
''';

// --------------------------------------------------


// -------- StackedJsonStk Template Data ----------

const String kAppMobileTemplateStackedJsonStkPath =
    'stacked.json.stk';

const String kAppMobileTemplateStackedJsonStkContent = '''
{
    "stacked_app_file_path": "app/app.dart",
    "services_path": "services",
    "views_path": "ui/views",
    "bottom_sheets_path": "ui/bottom_sheets",
    "bottom_sheet_type_file_path": "enums/bottom_sheet_type.dart",
    "bottom_sheet_builder_file_path": "ui/setup/setup_bottom_sheet_ui.dart",
    "dialogs_path": "ui/dialogs",
    "dialog_type_file_path": "enums/dialog_type.dart",
    "dialog_builder_file_path": "ui/setup/setup_dialog_ui.dart",
    "test_helpers_file_path": "helpers/test_helpers.dart",
    "test_services_path": "services",
    "test_views_path": "viewmodels",
    "locator_name": "locator",
    "register_mocks_function": "registerServices",
    "v1": false,
    "line_length": 80
}
''';

// --------------------------------------------------


// -------- HomeViewmodelTest Template Data ----------

const String kAppMobileTemplateHomeViewmodelTestPath =
    'test/viewmodels/home_viewmodel_test.dart.stk';

const String kAppMobileTemplateHomeViewmodelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:{{packageName}}/{{{relativeBottomSheetFilePath}}}';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/ui/common/app_strings.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/home/home_viewmodel.dart';

import '{{{viewTestHelpersImport}}}';

void main() {
  HomeViewModel _getModel() => HomeViewModel();

  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('incrementCounter -', () {
      test('When called once should return  Counter is: 1', () {
        final model = _getModel();
        model.incrementCounter();
        expect(model.counterLabel, 'Counter is: 1');
      });
    });

    group('showBottomSheet -', () {
      test('When called, should show custom bottom sheet using notice variant',
          () {
        final bottomSheetService = getAndRegisterBottomSheetService();

        final model = _getModel();
        model.showBottomSheet();
        verify(bottomSheetService.showCustomSheet(
          variant: BottomSheetType.notice,
          title: ksHomeBottomSheetTitle,
          description: ksHomeBottomSheetDescription,
        ));
      });
    });
  });
}

''';

// --------------------------------------------------


// -------- NoticeSheetModelTest Template Data ----------

const String kAppMobileTemplateNoticeSheetModelTestPath =
    'test/viewmodels/notice_sheet_model_test.dart.stk';

const String kAppMobileTemplateNoticeSheetModelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('InfoAlertDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- InfoAlertDialogModelTest Template Data ----------

const String kAppMobileTemplateInfoAlertDialogModelTestPath =
    'test/viewmodels/info_alert_dialog_model_test.dart.stk';

const String kAppMobileTemplateInfoAlertDialogModelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('InfoAlertDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- TestHelpers Template Data ----------

const String kAppMobileTemplateTestHelpersPath =
    'test/helpers/test_helpers.dart.stk';

const String kAppMobileTemplateTestHelpersContent = '''
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  // @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  // @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

''';

// --------------------------------------------------


// -------- READMEMdStk Template Data ----------

const String kAppMobileTemplateREADMEMdStkPath =
    'README.md.stk';

const String kAppMobileTemplateREADMEMdStkContent = '''
# stacked_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

''';

// --------------------------------------------------


// -------- Main Template Data ----------

const String kAppMobileTemplateMainPath =
    'lib/main.dart.stk';

const String kAppMobileTemplateMainContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/{{{relativeBottomSheetFilePath}}}';
import 'package:{{packageName}}/{{{relativeDialogFilePath}}}';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/{{{relativeRouterFilePath}}}';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Theme.of(context).copyWith(
        primaryColor: kcBackgroundColor,
        focusColor: kcPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
            ),
      ),
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}

''';

// --------------------------------------------------


// -------- UiHelpers Template Data ----------

const String kAppMobileTemplateUiHelpersPath =
    'lib/ui/common/ui_helpers.dart.stk';

const String kAppMobileTemplateUiHelpersContent = '''
import 'dart:math';

import 'package:flutter/material.dart';

const double _tinySize = 5.0;
const double _smallSize = 10.0;
const double _mediumSize = 25.0;
const double _largeSize = 50.0;
const double _massiveSize = 120.0;

const Widget horizontalSpaceTiny = SizedBox(width: _tinySize);
const Widget horizontalSpaceSmall = SizedBox(width: _smallSize);
const Widget horizontalSpaceMedium = SizedBox(width: _mediumSize);
const Widget horizontalSpaceLarge = SizedBox(width: _largeSize);

const Widget verticalSpaceTiny = SizedBox(height: _tinySize);
const Widget verticalSpaceSmall = SizedBox(height: _smallSize);
const Widget verticalSpaceMedium = SizedBox(height: _mediumSize);
const Widget verticalSpaceLarge = SizedBox(height: _largeSize);
const Widget verticalSpaceMassive = SizedBox(height: _massiveSize);

Widget spacedDivider = Column(
  children: const <Widget>[
    verticalSpaceMedium,
    Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenHeight(context) - offsetBy) / dividedBy, max);

double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenWidth(context) - offsetBy) / dividedBy, max);

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

double quarterScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 4);

double getResponsiveHorizontalSpaceMedium(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 10);
double getResponsiveSmallFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 14, max: 15);

double getResponsiveMediumFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 16, max: 17);

double getResponsiveLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 21, max: 31);

double getResponsiveExtraLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 25);

double getResponsiveMassiveFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 30);

double getResponsiveFontSize(BuildContext context,
    {double? fontSize, double? max}) {
  max ??= 100;

  var responsiveSize = min(
      screenWidthFraction(context, dividedBy: 10) * ((fontSize ?? 100) / 100),
      max);
  
  return responsiveSize;
}

''';

// --------------------------------------------------


// -------- AppStrings Template Data ----------

const String kAppMobileTemplateAppStringsPath =
    'lib/ui/common/app_strings.dart.stk';

const String kAppMobileTemplateAppStringsContent = '''
const String ksHomeBottomSheetTitle = 'Build Great Apps!';
const String ksHomeBottomSheetDescription =
    'Stacked is built to help you build better apps. Give us a chance and we\\'ll prove it to you. Check out stacked.filledstacks.com to learn more';

''';

// --------------------------------------------------


// -------- AppColors Template Data ----------

const String kAppMobileTemplateAppColorsPath =
    'lib/ui/common/app_colors.dart.stk';

const String kAppMobileTemplateAppColorsContent = '''
import 'package:flutter/material.dart';

const Color kcPrimaryColor = Color(0xFF9600FF);
const Color kcPrimaryColorDark = Color(0xFF300151);
const Color kcDarkGreyColor = Color(0xFF1A1B1E);
const Color kcMediumGrey = Color(0xFF474A54);
const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);
const Color kcVeryLightGrey = Color(0xFFE3E3E3);
const Color kcBackgroundColor = kcDarkGreyColor;

''';

// --------------------------------------------------


// -------- NoticeSheetModel Template Data ----------

const String kAppMobileTemplateNoticeSheetModelPath =
    'lib/ui/bottom_sheets/notice/notice_sheet_model.dart.stk';

const String kAppMobileTemplateNoticeSheetModelContent = '''
import 'package:stacked/stacked.dart';

class NoticeSheetModel extends BaseViewModel {}

''';

// --------------------------------------------------


// -------- NoticeSheet Template Data ----------

const String kAppMobileTemplateNoticeSheetPath =
    'lib/ui/bottom_sheets/notice/notice_sheet.dart.stk';

const String kAppMobileTemplateNoticeSheetContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'notice_sheet_model.dart';

class NoticeSheet extends StackedView<NoticeSheetModel> {
  final Function(SheetResponse)? completer;
  final SheetRequest request;
  const NoticeSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NoticeSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          verticalSpaceTiny,
          Text(
            request.description!,
            style: const TextStyle(fontSize: 14, color: kcMediumGrey),
            maxLines: 3,
            softWrap: true,
          ),
          verticalSpaceLarge,
        ],
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  @override
  NoticeSheetModel viewModelBuilder(BuildContext context) =>
      NoticeSheetModel();
}

''';

// --------------------------------------------------


// -------- InfoAlertDialogModel Template Data ----------

const String kAppMobileTemplateInfoAlertDialogModelPath =
    'lib/ui/dialogs/info_alert/info_alert_dialog_model.dart.stk';

const String kAppMobileTemplateInfoAlertDialogModelContent = '''
import 'package:stacked/stacked.dart';

class InfoAlertDialogModel extends BaseViewModel {}

''';

// --------------------------------------------------


// -------- InfoAlertDialog Template Data ----------

const String kAppMobileTemplateInfoAlertDialogPath =
    'lib/ui/dialogs/info_alert/info_alert_dialog.dart.stk';

const String kAppMobileTemplateInfoAlertDialogContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'info_alert_dialog_model.dart';

const double _graphicSize = 60;

class InfoAlertDialog extends StackedView<InfoAlertDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const InfoAlertDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InfoAlertDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                      verticalSpaceTiny,
                      Text(
                        request.description!,
                        style:
                            const TextStyle(fontSize: 14, color: kcMediumGrey),
                        maxLines: 3,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _graphicSize,
                  height: _graphicSize,
                  decoration: const BoxDecoration(
                    color: Color(0xffF6E7B0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_graphicSize / 2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '⭐️',
                    style: TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () => completer(DialogResponse(
                confirmed: true,
              )),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                child: const Text(
                  'Got it',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  InfoAlertDialogModel viewModelBuilder(BuildContext context) =>
      InfoAlertDialogModel();
}

''';

// --------------------------------------------------


// -------- HomeViewV1 Template Data ----------

const String kAppMobileTemplateHomeViewV1Path =
    'lib/ui/views/home/home_view_v1.dart.stk';

const String kAppMobileTemplateHomeViewV1Content = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  verticalSpaceLarge,
                  Column(
                    children: [
                      const Text(
                        'Hello, STACKED!',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      verticalSpaceMedium,
                      MaterialButton(
                        color: Colors.black,
                        onPressed: model.incrementCounter,
                        child: Text(
                          model.counterLabel,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        color: kcDarkGreyColor,
                        child: const Text(
                          'Show Dialog',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: model.showDialog,
                      ),
                      MaterialButton(
                        color: kcDarkGreyColor,
                        child: const Text(
                          'Show Bottom Sheet',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: model.showBottomSheet,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''';

// --------------------------------------------------


// -------- HomeView Template Data ----------

const String kAppMobileTemplateHomeViewPath =
    'lib/ui/views/home/home_view.dart.stk';

const String kAppMobileTemplateHomeViewContent = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                verticalSpaceLarge,
                Column(
                  children: [
                    const Text(
                      'Hello, STACKED!',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    verticalSpaceMedium,
                    MaterialButton(
                      color: Colors.black,
                      onPressed: viewModel.incrementCounter,
                      child: Text(
                        viewModel.counterLabel,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: kcDarkGreyColor,
                      child: const Text(
                        'Show Dialog',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: viewModel.showDialog,
                    ),
                    MaterialButton(
                      color: kcDarkGreyColor,
                      child: const Text(
                        'Show Bottom Sheet',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: viewModel.showBottomSheet,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) => HomeViewModel();
}

''';

// --------------------------------------------------


// -------- HomeViewmodel Template Data ----------

const String kAppMobileTemplateHomeViewmodelPath =
    'lib/ui/views/home/home_viewmodel.dart.stk';

const String kAppMobileTemplateHomeViewmodelContent = '''
import 'package:{{packageName}}/{{{relativeBottomSheetFilePath}}}';
import 'package:{{packageName}}/{{{relativeDialogFilePath}}}';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  String get counterLabel => 'Counter is: \$_counter';

  int _counter = 0;

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked \$_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}

''';

// --------------------------------------------------


// -------- StartupViewmodel Template Data ----------

const String kAppMobileTemplateStartupViewmodelPath =
    'lib/ui/views/startup/startup_viewmodel.dart.stk';

const String kAppMobileTemplateStartupViewmodelContent = '''
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';
import 'package:{{packageName}}/{{{relativeRouterFilePath}}}';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    _navigationService.replaceWithHomeView();
  }
}

''';

// --------------------------------------------------


// -------- StartupViewV1 Template Data ----------

const String kAppMobileTemplateStartupViewV1Path =
    'lib/ui/views/startup/startup_view_v1.dart.stk';

const String kAppMobileTemplateStartupViewV1Content = '''
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';

import 'startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'STACKED',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Loading ...',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  horizontalSpaceSmall,
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 6,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((timeStamp) => model.runStartupLogic()),
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}
''';

// --------------------------------------------------


// -------- StartupView Template Data ----------

const String kAppMobileTemplateStartupViewPath =
    'lib/ui/views/startup/startup_view.dart.stk';

const String kAppMobileTemplateStartupViewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'STACKED',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Loading ...',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                horizontalSpaceSmall,
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 6,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}

''';

// --------------------------------------------------


// -------- App Template Data ----------

const String kAppMobileTemplateAppPath =
    'lib/app/app.dart.stk';

const String kAppMobileTemplateAppContent = '''
import 'package:{{packageName}}/{{{bottomSheetsPath}}}/notice/notice_sheet.dart';
import 'package:{{packageName}}/{{{dialogsPath}}}/info_alert/info_alert_dialog.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/home/home_view.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}

''';

// --------------------------------------------------


// -------- PubspecYamlStk Template Data ----------

const String kAppMobileTemplatePubspecYamlStkPath =
    'pubspec.yaml.stk';

const String kAppMobileTemplatePubspecYamlStkContent = '''
name: {{packageName}}
description: An app build with the stacked framework

# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
version: 1.0.0+1

environment:
  sdk: ">=2.17.0 <3.0.0"

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  
  stacked: ^3.1.0+3
  stacked_services: ^0.9.9

dev_dependencies:
  flutter_test:
    sdk: flutter

  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^1.0.0
  build_runner: ^2.2.0

  stacked_generator: ^0.8.5
  mockito: ^5.3.2

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  # assets:
  #   - images/a_dot_burr.jpeg
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/assets-and-images/#resolution-aware.

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/assets-and-images/#from-packages

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/custom-fonts/#from-packages

''';

// --------------------------------------------------


// -------- GenericDialogModelTest Template Data ----------

const String kDialogEmptyTemplateGenericDialogModelTestPath =
    'test/viewmodels/generic_dialog_model_test.dart.stk';

const String kDialogEmptyTemplateGenericDialogModelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('{{dialogModelName}} Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- GenericDialogModel Template Data ----------

const String kDialogEmptyTemplateGenericDialogModelPath =
    'lib/ui/dialogs/generic/generic_dialog_model.dart.stk';

const String kDialogEmptyTemplateGenericDialogModelContent = '''
import 'package:stacked/stacked.dart';

class {{dialogModelName}} extends BaseViewModel {}

''';

// --------------------------------------------------


// -------- GenericDialogUseModel Template Data ----------

const String kDialogEmptyTemplateGenericDialogUseModelPath =
    'lib/ui/dialogs/generic/generic_dialog_use_model.dart.stk';

const String kDialogEmptyTemplateGenericDialogUseModelContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '{{dialogModelFilename}}';

const double _graphicSize = 60;

class {{dialogName}} extends StackedView<{{dialogModelName}}> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const {{dialogName}}({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    {{dialogModelName}} viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title ?? 'Hello Stacked Dialog!!',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      if (request.description != null) ...[
                        verticalSpaceTiny,
                        Text(
                          request.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: kcMediumGrey,
                          ),
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  width: _graphicSize,
                  height: _graphicSize,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6E7B0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_graphicSize / 2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('⭐️', style: TextStyle(fontSize: 30)),
                )
              ],
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () => completer(DialogResponse(confirmed: true)),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                child: const Text(
                  'Got it',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  {{dialogModelName}} viewModelBuilder(BuildContext context) =>
      {{dialogModelName}}();
}

''';

// --------------------------------------------------


// -------- GenericDialog Template Data ----------

const String kDialogEmptyTemplateGenericDialogPath =
    'lib/ui/dialogs/generic/generic_dialog.dart.stk';

const String kDialogEmptyTemplateGenericDialogContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

const double _graphicSize = 60;

class {{dialogName}} extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const {{dialogName}}({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title ?? 'Hello Stacked Dialog!!',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      if (request.description != null) ...[
                        verticalSpaceTiny,
                        Text(
                          request.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: kcMediumGrey,
                          ),
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  width: _graphicSize,
                  height: _graphicSize,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6E7B0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_graphicSize / 2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('⭐️', style: TextStyle(fontSize: 30)),
                )
              ],
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () => completer(DialogResponse(confirmed: true)),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                child: const Text(
                  'Got it',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- GenericViewmodelTest Template Data ----------

const String kViewEmptyTemplateGenericViewmodelTestPath =
    'test/viewmodels/generic_viewmodel_test.dart.stk';

const String kViewEmptyTemplateGenericViewmodelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('{{viewModelName}} Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- GenericViewmodel Template Data ----------

const String kViewEmptyTemplateGenericViewmodelPath =
    'lib/ui/views/generic/generic_viewmodel.dart.stk';

const String kViewEmptyTemplateGenericViewmodelContent = '''
import 'package:stacked/stacked.dart';

class {{viewModelName}} extends BaseViewModel {
}
''';

// --------------------------------------------------


// -------- GenericView Template Data ----------

const String kViewEmptyTemplateGenericViewPath =
    'lib/ui/views/generic/generic_view.dart.stk';

const String kViewEmptyTemplateGenericViewContent = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '{{viewModelFileName}}';

class {{viewName}} extends StackedView<{{viewModelName}}> {
  const {{viewName}}({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    {{viewModelName}} viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  {{viewModelName}} viewModelBuilder(
    BuildContext context,
  ) => {{viewModelName}}();
}
''';

// --------------------------------------------------


// -------- GenericViewV1 Template Data ----------

const String kViewEmptyTemplateGenericViewV1Path =
    'lib/ui/views/generic/generic_view_v1.dart.stk';

const String kViewEmptyTemplateGenericViewV1Content = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '{{viewModelFileName}}';

class {{viewName}} extends StatelessWidget {
  const {{viewName}}({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<{{viewModelName}}>.reactive(
      viewModelBuilder: () => {{viewModelName}}(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        ),
      ),
    );
  }
}
''';

// --------------------------------------------------


// -------- GenericViewmodelTest Template Data ----------

const String kViewWebTemplateGenericViewmodelTestPath =
    'test/viewmodels/generic_viewmodel_test.dart.stk';

const String kViewWebTemplateGenericViewmodelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('{{viewModelName}} Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- GenericViewmodel Template Data ----------

const String kViewWebTemplateGenericViewmodelPath =
    'lib/ui/views/generic/generic_viewmodel.dart.stk';

const String kViewWebTemplateGenericViewmodelContent = '''
import 'package:stacked/stacked.dart';

class {{viewModelName}} extends BaseViewModel {
}
''';

// --------------------------------------------------


// -------- GenericViewMobile Template Data ----------

const String kViewWebTemplateGenericViewMobilePath =
    'lib/ui/views/generic/generic_view.mobile.dart.stk';

const String kViewWebTemplateGenericViewMobileContent = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '{{viewModelFileName}}';

class {{viewName}}Mobile extends ViewModelWidget<{{viewModelName}}> {
  const {{viewName}}Mobile({super.key});

  @override
  Widget build(BuildContext context, {{viewModelName}} viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, MOBILE UI!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- GenericViewTablet Template Data ----------

const String kViewWebTemplateGenericViewTabletPath =
    'lib/ui/views/generic/generic_view.tablet.dart.stk';

const String kViewWebTemplateGenericViewTabletContent = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '{{viewModelFileName}}';

class {{viewName}}Tablet extends ViewModelWidget<{{viewModelName}}> {
  const {{viewName}}Tablet({super.key});

  @override
  Widget build(BuildContext context, {{viewModelName}} viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, TABLET UI!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- GenericView Template Data ----------

const String kViewWebTemplateGenericViewPath =
    'lib/ui/views/generic/generic_view.dart.stk';

const String kViewWebTemplateGenericViewContent = '''
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import '{{viewFileNameWithoutExtension}}.desktop.dart';
import '{{viewFileNameWithoutExtension}}.tablet.dart';
import '{{viewFileNameWithoutExtension}}.mobile.dart';
import '{{viewModelFileName}}';

class {{viewName}} extends StackedView<{{viewModelName}}> {
  const {{viewName}}({super.key});

  @override
  Widget builder(
    BuildContext context,
    {{viewModelName}}  viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const {{viewName}}Mobile(),
      tablet: (_) => const {{viewName}}Tablet(),
      desktop: (_) => const {{viewName}}Desktop(),
    );
  }

  @override
  {{viewModelName}} viewModelBuilder(
    BuildContext context,
  ) =>
  {{viewModelName}}();
}

''';

// --------------------------------------------------


// -------- GenericViewDesktop Template Data ----------

const String kViewWebTemplateGenericViewDesktopPath =
    'lib/ui/views/generic/generic_view.desktop.dart.stk';

const String kViewWebTemplateGenericViewDesktopContent = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '{{viewModelFileName}}';

class {{viewName}}Desktop extends ViewModelWidget<{{viewModelName}}> {
  const {{viewName}}Desktop({super.key});

  @override
  Widget build(BuildContext context, {{viewModelName}} viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, DESKTOP UI!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------


// -------- GenericServiceTest Template Data ----------

const String kServiceEmptyTemplateGenericServiceTestPath =
    'test/services/generic_service_test.dart.stk';

const String kServiceEmptyTemplateGenericServiceTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{serviceTestHelpersImport}}}';

void main() {
  group('{{serviceName}}Test -', () {
    setUp(() => {{registerMocksFunction}}());
    tearDown(() => {{locatorName}}.reset());
  });
}

''';

// --------------------------------------------------


// -------- GenericService Template Data ----------

const String kServiceEmptyTemplateGenericServicePath =
    'lib/services/generic_service.dart.stk';

const String kServiceEmptyTemplateGenericServiceContent = '''
class {{serviceName}} {

}
''';

// --------------------------------------------------


// -------- GenericSheetModelTest Template Data ----------

const String kBottomSheetEmptyTemplateGenericSheetModelTestPath =
    'test/viewmodels/generic_sheet_model_test.dart.stk';

const String kBottomSheetEmptyTemplateGenericSheetModelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorFilePath}}}';

import '{{{viewTestHelpersImport}}}';

void main() {
  group('{{sheetModelName}} Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- GenericSheetModel Template Data ----------

const String kBottomSheetEmptyTemplateGenericSheetModelPath =
    'lib/ui/bottom_sheets/generic/generic_sheet_model.dart.stk';

const String kBottomSheetEmptyTemplateGenericSheetModelContent = '''
import 'package:stacked/stacked.dart';

class {{sheetModelName}} extends BaseViewModel {}

''';

// --------------------------------------------------


// -------- GenericSheetUseModel Template Data ----------

const String kBottomSheetEmptyTemplateGenericSheetUseModelPath =
    'lib/ui/bottom_sheets/generic/generic_sheet_use_model.dart.stk';

const String kBottomSheetEmptyTemplateGenericSheetUseModelContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '{{sheetModelFilename}}';

class {{sheetName}} extends StackedView<{{sheetModelName}}> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const {{sheetName}}({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    {{sheetModelName}} viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? 'Hello Stacked Sheet!!',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          if (request.description != null) ...[
            verticalSpaceTiny,
            Text(
              request.description!,
              style: const TextStyle(fontSize: 14, color: kcMediumGrey),
              maxLines: 3,
              softWrap: true,
            ),
          ],
          verticalSpaceLarge,
        ],
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  @override
  {{sheetModelName}} viewModelBuilder(BuildContext context) =>
      {{sheetModelName}}();
}

''';

// --------------------------------------------------


// -------- GenericSheet Template Data ----------

const String kBottomSheetEmptyTemplateGenericSheetPath =
    'lib/ui/bottom_sheets/generic/generic_sheet.dart.stk';

const String kBottomSheetEmptyTemplateGenericSheetContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

class {{sheetName}} extends StatelessWidget {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const {{sheetName}}({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? 'Hello Stacked Sheet!!',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          if (request.description != null) ...[
            verticalSpaceTiny,
            Text(
              request.description!,
              style: const TextStyle(fontSize: 14, color: kcMediumGrey),
              maxLines: 3,
              softWrap: true,
            ),
          ],
          verticalSpaceLarge,
        ],
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }
}

''';

// --------------------------------------------------

