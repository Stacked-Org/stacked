import 'package:example/ui/views/order_details/order_details_view.dart';
import 'package:stacked/stacked_annotations.dart';
// @stacked-import

@StackedApp(routes: [
  MaterialRoute(page: OrderDetailsView),
// @stacked-route
])
class App {}
