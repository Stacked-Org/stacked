import 'dart:async';
import 'package:stacked/stacked.dart';
import '../type_def.dart';

class ProxyValue<T> implements ReactiveValue<T> {
  ValueGetter<T> getterProxy;

  final StreamController<Change<T>> _controller;

  int _curBatch = 0;

  ProxyValue._(this._controller, this._onChange, this.getterProxy);

  factory ProxyValue(ValueGetter<T> getterProxy) {
    // ignore: close_sinks
    final controller = StreamController<Change<T>>();
    final onChange = controller.stream.asBroadcastStream();

    return ProxyValue._(controller, onChange, getterProxy);
  }

  @override
  T get value => getterProxy();
  @override
  set value(T val) {
    T old = value;
    if (old == val) {
      return;
    }
    _controller.add(Change<T>(val, old, _curBatch));
  }

  @override
  void setCast(dynamic /* T */ val) => value = val;

  Stream<Change<T>> _onChange;

  @override
  Stream<Change<T>> get onChange {
    _curBatch++;
    // ignore: close_sinks
    final ret = StreamController<Change<T>>();
    ret.add(Change<T>(value, value, _curBatch));
    ret.addStream(_onChange.skipWhile((v) => v.batch < _curBatch));
    return ret.stream.asBroadcastStream();
  }

  @override
  Stream<T> get values => onChange.map((c) => c.neu);

  @override
  void bind(ReactiveValue<T> reactive) {
    value = reactive.value;
    reactive.values.listen((v) => value = v);
  }

  @override
  void bindStream(Stream<T> stream) => stream.listen((v) => value = v);

  @override
  void bindOrSet(/* T | Stream<T> | Reactive<T> */ other) {
    if (other is ReactiveValue<T>) {
      bind(other);
    } else if (other is Stream<T>) {
      bindStream(other.cast<T>());
    } else {
      value = other;
    }
  }

  @override
  StreamSubscription<T> listen(ValueCallback<T> callback) =>
      values.listen(callback);

  @override
  Stream<R> map<R>(R Function(T data) mapper) => values.map(mapper);
}
