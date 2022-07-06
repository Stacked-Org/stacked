const kRouterWithNamePathNameClassName = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterWithEmptyRoutes = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const all = <String>{
};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
}
''';
const kRouterWithThreeNamePathNameClassName = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView1 = 'pathNamaw1';
static const String loginView2 = 'pathNamaw2';
static const String loginView3 = 'pathNamaw3';
static const all = <String>{
loginView1,loginView2,loginView3,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView1
,page: TestClass1
),
RouteDef(RoutesTestClassName.loginView2
,page: TestClass2
),
RouteDef(RoutesTestClassName.loginView3
,page: TestClass3
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass1: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass1(), settings: data,);
},TestClass2: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass2(), settings: data,);
},TestClass3: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass3(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView1()
 => push(RoutesTestClassName.loginView1);

Future pushLoginView2()
 => push(RoutesTestClassName.loginView2);

Future pushLoginView3()
 => push(RoutesTestClassName.loginView3);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass1( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView1, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToTestClass2( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView2, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToTestClass3( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView3, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterWithNamePathNameClassNameFullScreenDialogIsTrue = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(), settings: data,fullscreenDialog:true,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterWithHasConstConstructorIsTrue = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) => const  TestClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithHasWrapperIsTrue = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass().wrappedRoute(context), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithImports = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'import one';
import 'import two';
class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithMaintainStateIsFalse = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(), settings: data,maintainState:false,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterWithParameterPathFalseQueryFalse = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
var args = data.getArgs<TestClassArguments>(
orElse: ()=> TestClassArguments(),);return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(null:args.null), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(null: null),);

}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// TestClass arguments holder class
class TestClassArguments{
final null null;
TestClassArguments({
this.null});
}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
null null
,      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
arguments: TestClassArguments(
      null: null
    ),
     
      
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterWithParameterPathTrueQueryFalse = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(null:data.pathParams['null'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(null: null),);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithParameterPathFalseQueryTrue = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(null:data.queryParams['null'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(null: null),);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterWithParameterPathFalseQueryTrueAlias = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(null:data.queryParams['aliaso'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(null: null),);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithParameterPathFalseQueryTrueDefaultCode2 = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(null:data.queryParams['null'].value(2)), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null = 2,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(null: null),);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithParameterPathFalseQueryTrueImports = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'parameter/import1';
import 'parameter/import2';
class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(null:data.queryParams['null'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(null: null),);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithParameterPathFalseQueryTrueIsPositionalTrue = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(data.queryParams['null'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({@required null null,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(null: null),);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithParameterPathFalseQueryTrueIsRequiredTrue = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(null:data.queryParams['null'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({@required null null,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(null: null),);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithParameterPathFalseQueryTrueIsRequiredTrueName = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(ebra:data.queryParams['ebra'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null ebra,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(ebra: ebra),);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterWithParameterPathFalseQueryFalseType = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
var args = data.getArgs<TestClassArguments>(
orElse: ()=> TestClassArguments(),);return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass(null:args.null), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({newType null,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(null: null),);

}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// TestClass arguments holder class
class TestClassArguments{
final newType null;
TestClassArguments({
this.null});
}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
newType null
,      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
arguments: TestClassArguments(
      null: null
    ),
     
      
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithRetrunType = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<returnYpe>(builder: (context) =>   TestClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future<returnYpe> pushLoginView()
 => push<returnYpe>(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<returnYpe?>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithRetrunTypeCupertinoRoute = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return MaterialPageRoute<CupertinoRoute>(builder: (context) =>   TestClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future<<CupertinoRoute>> pushLoginView()
 => push<<CupertinoRoute>>(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<CupertinoRoute?>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithNestedRouter = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView1 = 'pathNamaw1';
static const all = <String>{
loginView1,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView1
,page: TestClass1
,generator: LoginView1Router(),
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass1: (data) {
return MaterialPageRoute<returnYpe1>(builder: (context) =>   TestClass1(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future<returnYpe1> pushLoginView1()
 => push<returnYpe1>(RoutesTestClassName.loginView1);

}
class LoginView1Routes {
static const String nestedView1 = 'nestedPath1';
static const all = <String>{
nestedView1,};}

class LoginView1Router extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(LoginView1Routes.nestedView1
,page: nestedClass1
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

nestedClass1: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   nestedClass1(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension LoginView1RouterExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushNestedView1()
 => push(LoginView1Routes.nestedView1);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<returnYpe1?>
navigateToTestClass1( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView1, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToNestednestedClass1( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(LoginView1Routes.nestedView1, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterWithMultipleNestedRouter = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView1 = 'pathNamaw1';
static const all = <String>{
loginView1,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView1
,page: TestClass1
,generator: LoginView1Router(),
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass1: (data) {
return MaterialPageRoute<returnYpe1>(builder: (context) =>   TestClass1(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future<returnYpe1> pushLoginView1()
 => push<returnYpe1>(RoutesTestClassName.loginView1);

}
class LoginView1Routes {
static const String nestedView1 = 'nestedPath1';
static const all = <String>{
nestedView1,};}

class LoginView1Router extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(LoginView1Routes.nestedView1
,page: nestedClass1
,generator: NestedView1Router(),
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

nestedClass1: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   nestedClass1(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension LoginView1RouterExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushNestedView1()
 => push(LoginView1Routes.nestedView1);

}
class NestedView1Routes {
static const String multiNestedmultiNestedView1 = 'multiNestedmultiNestedPath1';
static const all = <String>{
multiNestedmultiNestedView1,};}

class NestedView1Router extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(NestedView1Routes.multiNestedmultiNestedView1
,page: multiNestedmultiNestedClass1
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

multiNestedmultiNestedClass1: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   multiNestedmultiNestedClass1(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension NestedView1RouterExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushMultiNestedmultiNestedView1()
 => push(NestedView1Routes.multiNestedmultiNestedView1);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<returnYpe1?>
navigateToTestClass1( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView1, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToNestednestedClass1( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(LoginView1Routes.nestedView1, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToNestedmultiNestedmultiNestedClass1( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(NestedView1Routes.multiNestedmultiNestedView1, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithThreeNestedRouter = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView2 = 'pathNamaw2';
static const all = <String>{
loginView2,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView2
,page: TestClass2
,generator: LoginView2Router(),
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass2: (data) {
return MaterialPageRoute<returnYpe2>(builder: (context) =>   TestClass2(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future<returnYpe2> pushLoginView2()
 => push<returnYpe2>(RoutesTestClassName.loginView2);

}
class LoginView2Routes {
static const String firstView = 'firstPath';
static const String secondView = 'secondPath';
static const String thirdView = 'thirdPath';
static const all = <String>{
firstView,secondView,thirdView,};}

class LoginView2Router extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(LoginView2Routes.firstView
,page: firstClass
),
RouteDef(LoginView2Routes.secondView
,page: secondClass
),
RouteDef(LoginView2Routes.thirdView
,page: thirdClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

firstClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   firstClass(), settings: data,);
},secondClass: (data) {
return CupertinoPageRoute<dynamic>(builder: (context) =>   secondClass(), settings: data,);
},thirdClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   thirdClass(), settings: data,transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          });
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension LoginView2RouterExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushFirstView()
 => push(LoginView2Routes.firstView);

Future pushSecondView()
 => push(LoginView2Routes.secondView);

Future pushThirdView()
 => push(LoginView2Routes.thirdView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<returnYpe2?>
navigateToTestClass2( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView2, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToNestedfirstClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(LoginView2Routes.firstView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToNestedsecondClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(LoginView2Routes.secondView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToNestedthirdClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(LoginView2Routes.thirdView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithSixNestedRouter = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView3 = 'pathNamaw3';
static const String loginView4 = 'pathNamaw4';
static const all = <String>{
loginView3,loginView4,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView3
,page: TestClass3
,generator: LoginView3Router(),
),
RouteDef(RoutesTestClassName.loginView4
,page: TestClass4
,generator: LoginView4Router(),
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass3: (data) {
return MaterialPageRoute<returnYpe3>(builder: (context) =>   TestClass3(), settings: data,);
},TestClass4: (data) {
return buildAdaptivePageRoute<returnYpe4>(builder: (context) =>   TestClass4(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future<returnYpe3> pushLoginView3()
 => push<returnYpe3>(RoutesTestClassName.loginView3);

Future<returnYpe4> pushLoginView4()
 => push<returnYpe4>(RoutesTestClassName.loginView4);

}
class LoginView3Routes {
static const String firstView = 'firstPath';
static const String secondView = 'secondPath';
static const String thirdView = 'thirdPath';
static const all = <String>{
firstView,secondView,thirdView,};}

class LoginView3Router extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(LoginView3Routes.firstView
,page: firstClass
),
RouteDef(LoginView3Routes.secondView
,page: secondClass
),
RouteDef(LoginView3Routes.thirdView
,page: thirdClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

firstClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   firstClass(), settings: data,);
},secondClass: (data) {
return CupertinoPageRoute<dynamic>(builder: (context) =>   secondClass(), settings: data,);
},thirdClass: (data) {
return buildAdaptivePageRoute<dynamic>(builder: (context) =>   thirdClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension LoginView3RouterExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushFirstView()
 => push(LoginView3Routes.firstView);

Future pushSecondView()
 => push(LoginView3Routes.secondView);

Future pushThirdView()
 => push(LoginView3Routes.thirdView);

}
class LoginView4Routes {
static const String fourthView = 'fourthPath';
static const String fifthView = 'fifthPath';
static const String sixthView = 'sixthPath';
static const all = <String>{
fourthView,fifthView,sixthView,};}

class LoginView4Router extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(LoginView4Routes.fourthView
,page: fourthClass
),
RouteDef(LoginView4Routes.fifthView
,page: fifthClass
),
RouteDef(LoginView4Routes.sixthView
,page: sixthClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

fourthClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   fourthClass(), settings: data,);
},fifthClass: (data) {
return CupertinoPageRoute<dynamic>(builder: (context) =>   fifthClass(), settings: data,);
},sixthClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   sixthClass(), settings: data,transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          });
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension LoginView4RouterExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushFourthView()
 => push(LoginView4Routes.fourthView);

Future pushFifthView()
 => push(LoginView4Routes.fifthView);

Future pushSixthView()
 => push(LoginView4Routes.sixthView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<returnYpe3?>
navigateToTestClass3( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView3, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToNestedfirstClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(LoginView3Routes.firstView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToNestedsecondClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(LoginView3Routes.secondView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToNestedthirdClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(LoginView3Routes.thirdView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<returnYpe4?>
navigateToTestClass4( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView4, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToNestedfourthClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(LoginView4Routes.fourthView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToNestedfifthClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(LoginView4Routes.fifthView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToNestedsixthClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(LoginView4Routes.sixthView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterTypeCupertinoWithNamePathNameClassName = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return CupertinoPageRoute<dynamic>(builder: (context) =>   TestClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterTypeCupertinoWithCupertinoNavTitle = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return CupertinoPageRoute<dynamic>(builder: (context) =>   TestClass(), settings: data,title:'cupertinoNavTitle',);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterTypeCupertinoWithParametersPathFalseQueryFalse = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
var args = data.getArgs<TestClassArguments>(
orElse: ()=> TestClassArguments(),);return CupertinoPageRoute<dynamic>(builder: (context) =>   TestClass(null:args.null), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(null: null),);

}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// TestClass arguments holder class
class TestClassArguments{
final null null;
TestClassArguments({
this.null});
}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
null null
,      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
arguments: TestClassArguments(
      null: null
    ),
     
      
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterTypeAdaptive = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return buildAdaptivePageRoute<dynamic>(builder: (context) =>   TestClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterTypeAdaptiveWithCupertinoNavTitle = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return buildAdaptivePageRoute<dynamic>(builder: (context) =>   TestClass(), settings: data,cupertinoTitle:'cupertinooo',);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterTypeAdaptiveWithParametersPathFalseQueryFalse = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
var args = data.getArgs<TestClassArguments>(
orElse: ()=> TestClassArguments(),);return buildAdaptivePageRoute<dynamic>(builder: (context) =>   TestClass(null:args.null), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(null: null),);

}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// TestClass arguments holder class
class TestClassArguments{
final null null;
TestClassArguments({
this.null});
}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
null null
,      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
arguments: TestClassArguments(
      null: null
    ),
     
      
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterTypeCustom = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   TestClass(), settings: data,transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          });
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterTypeCustomWithbarrierDismissible = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   TestClass(), settings: data,transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          });
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterTypeCustomWithTransitionDuration = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   TestClass(), settings: data,transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          }transitionDuration: const Duration(milliseconds: 22),);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterTypeCustomWithReverseDurationInMilliseconds = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   TestClass(), settings: data,transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          }reverseTransitionDuration: const Duration(milliseconds: 2),);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterTypeCustomWithCustomRouteOpaqueFalse = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   TestClass(), settings: data,opaque:false,transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          });
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesTestClassName.loginView);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterTypeCustomWithParametersPathFalseQueryFalse = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
var args = data.getArgs<TestClassArguments>(
orElse: ()=> TestClassArguments(),);return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   TestClass(null:args.null), settings: data,transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          });
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(null: null),);

}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// TestClass arguments holder class
class TestClassArguments{
final null null;
TestClassArguments({
this.null});
}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
null null
,      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
arguments: TestClassArguments(
      null: null
    ),
     
      
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterTypeCustomWithParametersPathFalseQueryTrue = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView
,page: TestClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   TestClass(null:data.queryParams['null'].value()), settings: data,transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          });
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesTestClassName.loginView,arguments: TestClassArguments(null: null),);

}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterMixin = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutesTestClassName {
static const String loginView1 = 'pathNamaw1';
static const String loginView2 = 'pathNamaw2';
static const String loginView3 = 'pathNamaw3';
static const String loginView4 = 'pathNamaw4';
static const String loginView5 = 'pathNamaw5';
static const String loginView6 = 'pathNamaw6';
static const all = <String>{
loginView1,loginView2,loginView3,loginView4,loginView5,loginView6,};}

class RouterTestClassName extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesTestClassName.loginView1
,page: TestClass1
),
RouteDef(RoutesTestClassName.loginView2
,page: TestClass2
),
RouteDef(RoutesTestClassName.loginView3
,page: TestClass3
),
RouteDef(RoutesTestClassName.loginView4
,page: TestClass4
),
RouteDef(RoutesTestClassName.loginView5
,page: TestClass5
),
RouteDef(RoutesTestClassName.loginView6
,page: TestClass6
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

TestClass1: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   TestClass1(), settings: data,transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          }transitionDuration: const Duration(milliseconds: 22),reverseTransitionDuration: const Duration(milliseconds: 2),);
},TestClass2: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass2(null:data.queryParams['null'].value()), settings: data,);
},TestClass3: (data) {
var args = data.getArgs<TestClass3Arguments>(
orElse: ()=> TestClass3Arguments(),);return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass3(null:args.null), settings: data,);
},TestClass4: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   TestClass4(), settings: data,maintainState:false,);
},TestClass5: (data) {
return buildAdaptivePageRoute<dynamic>(builder: (context) =>   TestClass5(), settings: data,cupertinoTitle:'cupertinooo',);
},TestClass6: (data) {
return CupertinoPageRoute<dynamic>(builder: (context) =>   TestClass6(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterTestClassNameExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView1()
 => push(RoutesTestClassName.loginView1);

Future pushLoginView2({null null,})
 => push(RoutesTestClassName.loginView2,arguments: TestClass2Arguments(null: null),);

Future pushLoginView3({null null,})
 => push(RoutesTestClassName.loginView3,arguments: TestClass3Arguments(null: null),);

Future pushLoginView4()
 => push(RoutesTestClassName.loginView4);

Future pushLoginView5()
 => push(RoutesTestClassName.loginView5);

Future pushLoginView6()
 => push(RoutesTestClassName.loginView6);

}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// TestClass3 arguments holder class
class TestClass3Arguments{
final null null;
TestClass3Arguments({
this.null});
}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {

Future<dynamic>
navigateToTestClass1( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView1, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToTestClass2( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView2, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToTestClass3( {
null null
,      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView3, 
arguments: TestClass3Arguments(
      null: null
    ),
     
      
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToTestClass4( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView4, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToTestClass5( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView5, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }


Future<dynamic>
navigateToTestClass6( {
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      
}
) async { return navigateTo(Routes.loginView6, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
