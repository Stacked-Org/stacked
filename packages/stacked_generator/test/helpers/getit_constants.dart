final kStackedLocaterContentGeneratorResult = '''
// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'importOne';

final ebraLocator = StackedLocator.instance;

void ebraLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter})  {

// Register environments
ebraLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
ebraLocator.registerSingleton(GeolocaorService()  );
}
''';
