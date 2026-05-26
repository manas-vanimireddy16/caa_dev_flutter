import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/chat.dart';
import 'package:code_setup/presentation/common_widgets/common_attachments.dart';
import 'package:code_setup/presentation/common_widgets/common_request_details.dart';
import 'package:code_setup/presentation/common_widgets/common_workflow.dart';
import 'package:code_setup/presentation/common_widgets/employee_information_card.dart';
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
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/area_permission.dart';
import 'package:code_setup/presentation/screens/hr_service/models/employee_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/position_model.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_reassign.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/presentation/screens/task_management/models/request_data_model.dart';
import 'package:code_setup/repository/task_management/assign_a_task_to_employee/domain/domain.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
import 'package:code_setup/utils/helper/type_checker.dart' hide FileType;
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'widgets/request_for_assign_a_task_to_employee.dart';
part 'controller.dart';
part 'widgets/request_details.dart';
part 'widgets/request_tab.dart';
part 'widgets/ticket_requests_card.dart';
part 'widgets/request_list.dart';
part 'widgets/request_details_tabs.dart';

// part 'widgets/assign_engineer_dialog.dart';

@RoutePage()
class AssignaTasktoEmployeeScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  const AssignaTasktoEmployeeScreen({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<AssignaTasktoEmployeeScreen> createState() =>
      _AssignaTasktoEmployeeScreenScreenState();
}

class _AssignaTasktoEmployeeScreenScreenState
    extends ConsumerState<AssignaTasktoEmployeeScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController searchController;
  late FocusNode _focusNode;
  late TabController _tabController;

  late _VSControllerParams _providerArgs;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    /// ✅ Pass full objects (Service & SubService)
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    /// Search controller
    searchController = TextEditingController(
      text: ref.read(searchQueryProvider),
    );

    _focusNode = FocusNode();

    searchController.addListener(() {
      setState(() {}); // rebuild suffixIcon
    });

    /// Tabs
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      ref
          .read(_vsProvider(_providerArgs).notifier)
          .updateTabIndex(_tabController.index);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose();
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);

    // // Keep TabController in sync with provider
    // if (_tabController.index != selectedTab) {
    //   _tabController.index = selectedTab;
    // }

    return KScaffold(
      backgroundColor: Colors.white,
      // appBar: KAppBar(title: const Text('Report Security Threat ')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // KPI Cards
          StatSummaryRow(
            stats: controller.currentStats((key) => l10n.statTitle(key)),
          ),
          20.toHorizontalSizedBox,

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

          RequestTrendBreakdownCard(
            monthlyData: state.tabIndex == 0
                ? controller.trendCounts
                : controller.approvalTrendCounts,
            monthLabels: state.months,
            title: l10n.requestTrendBreakdown,
            metric: l10n.totalTickets,
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
