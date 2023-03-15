import 'dart:async';

import 'package:collection/collection.dart';
import 'package:stacked/src/reactive/type_def.dart';

/// Reactive list
class ReactiveList<E> extends DelegatingList<E> implements List<E> {
  Stream<ListChangeNotification<E>>? _onChange;

  final _changes = StreamController<ListChangeNotification<E>>();

  /// Create a list. Behaves similar to `List<int>([int length])`
  ReactiveList() : super(<E>[]) {
    _onChange = _changes.stream.asBroadcastStream();
  }

  ReactiveList.filled(int length, E fill, {bool growable = false})
      : super(List<E>.filled(length, fill, growable: growable)) {
    _onChange = _changes.stream.asBroadcastStream();
  }

  ReactiveList.from(Iterable<E> elements, {bool growable = true})
      : super(List<E>.from(elements, growable: growable)) {
    _onChange = _changes.stream.asBroadcastStream();
  }

  ReactiveList.of(Iterable<E> elements, {bool growable = true})
      : super(List<E>.of(elements, growable: growable));

  ReactiveList.generate(
    int length,
    E Function(int index) generator, {
    bool growable = true,
  }) : super(List<E>.generate(length, generator, growable: growable));

  /// Adds [element] only if [condition] resolves to true.
  void addIf(/* bool | Condition */ condition, E element) {
    if (condition is Condition) condition = condition();
    if (condition is bool && condition) add(element);
  }

  /// Adds all [elements] only if [condition] resolves to true.
  void addAllIf(/* bool | Condition */ condition, Iterable<E> elements) {
    if (condition is Condition) condition = condition();
    if (condition is bool && condition) addAll(elements);
  }

  @override
  operator []=(int index, E value) {
    super[index] = value;
    _changes.add(ListChangeNotification<E>.set(value, index));
  }

  void _add(E element) => super.add(element);

  @override
  void add(E value) {
    super.add(value);
    _changes.add(ListChangeNotification<E>.insert(value, length - 1));
  }

  @override
  void addAll(Iterable<E> iterable) {
    super.addAll(iterable);
    for (var element in iterable) {
      _changes.add(ListChangeNotification<E>.insert(element, length - 1));
    }
  }

  /// Adds only if [element] is not null.
  void addNonNull(E element) {
    if (element != null) add(element);
  }

  @override
  void insert(int index, E element) {
    super.insert(index, element);
    _changes.add(ListChangeNotification<E>.insert(element, index));
  }

  @override
  bool remove(final Object? value) {
    int pos = indexOf(value as E);
    bool hasRemoved = super.remove(value);
    if (hasRemoved) {
      _changes.add(ListChangeNotification<E>.remove(value, pos));
    }
    return hasRemoved;
  }

  @override
  void clear() {
    super.clear();
    _changes.add(ListChangeNotification<E>.clear());
  }

  /// Replaces all existing elements of this list with [element]
  void assign(E element) {
    clear();
    add(element);
  }

  /// Replaces all existing elements of this list with [elements]
  void assignAll(Iterable<E> elements) {
    clear();
    addAll(elements);
  }

  /// A stream of record of changes to this list
  Stream<ListChangeNotification<E>> get onChange {
    // ignore: close_sinks
    final ret = StreamController<ListChangeNotification<E>>();
    final now = DateTime.now();
    ret.addStream(_onChange!.skipWhile((m) => m.time.isBefore(now)));
    return ret.stream.asBroadcastStream();
  }
}

typedef ChildrenListComposer<S, E> = E Function(S value);

/// An Reactive list that is bound to another list [binding]
class BoundList<S, E> extends ReactiveList<E> {
  final ReactiveList<S> binding;

  final ChildrenListComposer<S, E> composer;

  BoundList(this.binding, this.composer) {
    for (S v in binding) {
      _add(composer(v));
    }
    binding.onChange.listen((ListChangeNotification<S> n) {
      if (n.op == ListChangeOp.add) {
        insert(n.pos!, composer(n.element as S));
      } else if (n.op == ListChangeOp.remove) {
        removeAt(n.pos!);
      } else if (n.op == ListChangeOp.clear) {
        clear();
      }
    });
  }
}

/// Change operation
enum ListChangeOp { add, remove, clear, set }

/// A record of change in a [ReactiveList]
class ListChangeNotification<E> {
  final E? element;

  final ListChangeOp op;

  final int? pos;

  final DateTime time;

  ListChangeNotification(this.element, this.op, this.pos, {DateTime? time})
      : time = time ?? DateTime.now();

  ListChangeNotification.insert(this.element, this.pos, {DateTime? time})
      : op = ListChangeOp.add,
        time = time ?? DateTime.now();

  ListChangeNotification.set(this.element, this.pos, {DateTime? time})
      : op = ListChangeOp.set,
        time = time ?? DateTime.now();

  ListChangeNotification.remove(this.element, this.pos, {DateTime? time})
      : op = ListChangeOp.remove,
        time = time ?? DateTime.now();

  ListChangeNotification.clear({DateTime? time})
      : op = ListChangeOp.clear,
        pos = null,
        element = null,
        time = time ?? DateTime.now();
}
