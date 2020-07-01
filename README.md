# Stacked

An architecture developed and revised by the [FilledStacks](https://www.youtube.com/filledstacks) community. This architecture was initially a version of MVVM as [described in this video](https://youtu.be/kDEflMYTFlk). Since then Filledstacks app development team has built 6 production applications with various requirements. This experience along with countless requests for improvements and common functionality is what sparked the creation of this architecture package. It aims to provide **common functionalities to make app development easier** as well as code principles to use during development to ensure your code stays maintainable.

**If you're Reading this disclaimer the series that does a deep-dive on this architecture has not been published yet.**

## How Does it work

The architecture is very simple. It consists of 3 major pieces, everything else is up to your implementation style. These pieces are:

- **View**: Shows the UI to the user. Single widgets also qualify as views (for consistency in terminology) a view, in this case, is not a "Page" it's just a UI representation.
- **ViewModel**: Manages the state of the View, business logic, and any other logic as required from user interaction. It does this by making use of the services
- **Services**: A wrapper of a single functionality/feature set. This is commonly used to wrap things like showing a dialog, wrapping database functionality, integrating an API, etc.

Let's go over some of those principles to follow during development.

- Views should never MAKE USE a of service directly.
- Views should contain zero to (preferred) no logic. If the logic is from UI only items then we do the least amount of required logic and pass the rest to the ViewModel.
- Views should ONLY render the state in its ViewModel.
- ViewModels for widgets that represent page views are bound to a single view only.
- ViewModels may be re-used if the UI required the same functionality.
- ViewModels should not know about other ViewModels

That's quite a bit of "rules" but they help during production. Trust me.

## Stacked's place in your architecture

Stacked provides you with classes and functionalities to make it easy to implement that base architecture that this package is built for. There are additional things that you can add to your application that will make the user of this architecture much more pleasant. This will be discussed in full on the architecture series that will come out soon. Everything from navigation, dependency injection, service location, error handling, etc.

## Packages

In the efforts of providing as much value with the stacked package as possible, the repo contains all of the other packages that extend the stacked functionality further and implements some of the base functionalities for you. It also contains third-party extensions that can be used with stacked.

| Package                                                                                           | Pub                                                                                                            |
| ------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| [stacked](https://github.com/FilledStacks/stacked/tree/master/packages/stacked)                   | [![pub package](https://img.shields.io/pub/v/stacked.svg)](https://pub.dev/packages/stacked)                   |
| [stacked_services](https://github.com/FilledStacks/stacked/tree/master/packages/stacked_services) | [![pub package](https://img.shields.io/pub/v/stacked_services.svg)](https://pub.dev/packages/stacked_services) |
| [stacked_hooks](https://github.com/FilledStacks/stacked/tree/master/packages/stacked_hooks)       | [![pub package](https://img.shields.io/pub/v/stacked_hooks.svg)](https://pub.dev/packages/stacked_hooks)       |

Each package folder contains instructions on how to use the package so please look at the README per package for detailed examples.

## Migrating from `provider_architecture` to Stacked

Let's start with a statement to ease your migration panic 😅 stacked is the same code from `provider_architecture` with name changes and removal of some old deprecated properties. If you don't believe me, open the repo's side by side and look at the lib folders. Well, up till yesterday (22 April 2020) I guess when I updated the BaseViewModel. I wanted to do this to show that stacked is production-ready from the go. It's a new package but it's been used by all of you and the FilledStacks development team for months in the form of `provider_architecture`. With that out of the way, let's start the migrate.

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
