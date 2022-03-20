import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_cli/ui/views/order_details/order_details_view.dart';
// @stacked-import

@StackedApp(routes: [
  MaterialRoute(page: OrderDetailsView),
// @stacked-route
])
class App {}
