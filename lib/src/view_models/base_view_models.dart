import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:stacked/src/mixins/listenable_service_mixin.dart';
import 'package:stacked/src/view_models/helpers/data_state_helper.dart';

import '../mixins/reactive_service_mixin.dart';
import 'helpers/builders_helpers.dart';
import 'helpers/busy_error_state_helper.dart';
import 'helpers/message_state_helper.dart';

/// Contains ViewModel functionality for busy and error state management
class BaseViewModel extends ChangeNotifier
    with BuilderHelpers, BusyAndErrorStateHelper {
  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  /// Calls the builder function with this updated viewmodel
  void rebuildUi() {
    notifyListeners();
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}

/// A [BaseViewModel] that provides functionality to subscribe to a reactive service.
abstract class ReactiveViewModel extends BaseViewModel {
  List<ListenableServiceMixin> _listenableServices = [];
  List<ListenableServiceMixin> get listenableServices => [];

  // ignore: deprecated_member_use_from_same_package
  List<ReactiveServiceMixin> _reactiveServices = [];

  @Deprecated('Use listenableServices property instead')
  List<ReactiveServiceMixin> get reactiveServices => [];

  ReactiveViewModel() {
    if (listenableServices.isNotEmpty) _reactToServices(listenableServices);

    // ignore: deprecated_member_use_from_same_package
    if (reactiveServices.isNotEmpty) {
      // ignore: deprecated_member_use_from_same_package
      _reactToServicesDeprecated(reactiveServices);
    }
  }

  void _reactToServices(List<ListenableServiceMixin> listenableServices) {
    _listenableServices = listenableServices;
    for (var listenableService in _listenableServices) {
      listenableService.addListener(_indicateChange);
    }
  }

  // ignore: deprecated_member_use_from_same_package
  void _reactToServicesDeprecated(List<ReactiveServiceMixin> reactiveServices) {
    _reactiveServices = reactiveServices;
    for (var reactiveService in _reactiveServices) {
      reactiveService.addListener(_indicateChange);
    }
  }

  @override
  void dispose() {
    for (var listenableService in _listenableServices) {
      listenableService.removeListener(_indicateChange);
    }

    for (var reactiveService in _reactiveServices) {
      reactiveService.removeListener(_indicateChange);
    }
    super.dispose();
  }

  void _indicateChange() {
    notifyListeners();
  }
}

@protected
class DynamicSourceViewModel<T> extends ReactiveViewModel {
  bool changeSource = false;
  void notifySourceChanged() {
    changeSource = true;
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [];
}

/// Interface: Additional actions that should be implemented by spcialised ViewModels
abstract class Initialisable {
  void initialise();
}

class StreamData<T> extends DynamicSourceViewModel<T>
    with MessageStateHelper, DataStateHelper<T> {
  Stream<T> stream;

  /// Called when the new data arrives
  ///
  /// notifyListeners is called before this so no need to call in here unless you're
  /// running additional logic and setting a separate value.
  Function? onData;

  /// Called after the stream has been listened too
  Function? onSubscribed;

  /// Called when an error is placed on the stream
  Function? onError;

  /// Called when the stream is cancelled
  Function? onCancel;

  /// Allows you to modify the data before it's set as the new data for the ViewModel
  ///
  /// This can be used to modify the data if required. If nothhing is returned the data
  /// won't be set.
  Function? transformData;
  StreamData(
    this.stream, {
    this.onData,
    this.onSubscribed,
    this.onError,
    this.onCancel,
    this.transformData,
  });
  late StreamSubscription _streamSubscription;

  void initialise() {
    _streamSubscription = stream.listen(
      (incomingData) {
        setError(null);
        setMessage(null);
        // Extra security in case transformData isnt sent
        var interceptedData =
            transformData == null ? incomingData : transformData!(incomingData);

        if (interceptedData != null) {
          data = interceptedData;
        } else {
          data = incomingData;
        }

        notifyListeners();
        onData!(data);
      },
      onError: (error) {
        setError(error);
        data = null;
        onError!(error);
        notifyListeners();
      },
    );

    onSubscribed!();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    onCancel!();

    super.dispose();
  }
}
