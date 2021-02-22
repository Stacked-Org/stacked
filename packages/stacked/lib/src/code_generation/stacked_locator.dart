import 'package:get_it/get_it.dart';

/// A thin wrapper around get_it to reduce the number of direct dependencies the user has to depend on.
class StackedLocator {
  static StackedLocator _instance;

  GetIt locator;

  StackedLocator._(GetIt instance) : locator = instance;

  /// access to the Singleton instance of GetIt
  static StackedLocator get instance {
    // ignore: join_return_with_assignment
    if (_instance == null) {
      // TODO: Add new instance ability here
      _instance = StackedLocator._(GetIt.instance);
    }
    return _instance;
  }

  /// If you need more than one instance of GetIt you can use [asNewInstance()]
  /// You should prefer to use the `instance()` method to access the global instance of [GetIt].
  factory StackedLocator.asNewInstance() {
    return StackedLocator._(GetIt.asNewInstance());
  }

  /// By default it's not allowed to register a type a second time.
  /// If you really need to you can disable the asserts by setting[allowReassignment]= true
  bool allowReassignment = false;

  /// retrieves or creates an instance of a registered type [T] depending on the registration
  /// function used for this type or based on a name.
  /// for factories you can pass up to 2 parameters [param1,param2] they have to match the types
  /// given at registration with [registerFactoryParam()]
  T get<T>({String instanceName, dynamic param1, dynamic param2}) =>
      locator.get<T>(
        instanceName: instanceName,
        param1: param1,
        param2: param2,
      );

  /// Returns an Future of an instance that is created by an async factory or a Singleton that is
  /// not ready with its initialization.
  /// for async factories you can pass up to 2 parameters [param1,param2] they have to match the types
  /// given at registration with [registerFactoryParamAsync()]
  Future<T> getAsync<T>(
          {String instanceName, dynamic param1, dynamic param2}) =>
      locator.getAsync<T>(
        instanceName: instanceName,
        param1: param1,
        param2: param2,
      );

  /// Callable class so that you can write `GetIt.instance<MyType>` instead of
  /// `GetIt.instance.get<MyType>`
  T call<T>({String instanceName, dynamic param1, dynamic param2}) =>
      locator<T>(
        instanceName: instanceName,
        param1: param1,
        param2: param2,
      );

  /// registers a type so that a new instance will be created on each call of [get] on that type
  /// [T] type to register
  /// [factoryfunc] factory function for this type
  /// [instanceName] if you provide a value here your factory gets registered with that
  /// name instead of a type. This should only be necessary if you need to register more
  /// than one instance of one type. Its highly not recommended
  void registerFactory<T>(FactoryFunc<T> factoryfunc, {String instanceName}) =>
      locator.registerFactory<T>(
        factoryfunc,
        instanceName: instanceName,
      );

  /// registers a type so that a new instance will be created on each call of [get] on that type based on
  /// up to two parameters provided to [get()]
  /// [T] type to register
  /// [P1] type of  param1
  /// [P2] type of  param2
  /// if you use only one parameter pass void here
  /// [factoryfunc] factory function for this type that accepts two parameters
  /// [instanceName] if you provide a value here your factory gets registered with that
  /// name instead of a type. This should only be necessary if you need to register more
  /// than one instance of one type. Its highly not recommended
  ///
  /// example:
  ///    getIt.registerFactoryParam<TestClassParam,String,int>((s,i)
  ///        => TestClassParam(param1:s, param2: i));
  ///
  /// if you only use one parameter:
  ///
  ///    getIt.registerFactoryParam<TestClassParam,String,void>((s,_)
  ///        => TestClassParam(param1:s);
  void registerFactoryParam<T, P1, P2>(FactoryFuncParam<T, P1, P2> factoryfunc,
          {String instanceName}) =>
      locator.registerFactoryParam<T, P1, P2>(factoryfunc,
          instanceName: instanceName);

  /// Registers a type so that a new instance will be created on each call of [getAsync] on that type
  /// the creation function is executed asynchronously and has to be accessed  with [getAsync]
  /// [T] type to register
  /// [factoryfunc] async factory function for this type
  /// [instanceName] if you provide a value here your factory gets registered with that
  /// name instead of a type. This should only be necessary if you need to register more
  /// than one instance of one type. Its highly not recommended
  void registerFactoryAsync<T>(FactoryFuncAsync<T> factoryfunc,
          {String instanceName}) =>
      locator.registerFactoryAsync<T>(factoryfunc, instanceName: instanceName);

