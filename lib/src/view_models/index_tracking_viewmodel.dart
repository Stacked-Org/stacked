import 'package:stacked/src/mixins/listenable_service_mixin.dart';
import 'package:stacked/src/router/router_service_interface.dart';
import 'package:stacked/src/view_models/base_view_models.dart';

/// You can use [BaseViewModel] or [ReactiveViewModel] with a [IndexTrackingStateHelper]
/// to achive the same result incase you want to combine multiple functionalities
class IndexTrackingViewModel extends ReactiveViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _reverse = false;

  /// Indicates whether we're going forward or backward in terms of the index we're changing.
  /// This is very helpful for the page transition directions.
  bool get reverse => _reverse;

  void setIndex(int value) {
    if (value < _currentIndex) {
      _reverse = true;
    } else {
      _reverse = false;
    }
    _currentIndex = value;
    notifyListeners();
  }

  bool isIndexSelected(int index) => _currentIndex == index;

  @override
  List<ListenableServiceMixin> get listenableServices => [];

  /// Sets current index using current Route on Web Platform.
  ///
  /// Allows to get the index from url during a browser refresh which means the
  /// app starts from scracth.
  void setCurrentWebPageIndex(RouterServiceInterface service) {
    if (!service.topRoute.hasPendingChildren) return;

    int? currentWebPageIndex;

    try {
      currentWebPageIndex = service.router.routes
          .firstWhere(
            (route) => route.name == service.topRoute.name,
          )
          .children
          ?.routes
          .skipWhile((route) => route.name.startsWith('#'))
          .toList()
          .indexWhere(
            (route) =>
                route.name == service.topRoute.pendingChildren.first.name,
          );
    } on StateError catch (_) {
      /// The route does not meet the condition in the firstWhere call
    } catch (_) {
      /// Catch everything else
    }

    if (currentWebPageIndex == null || currentWebPageIndex == -1) return;

    setIndex(currentWebPageIndex);
  }
}
