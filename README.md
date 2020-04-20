# Stacked

An architecture developed and revised by the [FilledStacks](https://www.youtube.com/filledstacks) community. This architecture was initially a version of Mvvm as [described in this video](https://youtu.be/kDEflMYTFlk). Since then Filledstacks app development team has built 6 production applications with various requirements. This experience along with countless requests for improvements and common functionality is what sparked the creation of this architecture package. It aims to provide **common functionalities to make app development easier** as well as code principles to use during development to ensure your code stays maintainable.

**If you're Reading this disclaimer the series that does a deepdive on this architecture has not been published yet.**

## How Does it work

The architecture is very simple. It consists of 4 major pieces, everything else is up to your implementation style. These pieces are:

- **View**: Shows the UI to the user. Single widgets also qualifies as views (for consistency in terminology) a view in this case is not a "Page" it's just a UI representation.
- **ViewModel**: Manages the state of the View, business logic and any other logic as required from user interaction. It does this by making use of the services
- **Services**: A wrapper of a single functionality / feature set. This is commonly used to wrap things like showing a dialog, wrapping database functionality, integrating an api, etc.
- **Managers**: Any object that makes use of multiple services. This piece serves no distinct purpose in the architecture and is ONLY here to differentiate between Services with dependencies and services without dependencies.

Lets go over some of those principles to follow during development.

- Views should never MAKE USE of a service directly.
- Views should contain zero to (preferred) no logic. If the logic is from UI only items then we do the least amount of required logic and pass the rest to the ViewModel.
- Views should ONLY render the state in its ViewModel.
- ViewModels for widgets that represent page views are bound to a single View only.
- ViewModels may be re-used if the UI required the exact same functionality.
- ViewModels should not know about other ViewModels

That's quite a bit of "rules" but they help during production. Trust me. Lets get on to some of the implementation.

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
