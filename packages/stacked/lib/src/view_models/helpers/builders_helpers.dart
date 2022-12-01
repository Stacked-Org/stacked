/// Essential helper to work with the [ViewModelBuilder]
mixin BuilderHelpers {
  bool disposed = false;

  bool _initialised = false;
  bool get initialised => _initialised;

  bool _onModelReadyCalled = false;
  bool get onModelReadyCalled => _onModelReadyCalled;

  /// Sets the initialised value for the ViewModel to true. This is called after
  /// the first initialise special ViewModel call
  void setInitialised(bool value) {
    _initialised = value;
  }

  /// Sets the onModelReadyCalled value to true. This is called after this first onModelReady call
  void setOnModelReadyCalled(bool value) {
    _onModelReadyCalled = value;
  }
}
