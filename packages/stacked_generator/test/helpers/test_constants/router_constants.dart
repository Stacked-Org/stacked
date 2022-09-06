const kRouterWithNamePathNameClassName = '''
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i3;

import 'test.dart' as _i2;

class RoutesTestClassName {
  static const loginView = 'pathNamaw';

  static const all = <String>{loginView};
}

class RouterTestClassName extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(RoutesTestClassName.loginView, page: _i2.TestClass)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.TestClass: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i2.TestClass(),
        settings: data,
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

extension NavigatorStateExtension on _i3.NavigationService {
  Future<dynamic> navigateToTestClass(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
''';

const kRouterWithEmptyRoutes = '''
import 'package:stacked/stacked.dart' as _i1;

class RoutesTestClassName {
  static const all = <String>{};
}

class RouterTestClassName extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{};

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
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
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i4;

import 'nested_test1.dart' as _i3;
import 'test1.dart' as _i2;

class RoutesTestClassName {
  static const loginView1 = 'pathNamaw1';

  static const all = <String>{loginView1};
}

class RouterTestClassName extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(RoutesTestClassName.loginView1, page: _i2.TestClass1)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.TestClass1: (data) {
      return MaterialPageRoute<returnYpe1>(
        builder: (context) => _i2.TestClass1(),
        settings: data,
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class LoginView1Routes {
  static const nestedView1 = 'nestedPath1';

  static const all = <String>{nestedView1};
}

class LoginView1Router extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(LoginView1Routes.nestedView1, page: _i3.nestedClass1)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i3.nestedClass1: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i3.nestedClass1(),
        settings: data,
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

extension NavigatorStateExtension on _i4.NavigationService {
  Future<returnYpe1?> navigateToTestClass1(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<returnYpe1?>(Routes.loginView1,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNestednestedClass1InParentClass(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(ParentClassRoutes.nestedView1,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
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
) async { return navigateTo<returnYpe1?>(Routes.loginView1, 
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
) async { return navigateTo<dynamic>(LoginView1Routes.nestedView1, 
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
) async { return navigateTo<dynamic>(NestedView1Routes.multiNestedmultiNestedView1, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterWithThreeNestedRouter = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i4;

import 'nested_test1.dart' as _i3;
import 'test1.dart' as _i2;

class RoutesTestClassName {
  static const loginView1 = 'pathNamaw1';

  static const all = <String>{loginView1};
}

class RouterTestClassName extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(RoutesTestClassName.loginView1, page: _i2.TestClass1)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.TestClass1: (data) {
      return MaterialPageRoute<returnYpe1>(
        builder: (context) => _i2.TestClass1(),
        settings: data,
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class LoginView1Routes {
  static const nestedView1 = 'nestedPath1';

  static const all = <String>{nestedView1};
}

class LoginView1Router extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(LoginView1Routes.nestedView1, page: _i3.nestedClass1)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i3.nestedClass1: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i3.nestedClass1(),
        settings: data,
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

extension NavigatorStateExtension on _i4.NavigationService {
  Future<returnYpe1?> navigateToTestClass1(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<returnYpe1?>(Routes.loginView1,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNestednestedClass1InParentClass(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(ParentClassRoutes.nestedView1,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
''';
const kRouterWithSixNestedRouter = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
          },);
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
) async { return navigateTo<returnYpe3?>(Routes.loginView3, 
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
) async { return navigateTo<dynamic>(LoginView3Routes.firstView, 
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
) async { return navigateTo<dynamic>(LoginView3Routes.secondView, 
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
) async { return navigateTo<dynamic>(LoginView3Routes.thirdView, 
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
) async { return navigateTo<returnYpe4?>(Routes.loginView4, 
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
) async { return navigateTo<dynamic>(LoginView4Routes.fourthView, 
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
) async { return navigateTo<dynamic>(LoginView4Routes.fifthView, 
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
) async { return navigateTo<dynamic>(LoginView4Routes.sixthView, 
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
) async { return navigateTo<dynamic>(Routes.loginView, 
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
) async { return navigateTo<dynamic>(Routes.loginView, 
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
) async { return navigateTo<dynamic>(Routes.loginView, 
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
) async { return navigateTo<dynamic>(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterTypeAdaptiveWithCupertinoNavTitle = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

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
) async { return navigateTo<dynamic>(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';
const kRouterTypeAdaptiveWithParametersPathFalseQueryFalse = '''
// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

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
) async { return navigateTo<dynamic>(Routes.loginView, 
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
          },);
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
) async { return navigateTo<dynamic>(Routes.loginView, 
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
          },);
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
) async { return navigateTo<dynamic>(Routes.loginView, 
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
          },transitionDuration: const Duration(milliseconds: 22),);
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
) async { return navigateTo<dynamic>(Routes.loginView, 
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
          },reverseTransitionDuration: const Duration(milliseconds: 2),);
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
) async { return navigateTo<dynamic>(Routes.loginView, 
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
          },);
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
) async { return navigateTo<dynamic>(Routes.loginView, 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        
); }

}
''';

const kRouterWithAliasedImport = '''
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i4;

import 'map.dart' as _i3;
import 'test.dart' as _i2;

class RoutesTestClassName {
  static const loginView = 'pathNamaw';

  static const all = <String>{loginView};
}

class RouterTestClassName extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(RoutesTestClassName.loginView, page: _i2.TestClass)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.TestClass: (data) {
      final args = data.getArgs<TestClassArguments>(
        orElse: () => const TestClassArguments(),
      );
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i2.TestClass(markers: args.markers),
        settings: data,
        transitionsBuilder: data.transition ??
            (context, animation, secondaryAnimation, child) {
              return child;
            },
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class TestClassArguments {
  const TestClassArguments({this.markers});

  final List<_i3.Marker> markers;
}

extension NavigatorStateExtension on _i4.NavigationService {
  Future<dynamic> navigateToTestClass(
      {List<_i3.Marker> markers,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments: TestClassArguments(markers: markers),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
''';
const kParameterTypeString = '''
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i4;

import 'map.dart' as _i3;
import 'test.dart' as _i2;

class RoutesTestClassName {
  static const loginView = 'pathNamaw';

  static const all = <String>{loginView};
}

class RouterTestClassName extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(RoutesTestClassName.loginView, page: _i2.TestClass)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.TestClass: (data) {
      final args = data.getArgs<TestClassArguments>(
        orElse: () => const TestClassArguments(),
      );
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i2.TestClass(name: args.name),
        settings: data,
        transitionsBuilder: data.transition ??
            (context, animation, secondaryAnimation, child) {
              return child;
            },
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class TestClassArguments {
  const TestClassArguments({this.name});

  final _i3.String name;
}

extension NavigatorStateExtension on _i4.NavigationService {
  Future<dynamic> navigateToTestClass(
      {_i3.String name,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments: TestClassArguments(name: name),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
''';
const kRouterMixin = '''
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/cupertino.dart' as _i8;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i10;

import 'test1.dart' as _i2;
import 'test2.dart' as _i3;
import 'test3.dart' as _i4;
import 'test3type.dart' as _i9;
import 'test4.dart' as _i5;
import 'test5.dart' as _i6;
import 'test6.dart' as _i7;

class RoutesTestClassName {
  static const loginView1 = 'pathNamaw1';

  static const loginView2 = 'pathNamaw2';

  static const loginView3 = 'pathNamaw3';

  static const loginView4 = 'pathNamaw4';

  static const loginView5 = 'pathNamaw5';

  static const loginView6 = 'pathNamaw6';

  static const all = <String>{
    loginView1,
    loginView2,
    loginView3,
    loginView4,
    loginView5,
    loginView6
  };
}

class RouterTestClassName extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(RoutesTestClassName.loginView1, page: _i2.TestClass1),
    _i1.RouteDef(RoutesTestClassName.loginView2, page: _i3.TestClass2),
    _i1.RouteDef(RoutesTestClassName.loginView3, page: _i4.TestClass3),
    _i1.RouteDef(RoutesTestClassName.loginView4, page: _i5.TestClass4),
    _i1.RouteDef(RoutesTestClassName.loginView5, page: _i6.TestClass5),
    _i1.RouteDef(RoutesTestClassName.loginView6, page: _i7.TestClass6)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.TestClass1: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i2.TestClass1(),
        settings: data,
        transitionsBuilder: data.transition ??
            (context, animation, secondaryAnimation, child) {
              return child;
            },
        transitionDuration: const Duration(milliseconds: 22),
        reverseTransitionDuration: const Duration(milliseconds: 2),
      );
    },
    _i3.TestClass2: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i3.TestClass2(
            test2paramName: data.queryParams['test2paramName'].value()),
        settings: data,
      );
    },
    _i4.TestClass3: (data) {
      final args = data.getArgs<TestClass3Arguments>(
        orElse: () => const TestClass3Arguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i4.TestClass3(test3paramName: args.test3paramName),
        settings: data,
      );
    },
    _i5.TestClass4: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i5.TestClass4(),
        settings: data,
        maintainState: false,
      );
    },
    _i6.TestClass5: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i6.TestClass5(),
        settings: data,
        cupertinoTitle: 'cupertinooo',
      );
    },
    _i7.TestClass6: (data) {
      return _i8.CupertinoPageRoute<dynamic>(
        builder: (context) => _i7.TestClass6(),
        settings: data,
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class TestClass3Arguments {
  const TestClass3Arguments({this.test3paramName});

  final _i9.Test3Type test3paramName;
}

extension NavigatorStateExtension on _i10.NavigationService {
  Future<dynamic> navigateToTestClass1(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.loginView1,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTestClass2(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.loginView2,
        arguments: TestClass2Arguments(test2paramName: test2paramName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTestClass3(
      {_i9.Test3Type test3paramName,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    return navigateTo<dynamic>(Routes.loginView3,
        arguments: TestClass3Arguments(test3paramName: test3paramName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTestClass4(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.loginView4,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTestClass5(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.loginView5,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTestClass6(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.loginView6,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
''';
const kImportsWithoutAliasesTest = '''


import 'package:importone.dart';
import 'package:importtwo.dart';
import 'package:ClashTypeOne/ClashType.dart';
import 'package:flutter/material.dart';
import 'package:ClashTypeTwo/ClashType.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/bottom_nav/profile/profile_view.dart';
import '../ui/details/details_view.dart';
import '../ui/form/example_form_view.dart';
import '../ui/home/home_view.dart';
''';
const kImportsWithAliasesTest = '''

import 'package:ClashTypeOne/ClashType.dart' as i_0;
import 'package:ClashTypeTwo/ClashType.dart' as i_1;
import 'package:flutter/material.dart' as i_2;
import 'package:importone.dart' as i_3;
import 'package:importtwo.dart' as i_4;
import 'package:stacked/stacked.dart' as i_5;
import 'package:stacked_services/stacked_services.dart' as i_6;

''';
const kRoutesClass = '''
class RoutesClassName {
  static const loginView = 'pathNamaw';

  static const _homeView = '/family/:fid';

  static const all = <String>{loginView, _homeView};

  static String homeView({required dynamic fid}) => '/family/\$fid';
}
''';

const kRouterClass = '''
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:stacked/stacked.dart' as _i1;
import 'ui/login_class.dart' as _i2;
import 'ui/home_class.dart' as _i3;

class RouterClassName extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(RoutesClassName.loginView, page: _i2.LoginClass),
    _i1.RouteDef(RoutesClassName.homeView, page: _i3.HomeClass)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.LoginClass: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i2.LoginClass(),
        settings: data,
      );
    },
    _i3.HomeClass: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i3.HomeClass(),
        settings: data,
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}
''';

const kListOfRoutes = '''
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:stacked/stacked.dart' as _i1;
import 'ui/login_class.dart' as _i2;
import 'ui/home_class.dart' as _i3;

final _routes = <_i1.RouteDef>[
  _i1.RouteDef(RoutesClassName.loginView, page: _i2.LoginClass),
  _i1.RouteDef(RoutesClassName.homeView, page: _i3.HomeClass)
];
''';
const kRoutesGetter = '''
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:stacked/stacked.dart' as _i1;

@override
List<_i1.RouteDef> get routes => _routes;
''';
const kPagesMapGetter = '''
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:stacked/stacked.dart' as _i1;

@override
Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
''';
const kMapOfPagesForEmptyRoutes = '''
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:stacked/stacked.dart' as _i1;

final _pagesMap = <Type, _i1.StackedRouteFactory>{};
''';
const kMapOfPages = '''
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:stacked/stacked.dart' as _i1;
import 'ui/login_class.dart' as _i2;
import 'ui/home_class.dart' as _i3;

final _pagesMap = <Type, _i1.StackedRouteFactory>{
  _i2.LoginClass: (data) {
    return MaterialPageRoute<dynamic>(
      builder: (context) => _i2.LoginClass(),
      settings: data,
    );
  },
  _i3.HomeClass: (data) {
    final args = data.getArgs<HomeClassArguments>(nullOk: false);
    return MaterialPageRoute<dynamic>(
      builder: (context) => _i3.HomeClass(name: args.name),
      settings: data,
    );
  }
};
''';
const kRouteNavigationExtension = '''
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:stacked_services/stacked_services.dart' as _i1;
import 'marker.dart' as _i2;
import 'car.dart' as _i3;
import 'map.dart' as _i4;

extension NavigatorStateExtension on _i1.NavigationService {
  Future<dynamic> navigateToLoginClass(
      {required _i2.Marker position,
      int age,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments: LoginClassArguments(position: position, age: age),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeClass(
      {required _i3.Car car,
      int age,
      List<_i4.Marker> markers,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    return navigateTo<dynamic>(Routes.homeView,
        arguments: HomeClassArguments(car: car, age: age, markers: markers),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
''';
const kRouteClassArguments = '''
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'marker.dart' as _i1;
import 'car.dart' as _i2;

class LoginClassArguments {
  const LoginClassArguments({required this.position, this.age});

  final _i1.Marker position;

  final int age;
}

class HomeClassArguments {
  const HomeClassArguments({required this.car, this.age});

  final _i2.Car car;

  final int age;
}
''';
