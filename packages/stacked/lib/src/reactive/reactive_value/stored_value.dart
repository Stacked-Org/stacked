import 'dart:async';
import 'package:stacked/stacked.dart';

import '../type_def.dart';

class StoredValue<T> implements ReactiveValue<T> {
  T _value;
  T get value => _value;
  set value(T val) {
    if (_value == val) {
      return;
    }
    T old = _value;
    _value = val;
    _change.add(Change<T>(val, old, _curBatch));
  }

  final StreamController<Change<T>> _change;

  final Stream<Change<T>> _onChange;

  int _curBatch = 0;

  StoredValue._(this._value, this._change, this._onChange);

  factory StoredValue(T initial) {
    // ignore: close_sinks
    final controller = StreamController<Change<T>>();
    return StoredValue._(
        initial, controller, controller.stream.asBroadcastStream());
  }

  void setCast(dynamic /* T */ val) => value = val;

  Stream<Change<T>> get onChange {
    _curBatch++;
    // ignore: close_sinks
    final ret = StreamController<Change<T>>();
    ret.add(Change<T>(value, value, _curBatch));
    ret.addStream(_onChange.skipWhile((v) => v.batch < _curBatch));
    return ret.stream.asBroadcastStream();
  }

  Stream<T> get values => onChange.map((c) => c.neu);

  void bind(ReactiveValue<T> reactive) {
    value = reactive.value;
    reactive.values.listen((v) => value = v);
  }

  void bindStream(Stream<T> stream) => stream.listen((v) => value = v);

  void bindOrSet(/* T | Stream<T> | Reactive<T> */ other) {
    if (other is ReactiveValue<T>) {
      bind(other);
    } else if (other is Stream<T>) {
      bindStream(other.cast<T>());
    } else {
      value = other;
    }
  }

  StreamSubscription<T> listen(ValueCallback<T> callback) =>
      values.listen(callback);

  Stream<R> map<R>(R mapper(T data)) => values.map(mapper);
}
