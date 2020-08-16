import 'package:stacked_localisation/src/setup_locator.dart';
import 'package:stacked_localisation/src/utils/locale_provider.dart';
import 'package:stacked_localisation/src/utils/string_reader.dart';

class LocalisationService {
  final _localeProvider = locator<LocaleProvider>();
  final _stringReader = locator<StringReader>();

  /// Stores the Strings for the locale that the service was initialised with
  Map<String, String> _localisedStrings;

  String operator [](String key) => _localisedStrings[key];

  Future initialise() async {
    var locale = await _localeProvider.getCurrentLocale();
    _localisedStrings = await _stringReader.getStringsFromAssets(locale);
  }

  /// Registers the classes required for the localisation service to work.
  /// This function HAS to be called before the application is started.
  static void setupLocator() {
    locator.registerLazySingleton(() => LocaleProvider());
    locator.registerLazySingleton(() => StringReader());
  }
}
