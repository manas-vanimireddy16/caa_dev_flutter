import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/approval_comment_dialog.dart';
import 'package:code_setup/presentation/common_widgets/assign_dialog.dart';
import 'package:code_setup/presentation/common_widgets/chat.dart';
import 'package:code_setup/presentation/common_widgets/common_attachments.dart';
import 'package:code_setup/presentation/common_widgets/common_request_details.dart';
import 'package:code_setup/presentation/common_widgets/common_workflow.dart';
import 'package:code_setup/presentation/common_widgets/dialog_config.dart';
import 'package:code_setup/presentation/common_widgets/requestCard.dart';
import 'package:code_setup/presentation/common_widgets/requestStatusBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/requestTrendBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/statSummaryData.dart';
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
import 'package:code_setup/presentation/screens/hr_service/models/grade_list_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/payment_of_shift_allowance_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/position_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/required_new_resource_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/user_model.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/profileCard.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_reassign.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/presentation/screens/training_and_development/models/location_model.dart';
import 'package:code_setup/repository/hr_service/assignment_decision/domain/domain.dart';
import 'package:code_setup/repository/hr_service/payment_of_shift_allowance/domain/domain.dart';
import 'package:code_setup/repository/hr_service/required_new_resource/domain/domain.dart';
import 'package:code_setup/repository/security_access/domain/domain.dart';
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

part 'widgets/payment_of_shift_allowance_new_request.dart';
part 'controller.dart';
part 'widgets/request_details.dart';
part 'widgets/request_details_tabs.dart';
part 'widgets/request_list.dart';
part 'widgets/request_tab.dart';

@RoutePage()
class RequiredNewResourceScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;

  const RequiredNewResourceScreen({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<RequiredNewResourceScreen> createState() =>
      _RequiredNewResourceScreenState();
}

class _RequiredNewResourceScreenState
    extends ConsumerState<RequiredNewResourceScreen> {
  late FocusNode _focusNode;
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final filterLabelList = List.generate(
      6,
      (index) => (currentYear - index).toString(),
    );

    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final statsList = StatSummaryHelper.buildStatList(
      state.kpiData.data?.toJson(),
    );
    final statsApproverList = StatSummaryHelper.buildStatList(
      state.approvalKpiData.data?.toJson(),
    );

    return KScaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          /// KPI
          StatSummaryRow(
            stats: state.tabIndex == 0 ? statsList : statsApproverList,
          ),

          20.toHorizontalSizedBox,

          /// Status Breakdown
          RequestStatusBreakdownCard(
            data: state.tabIndex == 0
                ? state.statusBreakdown.data?.breakdown ?? []
                : state.approvalStatusBreakdown.data?.breakdown ?? [],
            breakdown: state.statusBreakdown.data,
            title: "Requests Status Breakdown",
            onChanged: (value) {
              state.tabIndex == 0
                  ? controller.fetchStatusBreakdown(value ?? '')
                  : controller.fetchApprovalStatusBreakdown(value ?? '');
            },
          ),

          16.toHorizontalSizedBox,

          /// Trend Breakdown
          RequestTrendBreakdownCard(
            monthlyData: state.tabIndex == 0
                ? state.trendData.data?.trendData
                          ?.map((e) => e.count ?? 0)
                          .toList() ??
                      List.filled(12, 0)
                : state.approvalTrendData.data?.trendData
                          ?.map((e) => e.count ?? 0)
                          .toList() ??
                      List.filled(12, 0),
            monthLabels: state.months,
            metric: "Total Tickets",
            // selectedYear: currentYear.toString(),
            barColor: Colors.blue,
            filterLabelList: filterLabelList,
            onChanged: (value) {
              if (value != null) {
                state.tabIndex == 0
                    ? controller.fetchTrendBreakDown(value)
                    : controller.fetchApprovalTrendBreakDown(value);
              }
            },
          ),

          16.toHorizontalSizedBox,

          /// MAIN CARD
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ticket Requests",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: controller.openNewRequestForm,
                        child: const Text('Assign New Task'),
                      ),
                    ],
                  ),

                  12.toHorizontalSizedBox,

                  /// Search
                  KTextField(
                    focusNode: _focusNode,
                    hintText: "Search by ID or Name",
                    controller: controller.searchController,
                    onChanged: controller.onSearchChanged,
                  ),

                  12.toHorizontalSizedBox,

                  /// Tabs Widget
                  RequestTabs(
                    selectedIndex: state.tabIndex,
                    onTabChanged: controller.updateTabIndex,
                  ),

                  16.toHorizontalSizedBox,

                  /// Single Reusable Page
                  SizedBox(
                    height: 400,
                    child: RequestsPage(providerArgs: _providerArgs),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
