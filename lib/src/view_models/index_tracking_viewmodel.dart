// import 'package:stacked/src/mixins/listenable_service_mixin.dart';
// import 'package:stacked/src/router/router_service_interface.dart';
// import 'package:stacked/src/view_models/base_view_models.dart';
import 'package:stacked/stacked.dart';

/// You can use [BaseViewModel] or [ReactiveViewModel] with a [IndexTrackingStateHelper]
/// to achive the same result incase you want to combine multiple functionalities
abstract class IndexTrackingViewModel extends ReactiveViewModel
    with IndexTrackingStateHelper {
  @override
  List<ListenableServiceMixin> get listenableServices => [];
}
