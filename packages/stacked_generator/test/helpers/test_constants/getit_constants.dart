const kStackedLocaterWithOneDependencyOutput = '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final ebraLocator = StackedLocator.instance;

Future<void> ebraLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
ebraLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
ebraLocator.registerSingleton(GeolocaorService()  );
}
''';
const kStackedLocaterWithTwoDependenciesOutput = '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';
import 'importTwo';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerSingleton(GeolocaorService()  );
filledstacksLocator.registerSingleton(FireService()  );
}
''';
const kStackedLocaterWithOneDependencyOutputWithImports = '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerSingleton(GeolocaorService()  , instanceName: 'instance1');
}
''';

const kStackedLocaterWithOneDependencyOutputWithAbstractedImport = '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'abstractedImportOne';
import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerSingleton(GeolocaorService()  );
}
''';
const kStackedLocaterWithOneDependencyOutputWithAbstractedTypeClassName = '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerSingleton<abstractedTypeClassNamee>(GeolocaorService()  );
}
''';
const kStackedLocaterWithOneDependencyOutputWithEnviroments = '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerSingleton(GeolocaorService()  ,registerFor:{"dev","prod"}, instanceName: 'instance1');
}
''';
const kStackedLocaterWithOneDependencyOutputWithPresolveFunctionAndDependencyTypePresolvedSingleton =
    '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
        final geolocaorService = await GeolocaorService.staticPresolveFunction();
        filledstacksLocator.registerSingleton(geolocaorService  , instanceName: 'instance1');
        
}
''';
const kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactory = '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerFactory(() => GeolocaorService()  , instanceName: 'instance1');
}
''';
const kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParams =
    '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerFactoryParam<GeolocaorService,newType?,dynamic>((param1, param2) => GeolocaorService(null:param1)  );
}
''';
const kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndDefaultValue =
    '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerFactoryParam<GeolocaorService,newType?,dynamic>((param1, param2) => GeolocaorService(null:param1 ?? shit)  );
}
''';
const kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndIsPositionalIsTrue =
    '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerFactoryParam<GeolocaorService,newType?,dynamic>((param1, param2) => GeolocaorService(param1)  );
}
''';
const kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndDefaultValueIsshitAndIsPositionalIsTrue =
    '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerFactoryParam<GeolocaorService,newType?,dynamic>((param1, param2) => GeolocaorService(param1 ?? shit)  );
}
''';
const kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndIsNameIsHello =
    '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerFactoryParam<GeolocaorService,newType?,dynamic>((param1, param2) => GeolocaorService(hello:param1)  );
}
''';
const kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndTwoFactoryParam =
    '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerFactoryParam<GeolocaorService,newType?,freshType?>((param1, param2) => GeolocaorService(hello:param1,helloThere:param2)  , instanceName: 'instance1');
}
''';
const kStackedLocaterWithOneDependencyOutputWithDependencyTypeSinglton = '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerSingleton(GeolocaorService()  );
}
''';

const kStackedLocaterWithOneDependencyOutputWithDependencyTypeLazySinglton = '''
// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';

import 'importOne';

final filledstacksLocator = StackedLocator.instance;

Future<void> filledstacksLocatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {

// Register environments
filledstacksLocator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

// Register dependencies
filledstacksLocator.registerLazySingleton(() => GeolocaorService() , instanceName: 'instance1');
}
''';
