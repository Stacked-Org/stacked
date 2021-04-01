typedef void ValueCallback<T>(T v);

/// A callback with no arguments.
///
/// Intended to listen to events emitted by [Emitter].
typedef dynamic Callback();

typedef bool Condition();

typedef T ValueGetter<T>();

typedef void ValueSetter<T>(T val);
