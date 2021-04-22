# Stacked [![Pub Version](https://img.shields.io/pub/v/stacked)](https://pub.dev/packages/stacked)

An architecture developed and revised by the [FilledStacks](https://www.youtube.com/filledstacks) community. This architecture was initially a version of MVVM as [described in this video](https://youtu.be/kDEflMYTFlk). Since then Filledstacks app development team has built 6 production applications with various requirements. This experience along with countless requests for improvements and common functionality is what sparked the creation of this architecture package. It aims to provide **common functionalities to make app development easier** as well as code principles to use during development to ensure your code stays maintainable.

[Here you can watch the full video series](https://www.youtube.com/playlist?list=PLdTodMosi-BwM4XkagNwe4KADOMWQS5X-) for an in depth dive of this architecture.

### Migrate from 1.6.1 -> 1.7

- hasError(key) -> error(key) for multiple ViewModel
- viewModel.error -> viewModel.modelError for multiple ViewModel

## How Does it work

The architecture is very simple. It consists of 3 major pieces, everything else is up to your implementation style. These pieces are:

- **View**: Shows the UI to the user. Single widgets also qualify as views (for consistency in terminology) a view, in this case, is not a "Page" it's just a UI representation.
- **ViewModel**: Manages the state of the View, business logic, and any other logic as required from user interaction. It does this by making use of the services
- **Services**: A wrapper of a single functionality/feature set. This is commonly used to wrap things like showing a dialog, wrapping database functionality, integrating an API, etc.

Let's go over some of those principles to follow during development.

- Views should never MAKE USE of services directly.
- Views should contain zero to (preferred) no logic. If the logic is from UI only items then we do the least amount of required logic and pass the rest to the ViewModel.
- Views should ONLY render the state in its ViewModel.
- ViewModels for widgets that represent page views are bound to a single View only.
- ViewModels may be re-used if the UI require the same functionality.
- ViewModels should not know about other ViewModels

That's quite a bit of "rules" but they help during production. Trust me.

## Stacked's place in your architecture

Stacked provides you with classes and functionalities to make it easy to implement that base architecture that this package is built for. There are additional things that you can add to your application that will make the user of this architecture much more pleasant. This will be discussed in full on the architecture series that will come out soon. Everything from navigation, dependency injection, service location, error handling, etc.

## ViewModelBuilder

The `ViewModelBuilder` was first built in the [Provider Architecture Tutorial](https://youtu.be/kDEflMYTFlk) where it was titled BaseView. The `ViewModelBuilder` is used to create the "binding" between a ViewModel and the View. There is no two-way binding in this architecture, which is why I don't want to say it's an Mvvm implementation and why we have instead given it our name. The `ViewModelBuilder` wraps up all the `ChangeNotifierProvider` code which allows us to trigger a rebuild of a widget when calling `notifyListeners` within the ViewModel.

A ViewModel is simply a dart class that extends `ChangeNotifier`. The `ViewModelBuilder` has 2 constructors, one that's reactive and one that's not. The tutorial mentioned above emulates the default implementation which has been put into the `.reactive` named constructor. The `.nonReactive` constructor is for UI that does not require the builder to fire when `notifyListeners` is called in the ViewModel. The nonReactive construction was born in [this tutorial](https://youtu.be/HUSqk0OrR7I?t=224) where we wanted to reduce the boilerplate when the same data has to go to multiple widgets using the same ViewModel. This is very prominent when using the responsive_builder package.

### Reactive

This is the default implementation of "binding" your view to your ViewModel.

```dart

// View
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using the reactive constructor gives you the traditional ViewModel
    // binding which will execute the builder again when notifyListeners is called.
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            viewModel.updateTitle();
          },
        ),
        body: Center(
          child: Text(viewModel.title),
        ),
      ),
    );
  }
}

// ViewModel
class HomeViewModel extends ChangeNotifier {
  String title = 'default';

  void initialise() {
    title = 'initialised';
    notifyListeners();
  }

  int counter = 0;
  void updateTitle() {
    counter++;
    title = '$counter';
    notifyListeners();
  }
}

```

When `notifyListeners` is called in the ViewModel the builder is triggered allowing you to rebuild your UI with the new updated ViewModel state. The process here is you update your data then call `notifyListeners` and rebuild your UI.

### Non Reactive

The `.nonReactive` constructor is best used for providing your ViewModel to multiple child widgets that will make use of it. It was created to make it easier to build and provide the same ViewModel to multiple UI's. It was born out of the [Responsive UI architecture](https://youtu.be/HUSqk0OrR7I) where we would have to provide the same ViewModel to all the different responsive layouts. Here's a simple example.

```dart
// ViewModel in the above code

// View
class HomeViewMultipleWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, _) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            viewModel.updateTitle();
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[TitleSection(), DescriptionSection()],
        ),
      ),
    );
  }
}

class TitleSection extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Row(
      children: <Widget>[
        Text(
          'Title',
          style: TextStyle(fontSize: 20),
        ),
        Container(
          child: Text(viewModel.title),
        ),
      ],
    );
  }
}

class DescriptionSection extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Row(
      children: <Widget>[
        Text(
          'Description',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        Container(
          child: Text(viewModel.title),
        ),
      ],
    );
  }
}
```

So what we're doing here is providing the ViewModel to the children of the builder function. The builder function itself won't retrigger when `notifyListeners` is called. Instead, we will extend from `ViewModelWidget` in the widgets that we want to rebuild from the ViewModel. This allows us to easily access the ViewModel in multiple widgets without a lot of repeat boilerplate code. We already extend from a `StatelessWidget` so we can change that to `ViewModelWidget`. Then we simply add the ViewModel as a parameter to the build function. This is the same as calling `Provider<ViewModel>.of` in every widget we want to rebuild.

### ViewModelBuilderWidget

If you want to make use of the `ViewModelBuilder` directly as a widget it can be extended as well using the `ViewModelBuilderWidget<T>`. This will give you the same properties to override as the ones you can pass into the named constructors. There are 2 required overrides, the same as the 2 required parameters for the constructors. The difference with this is that your code will look like a normal widget so it fits into the codebase. You can also override and implement `onModelReady` and `staticChildBuilder`.

```dart

class BuilderWidgetExampleView extends ViewModelBuilderWidget<HomeViewModel> {

  @override
  bool get reactive => false;

  @override
  bool get createNewModelOnInsert => false;

  @override
  bool get disposeViewModel => true;

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget child,
  ) {
    return Scaffold(
      body: Center(
        child: Text(viewModel.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.updateTitle(),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
```

This is to help with removing some boilerplate code.

### Disable ViewModel Dispose

An example of how to disable the dispose of a ViewModel.

```dart
// View
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
      // When the disposeViewModel is set to false the ViewModel will
      // not be disposed during the normal life cycle of a widget.
      disposeViewModel: false,
      builder: (context, viewModel, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            viewModel.updateTitle();
          },
        ),
        body: Center(
          child: Text(viewModel.title),
        ),
      ),
    );
  }
}

```

Note that the `ViewModelBuilder` constructor is called with parameter `disposeViewModel: false`. This enables us to pass an existing instance of a ViewModel.

### Call onModelReady only once

In some cases, specifically using a `BottomNavigationBar` you don't want the `onModelReady` function to fire every time the widget that the `ViewModel` is associated with comes into view. To toggle this you can set `fireOnModelReadyOnce` to true. This will fire the onModelReady call only once during the lifecycle of the `ViewModel`. When it's recreated it will fire again. Checkout the [BottomNavigation example](https://github.com/FilledStacks/stacked/blob/master/packages/stacked/example/lib/ui/bottom_nav/bottom_nav_example.dart) in the examples folder.

```dart
class FavoritesView extends StatelessWidget {
  const FavoritesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoritesViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => viewModel.incrementCounter(),
          ),
          body: Center(
              child: Text(
            viewModel.counter.toString(),
            style: TextStyle(fontSize: 30),
          ))),
      viewModelBuilder: () => locator<FavoritesViewModel>(),
      onModelReady: (viewModel) => viewModel.setCounterTo999(),
      disposeViewModel: false,
      // Tell the ViewModelBuilder to only fire this once
      fireOnModelReadyOnce: true,
    );
  }
}
```

### Fire initialisation only once

Special `ViewModels` like `FutureViewModel` or `StreamViewModel` runs it's logic through an initialise call by the ViewModelBuilder. If you want to fire the initialisation logic only once you can set `initialiseSpecialViewModelsOnce: true`

```dart
class FavoritesView extends StatelessWidget {
  const FavoritesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoritesViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => viewModel.incrementCounter(),
          ),
          body: Center(
              child: Text(
            viewModel.counter.toString(),
            style: TextStyle(fontSize: 30),
          ))),
      viewModelBuilder: () => locator<FavoritesViewModel>(),
      disposeViewModel: false,
      // Tell the ViewModelBuilder to only fire the initialse function once
      initialiseSpecialViewModelsOnce: true
    );
  }
}
```

This in cases that you have a Future ViewModel that you'd like to fire only once. To ensure this works correctly you should also make sure you're using a singleton ViewModel so that you always use the same instance and also set disposeViewModel to false. This can be seen in the bottom_nav folder under ui in the example. Look at the bottom_nav_example.dart file for more details.

## ViewModel Widget

The `ViewModelWidget` is an implementation of a widget class that returns a value provided by the Provider as a parameter in the build function of the widget. Let's say for instance you have a DataModel you want to use in multiple widgets. We can use the `Provider.value` call to supply that value, then inside the multiple widgets, we inherit from the `ViewModelWidget` and make use of the data directly from the build method.

```dart

// View
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.value(
        value: Human(name: 'Dane', surname: 'Mackier'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[FullNameWidget(), DuplicateNameWidget()],
        ),
      ),
    );
  }
}

// DataModel
class Human {
  final String name;
  final String surname;

  Human({this.name, this.surname});
}

// consuming widget 1
class FullNameWidget extends ViewModelWidget<Human> {
  @override
  Widget build(BuildContext context, Human dataModel) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            dataModel.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        SizedBox(
          width: 50,
        ),
        Container(
          child: Text(
            dataModel.surname,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
      ],
    );
  }
}

// consuming widget 2
class DuplicateNameWidget extends ViewModelWidget<Human> {
  @override
  Widget build(BuildContext context, Human dataModel) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(dataModel.name),
        ),
        SizedBox(
          width: 50,
        ),
        Container(
          child: Text(dataModel.name),
        ),
      ],
    );
  }
}
```

### Non reactive ViewModelWidget

Sometimes you want a widget to have access to the ViewModel but you don't want it to rebuild when `notifyListeners()` is called. In this case, you can set the reactive value to false for the super constructor of the `ViewModelWidget`. This is commonly used in widgets that don't make use of the ViewModel's state and only it's functionality.

```dart
class UpdateTitleButton extends ViewModelWidget<HomeViewModel> {
  const UpdateTitleButton({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return FloatingActionButton(
      onPressed: () {
        viewModel.updateTitle();
      },
    );
  }
}
```

## BaseViewModel functionality

This is a `ChangeNotifier` with busy state indication functionality. This allows you to set a busy state based on an object passed it. This will most likely be the properties on the extended ViewModel. It came from the need to have busy states for multiple values in the same ViewModels without relying on implicit state values. It also contains a helper function to indicate busy while a future is executing. This way we avoid having to call setBusy before and after every Future call.

To use the `BaseViewModel` you can extend it and make use of the busy functionality as follows.

```dart
class WidgetOneViewModel extends BaseViewModel {

  Human _currentHuman;
  Human get currentHuman => _currentHuman;

  void setBusyOnProperty() {
    setBusyForObject(_currentHuman, true);
    // Fetch updated human data
    setBusyForObject(_currentHuman, false);
  }

  void setModelBusy() {
    setBusy(true);
    // Do things here
    setBusy(false);
  }

  Future longUpdateStuff() async {
    // Sets busy to true before starting future and sets it to false after executing
    // You can also pass in an object as the busy object. Otherwise it'll use the ViewModel
    var result = await runBusyFuture(updateStuff());
  }

  Future updateStuff() {
    return Future.delayed(const Duration(seconds: 3));
  }
}
```

This makes it convenient to use in the UI in a more readable manner.

```dart
class WidgetOne extends StatelessWidget {
  const WidgetOne({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WidgetOneViewModel>.reactive(
      viewModelBuilder: () => WidgetOneViewModel(),
      builder: (context, viewModel, child) => GestureDetector(
        onTap: () => viewModel.longUpdateStuff(),
        child: Container(
          width: 100,
          height: 100,
          // Use isBusy to check if the ViewModel is set to busy
          color: viewModel.isBusy ? Colors.green : Colors.red,
          alignment: Alignment.center,
          // A bit silly to pass the same property back into the ViewModel
          // but here it makes sense
          child: viewModel.busy(viewModel.currentHuman)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(/* Human Details styling */)
        ),
      ),
    );
  }
}

```

All the major functionality for the BaseViewModel is shown above

### Busy handling

Stacked makes it easier for you to indicate to the UI if your ViewModel is busy or not through by providing some utility functions. Lets look at an example. When you run a future and you want to indicate to the UI the ViewModel is busy you would use the `runBusyFuture`.

```dart
class BusyExampleViewModel extends BaseViewModel {
 Future longUpdateStuff() async {
    // Sets busy to true before starting future and sets it to false after executing
    // You can also pass in an object as the busy object. Otherwise it'll use the ViewModel
    var result = await runBusyFuture(updateStuff());
  }

  Future updateStuff() {
    return Future.delayed(const Duration(seconds: 3));
  }
}
```

This will set the busy property using `this` as the key so you can check if the future is still running by calling `isBusy` on the ViewModel. If you want to assign it a different key, in the example of a `CartView` where you have multiple items listed. When increasing the quantity of an item you want only that item to show a busy indicator. For that you can also supply a key to the `runBusyFuture` function.

```dart
const String BusyObjectKey = 'my-busy-key';

class BusyExampleViewModel extends BaseViewModel {
  Future longUpdateStuff() async {
    // Sets busy to true before starting future and sets it to false after executing
    // You can also pass in an object as the busy object. Otherwise it'll use the ViewModel
    var result = await runBusyFuture(updateStuff(), busyObject: BusyObjectKey);
  }

  Future updateStuff() {
    return Future.delayed(const Duration(seconds: 3));
  }
}
```

Then you can check the busy state using that busy key and calling `viewModel.busy(BusyObjectKey)`. The key should be any unique value that won't change with the busy state of the object. In the example mentioned above you can use the id of each of the cart products to indicate if it's busy or not. This way you can show a busy state for each of them individually.

### Error Handling

The same way that the busy state is set you also get an error state. When you use one of the specialty `ViewModels` or the future helper functions. `runBusyFuture` or `runErrorFuture` stacked will store the exception thrown in the `ViewModel` for you to use. It will follow the same rules as the busy above and will assign the exception to the `ViewModel` or the key passed in. Lets look at some code.

```dart
class ErrorExampleViewModel extends BaseViewModel {
 Future longUpdateStuff() async {
    // Sets busy to true before starting future and sets it to false after executing
    // You can also pass in an object as the busy object. Otherwise it'll use the ViewModel
    var result = await runBusyFuture(updateStuff());
  }

  Future updateStuff() async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception('Things went wrong');
  }
}
```

After 3 seconds this future will throw an error. It will automatically catch that error, set the view back to not busy and then save the error. When no key is supplied to `runBusyFuture` you can check if there's an error using the `hasError` property. You can also get the actual exception from the `modelError` property. If you do supply a key however then you can get the exception back using the error function.

```dart
const String BusyObjectKey = 'my-busy-key';

class BusyExampleViewModel extends BaseViewModel {
  Future longUpdateStuff() async {
    // Sets busy to true before starting future and sets it to false after executing
    // You can also pass in an object as the busy object. Otherwise it'll use the ViewModel
    var result = await runBusyFuture(updateStuff(), busyObject: BusyObjectKey);
  }

  Future updateStuff() {
    return Future.delayed(const Duration(seconds: 3));
  }
}
```

In this case the error can be retrieved using `viewModel.error(BusyObjectKey)` or you can simply check if there is an error for the key using `mode.hasErrorForKey(BusyObjectKey)`. If you want to react to an error from your future you can override `onFutureError` which will return the exception and the key you used for that future. The Specialty `ViewModels` have their own onError override but this one can be used in there as well if needed.

## Reactivity

One thing that was common in a scenario with the first implementation of this architecture is reacting to values changed by different ViewModels. I don't have the exact implementation that I would hope for but without reflection, some things will have to be a bit more verbose. The stacked architecture makes provision for ViewModels to react to changes to values in service by making use of RxValue from the [Observable-Ish](https://pub.dev/packages/observable_ish) package.

### Reactive Service Mixin

In the stacked library, we have a `ReactiveServiceMixin` which can be used to register values to "react" to. When any of these values change the listeners registered with this service will be notified to update their UI. This is definitely not the most efficient way but I have tested this with 1000 widgets with its ViewModel all updating on the screen and it works fine. If you follow general good code implementations and layout structuring you will have no problem keeping your app at 60fps no matter the size.

There are three things you need to make a service reactive.

1. Use the `ReactiveServiceMixin` with the service you want to make reactive
2. Wrap your values in an RxValue. The value provided by Observable-ish
3. Register your reactive values by calling `listenToReactiveValues`. A function provided by the mixin.

Below is some source code for the non-theory coders out there like myself.

```dart
class InformationService with ReactiveServiceMixin { //1
  InformationService() {
    //3
    listenToReactiveValues([_postCount]);
  }

  //2
  RxValue<int> _postCount = RxValue<int>(initial: 0);
  int get postCount => _postCount.value;

  void updatePostCount() {
    _postCount.value++;
  }

  void resetCount() {
    _postCount.value = 0;
  }
}
```

Easy peasy. This service can now be listened to when any of the properties passed into the `listenToReactiveValues` is changed. So how do you listen to these values? I'm glad you asked. Let's move onto the `ReactiveViewModel`.

### ReactiveViewModel

This ViewModel extends the `BaseViewModel` and adds a function that allows you to listen to services that are being used in the ViewModel. There are two things you have to do to make a ViewModel react to changes in a service.

1. Extend from `ReactiveViewModel`.
2. Implement `reactiveServices` getter that returns a list of reactive services.

```dart
class WidgetOneViewModel extends ReactiveViewModel {
  // You can use get_it service locator or pass it in through the constructor
  final InformationService _informationService = locator<InformationService>();

   @override
  List<ReactiveServiceMixin> get reactiveServices => [_informationService];
}
```

That's it. To see a full example take a look at the example in the git repo.

### StreamViewModel

This `ViewModel` extends the `BaseViewModel` and provides functionality to easily listen and react to stream data. It allows you to supply a `Stream` of type `T` which it will subscribe to, manage subscription (dispose when done), and give you callbacks where you can modify/manipulate the data. It will automatically rebuild the `ViewModel` as new stream values come in. It has 1 required override which is the stream getter and 4 optional overrides.

- **stream**: Returns the `Stream` you would like to listen to
- **onData**: Called after the view has rebuilt and provides you with the data to use
- **onCancel**: Called after the stream has been disposed
- **onSubscribed**: Called when the stream has been subscribed to
- **onError**: Called when an error is sent over the stream

```dart
// ViewModel
class StreamCounterViewModel extends StreamViewModel<int> {

  String get title => 'This is the time since epoch in seconds \n $data';

  @override
  Stream<int> get stream => locator<EpochService>().epochUpdatesNumbers();
}

// View
class StreamCounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StreamCounterViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
            body: Center(
              child: Text(viewModel.title),
            ),
          ),
      viewModelBuilder: () => StreamCounterViewModel(),
    );
  }
}

// Service (registered using injectable, NOT REQUIRED)
@lazySingleton
class EpochService {
  Stream<int> epochUpdatesNumbers() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      yield DateTime.now().millisecondsSinceEpoch;
    }
  }
}
```

The code above will listen to a stream and provide you the data to rebuild with. You can create a `ViewModel` that listens to a stream with two lines of code.

```dart
class StreamCounterViewModel extends StreamViewModel<int> {
  @override
  Stream<int> get stream => locator<EpochService>().epochUpdatesNumbers();
}
```

Besides having the onError function you can override the `ViewModel` will also set the hasError property to true for easier checking on the view side. The `onError` callback can be used for running additional actions on failure and the `hasError` property should be used when you want to show error specific UI.

### FutureViewModel

This `ViewModel` extends the `BaseViewModel` to provide functionality to easily listen to a Future that fetches data. This requirement came off a Details view that has to fetch additional data to show to the user after selecting an item. When you extend the `FutureViewModel` you can provide a type which will then require you to override the future getter where you can set the future you want to run.

The future will run after the ViewModel has been created automatically.

```dart
class FutureExampleViewModel extends FutureViewModel<String> {
  @override
  Future<String> futureToRun() => getDataFromServer();

  Future<String> getDataFromServer() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'This is fetched from everywhere';
  }
}
```

This will automatically set the view's isBusy property and will indicate false when it's complete. It also exposes have a `dataReady` property that can be used. This will indicate true when the data is available. The `ViewModel` can be used in a view as follows.

```dart
class FutureExampleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FutureExampleViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        body: Center(
          // viewModel will indicate busy until the future is fetched
          child: viewModel.isBusy ? CircularProgressIndicator() : Text(viewModel.data),
        ),
      ),
      viewModelBuilder: () => FutureExampleViewModel(),
    );
  }
}
```

The `FutureViewModel` will also catch an error and indicate that it has received an error through the `hasError` property. You can also override the onError function if you want to receive that error and perform a specific action at that point.

```dart
class FutureExampleViewModel extends FutureViewModel<String> {
  @override
  Future<String> get future => getDataFromServer();

  Future<String> getDataFromServer() async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception('This is an error');
  }

  @override
  void onError(error) {
  }
}
```

The hasError property can be used in the view the same way as the isBusy property.

```dart
class FutureExampleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FutureExampleViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        body: viewModel.hasError
            ? Container(
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(
                  'An error has occered while running the future',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Center(
                child: viewModel.isBusy
                    ? CircularProgressIndicator()
                    : Text(viewModel.data),
              ),
      ),
      viewModelBuilder: () => FutureExampleViewModel(),
    );
  }
}
```

### MultipleFutureViewModel

In addition to being able to run a Future, you also make a view react to data returned from multiple futures. It requires you to provide a map of type string along with a Function that returns a Future that will be executed after the `ViewModel` has been constructed. See below for an example of using a `MultipleFutureViewModel`.

```dart
import 'package:stacked/stacked.dart';

const String _NumberDelayFuture = 'delayedNumber';
const String _StringDelayFuture = 'delayedString';

class MultipleFuturesExampleViewModel extends MultipleFutureViewModel {
  int get fetchedNumber => dataMap[_NumberDelayFuture];
  String get fetchedString => dataMap[_StringDelayFuture];

  bool get fetchingNumber => busy(_NumberDelayFuture);
  bool get fetchingString => busy(_StringDelayFuture);

  @override
  Map<String, Future Function()> get futuresMap => {
        _NumberDelayFuture: getNumberAfterDelay,
        _StringDelayFuture: getStringAfterDelay,
      };

  Future<int> getNumberAfterDelay() async {
    await Future.delayed(Duration(seconds: 2));
    return 3;
  }

  Future<String> getStringAfterDelay() async {
    await Future.delayed(Duration(seconds: 3));
    return 'String data';
  }
}
```

The data for the future will be in the `dataMap` when the future is complete. Each future will individually be set to busy using the key for the future passed in. With these functionalities, you'll be able to show a busy indicator for the UI that depends on the future's data while it's being fetched. There's also a `hasError` function which will indicate if the Future for a specific key has thrown an error.

```dart
class MultipleFuturesExampleView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MultipleFuturesExampleViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
            body: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    color: Colors.yellow,
                    // Show busy for number future until the data is back or has failed
                    child: viewModel.fetchingNumber
                        ? CircularProgressIndicator()
                        : Text(viewModel.fetchedNumber.toString()),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    color: Colors.red,
                    // Show busy for string future until the data is back or has failed
                    child: viewModel.fetchingString
                        ? CircularProgressIndicator()
                        : Text(viewModel.fetchedString),
                  ),
                ],
              ),
            ),
          ),
      viewModelBuilder: () => MultipleFuturesExampleViewModel());
  }
}

```

### MultipleStreamViewModel

Similarly to the `StreamViewModel`, we also have a `MultipleStreamViewModel` which allows you to provide multiple streams through a String key -> Stream paring. Any of the values from these streams will be stored in the data[key] and the same goes for the errors. Each stream value emitted will call `notifyListeners()` to update the UI. `MultipleStreamViewModel` requires the `streamsMap` to be overridden.

```dart
const String _NumbersStreamKey = 'numbers-stream';
const String _StringStreamKey = 'string-stream';

class MultipleStreamsExampleViewModel extends MultipleStreamViewModel {
  int numbersStreamDelay = 500;
  int stringStreamDelay = 2000;

  @override
  Map<String, StreamData> get streamsMap => {
        _NumbersStreamKey: StreamData<int>(numbersStream(numbersStreamDelay)),
        _StringStreamKey: StreamData<String>(stringStream(stringStreamDelay)),
      };

  Stream<int> numbersStream([int delay = 500]) async* {
    var random = Random();
    while (true) {
      await Future.delayed(Duration(milliseconds: delay));
      yield random.nextInt(999);
    }
  }

  Stream<String> stringStream([int delay = 2000]) async* {
    var random = Random();
    while (true) {
      await Future.delayed(Duration(milliseconds: delay));
      var randomLength = random.nextInt(50);
      var randomString = '';
      for (var i = 0; i < randomLength; i++) {
        randomString += String.fromCharCode(random.nextInt(50));
      }
      yield randomString;
    }
  }
}
```

Similarly to the single-stream ViewModel. When your stream has changed you should call `notifySourceChanged` to let the ViewModel know that it should stop listening to the old stream and subscribe to the new one. If you want to check if the stream had an error you can use the `hasError` function with the key for the stream, you can also get the error using `getError` with the key for the Stream.

### IndexTrackingViewModel

This ViewModel provides the basic functionality required for index tracking like bottom nav bar, side drawer, etc. It has functions and properties set and get the current index as well as a property that indicates `reversed` to be used with page transition animations. it can be used in a view as follows.

```dart
class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        body: getViewForIndex(viewModel.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey[800],
          currentIndex: viewModel.currentTabIndex,
          onTap: viewModel.setTabIndex,
          items: [
            BottomNavigationBarItem(
              title: Text('Posts'),
              icon: Icon(Icons.art_track),
            ),
            BottomNavigationBarItem(
              title: Text('Todos'),
              icon: Icon(Icons.list),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return PostsView();
      case 1:
        return TodosView();
    }
  }
}
```

Where the `ViewModel` is just this.

```dart
class HomeViewModel extends IndexTrackingViewModel {}
```

## Application Setup

In addition to providing state management it's been clear that every stacked application also requires the following functionality:

- Navigation setup to make it accessible from the `ViewModels`
- Dependency registration for service location
- A Logger formatted to improve code maintenance and awareness of application inner workings

From v 1.9.0 and onward we have the functionality to generate this code for the user. This will remove the reliance on auto_route as well as injectable. To use this functionality it's quite simple. Add the [stacked_generator] package to your application and if you don't have `build_runner` add that in as well.

```yaml
dev_dependencies:
  ...
  build_runner:
  stacked_generator:
```

In the lib folder create a new folder called `app`. In that folder create a file called `app.dart`.

```dart
@StackedApp()
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
```

In that file we define a class called App and we annotate it with `StackedApp`. This annotation class takes in `routes` and `dependencies`.

### Router

The `StackedApp` annotation takes in a list of `routes`. These routes can be one of the following:

- MaterialRoute: Defines a route which will have a default transition based on the Material design guidelines.
- CupertinoRoute: Defines a route which will have a default transition based on the Cupertino design guidelines.
- CustomRouter: Defines a route that defaults to using a `PageRouteBuilder` for custom route building functionality

```dart
@StackedApp(routes: [
    MaterialRoute(page: HomeView, initial: true),
    CupertinoRoute(page: BottomNavExample),
    CustomRouter(page: StreamCounterView),
  ],
)

```

Each route requires you to provide a page type. This will be the type it looks at to generate the route as well as the arguments to parse when navigating to this route. Run the default code generator command

```
flutter pub run build_runner build --delete-conflicting-outputs
```

This will generate a new file in the app folder called `app.router.dart`. This contains all the routing code for your views. To use this router open your `main.dart` file and set the `onGenerateRoute` function.

```dart

import 'package:stacked_services/stacked_services.dart';
import 'app/app.router.dart';

...

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // If you've added the stacked_services package then set the navigatorKey, otherwise set
      // your own navigator key
      navigatorKey: StackedService.navigatorKey,
      // Construct the StackedRouter and set the onGenerateRoute function
      onGenerateRoute: StackedRouter().onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
```

Now you can perform navigations using the `NavigationService` if it's been registered as a dependency on your `locator`.

### Nested Navigation

Declaring your nested routes inside of the parent route's children property will generate a nested router class. The name will be the page name provided to the parent + Route. In this example: `OtherNavigatorRouter`.

```dart
@StackedApp(routes: [
    MaterialRoute(page: HomeView, initial: true),
    MaterialRoute(page: OtherNavigator, children: [
      MaterialRoute(page: OtherView, initial: true),
      MaterialRoute(page: OtherNestedView),
    ]),
  ],
)

```

Now we need to render these nested routes inside of their parent `OtherNavigator` and for that we use an `ExtendedNavigator()`.

```dart
class OtherNavigator extends StatelessWidget {
  ...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNavigator(router: OtherNavigatorRouter(), navigatorKey: StackedService.nestedNavigationKey(1)));
  }
}

```

Now we can navigate to the nested route using the `NavigationService`, making sure to match the `id` to the `nestedNavigationKey` supplied when creating the `ExtendedNavigator()`.

```dart
_navigationService.navigateTo(OtherNavigatorRoutes.otherNestedView, id: 1);
```

### Router Arguments

View argument serialisation is automatic when using the generated router. Lets take the following view

```dart
class DetailsView extends StatelessWidget {
  final String name;

  const DetailsView({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(name),
    );
  }
}
```

This view will generate a class called `DetailsViewArguments`.

```dart
class DetailsViewArguments {
  final Key key;
  final String name;
  DetailsViewArguments({this.key, this.name});
}
```

When you navigate to the `DetailsView` using the `NavigationService` then you can pass in the `DetailsViewArguments` class as your arguments.

```dart
_navigationService.navigateTo(
  Routes.detailsView,
  arguments: DetailsViewArguments(name: 'FilledStacks'),
);
```

These arguments can be passed into any of the navigation calls that takes in the route name. They will be generated for any view that has arguments in it and for all types, including custom classes created in your code.

_Note_: When your view arguments change you have to run the code generation command again.

### Dependency Registration

The other major piece of boilerplate that was required was setting up get_it and making use of it on its own. This is still a very valid approach but with these new changes I wanted to introduce a quicker way of setting all that up and remove the boilerplate. This is also done using the `StackedApp` annotation. The class takes in a list of `DependencyRegistration`'s into a property called `dependencies`.

```dart
@StackedApp(
dependencies: [
    LazySingleton(classType: ThemeService, resolveUsing: ThemeService.getInstance),
    // abstracted class type support
    LazySingleton(classType: FirebaseAuthService, asType: AuthService),

    Singleton(classType: NavigationService),

    Presolve(
      classType: SharedPreferencesService,
      presolveUsing: SharedPreferencesService.getInstance,
    ),
  ],
)
```

There are (at the point of writing **21 February 2021**) 4 dependency types that can be registered as a dependency.

- Factory: When this dependency is requested from get_it it will return a new instance of the class given as the `classType`
- Singleton: This will **construct** and register a single instance of the class. When that `classType` is requested it will always return the instance that was created
- LazySingleton: This will **only construct the type when requested** and for every request after that return the same instance that was first constructed
- Presolve: This is a type that requires the instance to be initialised or resolved before being able to register it. Your have to supply `presolveUsing` and it has to be a static function that returns a Future of the type defined in `classType`. The presolve function for the above function looks as follows.

```dart
static Future<SharedPreferencesService> getInstance() async {
  if (_instance == null) {
    // Initialise the asynchronous shared preferences
    _sharedPreferences = await SharedPreferences.getSharedPrefs();
    _instance = SharedPreferencesService();
  }

  return Future.value(_instance);
}
```

You can also pass in a `resolveFunction` for singleton registrations which takes a static `Function`. This would produce something like this

```dart
locator.registerLazySingleton(() => ThemeService.getInstance());
```

When looking at the `ThemeService` dependency registration. Once you've defined your dependencies then you can run

```
flutter pub run build_runner build --delete-conflicting-outputs
```

This will create a new file called app.locator.dart which contains a `setupLocator` function. That function should be called before the runApp function call in main.dart

```dart
void main() {
  setupLocator();
  runApp(MyApp());
}
```

If you have any dependency registered that needs to be preSolved then you have to change your main function into a Future and await the setupLocator call.

```dart
Future main() async {
  await setupLocator();
  runApp(MyApp());
}
```

After that you can start using the get_it locator

```dart
final navigationService = locator<NavigationService>;
```

To learn more about using get_it as a service locator you can [watch this video](https://youtu.be/vBT-FhgMaWM?t=321). That's all the functionality that the stacked_generator will generate for now. Over time we'll add more functionality that can help us reduce the amount of boilerplate required to build a stacked application.

### Logger

If you want to add a Logger to your app, all you have to do is supply a logger config.

```dart
@StackedApp(
logger: StackedLogger()
)
```

In addition to that you have to add the `logger` package into your project's pubspec file.

```yaml
dependencies:
  ...
  logger:
```

When you run the build_runner it will create a new file called app.logger.dart in the same folder as your app folder. In that file you will see some code for the logger. The most important part of that file for you is the `getLogger` function. This function is what you'll use for logging in your app. There's a few things about how this logger is setup.

**When using the logger provide the exact class name it's being used in**

To make use of a logger you'll do the following

```dart
class MyViewModel {
  final log = getLogger('MyViewModel');

  void doStuff() {
    log.i('');
  }
}
```

The code above will print out the following.

```
💡 MyViewModel | doStuff
```

It will automatically print out the name of the function that it's in. This can only be done if we know the exact class name that the logger is for. Which is why that's so important.

**Clash with getLogger**

If you already have `getLogger` function in your code base and you want to use a different name you can supply that to the logger config.

```dart
@StackedApp(
logger: StackedLogger(
    logHelperName: 'getStackedLogger'
  )
)
```

Now the function to get your logger will be called `getStackedLogger`. If you want a more detailed guide on how to effectively log in your application read [this guide](https://www.filledstacks.com/post/flutter-logging-a-guide-to-use-it-effectively/) that we use for our production apps.

## Migrating from provider_architecture to Stacked

Let's start with a statement to ease your migration panic 😅 stacked is the same code from `provider_architecture` with name changes and removal of some old deprecated properties. If you don't believe me, open the repo's side by side and look at the lib folders. Well, up till yesterday (22 April 2020) I guess when I updated the BaseViewModel. I wanted to do this to show that stacked is production-ready from the go. It's a new package but it's been used by all of you and the FilledStacks development team for months in the form of provider_architecture. With that out of the way, let's start the migrate.

### ViewModelProvider Migration

This class has now been more appropriately named `ViewModelBuilder`. This is to match it's functionality more closely. Building UI FROM the ViewModel. The ViewModel is used to drive the state of the reactive UI.

Migrations to take note of:

- `ViewModelProvider` -> `ViewModelBuilder`
- Named constructor `withoutConsumer` is now called `nonReactive`
- Named constructor `withConsumer` is now called `reactive`
- Instead of passing a constructed `ViewModel` which was constructing every rebuilder we pass a `viewModelBuilder`. A function that returns a `ChangeNotifier`.
- `reuseExisting` has changed to `disposeViewModel` and now has a default value of true. If you used `reuseExisting=true` it has to change to `disposeViewModel=false`.

Let's look at that in code. We'll go over `withoutConsumer/nonReactive` first

```dart
class HomeViewMultipleWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withoutConsumer(
      viewModel: HomeViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
      reuseExisting: true,
      builder: (context, viewModel, _) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            viewModel.updateTitle();
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[TitleSection(), DescriptionSection()],
        ),
      ),
    );
  }
}
```

Will Change to

```dart
class HomeViewMultipleWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive( // Take note here
      viewModelBuilder: () => HomeViewModel(), // Take note here
      disposeViewModel: false, // Take note here
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, _) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            viewModel.updateTitle();
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[TitleSection(), DescriptionSection()],
        ),
      ),
    );
  }
}
```

For the `withConsumer` function we do the following

```dart
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
    );
  }
}
```

Changes to

```dart
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive( // Take note here

    );
  }
}
```

### ProviderWidget Migration

The only change here was the name.

```dart
class DuplicateNameWidget extends ProviderWidget<Human> {

}

// Becomes

class DuplicateNameWidget extends ViewModelWidget<Human> {

}
```

The rest of the package is all new functionality which can be seen above. Please check out the issues for tasks we'd like to add. If you would like to see any functionality in here please create an issue and I'll assess and provide feedback.
