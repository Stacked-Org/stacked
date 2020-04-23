# Stacked

An architecture developed and revised by the [FilledStacks](https://www.youtube.com/filledstacks) community. This architecture was initially a version of Mvvm as [described in this video](https://youtu.be/kDEflMYTFlk). Since then Filledstacks app development team has built 6 production applications with various requirements. This experience along with countless requests for improvements and common functionality is what sparked the creation of this architecture package. It aims to provide **common functionalities to make app development easier** as well as code principles to use during development to ensure your code stays maintainable.

**If you're Reading this disclaimer the series that does a deepdive on this architecture has not been published yet.**

## How Does it work

The architecture is very simple. It consists of 3 major pieces, everything else is up to your implementation style. These pieces are:

- **View**: Shows the UI to the user. Single widgets also qualifies as views (for consistency in terminology) a view in this case is not a "Page" it's just a UI representation.
- **ViewModel**: Manages the state of the View, business logic and any other logic as required from user interaction. It does this by making use of the services
- **Services**: A wrapper of a single functionality / feature set. This is commonly used to wrap things like showing a dialog, wrapping database functionality, integrating an api, etc.

---

- **Managers(Suggestion)**: A service that requires other services. This piece serves no particular part in the architecture except for indicating that it has depdendencies on other service. It has no functional part in the architecture, It's main purpose is to distinguish between services that depend on other services and ones that don't. It's not a hard rule to follow but will allow for more code separation.

Lets go over some of those principles to follow during development.

- Views should never MAKE USE of a service directly.
- Views should contain zero to (preferred) no logic. If the logic is from UI only items then we do the least amount of required logic and pass the rest to the ViewModel.
- Views should ONLY render the state in its ViewModel.
- ViewModels for widgets that represent page views are bound to a single View only.
- ViewModels may be re-used if the UI required the exact same functionality.
- ViewModels should not know about other ViewModels

That's quite a bit of "rules" but they help during production. Trust me.

## Stacked's place in your architecture

Stacked provides you with classes and functionalities to make it easy to implement that base architecture that this package is built for. There are additional things that you can add to your application that will make the user of this architecture much more pleasant. This will be discussed in full on the architecture series that will come out soon. Everything from navigation, dependency injection, service location, error handling, etc.

## ViewModelBuilder

The `ViewModelBuilder` was first built in the [Provider Architecture Tutorial](https://youtu.be/kDEflMYTFlk) where it was titled BaseView. The `ViewModelBuilder` is used to create the "binding" between a ViewModel and the View. There is no two-way binding in this architecture, which is why I don't want to say it's an Mvvm implementation and why we have instead given it our own name. The `ViewModelBuilder` wraps up all the `ChangeNotifierProvider` code which allows us to trigger a rebuild of a widget when calling `notifyListeners` within the ViewModel.

A ViewModel is simply a dart class that extends `ChangeNotifier`. The `ViewModelBuilder` has 2 constructors, one that's reactive and one that's not. The tutorial mentioned above emulates the default implementation which has been put into the `.reactive` named constructor. The `.nonReactive` constructor is for UI that does not require the builder to fire when notifyListeners is called in the ViewModel. The nonReactive construction was born in [this tutorial](https://youtu.be/HUSqk0OrR7I?t=224) where we wanted to reduce the boiler plate when the same data has to go to multiple widgets using the same ViewModel. This is very prominent when using the responsive_builder package.

### Reactive

This is the default implementation of "binding" your view to your ViewModel.

```dart

// View
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using the reactive constructor gives you the traditional viewmodel
    // binding which will excute the builder again when notifyListeners is called.
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.updateTitle();
          },
        ),
        body: Center(
          child: Text(model.title),
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
// Viewmodel in the above code

// View
class HomeViewMultipleWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, _) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.updateTitle();
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
  Widget build(BuildContext context, HomeViewModel model) {
    return Row(
      children: <Widget>[
        Text(
          'Title',
          style: TextStyle(fontSize: 20),
        ),
        Container(
          child: Text(model.title),
        ),
      ],
    );
  }
}

class DescriptionSection extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Row(
      children: <Widget>[
        Text(
          'Description',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        Container(
          child: Text(model.title),
        ),
      ],
    );
  }
}
```

So what we're doing here is providing the ViewModel to the children of the builder function. The builder function itself won't retrigger when `notifyListeners` is called. Instead we will extend from `ViewModelWidget` in the widgets that we want to rebuild from the ViewModel. This allows us to easily access the ViewModel in multiple widgets without a lot of repeat boilerplate code. We already extend from a `StatelessWidget` so we can change that to `ViewModelWidget`. Then we simply add the ViewModel as a parameter to the build function. This is the same as calling `Provider<ViewModel>.of` in every widget we want to rebuild.

### Disable ViewModel Dispose

An example of how to use one viewmodel instance across the application with the help of [get_it](https://github.com/fluttercommunity/get_it).

```dart
// View
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.withConsumer(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initialise(),
      // When the disposeViewModel is set to false the viewmodel will
      // not be disposed during the normal life cycle of a widget.
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.updateTitle();
          },
        ),
        body: Center(
          child: Text(model.title),
        ),
      ),
    );
  }
}

```

Note that the `ViewModelBuilder` constructor is called with parameter `disposeViewModel: false`. This enables us to pass an existing instance of a viewmodel.

## ViewModel Widget

The `ViewModelWidget` is an implementation of a widget class that provides us with the provided value as a parameter in the build function of the widget. Above is an example of using the widget but here's another one that doesn't make use of a ViewModel. Lets say for instance you have a data model you want to use in multiple widgets. We can use the `Provider.value` call to supply that value and inside the multiple widgets we inherit from the `ViewModelWidget` and make use of the data.

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

// Model
class Human {
  final String name;
  final String surname;

  Human({this.name, this.surname});
}

// consuming widget 1
class FullNameWidget extends ViewModelWidget<Human> {
  @override
  Widget build(BuildContext context, Human model) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            model.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        SizedBox(
          width: 50,
        ),
        Container(
          child: Text(
            model.surname,
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
  Widget build(BuildContext context, Human model) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(model.name),
        ),
        SizedBox(
          width: 50,
        ),
        Container(
          child: Text(model.name),
        ),
      ],
    );
  }
}
```

### Non reactive ViewModelWidget

Sometimes you want a widget to have access to the viewmodel but you don't want it to rebuild. In the case of a button that has to call a function on the viewmodel but uses none of the viewmodel state for the UI. In this case you can set the reactive value to false for the super constructor of the `ViewModelWidget`

```dart
class UpdateTitleButton extends ViewModelWidget<HomeViewModel> {
  UpdateTitleButton({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, model) {
    return FloatingActionButton(
      onPressed: () {
        model.updateTitle();
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
    // You can also pass in an object as the busy object. Otherwise it'll use the model
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
      builder: (context, model, child) => GestureDetector(
        onTap: () => model.longUpdateStuff(),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
          alignment: Alignment.center,
          // A bit silly to pass the same property back into the viewmodel
          // but here it makes sense
          child: model.busy(model.currentHuman)
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

## Reactivity

One thing that was common a scenario with the first implementation of this architecture that was clearly lacking is reacting to values changed by different ViewModels. I don't have the exact implementation that I would hope for but without reflection some things will have to be a bit more verbose. The stacked architecture makes provision for ViewModels to react to changes to values in a service by making use of RxValue from the [Observable-Ish](https://pub.dev/packages/observable_ish) package.

### Reactive Service Mixin

In the stacked library we have a `ReactiveServiceMixin` which can be used to register values to "react" to. When any of these values change the listeners registered with this service will be notified to update their UI. This is definitely not the most effecient way but I have tested this with 1000 widgets with it's own viewmodel all updating on the screen and it works fine. If you follow general good code implementations and layout structuring you will have no problem keeping your app at 60fps no matter the size.

There are three things you need to make a service reactive.

1. Use the `ReactiveServiceMixin` with the service you want to make reactive
2. Wrap your values in an RxValue. The value provided by Observable-ish
3. Register your reactive values by calling `listenToReactiveValues`. A function provided by the mixin.

Below is some source code for the non theory coders out there like myself.

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

Easy peasy. This service can now be listened too when any of the properties passed into the `listenToReactiveValues` is changed. So how do listen to these values? I'm glad you asked. Lets move onto the `ReactiveViewModel`.

### Reactive View Model

This ViewModel extends the `BaseViewModel` and adds an additional function that allows you to listen to services that are being used in the model. There are two thing you have to do to make a ViewModel react to changes in a service.

1. Extend from `ReactiveViewModel`.
2. Implement reactiveServices getter that return a list of reactive services.

```dart
class WidgetOneViewModel extends ReactiveViewModel {
  // You can use get_it service locator or pass it in through the constructor
  final InformationService _informationService = locator<InformationService>();

   @override
  List<ReactiveServiceMixin> get reactiveServices => [_informationService];
}
```

That's it. To see a full example take a look at the example in the git repo.

## Migrating from provider_architecture to Stacked

Lets start with a statement to ease your migration panic 😅 stacked is the exact same code from provider_architecture with naming changes and removal of some old deprecated properties. If you don't believe me, open the repo's side by side and look at the lib folders. Well, up till yesterday (22 April 2020) I guess, when I updated the BaseViewModel. I wanted to do this to show that stacked is production ready from the go. It's a new package but it's been used by all of you and the FilledStacks development team for months in the form of provider_architecture. With that out of the way lets start the migrate.

### ViewModelProvider Migration

This class has now been more appropriately named `ViewModelBuilder`. This is to match it's functionality more closely. Building UI FROM the ViewModel. The ViewModel is used to drive the state of the reactive UI. 

Migrations to take note of:

- `ViewModelProvider` -> `ViewModelBuilder`
- Named constructor `withoutConsumer` is now called `nonReactive`
- Named constructor `withConsumer` is now called `reactive`
- Instead of passing a constructed `ViewModel` which was constructing every rebuilder we pass a `viewModelBuilder`. A function that returns a `ChangeNotifier`.
- `reuseExisting` has changed to `disposeViewModel` and now has a default value of true. If you used `reuseExisting=true` it has to change to `disposeViewModel=false`.

Lets look at that in code. We'll go over withoutConsumer / nonReactive first

```dart
class HomeViewMultipleWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withoutConsumer(
      viewModel: HomeViewModel(),
      onModelReady: (model) => model.initialise(),
      reuseExisting: true,
      builder: (context, model, _) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.updateTitle();
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
      onModelReady: (model) => model.initialise(),
      builder: (context, model, _) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.updateTitle();
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

For the withConsumer function we do the following

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

The rest of the package is all new functionality which can be seen above. Please check out the issues for tasks we'd like to add. If you would like to see any functionality in here please create an issue and I'll asses and provide feedback.