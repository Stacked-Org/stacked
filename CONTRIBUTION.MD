# Running Tests

To ensure that everything still works, run the integration tests in the example folder.

## **Running using flutter devices**

Use the command:

```
flutter test integration_test/app_test.dart
```

If multiple devices was found, select the device you want to run the tests on.

## **Running using command line**

Ensure you have the [chrome driver](https://chromedriver.chromium.org/downloads) installed.

Start the chrome driver:

```
chromedriver --port=4444
```

In a separate terminal, run the tests:

```
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d web-server
```
