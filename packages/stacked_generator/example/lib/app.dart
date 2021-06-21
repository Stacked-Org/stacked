import 'package:example/home_view.dart';
import 'package:example/main.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [
  CupertinoRoute(page: HomeView),
])
class App {}
