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
    _i1.RouteDef(
      RoutesTestClassName.loginView,
      page: _i2.TestClass,
    )
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
  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
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
    _i1.RouteDef(
      RoutesTestClassName.loginView1,
      page: _i2.TestClass1,
    )
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
    _i1.RouteDef(
      LoginView1Routes.nestedView1,
      page: _i3.nestedClass1,
    )
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
  Future<returnYpe1?> navigateToLoginView1([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<returnYpe1?>(Routes.loginView1,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNestedNestedView1InParentClass([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(ParentClassRoutes.nestedView1,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<returnYpe1?> replaceWithLoginView1([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<returnYpe1?>(Routes.loginView1,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNestedNestedView1InParentClass([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(ParentClassRoutes.nestedView1,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
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
    _i1.RouteDef(
      RoutesTestClassName.loginView,
      page: _i2.TestClass,
    )
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

  @override
  String toString() {
    return \'{"markers": "\$markers"}\';
  }
}

extension NavigatorStateExtension on _i4.NavigationService {
  Future<dynamic> navigateToLoginView({
    List<_i3.Marker> markers,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments: TestClassArguments(markers: markers),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView({
    List<_i3.Marker> markers,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginView,
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
    _i1.RouteDef(
      RoutesTestClassName.loginView,
      page: _i2.TestClass,
    )
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

  @override
  String toString() {
    return \'{"name": "\$name"}\';
  }
}

extension NavigatorStateExtension on _i4.NavigationService {
  Future<dynamic> navigateToLoginView({
    _i3.String name,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments: TestClassArguments(name: name),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView({
    _i3.String name,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginView,
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
    loginView6,
  };
}

class RouterTestClassName extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      RoutesTestClassName.loginView1,
      page: _i2.TestClass1,
    ),
    _i1.RouteDef(
      RoutesTestClassName.loginView2,
      page: _i3.TestClass2,
    ),
    _i1.RouteDef(
      RoutesTestClassName.loginView3,
      page: _i4.TestClass3,
    ),
    _i1.RouteDef(
      RoutesTestClassName.loginView4,
      page: _i5.TestClass4,
    ),
    _i1.RouteDef(
      RoutesTestClassName.loginView5,
      page: _i6.TestClass5,
    ),
    _i1.RouteDef(
      RoutesTestClassName.loginView6,
      page: _i7.TestClass6,
    ),
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
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class TestClass3Arguments {
  const TestClass3Arguments({this.test3paramName});

  final _i9.Test3Type test3paramName;

  @override
  String toString() {
    return \'{"test3paramName": "\$test3paramName"}\';
  }
}

extension NavigatorStateExtension on _i10.NavigationService {
  Future<dynamic> navigateToLoginView1([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView1,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView2([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView2,
        arguments: TestClass2Arguments(test2paramName: test2paramName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView3({
    _i9.Test3Type test3paramName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginView3,
        arguments: TestClass3Arguments(test3paramName: test3paramName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView4([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView4,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView5([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView5,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView6([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView6,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView1([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView1,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView2([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView2,
        arguments: TestClass2Arguments(test2paramName: test2paramName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView3({
    _i9.Test3Type test3paramName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginView3,
        arguments: TestClass3Arguments(test3paramName: test3paramName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView4([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView4,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView5([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView5,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView6([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView6,
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

  static const all = <String>{
    loginView,
    _homeView,
  };

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
    _i1.RouteDef(
      RoutesClassName.loginView,
      page: _i2.LoginClass,
    ),
    _i1.RouteDef(
      RoutesClassName.homeView,
      page: _i3.HomeClass,
    ),
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
    },
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
  _i1.RouteDef(
    RoutesClassName.loginView,
    page: _i2.LoginClass,
  ),
  _i1.RouteDef(
    RoutesClassName.homeView,
    page: _i3.HomeClass,
  ),
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
  },
};
''';
const kRouteNavigationExtension = '''
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:stacked_services/stacked_services.dart' as _i1;
import 'marker.dart' as _i2;
import 'car.dart' as _i3;
import 'map.dart' as _i4;

extension NavigatorStateExtension on _i1.NavigationService {
  Future<dynamic> navigateToLoginView({
    required _i2.Marker position,
    int age,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments: LoginClassArguments(position: position, age: age),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView({
    required _i3.Car car,
    int age,
    List<_i4.Marker> markers,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.homeView,
        arguments: HomeClassArguments(car: car, age: age, markers: markers),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView({
    required _i2.Marker position,
    int age,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginView,
        arguments: LoginClassArguments(position: position, age: age),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView({
    required _i3.Car car,
    int age,
    List<_i4.Marker> markers,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.homeView,
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
  const LoginClassArguments({
    required this.position,
    this.age,
  });

  final _i1.Marker position;

  final int age;

  @override
  String toString() {
    return '{"position": "\$position", "age": "\$age"}';
  }
}

class HomeClassArguments {
  const HomeClassArguments({
    required this.car,
    this.age,
  });

  final _i2.Car car;

  final int age;

  @override
  String toString() {
    return '{"car": "\$car", "age": "\$age"}';
  }
}
''';
