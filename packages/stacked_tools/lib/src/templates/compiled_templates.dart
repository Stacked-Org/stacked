/// NOTE: This is generated code from the compileTemplates command. Do not modify by hand
///       This file should be checked into source control.


// -------- StackedJsonStk Template Data ----------

const String kAppTemplateStackedJsonStkPath =
    'stacked.json.stk';

const String kAppTemplateStackedJsonStkContent = '''
{
    "stacked_app_file_path": "app/app.dart",
    "services_path": "services",
    "views_path": "ui/views",
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

const String kAppTemplateHomeViewmodelTestPath =
    'test/viewmodels/home_viewmodel_test.dart.stk';

const String kAppTemplateHomeViewmodelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:{{packageName}}/{{{relativeLocatorPath}}}';
import 'package:{{packageName}}/enums/bottom_sheet_type.dart';
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


// -------- TestHelpers Template Data ----------

const String kAppTemplateTestHelpersPath =
    'test/helpers/test_helpers.dart.stk';

const String kAppTemplateTestHelpersContent = '''
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:{{packageName}}/{{{relativeLocatorPath}}}';
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

const String kAppTemplateREADMEMdStkPath =
    'README.md.stk';

const String kAppTemplateREADMEMdStkContent = '''
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

const String kAppTemplateMainPath =
    'lib/main.dart.stk';

const String kAppTemplateMainContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/{{{relativeLocatorPath}}}';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/setup/setup_bottom_sheet_ui.dart';
import 'package:{{packageName}}/ui/setup/setup_dialog_ui.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.router.dart';

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
    );
  }
}

''';

// --------------------------------------------------


// -------- SetupDialogUi Template Data ----------

const String kAppTemplateSetupDialogUiPath =
    'lib/ui/setup/setup_dialog_ui.dart.stk';

const String kAppTemplateSetupDialogUiContent = '''
import 'package:{{packageName}}/{{{relativeLocatorPath}}}';
import 'package:{{packageName}}/enums/dialog_type.dart';
import 'package:{{packageName}}/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<dynamic, DialogBuilder> builders = {
    DialogType.infoAlert: (context, sheetRequest, completer) =>
        InfoAlertDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

''';

// --------------------------------------------------


// -------- SetupBottomSheetUi Template Data ----------

const String kAppTemplateSetupBottomSheetUiPath =
    'lib/ui/setup/setup_bottom_sheet_ui.dart.stk';

const String kAppTemplateSetupBottomSheetUiContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/{{{relativeLocatorPath}}}';
import 'package:{{packageName}}/enums/bottom_sheet_type.dart';
import 'package:{{packageName}}/ui/bottom_sheets/notice_sheet/notice_sheet.dart';
import 'package:stacked_services/stacked_services.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final Map<
      dynamic,
      Widget Function(BuildContext, SheetRequest<dynamic>,
          void Function(SheetResponse<dynamic>))> builders = {
    BottomSheetType.notice: (context, sheetRequest, completer) =>
        NoticeSheet(completer: completer, request: sheetRequest),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

''';

// --------------------------------------------------


// -------- UiHelpers Template Data ----------

const String kAppTemplateUiHelpersPath =
    'lib/ui/common/ui_helpers.dart.stk';

const String kAppTemplateUiHelpersContent = '''
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

const String kAppTemplateAppStringsPath =
    'lib/ui/common/app_strings.dart.stk';

const String kAppTemplateAppStringsContent = '''
const String ksHomeBottomSheetTitle = 'Build Great Apps!';
const String ksHomeBottomSheetDescription =
    'Stacked is built to help you build better apps. Give us a chance and we\\'ll prove it to you. Check out stacked.filledstacks.com to learn more';

''';

// --------------------------------------------------


// -------- AppColors Template Data ----------

const String kAppTemplateAppColorsPath =
    'lib/ui/common/app_colors.dart.stk';

const String kAppTemplateAppColorsContent = '''
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


// -------- NoticeSheet Template Data ----------

const String kAppTemplateNoticeSheetPath =
    'lib/ui/bottom_sheets/notice_sheet/notice_sheet.dart.stk';

const String kAppTemplateNoticeSheetContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

class NoticeSheet extends StatelessWidget {
  final Function(SheetResponse)? completer;
  final SheetRequest request;
  const NoticeSheet({
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
}

''';

// --------------------------------------------------


// -------- NoticeSheetViewmodel Template Data ----------

const String kAppTemplateNoticeSheetViewmodelPath =
    'lib/ui/bottom_sheets/notice_sheet/notice_sheet_viewmodel.dart.stk';

const String kAppTemplateNoticeSheetViewmodelContent = '''
// This file is here to show you that even bottom sheets can have its own viewmodels
''';

// --------------------------------------------------


// -------- InfoAlertDialog Template Data ----------

const String kAppTemplateInfoAlertDialogPath =
    'lib/ui/dialogs/info_alert/info_alert_dialog.dart.stk';

const String kAppTemplateInfoAlertDialogContent = '''
import 'package:flutter/material.dart';
import 'package:{{packageName}}/ui/common/app_colors.dart';
import 'package:{{packageName}}/ui/common/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

const double _graphicSize = 60;

class InfoAlertDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const InfoAlertDialog({
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
}

''';

// --------------------------------------------------


// -------- InfoAlertViewmodel Template Data ----------

const String kAppTemplateInfoAlertViewmodelPath =
    'lib/ui/dialogs/info_alert/info_alert_viewmodel.dart.stk';

const String kAppTemplateInfoAlertViewmodelContent = '''
// Dialogs should be treated exactly like a view. You should give it a viewmodel
// if you need to manage state in the viewmodel

''';

// --------------------------------------------------


// -------- HomeViewV1 Template Data ----------

const String kAppTemplateHomeViewV1Path =
    'lib/ui/views/home/home_view_v1.dart.stk';

const String kAppTemplateHomeViewV1Content = '''
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

const String kAppTemplateHomeViewPath =
    'lib/ui/views/home/home_view.dart.stk';

const String kAppTemplateHomeViewContent = '''
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

const String kAppTemplateHomeViewmodelPath =
    'lib/ui/views/home/home_viewmodel.dart.stk';

const String kAppTemplateHomeViewmodelContent = '''
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/{{{relativeLocatorPath}}}';
import 'package:{{packageName}}/enums/bottom_sheet_type.dart';
import 'package:{{packageName}}/enums/dialog_type.dart';
import 'package:{{packageName}}/ui/common/app_strings.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  String get counterLabel => 'Counter is: \$_counter';

  int _counter = 0;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Stacked Rocks!',
        description: 'Give stacked \$_counter stars on Github ');
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

const String kAppTemplateStartupViewmodelPath =
    'lib/ui/views/startup/startup_viewmodel.dart.stk';

const String kAppTemplateStartupViewmodelContent = '''
import 'package:stacked/stacked.dart';
import 'package:{{packageName}}/{{{relativeLocatorPath}}}';
import 'package:{{packageName}}/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    _navigationService.replaceWith(Routes.homeView);
  }
}

