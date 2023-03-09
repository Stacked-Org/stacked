class StackedRouterAnnotation {
  // if true a Navigator extension will be generated with
  // helper push methods of all routes
  final bool? generateNavigationHelperExtension;

  /// if true relative imports will be generated
  /// when possible
  /// defaults to true
  final bool preferRelativeImports;

  // defaults to 'Routes'
  final String? routesClassName;

  //This is the prefix for each Route String that is generated
  // initial routes will always be named '/'
  // defaults to '/'
  final String? routePrefix;

  final List<StackedRoute> routes;

  /// Auto generated route names can be a bit long with
  /// the [Route] suffix
  /// e.g ProductDetailsPage would be ProductDetailsPageRoute
  ///
  /// You can replace some relative parts in your route names
  /// by providing a replacement in the follow pattern
  /// [whatToReplace,replacement]
  /// what to replace and the replacement should be
  /// separated with a comma [,]
  /// e.g 'Page,Route'
  /// so ProductDetailsPage would be ProductDetailsRoute
  ///
  /// defaults to null, ignored if a route name is provided.
  final String? replaceInRouteName;

  /// Use for web for lazy loading other routes
  /// more info https://dart.dev/guides/language/language-tour#deferred-loading
  final bool deferredLoading;

  const StackedRouterAnnotation._(
    this.routes,
    this.preferRelativeImports, {
    this.routePrefix,
    this.generateNavigationHelperExtension,
    this.routesClassName,
    this.replaceInRouteName,
    this.deferredLoading = false,
  });
}

// Defaults created routes to MaterialPageRoute unless
// overridden by AutoRoute annotation
class MaterialRouter extends StackedRouterAnnotation {
  const MaterialRouter({
    bool preferRelativeImports = true,
    required List<StackedRoute> routes,
    bool? generateNavigationHelperExtension,
    String? routesClassName,
    String? pathPrefix,
    String? replaceInRouteName,
    bool? deferredLoading,
  }) : super._(
          routes,
          preferRelativeImports,
          generateNavigationHelperExtension: generateNavigationHelperExtension,
          routePrefix: pathPrefix,
          routesClassName: routesClassName,
          replaceInRouteName: replaceInRouteName,
          deferredLoading: deferredLoading ?? false,
        );
}

// Defaults created routes to CupertinoPageRoute unless
// overridden by AutoRoute annotation
class CupertinoRouter extends StackedRouterAnnotation {
  const CupertinoRouter({
    bool preferRelativeImports = true,
    required List<StackedRoute> routes,
    String? replaceInRouteName,
    bool? deferredLoading,
    bool? generateNavigationHelperExtension,
    String? routesClassName,
    String? pathPrefix,
  }) : super._(
          routes,
          preferRelativeImports,
          replaceInRouteName: replaceInRouteName,
          deferredLoading: deferredLoading ?? false,
          generateNavigationHelperExtension: generateNavigationHelperExtension,
          routesClassName: routesClassName,
          routePrefix: pathPrefix,
        );
}

class AdaptiveRouter extends StackedRouterAnnotation {
  const AdaptiveRouter({
    bool preferRelativeImports = false,
    required List<StackedRoute> routes,
    String? replaceInRouteName,
    bool? deferredLoading,
    bool? generateNavigationHelperExtension,
    String? routesClassName,
    String? pathPrefix,
  }) : super._(
          routes,
          preferRelativeImports,
          replaceInRouteName: replaceInRouteName,
          deferredLoading: deferredLoading ?? false,
          generateNavigationHelperExtension: generateNavigationHelperExtension,
          routesClassName: routesClassName,
          routePrefix: pathPrefix,
        );
}

