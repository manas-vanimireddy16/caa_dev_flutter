import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/request_details/approval_comment_dialog.dart';
import 'package:code_setup/presentation/common_widgets/request_details/chat.dart';
import 'package:code_setup/presentation/common_widgets/request_details/common_attachments.dart';
import 'package:code_setup/presentation/common_widgets/request_details/employee_information_card.dart';
import 'package:code_setup/presentation/common_widgets/request_details/common_request_details.dart';
import 'package:code_setup/presentation/common_widgets/request_card.dart';
import 'package:code_setup/presentation/common_widgets/analytics/request_status_breakdown.dart';
import 'package:code_setup/presentation/common_widgets/analytics/request_trend_breakdown.dart';
import 'package:code_setup/presentation/common_widgets/tab_item.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_notifier.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/presentation/common_widgets/analytics/stat_summary_data.dart';
import 'package:code_setup/presentation/common_widgets/my_requests_action_items_tabs.dart';
import 'package:code_setup/presentation/common_widgets/request_list_search_styles.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/it_services/models/muscat_roles_model.dart';
import 'package:code_setup/presentation/screens/it_services/models/muscat_user_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/it_technician.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestData.dart'
    hide Service;
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestDetail.dart'
    hide Service, SubService;
import 'package:code_setup/presentation/screens/it_services/salalah/models/salalah_action_items_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/salalah_data_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/service_dropdown_model.dart'
    hide Service, SubService;
import 'package:code_setup/presentation/screens/it_services/salalah/models/status_break_down.dart'
    hide ChartData;
import 'package:code_setup/presentation/screens/it_services/widgets/workflow.dart';
import 'package:code_setup/repository/it_services/salalah/domain/dashboard.dart'
    show DashboardRepository;
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/dashboard_metric_labels.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/helper.dart';
import 'package:code_setup/presentation/common_widgets/paginated_list_section.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/it_helpdesk_list_pagination.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
import 'package:code_setup/utils/helper/type_checker.dart' hide FileType;
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:code_setup/presentation/common_widgets/section_content_divider.dart';
part 'widgets/newRequest.dart';
part 'widgets/new_hos_request.dart';
part "controller.dart";
part 'widgets/request_details.dart';
part 'widgets/request_tab.dart';
// part 'widgets/new_ittechnician_request.dart';

part 'widgets/request_details_tabs.dart';
part 'widgets/request_list.dart';
part 'widgets/ticket_requests_card.dart';
part 'widgets/re_assign.dart';

@RoutePage()
class MuscatDashboard extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  const MuscatDashboard({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<MuscatDashboard> createState() => _MuscatDashboardState();
}

class _MuscatDashboardState extends ConsumerState<MuscatDashboard>
    with SingleTickerProviderStateMixin {
  late TextEditingController searchController;
  late FocusNode _focusNode;
  late TabController _tabController;
  late PageController _pageController;
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
    searchController = TextEditingController(
      text: ref.read(searchQueryProvider),
    );
    _focusNode = FocusNode();
    _pageController = PageController();

    searchController.addListener(() {
      setState(() {}); // rebuild suffixIcon
    });

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        ref.read(selectedSalalahTabProvider.notifier).state =
            _tabController.index;
      }
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
    final subServiceCode = widget.subService.code;
    final totalMetricLabel = DashboardMetricLabels.totalMetricLabel(
      l10n,
      subServiceCode: subServiceCode,
    );

    return KScaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(
          left: 12.toAutoScaledWidth,
          right: 12.toAutoScaledWidth,
          top: 12.toAutoScaledHeight,
          bottom: 12.toAutoScaledHeight,
        ),
        children: [
          // KPI Cards
          StatSummaryRow(
            stats: controller.currentStats(
              (key) => DashboardMetricLabels.statTitle(
                l10n,
                key,
                subServiceCode: subServiceCode,
              ),
            ),
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
            centerMetricLabel: totalMetricLabel,
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
            metric: totalMetricLabel,
            selectedYear: controller.currentYear.toString(),
            barColor: Colors.blue,
            filterLabelList: controller.filterLabelList,
            onChanged: controller.onTrendFilterChanged,
          ),

          16.toVerticalSizedBox,

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
