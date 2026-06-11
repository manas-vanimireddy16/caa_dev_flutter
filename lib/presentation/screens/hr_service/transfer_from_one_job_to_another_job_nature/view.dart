import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/request_details/approval_comment_dialog.dart';
import 'package:code_setup/presentation/common_widgets/request_details/assign_dialog.dart';
import 'package:code_setup/presentation/common_widgets/request_details/chat.dart';
import 'package:code_setup/presentation/common_widgets/request_details/common_attachments.dart';
import 'package:code_setup/presentation/common_widgets/request_details/common_request_details.dart';
import 'package:code_setup/presentation/common_widgets/request_details/employee_information_card.dart';
import 'package:code_setup/presentation/common_widgets/request_details/common_workflow.dart';
import 'package:code_setup/presentation/common_widgets/dialog_config.dart';
import 'package:code_setup/presentation/common_widgets/request_card.dart';
import 'package:code_setup/presentation/common_widgets/analytics/request_status_breakdown.dart';
import 'package:code_setup/presentation/common_widgets/analytics/request_trend_breakdown.dart';
import 'package:code_setup/presentation/common_widgets/analytics/stat_summary_data.dart';
import 'package:code_setup/presentation/common_widgets/tab_item.dart';
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
import 'package:code_setup/presentation/screens/hr_service/models/employee_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/position_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/transfer_from_job_to_another.dart';
import 'package:code_setup/presentation/screens/hr_service/models/user_model.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_reassign.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/presentation/screens/training_and_development/models/location_model.dart';
import 'package:code_setup/presentation/screens/training_and_development/models/request_data_model.dart';
import 'package:code_setup/repository/hr_service/assignment_decision/domain/domain.dart';
import 'package:code_setup/repository/hr_service/payment_of_shift_allowance/domain/domain.dart';
import 'package:code_setup/repository/hr_service/transfer_from_one_job_to_another_job_nature/domain/domain.dart';
import 'package:code_setup/repository/security_access/domain/domain.dart';
import 'package:code_setup/repository/training_and_development/annual_training_plan/domain/domain.dart';
import 'package:code_setup/repository/training_and_development/request_for_study_leave/domain/domain.dart';
import 'package:code_setup/repository/training_and_development/request_for_training_room_booking/domain/domain.dart';
import 'package:code_setup/repository/training_and_development/request_training/domain/domain.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
import 'package:code_setup/utils/helper/type_checker.dart' hide FileType;
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'widgets/request_for_transfer_from_one_job_to_another.dart';
part 'controller.dart';
part 'widgets/request_details.dart';

part 'widgets/request_details_tabs.dart';
part 'widgets/request_list.dart';
part 'widgets/request_tab.dart';
part 'widgets/ticket_requests_card.dart';
// part 'widgets/assign_engineer_dialog.dart';

@RoutePage()
class TransferFromOneJobtoAnotherJobNatureScreen
    extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  const TransferFromOneJobtoAnotherJobNatureScreen({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<TransferFromOneJobtoAnotherJobNatureScreen> createState() =>
      _TransferFromOneJobtoAnotherJobNatureScreenState();
}

class _TransferFromOneJobtoAnotherJobNatureScreenState
    extends ConsumerState<TransferFromOneJobtoAnotherJobNatureScreen>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  late final PageController pageController;

  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    _focusNode = FocusNode();
    pageController = PageController();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);

    return KScaffold(
      backgroundColor: Colors.white,
      // appBar: KAppBar(title: const Text('Report Security Threat ')),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

        padding: const EdgeInsets.all(12),
        children: [
          StatSummaryRow(
            stats: controller.currentStats((key) => l10n.statTitle(key)),
          ),
          20.toHorizontalSizedBox,
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
          RequestTrendBreakdownCard(
            monthlyData: state.tabIndex == 0
                ? controller.trendCounts
                : controller.approvalTrendCounts,
            monthLabels: state.months,
            title: l10n.requestTrendBreakdown,
            metric: l10n.totalRequests,
            barColor: Colors.blue,
            filterLabelList: controller.filterLabelList,
            onChanged: controller.onTrendFilterChanged,
          ),

          16.toHorizontalSizedBox,
          TicketRequestsCard(
            focusNode: _focusNode,
            pageController: pageController,
            providerArgs: _providerArgs,
          ),
          // Ticket Requests Section
        ],
      ),
    );
  }
}