  /// registers a type so that a new instance will be created on each call of [getAsync]
  /// on that type based on up to two parameters provided to [getAsync()]
  /// the creation function is executed asynchronously and has to be accessed  with [getAsync]
  /// [T] type to register
  /// [P1] type of  param1
  /// [P2] type of  param2
  /// if you use only one parameter pass void here
  /// [factoryfunc] factory function for this type that accepts two parameters
  /// [instanceName] if you provide a value here your factory gets registered with that
  /// name instead of a type. This should only be necessary if you need to register more
  /// than one instance of one type. Its highly not recommended
  ///
  /// example:
  ///    getIt.registerFactoryParam<TestClassParam,String,int>((s,i) async
  ///        => TestClassParam(param1:s, param2: i));
  ///
  /// if you only use one parameter:
  ///
  ///    getIt.registerFactoryParam<TestClassParam,String,void>((s,_) async
  ///        => TestClassParam(param1:s);
  void registerFactoryParamAsync<T, P1, P2>(
          FactoryFuncParamAsync<T, P1, P2> factoryfunc,
          {String instanceName}) =>
      locator.registerFactoryParamAsync<T, P1, P2>(factoryfunc,
          instanceName: instanceName);

  /// registers a type as Singleton by passing an [instance] of that type
  /// that will be returned on each call of [get] on that type
  /// [T] type to register
  /// [instanceName] if you provide a value here your instance gets registered with that
  /// name instead of a type. This should only be necessary if you need to register more
  /// than one instance of one type. Its highly not recommended
  /// If [signalsReady] is set to `true` it means that the future you can get from `allReady()`
  /// cannot complete until this this instance was signalled ready by calling [signalsReady(instance)].
  void registerSingleton<T>(T instance,
          {String instanceName, bool signalsReady, DisposingFunc<T> dispose}) =>
      locator.registerSingleton<T>(
        instance,
        instanceName: instanceName,
        signalsReady: signalsReady,
        dispose: dispose,
      );

  /// registers a type as Singleton by passing an factory function of that type
  /// that will be called on each call of [get] on that type
  /// [T] type to register
  /// [instanceName] if you provide a value here your instance gets registered with that
  /// name instead of a type. This should only be necessary if you need to register more
  /// than one instance of one type. Its highly not recommended
  /// [dependsOn] if this instance depends on other registered  Singletons before it can be initilaized
  /// you can either orchestrate this manually using [isReady()] or pass a list of the types that the
  /// instance depends on here. [factoryFunc] won't get executed till this types are ready.
  /// [func] is called
  /// If [signalsReady] is set to `true` it means that the future you can get from `allReady()`
  /// cannot complete until this this instance was signalled ready by calling [signalsReady(instance)].
  void registerSingletonWithDependencies<T>(FactoryFunc<T> factoryFunc,
          {String instanceName,
          Iterable<Type> dependsOn,
          bool signalsReady,
          DisposingFunc<T> dispose}) =>
      locator.registerSingletonWithDependencies<T>(
        factoryFunc,
        instanceName: instanceName,
        dependsOn: dependsOn,
        signalsReady: signalsReady,
        dispose: dispose,
      );

  /// registers a type as Singleton by passing an asynchronous factory function which has to return the instance
  /// that will be returned on each call of [get] on that type.
  /// Therefore you have to ensure that the instance is ready before you use [get] on it or use [getAsync()] to
  /// wait for the completion.
  /// You can wait/check if the instance is ready by using [isReady()] and [isReadySync()].
  /// [factoryfunc] is executed immediately if there are no dependencies to other Singletons (see below).
  /// As soon as it returns, this instance is marked as ready unless you don't set [signalsReady==true]
  /// [instanceName] if you provide a value here your instance gets registered with that
  /// name instead of a type. This should only be necessary if you need to register more
  /// than one instance of one type. Its highly not recommended
  /// [dependsOn] if this instance depends on other registered  Singletons before it can be initilaized
  /// you can either orchestrate this manually using [isReady()] or pass a list of the types that the
  /// instance depends on here. [factoryFunc] won't get  executed till this types are ready.
  /// If [signalsReady] is set to `true` it means that the future you can get from `allReady()`  cannot complete until this
  /// this instance was signalled ready by calling [signalsReady(instance)]. In that case no automatic ready signal
  /// is made after completion of [factoryfunc]
  void registerSingletonAsync<T>(FactoryFuncAsync<T> factoryfunc,
          {String instanceName,
          Iterable<Type> dependsOn,
          bool signalsReady,
          DisposingFunc<T> dispose}) =>
      locator.registerSingletonAsync<T>(
        factoryfunc,
        instanceName: instanceName,
        dependsOn: dependsOn,
        signalsReady: signalsReady,
        dispose: dispose,
      );

