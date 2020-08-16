import 'package:devicelocale/devicelocale.dart';

/// Uses the Flutter framework to get the devices selected locale
class LocaleProvider {
  Future<String> getCurrentLocale() {
    return Devicelocale.currentLocale;
  }
}
