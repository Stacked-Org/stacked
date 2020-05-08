import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'base_view_models.dart';

enum _ViewModelBuilderType { NonReactive, Reactive }

/// A widget that provides base functionality for the Mvvm style provider architecture by FilledStacks.
class ViewModelBuilder<T extends ChangeNotifier> extends StatefulWidget {
  final Widget staticChild;

  /// Fires once when the viewmodel is created or set for the first time
  ///
  /// If you want this to fire everytime the widget is inserted set [createNewModelOnInsert] to true
  final Function(T) onModelReady;

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

  /// Constructs a viewmodel provider that will not rebuild the provided widget when notifyListeners is called.
  ///
  /// Widget from [builder] will be used as a staic child and won't rebuild when notifyListeners is called
  const ViewModelBuilder.nonReactive({
    @required this.builder,
    @required this.viewModelBuilder,
    this.onModelReady,
    this.disposeViewModel = true,
    this.createNewModelOnInsert = false,
  })  : providerType = _ViewModelBuilderType.NonReactive,
        staticChild = null;

  /// Constructs a viewmodel provider that fires the [builder] function when notifyListeners is called in the viewmodel.
  const ViewModelBuilder.reactive({
    @required this.builder,
    @required this.viewModelBuilder,
    this.staticChild,
    this.onModelReady,
    this.disposeViewModel = true,
    this.createNewModelOnInsert = false,
  }) : providerType = _ViewModelBuilderType.Reactive;

  @override
  _ViewModelBuilderState<T> createState() => _ViewModelBuilderState<T>();
}

class _ViewModelBuilderState<T extends ChangeNotifier>
    extends State<ViewModelBuilder<T>> {
  T _model;

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
    if (widget.viewModelBuilder != null) {
      _model = widget.viewModelBuilder();
    }

    _initialiseSpecialViewModels();

    // Fire onModelReady after the model has been constructed
    if (widget.onModelReady != null) {
      widget.onModelReady(_model);
    }
  }

  void _initialiseSpecialViewModels() {
    // Add any additional actions here for spcialised ViewModels
    // TODO: Provide a closed implemenation of this functionality. Refer to the Open Closed
    // principle in the SOLID principles
    if (_model is FutureViewModel) {
      (_model as FutureViewModel).runFuture();
    }

    if (_model is MultipleFutureViewModel) {
      (_model as MultipleFutureViewModel).runFutures();
    }

    if (_model is StreamViewModel) {
      (_model as StreamViewModel).initialise();
    }

    if (_model is MultipleStreamViewModel) {
      (_model as MultipleStreamViewModel).initialise();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.providerType == _ViewModelBuilderType.NonReactive) {
      if (!widget.disposeViewModel) {
        return ChangeNotifierProvider.value(
          value: _model,
          child: widget.builder(context, _model, widget.staticChild),
        );
      }

      return ChangeNotifierProvider(
        create: (context) => _model,
        child: widget.builder(context, _model, widget.staticChild),
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
      BuildContext context, T model, Widget child) {
    if (model is DynamicSourceViewModel) {
      if (model.changeSource ?? false) {
        _initialiseSpecialViewModels();
      }
    }
    return widget.builder(context, model, child);
  }
}

/// EXPERIMENTAL: Returns the ViewModel provided above this widget in the tree 
T getParentViewModel<T>(BuildContext context) => Provider.of<T>(context);
