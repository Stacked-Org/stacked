import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '_base_viewmodels.dart';

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
  ViewModelBuilder.nonReactive({
    @required this.builder,
    @required this.viewModelBuilder,
    this.onModelReady,
    this.disposeViewModel = true,
    this.createNewModelOnInsert = false,
  })  : providerType = _ViewModelBuilderType.NonReactive,
        staticChild = null;

  /// Constructs a viewmodel provider that fires the [builder] function when notifyListeners is called in the viewmodel.
  ViewModelBuilder.reactive({
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

      if (widget.onModelReady != null) {
        widget.onModelReady(_model);
      }
    } else if (widget.createNewModelOnInsert) {
      _createViewModel();
    }

    // Add any additional actions here for spcialised ViewModels
    if (_model is FutureViewModel) {
      (_model as FutureViewModel).runFuture();
    }
  }

  void _createViewModel() {
    if (widget.viewModelBuilder != null) {
      _model = widget.viewModelBuilder();
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
          builder: widget.builder,
          child: widget.staticChild,
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => _model,
      child: Consumer(
        builder: widget.builder,
        child: widget.staticChild,
      ),
    );
  }
}
