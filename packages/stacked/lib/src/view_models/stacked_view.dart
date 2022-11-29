import 'package:flutter/widgets.dart';
import 'package:stacked/src/view_models/view_model_builder.dart';

/// A widget that wraps the [ViewModelBuilder] class in a less boiler plate use of the widget
///
/// Default [reactive] value is true. Can be overriden and set to false
abstract class StackedView<T extends ChangeNotifier> extends StatelessWidget {
  const StackedView({Key? key}) : super(key: key);

  /// A function that builds the UI to be shown from the ViewModel - Required
  ///
  /// [model] is the ViewModel passed in and [child] is the [staticChildBuilder] result
  Widget builder(BuildContext context, T model, Widget? child);

  /// A builder that builds the ViewModel for this UI - Required
  T modelBuilder(BuildContext context);

  /// Indicates if the [builder] should be rebuilt when notifyListeners is called
  ///
  /// When reactive is false the builder will fire once and the widgets will be used
  /// as a static child. IT WILL NOT BE BUILT AGAIN.
  bool get reactive => true;

  /// When set to true a new ViewModel will be constructed everytime the widget is inserted.
  ///
  /// When setting this to true make sure to handle all disposing of streams if subscribed
  /// to any in the ViewModel. [onModelReady] will fire once the ViewModel has been created/set.
  /// This will be used when on re-insert of the widget the ViewModel has to be constructed with
  /// a new value.
  bool get createNewModelOnInsert => false;

  /// Indicates if you want Provider to dispose the ViewModel when it's removed from the widget tree.
  ///
  /// default's to true
  bool get disposeModel => true;

  /// Indicates if you want to only initialise the [FutureViewModel] or [StreamViewModel] once or
  /// every time it's inserted into the widget tree.
  bool get initialiseSpecialModelsOnce => false;

  /// Indicates if you want to fire onModelReady only once or everytime this widget is inserted into
  /// the widget tree.
  bool get fireOnModelReadyOnce => false;

  /// Fires when the ViewModel is first created or re-created
  ///
  /// This will fire multiple times when [createNewModelOnInsert] is set to true
  void onModelReady(T model) {}

  /// Fires when the ViewModel is disposed
  ///
  /// Useful when working with a form on the view to dispose the form.
  void onDispose(T model) {}

  /// A Function that builds UI for the static child that builds only once
  ///
  /// When [reactive] is set to false the builder is used as the static child
  /// and is only ever built once.
  Widget? staticChildBuilder(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    if (reactive) {
      return ViewModelBuilder<T>.reactive(
        builder: builder,
        viewModelBuilder: () => modelBuilder(context),
        staticChild: staticChildBuilder(context),
        onModelReady: onModelReady,
        onDispose: onDispose,
        disposeViewModel: disposeModel,
        createNewModelOnInsert: createNewModelOnInsert,
        initialiseSpecialViewModelsOnce: initialiseSpecialModelsOnce,
        fireOnModelReadyOnce: fireOnModelReadyOnce,
      );
    } else {
      return ViewModelBuilder<T>.nonReactive(
        builder: builder,
        viewModelBuilder: () => modelBuilder(context),
        onModelReady: onModelReady,
        onDispose: onDispose,
        disposeViewModel: disposeModel,
        createNewModelOnInsert: createNewModelOnInsert,
        initialiseSpecialViewModelsOnce: initialiseSpecialModelsOnce,
        fireOnModelReadyOnce: fireOnModelReadyOnce,
      );
    }
  }
}
