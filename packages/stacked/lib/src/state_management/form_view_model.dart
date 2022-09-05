import 'package:stacked/stacked.dart';

/// You can use [BaseViewModel] or [ReactiveViewModel] with a [FormStateHelper]
/// to achive the same result incase you want to combine multiple functionalities
abstract class FormViewModel extends ReactiveViewModel with FormStateHelper {
  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
