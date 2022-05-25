const kRouterWithNamePathNameClassName = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';
const kRouterWithEmptyRoutes = '''
// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';

class RoutesClassB {
static const all = <String>{
};}

class RouterNamee extends RouterBase {
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

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
}
''';
const kRouterWithThreeNamePathNameClassName = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView1 = 'pathNamaw1';
static const String loginView2 = 'pathNamaw2';
static const String loginView3 = 'pathNamaw3';
static const all = <String>{
loginView1,loginView2,loginView3,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView1
,page: ebraClass1
),
RouteDef(RoutesClassB.loginView2
,page: ebraClass2
),
RouteDef(RoutesClassB.loginView3
,page: ebraClass3
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass1: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass1(), settings: data,);
},ebraClass2: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass2(), settings: data,);
},ebraClass3: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass3(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView1()
 => push(RoutesClassB.loginView1);

Future pushLoginView2()
 => push(RoutesClassB.loginView2);

Future pushLoginView3()
 => push(RoutesClassB.loginView3);

}
''';

const kRouterWithNamePathNameClassNameFullScreenDialogIsTrue = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,fullscreenDialog:true,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';

const kRouterWithOneGuard = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'guard/import.dart';
class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
,guards:[GuardType]
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';
const kRouterWithTwoGuards = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'guard/import.dart';
import 'guard/import2.dart';
class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
,guards:[GuardType, GuardType2?]
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';
const kRouterWithHasConstConstructorIsTrue = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) => const  ebraClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';
const kRouterWithHasWrapperIsTrue = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass().wrappedRoute(context), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';
const kRouterWithImports = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'import one';
import 'import two';
class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';
const kRouterWithMaintainStateIsFalse = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,maintainState:false,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';

const kRouterWithParameterPathFalseQueryFalse = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
var args = data.getArgs<ebraClassArguments>(
orElse: ()=> ebraClassArguments(),);return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(null:args.null), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(null: null),);

}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ebraClass arguments holder class
class ebraClassArguments{
final null null;
ebraClassArguments({
this.null});
}
''';

const kRouterWithParameterPathTrueQueryFalse = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(null:data.pathParams['null'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(null: null),);

}
''';
const kRouterWithParameterPathFalseQueryTrue = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(null:data.queryParams['null'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(null: null),);

}
''';

