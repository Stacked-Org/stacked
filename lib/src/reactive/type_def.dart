typedef ValueCallback<T> = void Function(T v);

/// A callback with no arguments.
///
/// Intended to listen to events emitted by [Emitter].
typedef Callback = dynamic Function();

typedef Condition = bool Function();

typedef ValueGetter<T> = T Function();

typedef ValueSetter<T> = void Function(T val);
