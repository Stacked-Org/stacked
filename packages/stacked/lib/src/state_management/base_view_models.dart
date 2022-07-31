import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:stacked/src/state_management/reactive_service_mixin.dart';

import 'helpers/builders_helpers.dart';
import 'helpers/busy_state_helper.dart';
import 'helpers/error_state_helper.dart';
import 'helpers/message_state_helper.dart';

/// Contains ViewModel functionality for busy state management
class BaseViewModel extends ChangeNotifier
    with BuilderHelpers, BusyStateHelper, ErrorStateHelper {
  // Sets up streamData property to hold data, busy, and lifecycle events
  @protected
  StreamData setupStream<T>(
    Stream<T> stream, {
    onData,
    onSubscribed,
    onError,
    onCancel,
    transformData,
  }) {
    StreamData<T> streamData = StreamData<T>(
      stream,
      onData: onData,
      onSubscribed: onSubscribed,
      onError: onError,
      onCancel: onCancel,
      transformData: transformData,
    );
    streamData.initialise();

    return streamData;
  }

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}

/// A [BaseViewModel] that provides functionality to subscribe to a reactive service.
abstract class ReactiveViewModel extends BaseViewModel {
  late List<ReactiveServiceMixin> _reactiveServices;

  List<ReactiveServiceMixin> get reactiveServices;

  ReactiveViewModel() {
    _reactToServices(reactiveServices);
  }

  void _reactToServices(List<ReactiveServiceMixin> reactiveServices) {
    _reactiveServices = reactiveServices;
    for (var reactiveService in _reactiveServices) {
      reactiveService.addListener(_indicateChange);
    }
  }

  @override
  void dispose() {
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
class DynamicSourceViewModel<T> extends BaseViewModel {
  bool changeSource = false;
  void notifySourceChanged() {
    changeSource = true;
  }
}

/// Interface: Additional actions that should be implemented by spcialised ViewModels
abstract class Initialisable {
  void initialise();
}

class StreamData<T> extends SingleDataSourceViewModel<T>
    with MessageStateHelper {
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
        _error = null;
        notifyListeners();
        // Extra security in case transformData isnt sent
        var interceptedData =
            transformData == null ? incomingData : transformData!(incomingData);

        if (interceptedData != null) {
          _data = interceptedData;
        } else {
          _data = incomingData;
        }

        notifyListeners();
        onData!(_data);
      },
      onError: (error) {
        setError(error);
        _data = null;
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

class SingleDataSourceViewModel<T> extends DynamicSourceViewModel<T> {
  dynamic _error;
  @override
  dynamic error([Object? object]) => _error;
  @override
  void setError(error) {
    _error = error;
    super.setError(error);
  }

  bool get hasError => error(this) != null;
}
