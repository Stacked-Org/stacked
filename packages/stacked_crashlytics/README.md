# Stacked Crashlytics Service
A service accompanied with a LogOutput that tracks all warnings as non-fatal crash reports and all errors as fatal crash reports. This makes use of the Firebase Crashlytics service.

## How To use

* In the pubspec.yaml file under dependencies add 
  ```dart
   stacked_crashlytics: ^0.1.0
    ```

* Register the service on to the locator 
    * If you are using a third party service module you can add it inside the file like so
    ```dart 
    @lazySingleton
  CrashlyticsService get crashlyticsService;
    ```
    * If you are presolving into an async instance, you can add it inside the file like so
    ```dart 
    @preResolve
  Future<CrashlyticsService> get crashlyticsService =>
      CrashlyticsService.getInstance();
    ```
    Note: Don't forget to run 

    ``` flutter pub run build_runner build --delete-conflicting-outputs ```

* Add the log Output inside your logger under outputs inside multiple logger output like so
    ```dart 
    Logger(
    ...
        output: MultipleLoggerOutput([
        ...
        CrashlyticsOutput(),
        ]),
    );
    ```