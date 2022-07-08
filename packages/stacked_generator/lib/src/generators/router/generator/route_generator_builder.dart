import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/utils.dart';

const _constImports = [
  "package:stacked/stacked.dart",
  "package:stacked_services/stacked_services.dart"
];

class RouteGeneratorBuilder with StringBufferUtils {
  final List<RouteConfig> routes;
  final String routesClassName;
  final String routerClassName;
  RouteGeneratorBuilder({
    required this.routes,
    required this.routesClassName,
    required this.routerClassName,
  });

  RouteGeneratorBuilder addHeaderComment() {
    write(
        "// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names");
    return this;
  }

  /// Example result
  ///
  /// import 'package:stacked/stacked.dart';
  /// import 'package:stacked_services/stacked_services.dart';
  ///
  /// import '../ui/bottom_nav/profile/profile_view.dart';
  /// import '../ui/details/details_view.dart';
  /// import '../ui/form/example_form_view.dart';
  /// import '../ui/home/home_view.dart';
  RouteGeneratorBuilder sortAndAddImports() {
    final allImports = routes
        .map((route) => route.registerImports())
        .fold<Set<String>>(
            {}, (previousValue, element) => {...previousValue, ...element});

    final dartImports =
        allImports.where((element) => element.startsWith('dart'));
    generateIterableWithPaddingLines(dartImports, preLines: 1, postlines: 1);

    final packageImports =
        allImports.where((element) => element.startsWith('package'));
    generateIterableWithPaddingLines([...packageImports, ..._constImports],
        postlines: 1);

    final remainingImports =
        allImports.difference({...dartImports, ...packageImports});
    generateIterableWithPaddingLines(remainingImports);

    return this;
  }

  /// Example result
  ///
  /// class RoutesClassName {
  /// static const String loginView = 'pathNamaw';
  /// static const String _homeView = '/family/:fid';
  /// static String homeView({@required dynamic fid}) => '/family/\$fid';
  /// static const all = <String>{
  /// loginView,_homeView,};}
  ///
  RouteGeneratorBuilder addRoutesClassName() {
    writeLine('class $routesClassName {');

    for (var route in routes) {
      writeLine(
          "static const String ${_convertToPrivateNameWhenRouteHasPathParameter(route)} = '${route.pathName}';");
      if (route.pathName.contains(':')) {
        _addRouteWithPathParameter(
            routeName: route.name, routePath: route.pathName);
      }
    }

    writeLine("static const all = <String>{");

    for (var route in routes) {
      write('${_convertToPrivateNameWhenRouteHasPathParameter(route)},');
    }

    // Closes the [all] map
    write("};");

    // Closes the [routesClassName] class
    writeLine('}');
    return this;
  }

  String _convertToPrivateNameWhenRouteHasPathParameter(RouteConfig route) {
    return route.pathName.contains(':') ? '_${route.name}' : route.name;
  }

  void _addRouteWithPathParameter(
      {required String routePath, required String routeName}) {
    final params = RegExp(r':([^/]+)').allMatches(routePath).map((m) {
      final match = m.group(1);
      if (match!.endsWith('?')) {
        return "dynamic ${match.substring(0, match.length - 1)} = ''";
      } else {
        return "@required dynamic $match";
      }
    });
    writeLine(
      "static String $routeName({${params.join(',')}}) => '${routePath.replaceAllMapped(RegExp(r'([:])|([?])'), (m) {
        if (m[1] != null) {
          return '\$';
        } else {
          return '';
        }
      })}';",
    );
  }

  /// Example result
  ///
  /// class routerClassName extends RouterBase {
  ///      @override
  ///      List<RouteDef> get routes => _routes;
  ///      final _routes = <RouteDef>[
  ///
  ///
  /// RouteDef(RoutesClassName.loginView
  /// ,page: LoginClass
  /// ),
  /// RouteDef(RoutesClassName._homeView
  /// ,page: HomeClass
  /// ),
  /// ];       @override
  ///        Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  ///         final _pagesMap = <Type, StackedRouteFactory>{
  ///
  ///
  /// LoginClass: (data) {
  /// var args = data.getArgs<LoginClassArguments>(
  /// orElse: ()=> LoginClassArguments(),);return MaterialPageRoute<dynamic>(builder: (context) =>   LoginClass(loginArg:args.loginArg), settings: data,);
  /// },HomeClass: (data) {
  /// var args = data.getArgs<HomeClassArguments>(
  /// orElse: ()=> HomeClassArguments(),);return MaterialPageRoute<dynamic>(builder: (context) =>   HomeClass(homeArg:args.homeArg), settings: data,);
  /// },};}
  RouteGeneratorBuilder addRouterClass() {
    writeLine('\nclass $routerClassName extends RouterBase {');

    writeLine('''
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     ''');
    for (var route in routes) {
      _addRouteTemplates(route, routesClassName);
    }
    newLine();
    write('];');

    write(
      '''
       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        ''',
      postlines: 2,
    );

    for (var route in routes) {
      _addRouteGeneratorFunction(route);
    }

    write('};');

    writeLine('}');
    return this;
  }

  /// RouteDef(RoutesClassName._homeView
  /// ,page: HomeClass
  /// ),
  void _addRouteTemplates(RouteConfig route, String routesClassName) {
    write(
      "RouteDef(${routesClassName}.${route.templateName}",
      preLines: 1,
      postlines: 1,
    );
    writeLine(",page: ${route.className}");

    if (route.children.isNotEmpty) {
      writeLine(",generator: ${capitalize(route.name)}Router(),");
    }
    write('),');
  }

  /// HomeClass: (data) {
  /// var args = data.getArgs<HomeClassArguments>(
  /// orElse: ()=> HomeClassArguments(),);return MaterialPageRoute<dynamic>(builder: (context) =>   HomeClass(homeArg:args.homeArg), settings: data,);
  /// },
  void _addRouteGeneratorFunction(RouteConfig route) {
    writeLine('${route.className}: (data) {');

    write(route.registerRoutes());

    write("},");
  }
}
