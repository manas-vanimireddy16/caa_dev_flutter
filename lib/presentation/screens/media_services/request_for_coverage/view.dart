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
import 'package:code_setup/presentation/common_widgets/request_list_search_styles.dart';
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
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/area_permission.dart';
import 'package:code_setup/presentation/screens/hc_service/models/employee_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/position_model.dart';
import 'package:code_setup/presentation/common_widgets/request_details/employee_information_card.dart';
import 'package:code_setup/presentation/screens/media_services/models/request_data_model.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_reassign.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/repository/media_coverage/request_for_coverage/domain/domain.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
import 'package:code_setup/presentation/common_widgets/paginated_list_section.dart';
import 'package:code_setup/utils/helper/list_pagination.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/type_checker.dart' hide FileType;
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/presentation/common_widgets/my_requests_action_items_tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:code_setup/presentation/common_widgets/section_content_divider.dart';

part 'widgets/request_for_coverage_new_request.dart';
part 'controller.dart';
part 'widgets/request_details.dart';
part 'widgets/request_details_tabs.dart';
part 'widgets/request_list.dart';
part 'widgets/request_tab.dart';
part 'widgets/ticket_requests_card.dart';

@RoutePage()
class RequestforCoverageScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  const RequestforCoverageScreen({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<RequestforCoverageScreen> createState() =>
      _RequestforCoverageScreenState();
}

class _RequestforCoverageScreenState
    extends ConsumerState<RequestforCoverageScreen>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  late TabController _tabController;
  late PageController _pageController;
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    /// ✅ Pass full objects (Service & SubService)
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
    _pageController = PageController();

    /// Search controller
    // searchController = TextEditingController(
    //   text: ref.read(searchQueryProvider),
    // );

    _focusNode = FocusNode();

    // searchController.addListener(() {
    //   setState(() {}); // rebuild suffixIcon
    // });

    /// Tabs
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      ref
          .read(_vsProvider(_providerArgs).notifier)
          .updateTabIndex(_tabController.index);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(_vsProvider(_providerArgs).notifier).initState();
    });
  }

  @override
  void dispose() {
    // searchController.dispose();
    _focusNode.dispose();
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);

    // // Keep TabController in sync with provider
    // if (_tabController.index != selectedTab) {
    //   _tabController.index = selectedTab;
    // }

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
