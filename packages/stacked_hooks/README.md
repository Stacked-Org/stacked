# Stacked Hooks

This package contains widgets that allow you to use the Flutter Hooks package with the `StackedView` in the Stacked architecture.

## StackedHook

The `StackedView` is an implementation of a widget class that returns a value provided by `Provider` as a parameter in the build function of the widget. This allows for easier consumption and use of ViewModel without boilerplate. The `StackedHook` allows you to use this widget and make use of Flutter Hooks inside the build function. This is very useful when you want to use `TextEditing` controllers and you're implementing this architecture.

```dart
// View that creates and provides the viewmodel
class StackedHookViewExample extends StackedView<HomeViewModel> {
  const StackedHookViewExample({Key key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel model, Widget? child) {
    return Scaffold(
      body: Center(child: _HookForm()),
    );
  }

  @override
  HomeViewModel modelBuilder(BuildContext context) {
    return HomeViewModel();
  }
}

// Form that makes use of the ViewModel provided above but also makes use of hooks
class _HookForm extends StackedHook<HomeViewModel> {
  @override
  Widget buildStackedView(BuildContext context, HomeViewModel model) {
    final title = useTextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(model.title),
        TextField(controller: title, onChanged: model.updateTitle),
      ],
    );
  }
}

// ViewModel
class HomeViewModel extends BaseViewModel {
  String title = 'default';

  void updateTitle(String value) {
    title = value;
    notifyListeners();
  }
}
```
