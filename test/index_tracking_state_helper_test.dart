import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/src/router/matcher/route_matcher.dart';
import 'package:stacked/stacked.dart';

class TestIndexTrackingViewModel extends BaseViewModel
    with IndexTrackingStateHelper {}

class TestRouterService implements RouterServiceInterface {
  final RootStackRouter testRouter;
  final RouteData testTopRoute;
  const TestRouterService({
    required this.testRouter,
    required this.testTopRoute,
  });

  @override
  RootStackRouter get router => testRouter;

  @override
  RouteData get topRoute => testTopRoute;
}

class TestRouter extends RootStackRouter {
  final Map<String, PageFactory> testPagesMap;
  final List<RouteConfig> testRoutes;
  TestRouter({this.testPagesMap = const {}, this.testRoutes = const []});

  @override
  Map<String, PageFactory> get pagesMap => testPagesMap;

  @override
  List<RouteConfig> get routes => testRoutes;
}

class TestRoutingController extends RoutingController {
  @override
  bool canPop({
    bool ignoreChildRoutes = false,
    bool ignoreParentRoutes = false,
    bool ignorePagelessRoutes = false,
  }) {
    // TODO: implement canPop
    throw UnimplementedError();
  }

  @override
  // TODO: implement canPopSelfOrChildren
  bool get canPopSelfOrChildren => throw UnimplementedError();

  @override
  // TODO: implement current
  RouteData get current => throw UnimplementedError();

  @override
  // TODO: implement currentChild
  RouteData? get currentChild => throw UnimplementedError();

  @override
  // TODO: implement key
  LocalKey get key => throw UnimplementedError();

  @override
  // TODO: implement managedByWidget
  bool get managedByWidget => throw UnimplementedError();

  @override
  // TODO: implement matcher
  RouteMatcher get matcher => throw UnimplementedError();

  @override
  // TODO: implement pageBuilder
  PageBuilder get pageBuilder => throw UnimplementedError();

  @override
  Future<bool> pop<T extends Object?>([T? result]) {
    // TODO: implement pop
    throw UnimplementedError();
  }

  @override
  // TODO: implement routeCollection
  RouteCollection get routeCollection => throw UnimplementedError();

  @override
  // TODO: implement routeData
  RouteData get routeData => throw UnimplementedError();

  @override
  // TODO: implement stack
  List<StackedPage> get stack => throw UnimplementedError();

  @override
  RoutingController topMostRouter({bool ignorePagelessRoutes = false}) {
    // TODO: implement topMostRouter
    throw UnimplementedError();
  }

  @override
  void updateRouteData(RouteData data) {
    // TODO: implement updateRouteData
  }
}

final bottomNavExampleRouteMatch = RouteMatch(
  key: UniqueKey(),
  name: 'BottomNavExample',
  path: 'bottom-nav-example',
  segments: const [],
  stringMatch: '',
);

final favoriteRouteMatch = RouteMatch(
  key: UniqueKey(),
  name: 'FavoriteView',
  path: 'favorite-view',
  segments: const [],
  stringMatch: '',
);

final historyRouteMatch = RouteMatch(
  key: UniqueKey(),
  name: 'HistoryView',
  path: 'history-view',
  segments: const [],
  stringMatch: '',
);

final profileRouteMatch = RouteMatch(
  key: UniqueKey(),
  name: 'ProfileView',
  path: 'profile-view',
  segments: const [],
  stringMatch: '',
);

RouteData getBottomNavExampleRouteData({
  List<RouteMatch> pendingChildren = const [],
}) =>
    RouteData(
      route: bottomNavExampleRouteMatch,
      router: TestRoutingController(),
      pendingChildren: pendingChildren,
    );

RouteConfig getRouteConfig(String name, {List<RouteConfig>? children}) =>
    RouteConfig(
      name,
      path: toSnakeCase(name),
      children: children,
    );

String toSnakeCase(String text) {
  return text.replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), r"_").toLowerCase();
}