''';

// --------------------------------------------------


// -------- StartupViewV1 Template Data ----------

const String kAppTemplateStartupViewV1Path =
    'lib/ui/views/startup/startup_view_v1.dart.stk';

const String kAppTemplateStartupViewV1Content = '''
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

const String kAppTemplateStartupViewPath =
    'lib/ui/views/startup/startup_view.dart.stk';

const String kAppTemplateStartupViewContent = '''
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

const String kAppTemplateAppPath =
    'lib/app/app.dart.stk';

const String kAppTemplateAppContent = '''
import 'package:stacked/stacked_annotations.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/home/home_view.dart';
import 'package:{{packageName}}/{{{viewImportPath}}}/startup/startup_view.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(routes: [
  MaterialRoute(page: StartupView),
  MaterialRoute(page: HomeView),
  // @stacked-route
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: BottomSheetService),
  // @stacked-service
])
class App {}

''';

// --------------------------------------------------


// -------- DialogType Template Data ----------

const String kAppTemplateDialogTypePath =
    'lib/enums/dialog_type.dart.stk';

const String kAppTemplateDialogTypeContent = '''
enum DialogType {
  infoAlert,
}

''';

// --------------------------------------------------


// -------- BottomSheetType Template Data ----------

const String kAppTemplateBottomSheetTypePath =
    'lib/enums/bottom_sheet_type.dart.stk';

const String kAppTemplateBottomSheetTypeContent = '''
enum BottomSheetType {
  notice,
}

''';

// --------------------------------------------------


// -------- PubspecYamlStk Template Data ----------

const String kAppTemplatePubspecYamlStkPath =
    'pubspec.yaml.stk';

const String kAppTemplatePubspecYamlStkContent = '''
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
  
  stacked: ^3.1.0-beta.0
  stacked_services: ^0.9.8

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

  stacked_generator: ^0.8.1
  mockito: ^5.1.0

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


// -------- GenericViewmodelTest Template Data ----------

const String kViewTemplateGenericViewmodelTestPath =
    'test/viewmodels/generic_viewmodel_test.dart.stk';

const String kViewTemplateGenericViewmodelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorPath}}}';

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

const String kViewTemplateGenericViewmodelPath =
    'lib/ui/views/generic/generic_viewmodel.dart.stk';

const String kViewTemplateGenericViewmodelContent = '''
import 'package:stacked/stacked.dart';

class {{viewModelName}} extends BaseViewModel {
}
''';

// --------------------------------------------------


// -------- GenericView Template Data ----------

const String kViewTemplateGenericViewPath =
    'lib/ui/views/generic/generic_view.dart.stk';

const String kViewTemplateGenericViewContent = '''
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

const String kViewTemplateGenericViewV1Path =
    'lib/ui/views/generic/generic_view_v1.dart.stk';

const String kViewTemplateGenericViewV1Content = '''
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


// -------- GenericServiceTest Template Data ----------

const String kServiceTemplateGenericServiceTestPath =
    'test/services/generic_service_test.dart.stk';

const String kServiceTemplateGenericServiceTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/{{{relativeLocatorPath}}}';

import '{{{serviceTestHelpersImport}}}';

void main() {
  group('{{serviceName}}ServiceTest -', () {
    setUp(() => {{registerMocksFunction}}());
    tearDown(() => {{locatorName}}.reset());
  });
}

''';

// --------------------------------------------------


// -------- GenericService Template Data ----------

const String kServiceTemplateGenericServicePath =
    'lib/services/generic_service.dart.stk';

const String kServiceTemplateGenericServiceContent = '''
class {{serviceName}}Service {

}
''';

// --------------------------------------------------

