import 'package:flutter/material.dart' show BuildContext, Widget;

// clients will implement this class to provide a wrapped route.
abstract class RouteWrapper {
  Widget wrappedRoute(BuildContext context);
}
