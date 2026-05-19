import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/approval_comment_dialog.dart';
import 'package:code_setup/presentation/common_widgets/attachments_tab.dart';
import 'package:code_setup/presentation/common_widgets/chat.dart';
import 'package:code_setup/presentation/common_widgets/comment.dart';
import 'package:code_setup/presentation/common_widgets/comment_box.dart';
import 'package:code_setup/presentation/common_widgets/common_attachments.dart';
import 'package:code_setup/presentation/common_widgets/employee_information_card.dart';
import 'package:code_setup/presentation/common_widgets/common_request_details.dart';
import 'package:code_setup/presentation/common_widgets/common_workflow.dart';
import 'package:code_setup/presentation/common_widgets/profile_card.dart';
import 'package:code_setup/presentation/common_widgets/requestCard.dart';
import 'package:code_setup/presentation/common_widgets/requestStatusBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/requestTrendBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/request_details_tab.dart';
import 'package:code_setup/presentation/common_widgets/request_history_tab.dart';
import 'package:code_setup/presentation/common_widgets/tab_item.dart';
import 'package:code_setup/presentation/common_widgets/workflow_tab.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_notifier.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/presentation/models/kpi.dart';
import 'package:code_setup/presentation/common_widgets/statSummaryData.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/action_item_model.dart';
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
import 'package:code_setup/presentation/screens/it_services/salalah/widgets/request_details_tab.dart';
import 'package:code_setup/presentation/screens/it_services/widgets/workflow.dart';
import 'package:code_setup/repository/it_services/salalah/domain/dashboard.dart'
    show DashboardRepository;
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/helper.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
import 'package:code_setup/utils/helper/type_checker.dart' hide FileType;
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
part 'widgets/newRequest.dart';
part 'widgets/new_hos_request.dart';
part "controller.dart";
part 'widgets/request_details.dart';
part 'widgets/request_tab.dart';
part 'widgets/new_ittechnician_request.dart';

part 'widgets/request_details_tabs.dart';
part 'widgets/request_list.dart';
part 'widgets/ticket_requests_card.dart';

