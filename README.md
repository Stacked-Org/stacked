# Stacked

An architecture developed and revised by the [FilledStacks](https://www.youtube.com/filledstacks) community. This architecture was initially a version of MVVM as [described in this video](https://youtu.be/kDEflMYTFlk). Since then Filledstacks app development team has built 6 production applications with various requirements. This experience along with countless requests for improvements and common functionality is what sparked the creation of this architecture package. It aims to provide **common functionalities to make app development easier** as well as code principles to use during development to ensure your code stays maintainable.

[Here you can watch the full video series](https://www.youtube.com/playlist?list=PLdTodMosi-BwM4XkagNwe4KADOMWQS5X-) for an in depth dive of this architecture.

## How it works

The architecture is very simple. It consists of 3 major pieces, everything else is up to your implementation style. These pieces are:

- **View**: Shows the UI to the user. Single widgets also qualify as views (for consistency in terminology) a view, in this case, is not a "Page" it's just a UI representation.
- **ViewModel**: Manages the state of the View, business logic, and any other logic as required from user interaction. It does this by making use of the services
- **Services**: A wrapper of a single functionality/feature set. This is commonly used to wrap things like showing a dialog, wrapping database functionality, integrating an API, etc.

Let's go over some of those principles to follow during development.

- Views should never MAKE USE of a service directly.
- Views should only contain logic if necessary. If the logic is from UI only items then we do the least amount of required logic and pass the rest to the ViewModel.
- Views should ONLY render the state in its ViewModel.
- ViewModels for widgets that represent page views are bound to a single View only.
- ViewModels may be re-used if the UI requires the same functionality.
- ViewModels should not know about other ViewModels.

That's quite a bit of "rules", but they help during production. Trust me.

## Stacked's place in your architecture

Stacked provides you with classes and functionalities to make it easy to implement that base architecture that this package is built for. There are additional things that you can add to your application that will make the usage of this architecture much more pleasant. This will be discussed in full on the architecture series that will come out soon. Everything from navigation, dependency injection, service location, error handling, etc.

## Packages

In the effort of providing as much value with the stacked package as possible, the repo contains all of the other packages that extend the stacked functionality further and implements some of the base functionalities for you. It also contains third-party extensions that can be used with stacked.

| Package                                                                                                                                            | Pub                                                                                                                                        |
| -------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| [stacked](https://github.com/FilledStacks/stacked/tree/master/packages/stacked)                                                                    | [![pub package](https://img.shields.io/pub/v/stacked.svg)](https://pub.dev/packages/stacked)                                               |
| [stacked_generator](https://github.com/FilledStacks/stacked/tree/master/packages/stacked_generator)                                                  | [![pub package](https://img.shields.io/pub/v/stacked_generator.svg)](https://pub.dev/packages/stacked_generator)                           |
| [stacked_services](https://github.com/FilledStacks/stacked/tree/master/packages/stacked_services)                                                  | [![pub package](https://img.shields.io/pub/v/stacked_services.svg)](https://pub.dev/packages/stacked_services)                             |
| [stacked_hooks](https://github.com/FilledStacks/stacked/tree/master/packages/stacked_hooks)                                                        | [![pub package](https://img.shields.io/pub/v/stacked_hooks.svg)](https://pub.dev/packages/stacked_hooks)                                   |
| [stacked_themes](https://github.com/FilledStacks/stacked/tree/master/packages/stacked_themes)                                                      | [![pub package](https://img.shields.io/pub/v/stacked_themes.svg)](https://pub.dev/packages/stacked_themes)                                 |
| [stacked_crashlytics](https://github.com/FilledStacks/stacked/tree/master/packages/stacked_crashlytics)                                                      | [![pub package](https://img.shields.io/pub/v/stacked_crashlytics.svg)](https://pub.dev/packages/stacked_crashlytics)                       |
| [stacked_firebase_auth](https://github.com/FilledStacks/stacked/tree/master/packages/stacked_firebase_auth)                                                      | [![pub package](https://img.shields.io/pub/v/stacked_firebase_auth.svg)](https://pub.dev/packages/stacked_firebase_auth)                   |
| [stacked_localisation](https://github.com/FilledStacks/stacked/tree/master/packages/stacked_localisation/stacked_localisation)                     | [![pub package](https://img.shields.io/pub/v/stacked_localisation.svg)](https://pub.dev/packages/stacked_localisation)                     |
| [stacked_localisation_generator](https://github.com/FilledStacks/stacked/tree/master/packages/stacked_localisation/stacked_localisation_generator) | [![pub package](https://img.shields.io/pub/v/stacked_localisation_generator.svg)](https://pub.dev/packages/stacked_localisation_generator) |

Each package folder contains instructions on how to use the package so please look at the README per package for detailed examples.
