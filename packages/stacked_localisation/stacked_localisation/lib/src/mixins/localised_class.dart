import 'package:stacked_localisation/src/setup_locator.dart';
import 'package:stacked_localisation/stacked_localisation.dart';

mixin LocalisedClass {
  final _localisationService = locator<LocalisationService>();
  String translate(String key) => _localisationService[key];
}
