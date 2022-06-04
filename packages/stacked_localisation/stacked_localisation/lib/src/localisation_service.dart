import 'package:flutter/material.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_localisation/src/setup_locator.dart';
import 'package:stacked_localisation/src/utils/locale_provider.dart';
import 'package:stacked_localisation/src/utils/string_reader.dart';

class LocalisationService with WidgetsBindingObserver {
  final _localeProvider = locator<LocaleProvider>();
  final _stringReader = locator<StringReader>();

  static LocalisationService? _instance = null;

  static Future<LocalisationService> getInstance() async {
    if (_instance == null) {
      _setupLocator();
      _instance = LocalisationService();
      await _instance?.initialise();
    }
    return _instance!;
  }

  LocalisationService() {
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
  }

  /// Stores the Strings for the locale that the service was initialised with
  Map<String, String>? _localisedStrings = null;

  String operator [](String key) => _localisedStrings?[key] ?? key;

  Future initialise() async {
    var locale = await _localeProvider.getCurrentLocale();
    _localisedStrings = await _stringReader.getStringsFromAssets(locale);
  }

  /// Registers the classes required for the localisation service to work.
  /// This function HAS to be called before the application is started.
  static void _setupLocator() {
    locator.registerLazySingleton(() => LocaleProvider());
    locator.registerLazySingleton(() => StringReader());
  }

  @override
  void didChangeLocales(List<Locale>? locale) async {
    final currentLocale = locale?.first.toString();
    if (currentLocale?.isNotEmpty == true) {
      _localisedStrings =
          await _stringReader.getStringsFromAssets(currentLocale!);
    }
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   // If the user changes language on the device and come back to the app,
  //   // it will trigger this function with AppLifecycleState.resumed
  //   if (state == AppLifecycleState.resumed) {
  //     await _instance.initialise();
  //   }
  // }
}