/// Defaults created routes to PageRouteBuilder unless
/// overridden by AutoRoute annotation
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
  final Function? transitionsBuilder;

  /// route transition duration in milliseconds
  /// is passed to [PageRouteBuilder]
  /// this property is ignored unless a [transitionBuilder] is provided
  final int? durationInMilliseconds;

  /// route transition reverse duration in milliseconds
  /// is passed to [PageRouteBuilder]
  final int? reverseDurationInMilliseconds;

  /// passed to the opaque property in [PageRouteBuilder]
  final bool? opaque;

  /// passed to the barrierDismissible property in [PageRouteBuilder]
  final bool? barrierDismissible;

  const CustomRouter({
    this.transitionsBuilder,
    this.barrierDismissible,
    this.durationInMilliseconds,
    this.reverseDurationInMilliseconds,
    this.opaque,
    bool? generateNavigationHelperExtension,
    String? routesClassName,
    String? pathPrefix,
    required List<StackedRoute> routes,
    bool preferRelativeImports = true,
    String? replaceInRouteName,
    bool? deferredLoading,
  }) : super._(
          routes,
          preferRelativeImports,
          replaceInRouteName: replaceInRouteName,
          deferredLoading: deferredLoading ?? false,
          generateNavigationHelperExtension: generateNavigationHelperExtension,
          routesClassName: routesClassName,
          routePrefix: pathPrefix,
        );
}

/// [T] is the results type returned
/// from this page route MaterialPageRoute<T>()
/// defaults to dynamic

class StackedRoute<T> {
  // initial route will have an explicit name of "/"
  // there could be only one initial route per navigator.
  final bool? initial;

  /// passed to the fullscreenDialog property in [MaterialPageRoute]
  final bool? fullscreenDialog;

  /// passed to the maintainState property in [MaterialPageRoute]
  final bool? maintainState;

  final List<StackedRoute>? children;

  /// route path name which will be assigned to the given variable name
  /// const homeScreen = '[path]';
  /// if null a kabab cased variable name
  /// prefixed with '/' will be used;
  /// homeScreen -> home-screen

  final String? path;
  final String? name;

  final Type? page;

  final List<Type>? guards;

  final bool fullMatch;

  /// if true path is used as page key instead of name
  final bool usesPathAsKey;

  /// meta data
  final Map<String, dynamic> meta;

  final bool? deferredLoading;

  const StackedRoute({
    this.page,
    this.initial = false,
    this.guards,
    this.fullscreenDialog = false,
    this.maintainState = true,
    this.fullMatch = false,
    this.path,
    this.name,
    this.usesPathAsKey = false,
    this.children,
    this.meta = const {},
    this.deferredLoading,
  });
}

class RedirectRoute extends StackedRoute {
  final String redirectTo;

  const RedirectRoute({
    required String path,
    required this.redirectTo,
  }) : super(path: path, fullMatch: true);
}

class MaterialRoute<T> extends StackedRoute<T> {
  const MaterialRoute({
    String? path,
    required Type page,
    bool initial = false,
    bool fullscreenDialog = false,
    bool maintainState = false,
    bool fullMatch = false,
    String? name,
    List<Type>? guards,
    bool usesPathAsKey = false,
    List<StackedRoute>? children,
    Map<String, dynamic> meta = const {},
    bool? deferredLoading,
  }) : super(
          page: page,
          guards: guards,
          fullMatch: fullMatch,
          initial: initial,
          usesPathAsKey: usesPathAsKey,
          fullscreenDialog: fullscreenDialog,
          maintainState: maintainState,
          path: path,
          children: children,
          name: name,
          meta: meta,
          deferredLoading: deferredLoading,
        );
}

// forces usage of CupertinoPageRoute instead of MaterialPageRoute
class CupertinoRoute<T> extends StackedRoute<T> {
  /// passed to the title property in [CupertinoPageRoute]
  final String? title;