const kRouterWithParameterPathFalseQueryTrueAlias = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(null:data.queryParams['aliaso'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(null: null),);

}
''';
const kRouterWithParameterPathFalseQueryTrueDefaultCode2 = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(null:data.queryParams['null'].value(2)), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null = 2,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(null: null),);

}
''';
const kRouterWithParameterPathFalseQueryTrueImports = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'parameter/import1';
import 'parameter/import2';
class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(null:data.queryParams['null'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(null: null),);

}
''';
const kRouterWithParameterPathFalseQueryTrueIsPositionalTrue = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(data.queryParams['null'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({@required null null,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(null: null),);

}
''';
const kRouterWithParameterPathFalseQueryTrueIsRequiredTrue = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(null:data.queryParams['null'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({@required null null,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(null: null),);

}
''';
const kRouterWithParameterPathFalseQueryTrueIsRequiredTrueName = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(ebra:data.queryParams['ebra'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null ebra,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(ebra: ebra),);

}
''';

const kRouterWithParameterPathFalseQueryFalseType = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
var args = data.getArgs<ebraClassArguments>(
orElse: ()=> ebraClassArguments(),);return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(null:args.null), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({newType null,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(null: null),);

}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ebraClass arguments holder class
class ebraClassArguments{
final newType null;
ebraClassArguments({
this.null});
}
''';
const kRouterWithRetrunType = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<returnYpe>(builder: (context) =>   ebraClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future<returnYpe> pushLoginView()
 => push<returnYpe>(RoutesClassB.loginView);

}
''';
const kRouterWithRetrunTypeCupertinoRoute = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<CupertinoRoute>(builder: (context) =>   ebraClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future<<CupertinoRoute>> pushLoginView()
 => push<<CupertinoRoute>>(RoutesClassB.loginView);

}
''';
const kRouterWithNestedRouter = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView1 = 'pathNamaw1';
static const all = <String>{
loginView1,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView1
,page: ebraClass1
,generator: LoginView1Router(),
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass1: (data) {
return MaterialPageRoute<returnYpe1>(builder: (context) =>   ebraClass1(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future<returnYpe1> pushLoginView1()
 => push<returnYpe1>(RoutesClassB.loginView1);

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
''';

const kRouterWithMultipleNestedRouter = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView1 = 'pathNamaw1';
static const all = <String>{
loginView1,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView1
,page: ebraClass1
,generator: LoginView1Router(),
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass1: (data) {
return MaterialPageRoute<returnYpe1>(builder: (context) =>   ebraClass1(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future<returnYpe1> pushLoginView1()
 => push<returnYpe1>(RoutesClassB.loginView1);

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
''';
const kRouterWithThreeNestedRouter = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView2 = 'pathNamaw2';
static const all = <String>{
loginView2,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView2
,page: ebraClass2
,generator: LoginView2Router(),
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass2: (data) {
return MaterialPageRoute<returnYpe2>(builder: (context) =>   ebraClass2(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future<returnYpe2> pushLoginView2()
 => push<returnYpe2>(RoutesClassB.loginView2);

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
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   thirdClass(), settings: data,);
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
''';
const kRouterWithSixNestedRouter = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView3 = 'pathNamaw3';
static const String loginView4 = 'pathNamaw4';
static const all = <String>{
loginView3,loginView4,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView3
,page: ebraClass3
,generator: LoginView3Router(),
),
RouteDef(RoutesClassB.loginView4
,page: ebraClass4
,generator: LoginView4Router(),
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass3: (data) {
return MaterialPageRoute<returnYpe3>(builder: (context) =>   ebraClass3(), settings: data,);
},ebraClass4: (data) {
return buildAdaptivePageRoute<returnYpe4>(builder: (context) =>   ebraClass4(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future<returnYpe3> pushLoginView3()
 => push<returnYpe3>(RoutesClassB.loginView3);

Future<returnYpe4> pushLoginView4()
 => push<returnYpe4>(RoutesClassB.loginView4);

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
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   sixthClass(), settings: data,);
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
''';

const kRouterTypeCupertinoWithNamePathNameClassName = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return CupertinoPageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';

const kRouterTypeCupertinoWithCupertinoNavTitle = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return CupertinoPageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,title:'cupertinoNavTitle',);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';
const kRouterTypeCupertinoWithParametersPathFalseQueryFalse = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
var args = data.getArgs<ebraClassArguments>(
orElse: ()=> ebraClassArguments(),);return CupertinoPageRoute<dynamic>(builder: (context) =>   ebraClass(null:args.null), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(null: null),);

}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ebraClass arguments holder class
class ebraClassArguments{
final null null;
ebraClassArguments({
this.null});
}
''';
const kRouterTypeAdaptive = '''
// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return buildAdaptivePageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';
const kRouterTypeAdaptiveWithCupertinoNavTitle = '''
// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return buildAdaptivePageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,cupertinoTitle:'cupertinooo',);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';
const kRouterTypeAdaptiveWithParametersPathFalseQueryFalse = '''
// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
var args = data.getArgs<ebraClassArguments>(
orElse: ()=> ebraClassArguments(),);return buildAdaptivePageRoute<dynamic>(builder: (context) =>   ebraClass(null:args.null), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(null: null),);

}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ebraClass arguments holder class
class ebraClassArguments{
final null null;
ebraClassArguments({
this.null});
}
''';
const kRouterTypeCustom = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   ebraClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';
const kRouterTypeCustomWithbarrierDismissible = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   ebraClass(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';

const kRouterTypeCustomWithTransitionDuration = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   ebraClass(), settings: data,transitionDuration: const Duration(milliseconds: 22),);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';
const kRouterTypeCustomWithReverseDurationInMilliseconds = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   ebraClass(), settings: data,reverseTransitionDuration: const Duration(milliseconds: 2),);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';

const kRouterTypeCustomWithCustomRouteOpaqueFalse = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   ebraClass(), settings: data,opaque:false,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView()
 => push(RoutesClassB.loginView);

}
''';

const kRouterTypeCustomWithParametersPathFalseQueryFalse = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
var args = data.getArgs<ebraClassArguments>(
orElse: ()=> ebraClassArguments(),);return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   ebraClass(null:args.null), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(null: null),);

}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ebraClass arguments holder class
class ebraClassArguments{
final null null;
ebraClassArguments({
this.null});
}
''';
const kRouterTypeCustomWithParametersPathFalseQueryTrue = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   ebraClass(null:data.queryParams['null'].value()), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView({null null,})
 => push(RoutesClassB.loginView,arguments: ebraClassArguments(null: null),);

}
''';
const kRouterMixin = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoutesClassB {
static const String loginView1 = 'pathNamaw1';
static const String loginView2 = 'pathNamaw2';
static const String loginView3 = 'pathNamaw3';
static const String loginView4 = 'pathNamaw4';
static const String loginView5 = 'pathNamaw5';
static const String loginView6 = 'pathNamaw6';
static const all = <String>{
loginView1,loginView2,loginView3,loginView4,loginView5,loginView6,};}

class RouterNamee extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(RoutesClassB.loginView1
,page: ebraClass1
),
RouteDef(RoutesClassB.loginView2
,page: ebraClass2
),
RouteDef(RoutesClassB.loginView3
,page: ebraClass3
),
RouteDef(RoutesClassB.loginView4
,page: ebraClass4
),
RouteDef(RoutesClassB.loginView5
,page: ebraClass5
),
RouteDef(RoutesClassB.loginView6
,page: ebraClass6
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass1: (data) {
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   ebraClass1(), settings: data,transitionDuration: const Duration(milliseconds: 22),reverseTransitionDuration: const Duration(milliseconds: 2),);
},ebraClass2: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass2(null:data.queryParams['null'].value()), settings: data,);
},ebraClass3: (data) {
var args = data.getArgs<ebraClass3Arguments>(
orElse: ()=> ebraClass3Arguments(),);return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass3(null:args.null), settings: data,);
},ebraClass4: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass4(), settings: data,maintainState:false,);
},ebraClass5: (data) {
return buildAdaptivePageRoute<dynamic>(builder: (context) =>   ebraClass5(), settings: data,cupertinoTitle:'cupertinooo',);
},ebraClass6: (data) {
return CupertinoPageRoute<dynamic>(builder: (context) =>   ebraClass6(), settings: data,);
},};}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterNameeExtendedNavigatorStateX on ExtendedNavigatorState {
Future pushLoginView1()
 => push(RoutesClassB.loginView1);

Future pushLoginView2({null null,})
 => push(RoutesClassB.loginView2,arguments: ebraClass2Arguments(null: null),);

Future pushLoginView3({null null,})
 => push(RoutesClassB.loginView3,arguments: ebraClass3Arguments(null: null),);

Future pushLoginView4()
 => push(RoutesClassB.loginView4);

Future pushLoginView5()
 => push(RoutesClassB.loginView5);

Future pushLoginView6()
 => push(RoutesClassB.loginView6);

}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ebraClass3 arguments holder class
class ebraClass3Arguments{
final null null;
ebraClass3Arguments({
this.null});
}
''';