  /// registers a type as Singleton by passing a factory function that will be called
  /// on the first call of [get] on that type
  /// [T] type to register
  /// [factoryfunc] factory function for this type
  /// [instanceName] if you provide a value here your factory gets registered with that
  /// name instead of a type. This should only be necessary if you need to register more
  /// than one instance of one type. Its highly not recommended
  /// [registerLazySingleton] does not influence [allReady] however you can wait
  /// for and be dependent on a LazySingleton.
  void registerLazySingleton<T>(FactoryFunc<T> factoryfunc,
          {String instanceName, DisposingFunc<T> dispose}) =>
      locator.registerLazySingleton<T>(
        factoryfunc,
        instanceName: instanceName,
        dispose: dispose,
      );

  /// registers a type as Singleton by passing a async factory function that will be called
  /// on the first call of [getAsnc] on that type
  /// This is a rather esoteric requirement so you should seldom have the need to use it.
  /// This factory function [factoryFunc] isn't called immediately but wait till the first call by
  /// [getAsync()] or [isReady()] is made
  /// To control if an async Singleton has completed its [factoryFunc] gets a `Completer` passed
  /// as parameter that has to be completed to signal that this instance is ready.
  /// Therefore you have to ensure that the instance is ready before you use [get] on it or use [getAsync()] to
  /// wait for the completion.
  /// You can wait/check if the instance is ready by using [isReady()] and [isReadySync()].
  /// [instanceName] if you provide a value here your instance gets registered with that
  /// name instead of a type. This should only be necessary if you need to register more
  /// than one instance of one type. Its highly not recommended.
  /// [registerLazySingletonAsync] does not influence [allReady] however you can wait
  /// for and be dependent on a LazySingleton.
  void registerLazySingletonAsync<T>(FactoryFuncAsync<T> factoryFunc,
          {String instanceName, DisposingFunc<T> dispose}) =>
      locator.registerLazySingletonAsync<T>(
        factoryFunc,
        instanceName: instanceName,
        dispose: dispose,
      );

  /// Tests if an [instance] of an object or aType [T] or a name [instanceName]
  /// is registered inside GetIt
  bool isRegistered<T>({Object instance, String instanceName}) =>
      locator.isRegistered<T>(
        instance: instance,
        instanceName: instanceName,
      );

  /// Clears all registered types. Handy when writing unit tests
  /// If you provided dispose function when registering they will be called
  /// [dispose] if `false` it only resets without calling any dispose
  /// functions
  /// As dispose funcions can be async, you should await this function.
  Future<void> reset({bool dispose = true}) => locator.reset(dispose: dispose);

  /// Clears all registered types for the current scope
  /// If you provided dispose function when registering they will be called
  /// [dispose] if `false` it only resets without calling any dispose
  /// functions
  /// As dispose funcions can be async, you should await this function.
  Future<void> resetScope({bool dispose = true}) =>
      locator.resetScope(dispose: dispose);

  /// Creates a new registration scope. If you register types after creating
  /// a new scope they will hide any previous registration of the same type.
  /// Scopes allow you to manage different live times of your Objects.
  /// [scopeName] if you name a scope you can pop all scopes above the named one
  /// by using the name.
  /// [dispose] function that will be called when you pop this scope. The scope
  /// is still valied while it is executed
  void pushNewScope({String scopeName, ScopeDisposeFunc dispose}) =>
      locator.pushNewScope(
        scopeName: scopeName,
        dispose: dispose,
      );

  /// Disposes all factories/Singletons that have ben registered in this scope
  /// and pops (destroys) the scope so that the previous scope gets active again.
  /// if you provided  dispose functions on registration, they will be called.
  /// if you passed a dispose function when you pushed this scope it will be
  /// calles before the scope is popped.
  /// As dispose funcions can be async, you should await this function.
  Future<void> popScope() => locator.popScope();

