library stacked;

/// code generators
export 'src/code_generation/router_annotation/extended_navigator.dart';
export 'src/code_generation/router_annotation/route_def.dart';
export 'src/code_generation/router_annotation/router_base.dart';
export 'src/code_generation/router_annotation/router_utils.dart';
export 'src/code_generation/router_annotation/transitions_builders.dart';

/// mixins
export 'src/mixins/listenable_service_mixin.dart';
export 'src/mixins/reactive_service_mixin.dart';
export 'src/reactive/reactive_list/reactive_list.dart';
export 'src/reactive/reactive_value/reactive_value.dart';
export 'src/router/auto_route_page.dart';
export 'src/router/auto_router_x.dart';
export 'src/router/controller/controller_scope.dart';
export 'src/router/controller/routing_controller.dart';

/// Navigator 2.0 Exports
export 'src/router/matcher/route_match.dart';
export 'src/router/navigation_failure.dart';
export 'src/router/parser/route_information_parser.dart';
export 'src/router/provider/auto_route_information_provider.dart';
export 'src/router/route/page_route_info.dart';
export 'src/router/route/route_config.dart';
export 'src/router/route/route_data_scope.dart';
export 'src/router/widgets/auto_back_button.dart';
export 'src/router/widgets/auto_leading_button.dart';
export 'src/router/widgets/auto_page_view.dart';
export 'src/router/widgets/auto_route_navigator.dart';
export 'src/router/widgets/auto_router.dart';
export 'src/router/widgets/auto_tabs_router.dart';
export 'src/router/widgets/auto_tabs_scaffold.dart';
export 'src/router/widgets/custom_cupertino_transitions_builder.dart'
    show NoShadowCupertinoPageTransitionsBuilder;
export 'src/router/widgets/deferred_widget.dart';
export 'src/router/widgets/wrapped_route.dart';

/// viewmodels
export 'src/view_models/base_view_models.dart';
export 'src/view_models/data_models/multiple_data_models.dart';
export 'src/view_models/data_models/single_data_models.dart';

/// deprecated viewmodels
export 'src/view_models/form_view_model.dart';
export 'src/view_models/helpers/data_state_helper.dart';
export 'src/view_models/helpers/form_state_helper.dart';
export 'src/view_models/helpers/index_tracking_state_helper.dart';

/// viewmodel helpers
export 'src/view_models/helpers/message_state_helper.dart';
export 'src/view_models/index_tracking_viewmodel.dart';
export 'src/view_models/selector_view_model_builder.dart';
export 'src/view_models/selector_view_model_builder_widget.dart';
export 'src/view_models/stacked_view.dart';

/// ui
export 'src/view_models/ui/skeleton_loader.dart';
export 'src/view_models/view_model_builder.dart';
export 'src/view_models/view_model_widget.dart';
