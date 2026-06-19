import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/request_details/approval_comment_dialog.dart';
import 'package:code_setup/presentation/common_widgets/request_details/chat.dart';
import 'package:code_setup/presentation/common_widgets/request_details/common_attachments.dart';
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
import 'package:code_setup/presentation/screens/hc_service/models/payment_of_cash_allowance_for_leave_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/position_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/user_model.dart';
import 'package:code_setup/presentation/screens/it_services/models/event_support_model.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/profileCard.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_reassign.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/presentation/screens/tender_service/models/respond_to_enquiry.dart';
import 'package:code_setup/presentation/screens/training_and_development/models/location_model.dart';
import 'package:code_setup/repository/assests_affair/residental_unit_rental/domain/domain.dart';
import 'package:code_setup/repository/hr_service/payment_of_cash_allowance_for_leave/domain/domain.dart';
import 'package:code_setup/repository/it_services/request_event_support/domain/domain.dart';
import 'package:code_setup/repository/tender_services/request_a_service_to_respond_to_enquiries/domain/domain.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/helper.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
import 'package:code_setup/utils/helper/type_checker.dart' hide FileType;
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/presentation/common_widgets/my_requests_action_items_tabs.dart';
// import 'package:flutter/rendering.dart' hide Border;
// import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

// part 'widgets/cash_allowance_new_request.dart';
part 'controller.dart';
part 'widgets/request_details.dart';
part 'widgets/request_details_tabs.dart';
part 'widgets/request_list.dart';
part 'widgets/request_tab.dart';
part 'widgets/ticket_requests_card.dart';

@RoutePage()
class PaymentofCashAllowanceForLeaveScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;

  const PaymentofCashAllowanceForLeaveScreen({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<PaymentofCashAllowanceForLeaveScreen> createState() =>
      _PaymentofCashAllowanceForLeaveScreenState();
}

class _PaymentofCashAllowanceForLeaveScreenState
    extends ConsumerState<PaymentofCashAllowanceForLeaveScreen> {
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

    return KScaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          /// KPI
          StatSummaryRow(stats: controller.currentStats),
          20.toHorizontalSizedBox,

          /// Status Breakdown
          RequestStatusBreakdownCard(
            data: state.tabIndex == 0
                ? controller.statusBreakdownList
                : controller.approvalStatusBreakdownList,
            title: "Requests Status Breakdown",
            onChanged: controller.onStatusFilterChanged,
            breakdown: state.statusBreakdown.data,
          ),

          RequestTrendBreakdownCard(
            monthlyData: state.tabIndex == 0
                ? controller.trendCounts
                : controller.approvalTrendCounts,
            monthLabels: state.months,
            metric: "Total Tickets",
            selectedYear: controller.currentYear.toString(),
            barColor: Colors.blue,
            filterLabelList: controller.filterLabelList,
            onChanged: controller.onTrendFilterChanged,
          ),

          16.toHorizontalSizedBox,

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
