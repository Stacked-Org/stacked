# Stacked Hooks

This package contains widgets that allow you to use the Flutter Hooks package with the ViewModelWidget in the stacked architecture.

## HookViewModelWidget

The `ViewModelWidget` is an implementation of a widget class that returns a value provided by `Povider` as a parameter in the build function of the widget. This allows for easier consumption and use of ViewModel without boilerplate. The `HookViewModelWidget` allows you to use this widget and make use of Flutter Hooks inside the build function. This is very useful when you want to use `TextEditting` controllers and you're implementing this architecture.

```dart
// View that creates and provides the viewmodel
class HookViewModelWidgetExample extends StatelessWidget {
  const HookViewModelWidgetExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
          body: Center(
        child: _HookForm(),
      )),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

// Form that makes use of the ViewModel provided above but also makes use of hooks
class _HookForm extends HookViewModelWidget<HomeViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, HomeViewModel model) {
    var title = useTextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(model.title),
        TextField(
          controller: title,
          onChanged: model.updateTile,
        )
      ],
    );
  }
}

// ViewModel
class HomeViewModel extends BaseViewModel {
  String title = 'default';

  void updateTile(String value) {
    title = value;
    notifyListeners();
  }
}
```
