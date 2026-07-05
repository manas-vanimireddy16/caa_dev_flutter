import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/request_details/approval_comment_dialog.dart';
import 'package:code_setup/presentation/common_widgets/request_details/chat.dart';
import 'package:code_setup/presentation/common_widgets/request_details/common_attachments.dart';
import 'package:code_setup/presentation/common_widgets/request_details/employee_information_card.dart';
import 'package:code_setup/presentation/common_widgets/request_details/common_request_details.dart';
import 'package:code_setup/presentation/common_widgets/request_details/common_workflow.dart';
import 'package:code_setup/presentation/common_widgets/request_card.dart';
import 'package:code_setup/presentation/common_widgets/analytics/request_status_breakdown.dart';
import 'package:code_setup/presentation/common_widgets/analytics/request_trend_breakdown.dart';
import 'package:code_setup/presentation/common_widgets/analytics/stat_summary_data.dart';
import 'package:code_setup/presentation/common_widgets/tab_item.dart';
import 'package:code_setup/presentation/core/providers/selected_service_provider.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_notifier.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/models/activity_feed_model.dart';
import 'package:code_setup/presentation/models/allowance_employee.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/master_roles.dart';
import 'package:code_setup/presentation/models/selection_dialog_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/asset_affairs/models/unit_locations_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/employee_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/goal_weight_list.dart';
import 'package:code_setup/presentation/screens/hc_service/models/goal_weight_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/grade_list_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/hr_task.dart';
import 'package:code_setup/presentation/screens/hc_service/models/position_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/temporary_decision.dart';
import 'package:code_setup/presentation/screens/it_services/models/event_support_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/request_vehicle_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/vehicle_maintenance_model.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_reassign.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/presentation/screens/tender_service/models/respond_to_enquiry.dart';
import 'package:code_setup/presentation/screens/training_and_development/models/location_model.dart';
import 'package:code_setup/repository/assests_affair/residental_unit_rental/domain/domain.dart';
import 'package:code_setup/repository/hr_service/assignment_decision/domain/domain.dart';
import 'package:code_setup/repository/hr_service/secondment_decision/domain/domain.dart';
import 'package:code_setup/repository/hr_service/temporary_assignment_decision/domain/domain.dart';
import 'package:code_setup/repository/it_services/request_event_support/domain/domain.dart';
import 'package:code_setup/repository/logistics/request_a_vehicle/domain/domain.dart';
import 'package:code_setup/repository/logistics/vehicle_maintenance/domain/domain.dart';
import 'package:code_setup/repository/tender_services/request_a_service_to_respond_to_enquiries/domain/domain.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/helper.dart';
import 'package:code_setup/presentation/common_widgets/administrative_decision/administrative_decision_data.dart';
import 'package:code_setup/presentation/common_widgets/administrative_decision/administrative_decision_pdf_service.dart';
import 'package:code_setup/presentation/common_widgets/paginated_list_section.dart';
import 'package:code_setup/utils/helper/list_pagination.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
import 'package:code_setup/utils/helper/type_checker.dart' hide FileType;
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/presentation/common_widgets/my_requests_action_items_tabs.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/rendering.dart' hide Border;
// import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:code_setup/presentation/common_widgets/section_content_divider.dart';

// part 'widgets/request_vehicle_new_request.dart';
part 'controller.dart';
part 'widgets/request_details.dart';
part 'widgets/request_details_tabs.dart';
part 'widgets/request_list.dart';
part 'widgets/request_tab.dart';
part 'widgets/ticket_requests_card.dart';
part 'widgets/assign_engineer.dart';

@RoutePage()
class AssignmentDecisionScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;

  const AssignmentDecisionScreen({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<AssignmentDecisionScreen> createState() =>
      _AssignmentDecisionScreenState();
}

class _AssignmentDecisionScreenState
    extends ConsumerState<AssignmentDecisionScreen> {
  late FocusNode _focusNode;
  late _VSControllerParams _providerArgs;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    final selected = ref.read(selectedServiceProvider);

    final service = widget.service.id != null
        ? widget.service
        : selected.service;

    final subService = widget.subService.id != null
        ? widget.subService
        : selected.subService;

    _providerArgs = _VSControllerParams(
      service: service,
      subService: subService,
    );

    _focusNode = FocusNode();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);

    return KScaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// KPI
          StatSummaryRow(
            stats: controller.currentStats((key) => l10n.statTitle(key)),
          ),
          16.toVerticalSizedBox,

          /// Status Breakdown
          RequestStatusBreakdownCard(
            data: state.tabIndex == 0
                ? controller.statusBreakdownList
                : controller.approvalStatusBreakdownList,
            title: l10n.requestsStatusBreakdown,
            filterLabel: l10n.periodFilterLabels[0],
            filterLabelList: l10n.periodFilterLabels,
            centerMetricLabel: l10n.totalRequests,
            legendHeading: l10n.breakdown,
            statusLabelBuilder: l10n.statusLabel,
            preserveFilterLabelOnChange: true,
            onChanged: (value) => controller.onStatusFilterChanged(
              value != null ? l10n.periodFilterValue(value) : null,
            ),
            breakdown: state.statusBreakdown.data,
          ),
          16.toVerticalSizedBox,
          RequestTrendBreakdownCard(
            monthlyData: state.tabIndex == 0
                ? controller.trendCounts
                : controller.approvalTrendCounts,
            monthLabels: state.months,
            title: l10n.requestTrendBreakdown,
            metric: l10n.totalRequests,
            selectedYear: controller.currentYear.toString(),
            barColor: Colors.blue,
            filterLabelList: controller.filterLabelList,
            onChanged: controller.onTrendFilterChanged,
          ),

          16.toVerticalSizedBox,

          /// MAIN CARD
          TicketRequestsCard(
            providerArgs: _providerArgs,
            focusNode: _focusNode,
            pageController: _pageController,
          ),
        ],
      ),
    );
  }
}
