import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/RadioButton.dart';
import 'package:code_setup/presentation/common_widgets/chat.dart';
import 'package:code_setup/presentation/common_widgets/common_attachments.dart';
import 'package:code_setup/presentation/common_widgets/common_request_details.dart';
import 'package:code_setup/presentation/common_widgets/common_workflow.dart';
import 'package:code_setup/presentation/common_widgets/file_upload.dart';
import 'package:code_setup/presentation/common_widgets/requestCard.dart';
import 'package:code_setup/presentation/common_widgets/requestStatusBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/requestTrendBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/statSummaryData.dart';
import 'package:code_setup/presentation/common_widgets/tab_item.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/models/activity_feed_model.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/request_for_project_approval.dart';
import 'package:code_setup/presentation/screens/logistics/models/dashBoardRequest.dart'
    hide ChatMessage, Service;
import 'package:code_setup/presentation/screens/logistics/widgets/profileCard.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_request_data.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_reassign.dart';
import 'package:code_setup/repository/information_security_services/report_security_threat/domain/domain.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'widgets/new_security_threat_request.dart';
part 'controller.dart';
part 'widgets/request_details.dart';
part 'widgets/assign_engineer_dialog.dart';

part 'widgets/request_list.dart';
part 'widgets/request_tab.dart';
part 'widgets/ticket_requests_card.dart';
part 'widgets/request_details_tab.dart';

@RoutePage()
class SecurityThreatScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  const SecurityThreatScreen({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<SecurityThreatScreen> createState() =>
      _SecurityThreatScreenState();
}

class _SecurityThreatScreenState extends ConsumerState<SecurityThreatScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController searchController;
  late FocusNode _focusNode;
  late TabController _tabController;
  late _VSControllerParams _providerArgs;
    late PageController _pageController;


  @override
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

    searchController.addListener(() {
      setState(() {}); // rebuild suffixIcon
    });
        _pageController = PageController();


    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        ref.read(selectedrequesteventTabProvider.notifier).state =
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
    final currentYear = DateTime.now().year;
    final filterLabelList = List.generate(
      6,
      (index) => (currentYear - index).toString(),
    );
    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final active = controller.getActiveApprovalLevel(
      state.requestDetails.approvalDetails ?? [],
    );
    final statsList = StatSummaryHelper.buildStatList(
      state.kpiData.data?.toJson(),
    );
    final statsApproverList = StatSummaryHelper.buildStatList(
      state.approvalKpiData.data?.toJson(),
    );

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
            stats: state.tabIndex == 0 ? statsList : statsApproverList,
          ),

          20.toHorizontalSizedBox,

          // Status breakdown
          RequestStatusBreakdownCard(
            data: state.tabIndex == 0
                ? state.statusBreakdown.data?.breakdown ?? []
                : state.approvalStatusBreakdown.data?.breakdown ??
                      [], // for action items
            breakdown: state.statusBreakdown.data,
            title: "Requests Status Breakdown",

            onChanged: (value) {
              // send the text to your controller’s search function
              state.tabIndex == 0
                  ? controller.fetchStatusBreakdown(value ?? '')
                  : controller.fetchApprovalStatusBreakdown(value ?? '');
            },
          ),
          16.toHorizontalSizedBox,

          // Trend breakdown
          RequestTrendBreakdownCard(
            monthlyData: state.tabIndex == 0
                ? state.trendData.data?.trendData
                          ?.map((e) => e.count ?? 0)
                          .toList() ??
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                : state.approvalTrendData.data?.trendData
                          ?.map((e) => e.count ?? 0)
                          .toList() ??
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            monthLabels: [
              "Jan",
              "Feb",
              "Mar",
              "Apr",
              "May",
              "Jun",
              "Jul",
              "Aug",
              "Sep",
              "Oct",
              "Nov",
              "Dec",
            ],
            metric: "Total Tickets",
            // selectedYear: '2025',
            barColor: Colors.blue,
            // onYearTap: () => debugPrint("Year dropdown tapped"),
            onChanged: (value) {
              if (value != null) {
                state.tabIndex == 0
                    ? controller.fetchTrendBreakDown(value)
                    : controller.fetchApprovalTrendBreakDown(value);
              }
            },
            filterLabelList: filterLabelList,
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
