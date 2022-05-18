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
''';

const kRouterWithFullScreenDialogIsFalse = '''
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
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,fullscreenDialog:false,);
},};}
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
''';
const kRouterWithMaintainStateIsTrue = '''
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
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,maintainState:true,);
},};}
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
''';
const kRouterWithNestedRouter = '''
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
,generator: MyNestedRouteerrr(),
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<returnYpe>(builder: (context) =>   ebraClass(), settings: data,);
},};}
class MyNestedRoutess {
static const String nestedView = 'nestedPath';
static const all = <String>{
nestedView,};}

class MyNestedRouteerrr extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(MyNestedRoutess.nestedView
,page: nestedClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

nestedClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   nestedClass(), settings: data,);
},};}
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
''';
const kRouterTypeCustomWithTitleNavBar = '''
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
return PageRouteBuilder<dynamic>(pageBuilder: (context, animation, secondaryAnimation) =>   ebraClass(), settings: data,barrierDismissible:false,);
},};}
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
/// Arguments holder classes
/// *************************************************************************

/// ebraClass3 arguments holder class
class ebraClass3Arguments{
final null null;
ebraClass3Arguments({
this.null});
}
''';
