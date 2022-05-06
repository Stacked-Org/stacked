final kStackedLocaterWithOneDependencyOutput = '''
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
final kStackedLocaterWithTwoDependenciesOutput = '''
// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'importOne';
import 'importTwo';

final filledstacksLocator = StackedLocator.instance;

void filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter})  {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerSingleton(GeolocaorService()  );
filledstacksLocator.registerSingleton(FireService()  );
}
''';
final kStackedLocaterWithOneDependencyOutputWithImports = '''
// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'importOne';
import 'importsSetOne';
import 'importsSetTwo';

final filledstacksLocator = StackedLocator.instance;

void filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter})  {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerSingleton(GeolocaorService()  );
}
''';

final kStackedLocaterWithOneDependencyOutputWithAbstractedImport = '''
// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'abstractedImportOne';
import 'importOne';

final filledstacksLocator = StackedLocator.instance;

void filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter})  {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerSingleton(GeolocaorService()  );
}
''';
final kStackedLocaterWithOneDependencyOutputWithAbstractedTypeClassName = '''
// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

void filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter})  {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerSingleton<abstractedTypeClassNamee>(GeolocaorService()  );
}
''';
final kStackedLocaterWithOneDependencyOutputWithEnviroments = '''
// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

void filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter})  {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerSingleton(GeolocaorService()  ,registerFor:{"dev","prod"});
}
''';
final kStackedLocaterWithOneDependencyOutputWithPresolveFunctionAndDependencyTypePresolvedSingleton =
    '''
// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
        final geolocaorService = await GeolocaorService.staticPresolveFunction();
        filledstacksLocator.registerSingleton(geolocaorService  );
        
}
''';
final kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactory = '''
// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

void filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter})  {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerFactory(() => GeolocaorService()  );
}
''';
final kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParams =
    '''
// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

void filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter})  {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerFactory(() => GeolocaorService()  );
}
''';
