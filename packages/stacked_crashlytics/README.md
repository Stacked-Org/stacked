# Stacked Crashlytics Service
A service accompanied with a LogOutput that tracks all warnings as non-fatal crash reports and all errors as fatal crash reports. This makes use of the Firebase Crashlytics service.

## How To use

* In the pubspec.yaml file under dependencies add 
  ```dart
   stacked_crashlytics: ^0.1.0
    ```

* Register the service on to the locator 
    * If you want to register the service
    ```dart 
  @StackedApp(
        dependencies: [
            ...
            LazySingleton(classType: CrashlyticsService),
            ...
            ),
        ],
    )
    ```
    * If you are presolving into an async instance, you can use
    ```dart 
    @StackedApp(
        dependencies: [
            ...
            Presolve(
            classType: CrashlyticsService,
            presolveUsing: CrashlyticsService.getInstance,
            ),
          ],
        )
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