# Stacked Services

Provides some essential services to aid in implementing the Stacked architecture. These services are only here to reduce boiler plate code for the users of the Stacked Architecture that uses the architecture as instructed by FilledStacks on the architecture series.

## Services

The following services are included in the package

- **NavigationService:** Makes use of the [Get](https://pub.dev/packages/get) package to expose basic navigation functionalities
- **DialogService**: Makes use of the [Get](https://pub.dev/packages/get) package to expose functionality that allows the dev to show dialogs from the ViewModels
- **SnackbarService**: Makes use of the [Get](https://pub.dev/packages/get) to expose the snack bar functionality to devs.

The services can be registered with get_it normally as you would usually

```dart
final locator = GetIt.instance;

locator.registerLazySingleton(() => NavigationService());
```

If you're using Injectable as recommended you can register the services using a third party services module. Create a new file in your services folder called thirdparty_services_module.dart.

```dart
@registerModule
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;
  @lazySingleton
  DialogService get dialogService;
  @lazySingleton
  SnackbarService get snackBarService;
}
```

If you now run

```
flutter pub run build_runner build
```

Your services will be available as usual on your locator instance.
