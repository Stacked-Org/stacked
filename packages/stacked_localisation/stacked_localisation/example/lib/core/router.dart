import 'package:auto_route/auto_route_annotations.dart';
import 'package:example/ui/home/home_view.dart';
import 'package:example/ui/startup/startup_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: StartupView, initial: true),
  MaterialRoute(page: HomeView),
])
class $Router {}