void main() {
  group('IndexTrackingViewmodelTest -', () {
    group('setIndex -', () {
      test('When called with 1, should set currentIndex to 1', () {
        final viewModel = TestIndexTrackingViewModel();
        viewModel.setIndex(1);
        expect(viewModel.currentIndex, 1);
      });

      test('When called with 1, should notifyListeners about update', () {
        final viewModel = TestIndexTrackingViewModel();
        var called = false;
        viewModel.addListener(() {
          called = true;
        });
        viewModel.setIndex(1);
        expect(called, true);
      });

      test(
          'When called with 1 and currentIndex was 0, reverse should return false',
          () {
        final viewModel = TestIndexTrackingViewModel();
        viewModel.setIndex(1);
        expect(viewModel.reverse, false);
      });

      test(
          'When called with 0 and currentIndex was 1, reverse should return true',
          () {
        final viewModel = TestIndexTrackingViewModel();
        viewModel.setIndex(1);

        viewModel.setIndex(0);
        expect(viewModel.reverse, true);
      });

      test('When called with 1 isIndexSelected should return false for 0', () {
        final model = TestIndexTrackingViewModel();
        model.setIndex(1);
        expect(model.isIndexSelected(0), false);
      });

      test('When called with 1 isIndexSelected should return true for 1', () {
        final viewModel = TestIndexTrackingViewModel();
        viewModel.setIndex(1);
        expect(viewModel.isIndexSelected(1), true);
      });
    });

    group('setCurrentWebPageIndex -', () {
      test('When pendingChildren is empty should NOT change currentIndex', () {
        final service = TestRouterService(
          testRouter: TestRouter(),
          testTopRoute: getBottomNavExampleRouteData(),
        );
        final viewModel = TestIndexTrackingViewModel();
        viewModel.setIndex(0);

        viewModel.setCurrentWebPageIndex(service);

        expect(viewModel.currentIndex, 0);
      });

      test('When pendingChildren is empty should NOT call notifyListeners', () {
        final service = TestRouterService(
          testRouter: TestRouter(),
          testTopRoute: getBottomNavExampleRouteData(),
        );
        final viewModel = TestIndexTrackingViewModel();
        var called = 0;
        viewModel.addListener(() {
          called++;
        });

        viewModel.setCurrentWebPageIndex(service);

        expect(called, 0);
      });

      test(
          'When topRoute is NOT find on routes should NOT call notifyListeners',
          () {
        final service = TestRouterService(
          testRouter: TestRouter(testRoutes: [
            getRouteConfig('HomeView'),
            getRouteConfig('StreamsView'),
            getRouteConfig('CounterView'),
          ]),
          testTopRoute: getBottomNavExampleRouteData(
            pendingChildren: [
              favoriteRouteMatch,
              historyRouteMatch,
              profileRouteMatch,
            ],
          ),
        );
        final viewModel = TestIndexTrackingViewModel();
        var called = 0;
        viewModel.addListener(() {
          called++;
        });

        viewModel.setCurrentWebPageIndex(service);

        expect(called, 0);
      });

      test(
          'When topRoute is find on routes and route has NO children should NOT call notifyListeners',
          () {
        final service = TestRouterService(
          testRouter: TestRouter(testRoutes: [
            getRouteConfig('HomeView'),
            getRouteConfig('StreamsView'),
            getRouteConfig('BottomNavExample'),
            getRouteConfig('CounterView'),
          ]),
          testTopRoute: getBottomNavExampleRouteData(
            pendingChildren: [
              favoriteRouteMatch,
              historyRouteMatch,
              profileRouteMatch,
            ],
          ),
        );
        final viewModel = TestIndexTrackingViewModel();
        var called = 0;
        viewModel.addListener(() {
          called++;
        });

        viewModel.setCurrentWebPageIndex(service);

        expect(called, 0);
      });

      test(
          'When topRoute is in the routes, the route has NOT a match in the children should NOT call notifyListeners',
          () {
        final service = TestRouterService(
          testRouter: TestRouter(testRoutes: [
            getRouteConfig('HomeView'),
            getRouteConfig('StreamsView'),
            getRouteConfig('BottomNavExample', children: [
              getRouteConfig('FavoriteView'),
              getRouteConfig('ProfileView'),
            ]),
            getRouteConfig('CounterView'),
          ]),
          testTopRoute: getBottomNavExampleRouteData(
            pendingChildren: [historyRouteMatch],
          ),
        );
        final viewModel = TestIndexTrackingViewModel();
        var called = 0;
        viewModel.addListener(() {
          called++;
        });

        viewModel.setCurrentWebPageIndex(service);

        expect(called, 0);
      });

      test(
          'When topRoute is in the routes, the route has a match in the children should call notifyListeners',
          () {
        final service = TestRouterService(
          testRouter: TestRouter(testRoutes: [
            getRouteConfig('HomeView'),
            getRouteConfig('StreamsView'),
            getRouteConfig('BottomNavExample', children: [
              getRouteConfig('FavoriteView'),
              getRouteConfig('HistoryView'),
              getRouteConfig('ProfileView'),
            ]),
            getRouteConfig('CounterView'),
          ]),
          testTopRoute: getBottomNavExampleRouteData(
            pendingChildren: [historyRouteMatch],
          ),
        );
        final viewModel = TestIndexTrackingViewModel();
        var called = 0;
        viewModel.addListener(() {
          called++;
        });

        viewModel.setCurrentWebPageIndex(service);

        expect(called, 1);
      });

      test(
          'When topRoute is in the routes, the route has a match in the children should change currentIndex to 0',
          () {
        final service = TestRouterService(
          testRouter: TestRouter(testRoutes: [
            getRouteConfig('HomeView'),
            getRouteConfig('StreamsView'),
            getRouteConfig('BottomNavExample', children: [
              getRouteConfig('FavoriteView'),
              getRouteConfig('HistoryView'),
              getRouteConfig('ProfileView'),
            ]),
            getRouteConfig('CounterView'),
          ]),
          testTopRoute: getBottomNavExampleRouteData(
            pendingChildren: [favoriteRouteMatch],
          ),
        );
        final viewModel = TestIndexTrackingViewModel();
        viewModel.setIndex(2);

        viewModel.setCurrentWebPageIndex(service);

        expect(viewModel.currentIndex, 0);
      });

      test(
          'When topRoute is in the routes, the route has a match in the children should change currentIndex to 1',
          () {
        final service = TestRouterService(
          testRouter: TestRouter(testRoutes: [
            getRouteConfig('HomeView'),
            getRouteConfig('StreamsView'),
            getRouteConfig('BottomNavExample', children: [
              getRouteConfig('FavoriteView'),
              getRouteConfig('HistoryView'),
              getRouteConfig('ProfileView'),
            ]),
            getRouteConfig('CounterView'),
          ]),
          testTopRoute: getBottomNavExampleRouteData(
            pendingChildren: [historyRouteMatch],
          ),
        );
        final viewModel = TestIndexTrackingViewModel();
        viewModel.setIndex(0);

        viewModel.setCurrentWebPageIndex(service);

        expect(viewModel.currentIndex, 1);
      });

      test(
          'When topRoute is in the routes, the route has a match in the children should change currentIndex to 2',
          () {
        final service = TestRouterService(
          testRouter: TestRouter(testRoutes: [
            getRouteConfig('HomeView'),
            getRouteConfig('StreamsView'),
            getRouteConfig('BottomNavExample', children: [
              getRouteConfig('FavoriteView'),
              getRouteConfig('HistoryView'),
              getRouteConfig('ProfileView'),
            ]),
            getRouteConfig('CounterView'),
          ]),
          testTopRoute: getBottomNavExampleRouteData(
            pendingChildren: [profileRouteMatch],
          ),
        );
        final viewModel = TestIndexTrackingViewModel();
        viewModel.setIndex(0);

        viewModel.setCurrentWebPageIndex(service);

        expect(viewModel.currentIndex, 2);
      });
    });
  });
}
