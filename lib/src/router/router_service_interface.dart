import 'package:stacked/stacked.dart';

abstract class RouterServiceInterface {
  RootStackRouter get router;

  RouteData get topRoute;
}
