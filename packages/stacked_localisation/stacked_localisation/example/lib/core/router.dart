import 'package:auto_route/auto_route_annotations.dart';
import 'package:example/ui/home/home_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: HomeView, initial: true),
])
class $Router {}