  /// if you have a lot of scopes with names you can pop (see [popScope]) all
  /// scopes above the scope with [name] including that scope
  /// Scopes are poped in order from the top
  /// As dispose funcions can be async, you should await this function.
  /// it no scope with [name] exists, nothing is popped and `false` is returned
  Future<bool> popScopesTill(String name) => locator.popScopesTill(name);

  /// Clears the instance of a lazy singleton,
  /// being able to call the factory function on the next call
  /// of [get] on that type again.
  /// you select the lazy Singleton you want to reset by either providing
  /// an [instance], its registered type [T] or its registration name.
  /// if you need to dispose some resources before the reset, you can
  /// provide a [disposingFunction]. This function overrides the disposing
  /// you might have provided when registering.
  void resetLazySingleton<T>(
          {Object instance,
          String instanceName,
          void Function(T) disposingFunction}) =>
      locator.resetLazySingleton<T>(
        instance: instance,
        instanceName: instanceName,
        disposingFunction: disposingFunction,
      );

  /// Unregister an [instance] of an object or a factory/singleton by Type [T] or by name [instanceName]
  /// if you need to dispose any resources you can do it using [disposingFunction] function
  /// that provides a instance of your class to be disposed. This function overrides the disposing
  /// you might have provided when registering.
  void unregister<T>(
          {Object instance,
          String instanceName,
          void Function(T) disposingFunction}) =>
      locator.unregister<T>(
        instance: instance,
        instanceName: instanceName,
        disposingFunction: disposingFunction,
      );

  /// returns a Future that completes if all asynchronously created Singletons and any Singleton that had
  ///  [signalsReady==true] are ready.
  /// This can be used inside a FutureBuilder to change the UI as soon as all initialization
  /// is done
  /// If you pass a [timeout], an [WaitingTimeOutException] will be thrown if not all Singletons
  /// were ready in the given time. The Exception contains details on which Singletons are not ready yet.
  /// if [allReady] should not wait for the completion of async Signletons set
  /// [ignorePendingAsyncCreation==true]
  Future<void> allReady(
          {Duration timeout, bool ignorePendingAsyncCreation = false}) =>
      locator.allReady(
        timeout: timeout,
        ignorePendingAsyncCreation: ignorePendingAsyncCreation,
      );

  /// Returns a Future that completes if the instance of an Singleton, defined by Type [T] or
  /// by name [instanceName] or by passing the an existing [instance],  is ready
  /// If you pass a [timeout], an [WaitingTimeOutException] will be thrown if the instance
  /// is not ready in the given time. The Exception contains details on which Singletons are
  /// not ready at that time.
  /// [callee] optional parameter which makes debugging easier. Pass `this` in here.
  Future<void> isReady<T>({
    Object instance,
    String instanceName,
    Duration timeout,
    Object callee,
  }) =>
      locator.isReady<T>(
        instance: instance,
        instanceName: instanceName,
        timeout: timeout,
        callee: callee,
      );

  /// Checks if an async Singleton defined by an [instance], a type [T] or an [instanceName]
  /// is ready without waiting
  bool isReadySync<T>({Object instance, String instanceName}) =>
      locator.isReadySync<T>(
        instance: instance,
        instanceName: instanceName,
      );

  /// Returns if all async Singletons are ready without waiting
  /// if [allReady] should not wait for the completion of async Signletons set
  /// [ignorePendingAsyncCreation==true]
  // ignore: avoid_positional_boolean_parameters
  bool allReadySync([bool ignorePendingAsyncCreation = false]) =>
      locator.allReadySync(ignorePendingAsyncCreation);

  /// Used to manually signal the ready state of a Singleton.
  /// If you want to use this mechanism you have to pass [signalsReady==true] when registering
  /// the Singleton.
  /// If [instance] has a value GetIt will search for the responsible Singleton
  /// and completes all futures that might be waited for by [isReady]
  /// If all waiting singletons have signalled ready the future you can get
  /// from [allReady] is automatically completed
  ///
  /// Typically this is used in this way inside the registered objects init
  /// method `GetIt.instance.signalReady(this);`
  ///
  /// if [instance] is `null` and no factory/singleton is waiting to be signalled this
  /// will complete the future you got from [allReady], so it can be used to globally
  /// giving a ready Signal
  ///
  /// Both ways are mutual exclusive, meaning either only use the global `signalReady()` and
  /// don't register a singleton to signal ready or use any async registrations
  ///
  /// Or use async registrations methods or let individual instances signal their ready
  /// state on their own.
  void signalReady(Object instance) => locator.signalReady(instance);
}
