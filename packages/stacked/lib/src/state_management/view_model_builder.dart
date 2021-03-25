import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'base_view_models.dart';

enum _ViewModelBuilderType { NonReactive, Reactive }

/// A widget that provides base functionality for the Mvvm style provider architecture by FilledStacks.
class ViewModelBuilder<T extends ChangeNotifier?> extends StatefulWidget {
  final Widget? staticChild;

  /// Fires once when the viewmodel is created or set for the first time
  ///
  /// If you want this to fire everytime the widget is inserted set [createNewModelOnInsert] to true
  final Function(T)? onModelReady;

  /// Builder function with access to the model to build UI form
  final Widget Function(BuildContext, T, Widget) builder;

  /// A builder function that returns the viewmodel for this widget
  final T Function() viewModelBuilder;

  /// Indicates if you want Provider to dispose the viewmodel when it's removed from the widget tree.
  ///
  /// default's to true
  final bool disposeViewModel;

  /// When set to true a new ViewModel will be constructed everytime the widget is inserted.
  ///
  /// When setting this to true make sure to handle all disposing of streams if subscribed
  /// to any in the ViewModel. [onModelReady] will fire once the viewmodel has been created/set.
  /// This will be used when on re-insert of the widget the viewmodel has to be constructed with
  /// a new value.
  final bool createNewModelOnInsert;

  final _ViewModelBuilderType providerType;

  /// Indicates if the onModelReady should fire every time the model is inserted into the widget tree.
  /// Or only once during the lifecycle of the model.
  final bool fireOnModelReadyOnce;

  /// Indicates if we should run the initialise functionality for special viewmodels only once
  final bool initialiseSpecialViewModelsOnce;

  /// Fires when the widget has been removed from the widget tree and allows you to dispose
  /// of any controllers or state values that need disposing
  final Function()? onDispose;

  /// Constructs a viewmodel provider that will not rebuild the provided widget when notifyListeners is called.
  ///
  /// Widget from [builder] will be used as a staic child and won't rebuild when notifyListeners is called
  const ViewModelBuilder.nonReactive({
    required this.builder,
    required this.viewModelBuilder,
    this.onModelReady,
    this.onDispose,
    this.disposeViewModel = true,
    this.createNewModelOnInsert = false,
    this.fireOnModelReadyOnce = false,
    this.initialiseSpecialViewModelsOnce = false,
    Key? key,
  })  : providerType = _ViewModelBuilderType.NonReactive,
        staticChild = null,
        super(key: key);

  /// Constructs a viewmodel provider that fires the [builder] function when notifyListeners is called in the viewmodel.
  const ViewModelBuilder.reactive({
    required this.builder,
    required this.viewModelBuilder,
    this.staticChild,
    this.onModelReady,
    this.onDispose,
    this.disposeViewModel = true,
    this.createNewModelOnInsert = false,
    this.fireOnModelReadyOnce = false,
    this.initialiseSpecialViewModelsOnce = false,
    Key? key,
  })  : providerType = _ViewModelBuilderType.Reactive,
        super(key: key);

  @override
  _ViewModelBuilderState<T> createState() => _ViewModelBuilderState<T>();
}

class _ViewModelBuilderState<T extends ChangeNotifier?>
    extends State<ViewModelBuilder<T?>> {
  T? _model;

  @override
  void initState() {
    super.initState();
    // We want to ensure that we only build the model if it hasn't been built yet.
    if (_model == null) {
      _createViewModel();
    }
    // Or if the user wants to create a new model whenever initState is fired
    else if (widget.createNewModelOnInsert) {
      _createViewModel();
    }
  }

  void _createViewModel() {
    // if (widget.viewModelBuilder) {
    _model = widget.viewModelBuilder();
    // }

    if (widget.initialiseSpecialViewModelsOnce &&
        !(_model as BaseViewModel).initialised) {
      _initialiseSpecialViewModels();
      (_model as BaseViewModel?)?.setInitialised(true);
    } else if (!widget.initialiseSpecialViewModelsOnce) {
      _initialiseSpecialViewModels();
    }

    // Fire onModelReady after the model has been constructed
    if (widget.onModelReady != null) {
      if (widget.fireOnModelReadyOnce &&
          !(_model as BaseViewModel).onModelReadyCalled) {
        widget.onModelReady!(_model);
        (_model as BaseViewModel?)?.setOnModelReadyCalled(true);
      } else if (!widget.fireOnModelReadyOnce) {
        widget.onModelReady!(_model);
      }
    }
  }

  void _initialiseSpecialViewModels() {
    if (_model is Initialisable) {
      (_model as Initialisable).initialise();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.providerType == _ViewModelBuilderType.NonReactive) {
      if (!widget.disposeViewModel) {
        return ChangeNotifierProvider.value(
          value: _model,
          child: widget.builder(context, _model, widget.staticChild!),
        );
      }

      return ChangeNotifierProvider(
        create: (context) => _model,
        child: widget.builder(context, _model, widget.staticChild!),
      );
    }

    if (!widget.disposeViewModel) {
      return ChangeNotifierProvider.value(
        value: _model,
        child: Consumer(
          builder: builderWithDynamicSourceInitialise,
          child: widget.staticChild,
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => _model,
      child: Consumer(
        builder: builderWithDynamicSourceInitialise,
        child: widget.staticChild,
      ),
    );
  }

  Widget builderWithDynamicSourceInitialise(
      BuildContext context, T model, Widget? child) {
    if (model is DynamicSourceViewModel) {
      if (model.changeSource) {
        _initialiseSpecialViewModels();
      }
    }
    return widget.builder(context, model, child!);
  }
}

/// EXPERIMENTAL: Returns the ViewModel provided above this widget in the tree
T getParentViewModel<T>(BuildContext context) => Provider.of<T>(context);
