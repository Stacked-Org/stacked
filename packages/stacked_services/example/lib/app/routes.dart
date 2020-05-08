import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';

import '../ui/views/home_screen.dart';
import '../ui/views/first_screen.dart';
import '../ui/views/second_screen.dart';

// Defining routes and global transitions
@CustomAutoRouter(
    transitionsBuilder: TransitionsBuilders.zoomIn, durationInMilliseconds: 400)
class $Router {
  @initial
  HomeScreen homeScreenRoute;

  FirstScreen firstScreenRoute;

  SecondScreen secondScreenRoute;
}
