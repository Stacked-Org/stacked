const kRouterWithNamePathNameClassName = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class null {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class null extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(null.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,);
},};}
''';

const kRouterWithNamePathNameClassNameFullScreenDialogIsTrue = '''
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class null {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class null extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(null.loginView
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

class null {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class null extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(null.loginView
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
class null {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class null extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(null.loginView
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
class null {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class null extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(null.loginView
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

class null {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class null extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(null.loginView
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

class null {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class null extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(null.loginView
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
class null {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class null extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(null.loginView
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

class null {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class null extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(null.loginView
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

class null {
static const String loginView = 'pathNamaw';
static const all = <String>{
loginView,};}

class null extends RouterBase {
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     

RouteDef(null.loginView
,page: ebraClass
),
];       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        

ebraClass: (data) {
return MaterialPageRoute<dynamic>(builder: (context) =>   ebraClass(), settings: data,maintainState:false,);
},};}
''';