@RoutePage()
class SalalahDashboard extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  const SalalahDashboard({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<SalalahDashboard> createState() => _SalalahDashboardState();
}

class _SalalahDashboardState extends ConsumerState<SalalahDashboard>
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

          TicketRequestsCard(
            providerArgs: _providerArgs,
            focusNode: _focusNode,
            pageController: _pageController,
          ),

          // Ticket Requests Section
          // Card(
          //   color: Colors.white,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(12.toAutoScaledHeight),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(16),
          //     child: Column(
          //       children: [
          //         // Header
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text(
          //               "Ticket Requests",
          //               style: TextStyle(
          //                 fontWeight: currentTheme.fontWeights.wBold,
          //                 fontSize: currentTheme.fontSizes.s16,
          //               ),
          //             ),
          //             ElevatedButton(
          //               onPressed: () {
          //                 showModalBottomSheet(
          //                   context: context,
          //                   shape: const RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.vertical(
          //                       top: Radius.circular(16),
          //                     ),
          //                   ),
          //                   builder: (_) {
          //                     return Padding(
          //                       padding: const EdgeInsets.all(20),
          //                       child: Column(
          //                         mainAxisSize: MainAxisSize.min,
          //                         children: [
          //                           const Text(
          //                             "Select Request Type",
          //                             style: TextStyle(
          //                               fontSize: 18,
          //                               fontWeight: FontWeight.bold,
          //                             ),
          //                           ),

          //                           const SizedBox(height: 20),

          //                           /// Option 1 - Salalah HOS
          //                           ListTile(
          //                             leading: const Icon(
          //                               Icons.account_circle,
          //                               color: Colors.blue,
          //                             ),
          //                             title: const Text(
          //                               "Salalah HOS New Request",
          //                             ),
          //                             onTap: () {
          //                               Navigator.pop(context);
          //                               KAppX.router.push(
          //                                 SalalahHOSNewRequestRoute(
          //                                   service: widget.service,
          //                                   subService: widget.subService,
          //                                 ),
          //                               );
          //                             },
          //                           ),

          //                           /// Option 2 - Salalah New Request
          //                           ListTile(
          //                             leading: const Icon(
          //                               Icons.assignment,
          //                               color: Colors.green,
          //                             ),
          //                             title: const Text("Salalah New Request"),
          //                             onTap: () {
          //                               // Navigator.pop(context);
          //                               KAppX.router.push(
          //                                 SalalahNewRequestRoute(
          //                                   service: widget.service,
          //                                   subService: widget.subService,
          //                                 ),
          //                               );
          //                             },
          //                           ),

          //                           ListTile(
          //                             leading: const Icon(
          //                               Icons.assignment,
          //                               color: Colors.green,
          //                             ),
          //                             title: const Text(
          //                               "Salalah Technician New Request",
          //                             ),
          //                             onTap: () {
          //                               // Navigator.pop(context);
          //                               KAppX.router.push(
          //                                 SalalahNewItTechnicianRequestRoute(
          //                                   service: widget.service,
          //                                   subService: widget.subService,
          //                                 ),
          //                               );
          //                             },
          //                           ),
          //                         ],
          //                       ),
          //                     );
          //                   },
          //                 );
          //               },
          //               child: const Text('New Request'),
          //             ),

          //             // ElevatedButton(
          //             //   onPressed: () {
          //             //     KAppX.router.push(SalalahNewRequestRoute());
          //             //   },
          //             //   child: Text('New Request'),
          //             // ),
          //           ],
          //         ),
          //         12.toHorizontalSizedBox,

          //         // Search box
          //         KTextField(
          //           focusNode: _focusNode,
          //           hintText: "Search by ID or Name",
          //           controller: searchController,
          //           textInputAction: TextInputAction.search,
          //           onSubmitted: (value) {
          //             ref.read(searchQueryProvider.notifier).state = value;
          //           },
          //           decoration: InputDecoration(
          //             prefixIcon: const Icon(Icons.search, color: Colors.black),
          //             suffixIcon: searchController.text.isNotEmpty
          //                 ? IconButton(
          //                     icon: const Icon(
          //                       Icons.clear,
          //                       color: Colors.black,
          //                     ),
          //                     onPressed: () {
          //                       searchController.clear();
          //                       ref.read(searchQueryProvider.notifier).state =
          //                           "";
          //                       Future.microtask(() {
          //                         if (!_focusNode.hasFocus) {
          //                           _focusNode.requestFocus();
          //                         }
          //                       });
          //                     },
          //                   )
          //                 : null,
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(12),
          //             ),
          //           ),
          //         ),
          //         12.toHorizontalSizedBox,

          //         // Tabs below the search bar
          //         TabBar(
          //           controller: _tabController,
          //           indicatorColor: Colors.blue,
          //           labelColor: Colors.blue,
          //           unselectedLabelColor: Colors.grey,
          //           tabs: const [
          //             Tab(text: "My Requests"),
          //             Tab(text: "Action Items"),
          //           ],
          //         ),

          //         // Tab content
          //         SizedBox(
          //           height: 400, // adjust height as needed
          //           child: TabBarView(
          //             controller: _tabController,
          //             // physics:   const NeverScrollableScrollPhysics(), // ❌ disables swipe
          //             children: [
          //               // Tab 0
          //               Consumer(
          //                 builder: (context, ref, _) {
          //                   final data = state.requests;
          //                   return ListView.builder(
          //                     itemCount: data.length,
          //                     itemBuilder: (context, index) {
          //                       final item = data[index];
          //                       return RequestCard(
          //                         from: 'salalah',
          //                         data: {
          //                           "id": item.id,
          //                           "status": item.status,
          //                           "problem": item.problem,
          //                           "service_type": item.serviceType?.name,
          //                           "created_at": item.createdAt,
          //                           "assigned_to": item
          //                               .approvalDetails?[0]
          //                               .approverUser
          //                               ?.employeeName,
          //                         },
          //                         onTap: () async {
          //                           // await controller.fetchRequestDetailsById(
          //                           //   item.id ?? 0,
          //                           // );
          //                           // final details =
          //                           //     controller.state.requestDetails;
          //                           KAppX.router.push(
          //                             SalalahRequestDetailsTabRoute(
          //                               id: item.id ?? 0,
          //                               service: widget.service,
          //                               subService: widget.subService,
          //                               // data: details,
          //                             ),
          //                           );
          //                         },
          //                       );
          //                     },
          //                   );
          //                 },
          //               ),
          //               // Tab 1
          //               Consumer(
          //                 builder: (context, ref, _) {
          //                   final data = state.actionItems;
          //                   return ListView.builder(
          //                     itemCount: data.length,
          //                     itemBuilder: (context, index) {
          //                       final item = data[index];
          //                       return RequestCard(
          //                         from: 'salalahactionitems',
          //                         data: {
          //                           "id": item.requestId,
          //                           "status": item.request?.status,
          //                           "problem": item.request?.problem,
          //                           "service_type":
          //                               item.request?.serviceType?.name,
          //                           "created_at": item.createdAt,
          //                           "assigned_to":
          //                               item.approverUser?.employeeName ??
          //                               'IT Technician',
          //                           'isAssigned': item.approverUserId != null,
          //                         },
          //                         onSelfAssign: () {
          //                           controller.selfAssign(
          //                             item.request?.workflowExecutionId ?? '',
          //                             item.requestId.toString(),
          //                           );
          //                         },
          //                         onTap: () async {
          //                           // await controller.fetchRequestDetailsById(
          //                           //   item.id ?? 0,
          //                           // );
          //                           // final details =
          //                           //     controller.state.requestDetails;
          //                           KAppX.router.push(
          //                             SalalahRequestDetailsTabRoute(
          //                               id: item.requestId ?? 0,
          //                               service: widget.service,
          //                               subService: widget.subService,
          //                               // data: details,
          //                             ),
          //                           );
          //                         },
          //                       );
          //                     },
          //                   );
          //                 },
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