  const CupertinoRoute({
    bool initial = false,
    bool fullscreenDialog = false,
    bool maintainState = false,
    String? path,
    this.title,
    String? name,
    bool fullMatch = false,
    required Type page,
    bool usesPathAsKey = false,
    List<Type>? guards,
    List<StackedRoute>? children,
    Map<String, dynamic> meta = const {},
    bool? deferredLoading,
  }) : super(
          initial: initial,
          fullscreenDialog: fullscreenDialog,
          maintainState: maintainState,
          path: path,
          name: name,
          usesPathAsKey: usesPathAsKey,
          fullMatch: fullMatch,
          page: page,
          guards: guards,
          children: children,
          meta: meta,
          deferredLoading: deferredLoading,
        );
}

class AdaptiveRoute<T> extends StackedRoute<T> {
  const AdaptiveRoute({
    bool initial = false,
    bool fullscreenDialog = false,
    bool maintainState = true,
    String? name,
    String? path,
    bool usesPathAsKey = false,
    bool fullMatch = false,
    this.cupertinoPageTitle,
    required Type page,
    List<Type>? guards,
    List<StackedRoute>? children,
    this.opaque = true,
    Type? returnType,
    Map<String, dynamic> meta = const {},
    bool? deferredLoading,
  }) : super(
          initial: initial,
          fullscreenDialog: fullscreenDialog,
          maintainState: maintainState,
          path: path,
          usesPathAsKey: usesPathAsKey,
          name: name,
          fullMatch: fullMatch,
          page: page,
          guards: guards,
          children: children,
          meta: meta,
          deferredLoading: deferredLoading,
        );

  /// passed to the opaque property in [_NoAnimationPageRouteBuilder] only when kIsWeb
  final bool opaque;

  /// passed to the title property in [CupertinoPageRoute]
  final String? cupertinoPageTitle;
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
  final Function? transitionsBuilder;

  /// this builder function is passed to customRouteBuilder property
  /// in [CustomPage]
  ///
  /// I couldn't type this function from here but it should match
  /// typedef [CustomRouteBuilder] = Route Function(BuildContext context, CustomPage page);
  /// you should only reference the function when passing it so
  /// the generator can import it into the generated file
  ///
  /// this builder function accepts a BuildContext and a CustomPage
  /// that has all the other properties assigned to it
  /// so using them then is totally up to you.
  final Function? customRouteBuilder;

  /// route transition duration in milliseconds
  /// is passed to [PageRouteBuilder]
  /// this property is ignored unless a [transitionBuilder] is provided
  final int? durationInMilliseconds;

  /// route transition reverse duration in milliseconds
  /// is passed to [PageRouteBuilder]
  final int? reverseDurationInMilliseconds;

  /// passed to the opaque property in [PageRouteBuilder]
  final bool? opaque;

  /// passed to the barrierDismissible property in [PageRouteBuilder]
  final bool? barrierDismissible;

  /// passed to the barrierLabel property in [PageRouteBuilder]
  final String? barrierLabel;

  /// passed to the barrierColor property in [PageRouteBuilder]
  final int? barrierColor;

  const CustomRoute({
    bool initial = false,
    bool fullscreenDialog = false,
    bool maintainState = true,
    String? name,
    String? path,
    bool fullMatch = false,
    required Type page,
    List<Type>? guards,
    bool usesPathAsKey = false,
    List<StackedRoute>? children,
    this.customRouteBuilder,
    this.barrierLabel,
    this.barrierColor,
    this.transitionsBuilder,
    this.durationInMilliseconds,
    this.reverseDurationInMilliseconds,
    this.opaque = true,
    this.barrierDismissible = false,
    Map<String, dynamic> meta = const {},
    bool? deferredLoading,
  }) : super(
          initial: initial,
          fullscreenDialog: fullscreenDialog,
          maintainState: maintainState,
          usesPathAsKey: usesPathAsKey,
          path: path,
          name: name,
          fullMatch: fullMatch,
          page: page,
          guards: guards,
          children: children,
          meta: meta,
          deferredLoading: deferredLoading,
        );
}

class PathParam {
  final String? name;

  const PathParam([this.name]);
}

const pathParam = PathParam();

class QueryParam {
  final String? name;

  const QueryParam([this.name]);
}

const queryParam = QueryParam();
