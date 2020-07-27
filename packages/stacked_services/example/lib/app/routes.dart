import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';

import '../ui/views/home_screen.dart';
import '../ui/views/first_screen.dart';
import '../ui/views/second_screen.dart';

// Defining routes and global transitions
@CustomAutoRouter(
    routes: <AutoRoute>[
    MaterialRoute(
      page: HomeScreen,
      name: 'homeScreenRoute',
      initial: true,
    ),
    MaterialRoute(
      page: FirstScreen,
      name: 'firstScreenRoute',
    ),
    MaterialRoute(
      page: SecondScreen,
      name: 'secondScreenRoute',
    ),
  ],
  transitionsBuilder: TransitionsBuilders.zoomIn, 
  durationInMilliseconds: 400,
)
class $Router {}
