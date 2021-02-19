import 'package:meta/meta.dart';

class StackedRouterAnnotation {
  // if true a Navigator extension will be generated with
  // helper push methods of all routes
  final bool generateNavigationHelperExtension;

  // defaults to 'Routes'
  final String routesClassName;

  //This is the prefix for each Route String that is generated
  // initial routes will always be named '/'
  // defaults to '/'
  final String routePrefix;

  final List<StackedRoute> routes;

  const StackedRouterAnnotation._(
    this.generateNavigationHelperExtension,
    this.routesClassName,
    this.routePrefix,
    this.routes,
  ) : assert(routes != null);
}

// Defaults created routes to MaterialPageRoute unless
// overridden by AutoRoute annotation
class MaterialRouter extends StackedRouterAnnotation {
  const MaterialRouter({
    bool generateNavigationHelperExtension,
    String routesClassName,
    String pathPrefix,
    @required List<StackedRoute> routes,
  }) : super._(generateNavigationHelperExtension, routesClassName, pathPrefix,
            routes);
}

// Defaults created routes to CupertinoPageRoute unless
// overridden by AutoRoute annotation
class CupertinoRouter extends StackedRouterAnnotation {
  const CupertinoRouter({
    bool generateNavigationHelperExtension,
    String routesClassName,
    String pathPrefix,
    @required List<StackedRoute> routes,
  }) : super._(
          generateNavigationHelperExtension,
          routesClassName,
          pathPrefix,
          routes,
        );
}

class AdaptiveRouter extends StackedRouterAnnotation {
  const AdaptiveRouter({
    bool generateNavigationHelperExtension,
    String routesClassName,
    String pathPrefix,
    @required List<StackedRoute> routes,
  }) : super._(
          generateNavigationHelperExtension,
          routesClassName,
          pathPrefix,
          routes,
        );
}

// Defaults created routes to PageRouteBuilder unless
// overridden by AutoRoute annotation
class CustomRouter extends StackedRouterAnnotation {
  /// this builder function is passed to the transition builder
  /// function in [PageRouteBuilder]
  ///
  /// I couldn't type this function from here but it should match
  /// typedef [RouteTransitionsBuilder] = Widget Function(BuildContext context, Animation<double> animation,
  /// Animation<double> secondaryAnimation, Widget child);
  ///
  /// you should only reference the function so
  /// the generator can import it into router_base.dart
  final Function transitionsBuilder;

  /// route transition duration in milliseconds
  /// is passed to [PageRouteBuilder]
  /// this property is ignored unless a [transitionBuilder] is provided
  final int durationInMilliseconds;

  /// passed to the opaque property in [PageRouteBuilder]
  final bool opaque;

  /// passed to the barrierDismissible property in [PageRouteBuilder]
  final bool barrierDismissible;

  const CustomRouter(
      {this.transitionsBuilder,
      this.barrierDismissible,
      this.durationInMilliseconds,
      this.opaque,
      bool generateNavigationHelperExtension,
      String routesClassName,
      String pathPrefix,
      @required List<StackedRoute> routes})
      : super._(
          generateNavigationHelperExtension,
          routesClassName,
          pathPrefix,
          routes,
        );
}

// [T] is the results type returned
/// from this page route MaterialPageRoute<T>()
/// defaults to dynamic

class StackedRoute<T> {
  // initial route will have an explicit name of "/"
  // there could be only one initial route per navigator.
  final bool initial;

  /// passed to the fullscreenDialog property in [MaterialPageRoute]
  final bool fullscreenDialog;

  /// passed to the maintainState property in [MaterialPageRoute]
  final bool maintainState;
  final List<StackedRoute> children;

  /// route path name which will be assigned to the given variable name
  /// const homeScreen = '[path]';
  /// if null a kabab cased variable name
  /// prefixed with '/' will be used;
  /// homeScreen -> home-screen

  final String path;
  final String name;

  final Type page;

  final List<Type> guards;

  const StackedRoute(
      {@required this.page,
      this.initial,
      this.guards,
      this.fullscreenDialog,
      this.maintainState,
      this.path,
      this.name,
      this.children});
}

class MaterialRoute<T> extends StackedRoute<T> {
  const MaterialRoute(
      {String path,
      @required Type page,
      bool initial,
      bool fullscreenDialog,
      bool maintainState,
      String name,
      List<Type> guards,
      List<StackedRoute> children})
      : super(
          page: page,
          guards: guards,
          initial: initial,
          fullscreenDialog: fullscreenDialog,
          maintainState: maintainState,
          path: path,
          children: children,
          name: name,
        );
}

// forces usage of CupertinoPageRoute instead of MaterialPageRoute
class CupertinoRoute<T> extends StackedRoute<T> {
  /// passed to the title property in [CupertinoPageRoute]
  final String title;

  const CupertinoRoute(
      {bool initial,
      bool fullscreenDialog,
      bool maintainState,
      String path,
      this.title,
      String name,
      @required Type page,
      List<Type> guards,
      List<StackedRoute> children})
      : super(
            initial: initial,
            fullscreenDialog: fullscreenDialog,
            maintainState: maintainState,
            path: path,
            name: name,
            page: page,
            guards: guards,
            children: children);
}

class AdaptiveRoute<T> extends StackedRoute<T> {
  const AdaptiveRoute(
      {bool initial,
      bool fullscreenDialog,
      bool maintainState,
      String name,
      String path,
      Type returnType,
      this.cupertinoPageTitle,
      @required Type page,
      List<Type> guards,
      List<StackedRoute> children})
      : super(
            initial: initial,
            fullscreenDialog: fullscreenDialog,
            maintainState: maintainState,
            path: path,
            name: name,
            page: page,
            guards: guards,
            children: children);

  /// passed to the title property in [CupertinoPageRoute]
  final String cupertinoPageTitle;
}

class CustomRoute<T> extends StackedRoute<T> {
  /// this builder function is passed to the transition builder
  /// function in [PageRouteBuilder]
  ///
  /// I couldn't type this function from here but it should match
  /// typedef [RouteTransitionsBuilder] = Widget Function(BuildContext context, Animation<double> animation,
  /// Animation<double> secondaryAnimation, Widget child);
  ///
  /// you should only reference the function so
  /// the generator can import it into router_base.dart
  final Function transitionsBuilder;

  /// route transition duration in milliseconds
  /// is passed to [PageRouteBuilder]
  /// this property is ignored unless a [transitionBuilder] is provided
  final int durationInMilliseconds;

  /// passed to the opaque property in [PageRouteBuilder]
  final bool opaque;

  /// passed to the barrierDismissible property in [PageRouteBuilder]
  final bool barrierDismissible;

  const CustomRoute({
    bool initial,
    bool fullscreenDialog,
    bool maintainState,
    String name,
    String path,
    @required Type page,
    List<Type> guards,
    List<StackedRoute> children,
    this.transitionsBuilder,
    this.durationInMilliseconds,
    this.opaque,
    this.barrierDismissible,
  }) : super(
            initial: initial,
            fullscreenDialog: fullscreenDialog,
            maintainState: maintainState,
            path: path,
            name: name,
            page: page,
            guards: guards,
            children: children);
}

class PathParam {
  final String name;

  const PathParam([this.name]);
}

const pathParam = PathParam();

class QueryParam {
  final String name;

  const QueryParam([this.name]);
}

const queryParam = QueryParam();
