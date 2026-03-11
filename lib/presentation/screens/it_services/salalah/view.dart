import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/attachments_tab.dart';
import 'package:code_setup/presentation/common_widgets/chat.dart';
import 'package:code_setup/presentation/common_widgets/comment.dart';
import 'package:code_setup/presentation/common_widgets/comment_box.dart';
import 'package:code_setup/presentation/common_widgets/common_attachments.dart';
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
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
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
import 'package:code_setup/presentation/screens/it_services/salalah/models/service_dropdown_model.dart'
    hide Service, SubService;
import 'package:code_setup/presentation/screens/it_services/salalah/models/status_break_down.dart'
    hide ChartData;
import 'package:code_setup/presentation/screens/it_services/salalah/widgets/request_details_tab.dart';
import 'package:code_setup/repository/salalah/domain/dashboard.dart'
    show DashboardRepository;
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
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
part 'widgets/comment.dart';
part 'widgets/new_ittechnician_request.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final filterLabelList = List.generate(
      6,
      (index) => (currentYear - index).toString(),
    );
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final selectedTab = ref.watch(selectedSalalahTabProvider);
    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final statsList = StatSummaryHelper.buildStatList(
      state.kpiData.data?.toJson(),
    );
    // final statsApproverList = StatSummaryHelper.buildStatList(
    //   state.approvalKpiData.data?.toJson(),
    // );

    // Keep TabController in sync with provider
    if (_tabController.index != selectedTab) {
      _tabController.index = selectedTab;
    }

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: KAppBar(title: const Text('HelpDesk Salalah')),
      body: ListView(
        padding: EdgeInsets.only(
          left: 12.toAutoScaledWidth,
          right: 12.toAutoScaledWidth,
          top: 12.toAutoScaledHeight,
          bottom: 12.toAutoScaledHeight,
        ),
        children: [
          // KPI Cards
          StatSummaryRow(stats: statsList), 20.toHorizontalSizedBox,

          // Status breakdown
          RequestStatusBreakdownCard(
            data: state.statusBreakdownCard.data?.breakdown ?? [],
            breakdown: state.statusBreakdownCard.data,
            title: "Requests Status Breakdown",

            onChanged: (value) {
              // send the text to your controller’s search function
              controller.fetchStatusBreakdown(value ?? '');
            },
          ),
          16.toHorizontalSizedBox,

          // Trend breakdown
          RequestTrendBreakdownCard(
            monthlyData:
                state.trendData.data?.trendData
                    ?.map((e) => e.count ?? 0)
                    .toList() ??
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            monthLabels: monthLabels,
            metric: "Total Tickets",
            selectedYear: '2025',
            barColor: Colors.blue,
            onYearTap: () => debugPrint("Year dropdown tapped"),
            onChanged: (value) {
              if (value != null) {
                controller.fetchTrendBreakDown(value);
              }
            },
            filterLabelList: filterLabelList,
          ),
          16.toHorizontalSizedBox,

          // Ticket Requests Section
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.toAutoScaledHeight),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ticket Requests",
                        style: TextStyle(
                          fontWeight: currentTheme.fontWeights.wBold,
                          fontSize: currentTheme.fontSizes.s16,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (_) {
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Select Request Type",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    /// Option 1 - Salalah HOS
                                    ListTile(
                                      leading: const Icon(
                                        Icons.account_circle,
                                        color: Colors.blue,
                                      ),
                                      title: const Text(
                                        "Salalah HOS New Request",
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        KAppX.router.push(
                                          SalalahHOSNewRequestRoute(
                                            service: widget.service,
                                            subService: widget.subService,
                                          ),
                                        );
                                      },
                                    ),

                                    /// Option 2 - Salalah New Request
                                    ListTile(
                                      leading: const Icon(
                                        Icons.assignment,
                                        color: Colors.green,
                                      ),
                                      title: const Text("Salalah New Request"),
                                      onTap: () {
                                        // Navigator.pop(context);
                                        KAppX.router.push(
                                          SalalahNewRequestRoute(
                                            service: widget.service,
                                            subService: widget.subService,
                                          ),
                                        );
                                      },
                                    ),

                                    ListTile(
                                      leading: const Icon(
                                        Icons.assignment,
                                        color: Colors.green,
                                      ),
                                      title: const Text(
                                        "Salalah Technician New Request",
                                      ),
                                      onTap: () {
                                        // Navigator.pop(context);
                                        KAppX.router.push(
                                          SalalahNewItTechnicianRequestRoute(
                                            service: widget.service,
                                            subService: widget.subService,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('New Request'),
                      ),

                      // ElevatedButton(
                      //   onPressed: () {
                      //     KAppX.router.push(SalalahNewRequestRoute());
                      //   },
                      //   child: Text('New Request'),
                      // ),
                    ],
                  ),
                  12.toHorizontalSizedBox,

                  // Search box
                  KTextField(
                    focusNode: _focusNode,
                    hintText: "Search by ID or Name",
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      ref.read(searchQueryProvider.notifier).state = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                searchController.clear();
                                ref.read(searchQueryProvider.notifier).state =
                                    "";
                                Future.microtask(() {
                                  if (!_focusNode.hasFocus) {
                                    _focusNode.requestFocus();
                                  }
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  12.toHorizontalSizedBox,

                  // Tabs below the search bar
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.blue,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: "My Requests"),
                      Tab(text: "Action Items"),
                    ],
                  ),

                  // Tab content
                  SizedBox(
                    height: 400, // adjust height as needed
                    child: TabBarView(
                      controller: _tabController,
                      // physics:   const NeverScrollableScrollPhysics(), // ❌ disables swipe
                      children: [
                        // Tab 0
                        Consumer(
                          builder: (context, ref, _) {
                            final data = state.requests;
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return RequestCard(
                                  from: 'salalah',
                                  data: {
                                    "id": item.id,
                                    "status": item.status,
                                    "problem": item.problem,
                                    "service_type": item.serviceType?.name,
                                    "created_at": item.createdAt,
                                    "assigned_to": item
                                        .approvalDetails?[0]
                                        .approverUser
                                        ?.employeeName,
                                  },
                                  onTap: () async {
                                    // await controller.fetchRequestDetailsById(
                                    //   item.id ?? 0,
                                    // );
                                    // final details =
                                    //     controller.state.requestDetails;
                                    KAppX.router.push(
                                      SalalahRequestDetailsTabRoute(
                                        id: item.id ?? 0,
                                        service: widget.service,
                                        subService: widget.subService,
                                        // data: details,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        // Tab 1
                        Consumer(
                          builder: (context, ref, _) {
                            final data = state.actionItems;
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return RequestCard(
                                  from: 'salalahactionitems',
                                  data: {
                                    "id": item.requestId,
                                    "status": item.request?.status,
                                    "problem": item.request?.problem,
                                    "service_type":
                                        item.request?.serviceType?.name,
                                    "created_at": item.createdAt,
                                    "assigned_to":
                                        item.approverUser?.employeeName ??
                                        'IT Technician',
                                    'isAssigned': item.approverUserId != null,
                                  },
                                  onSelfAssign: () {
                                    controller.selfAssign(
                                      item.request?.workflowExecutionId ?? '',
                                      item.requestId.toString(),
                                    );
                                  },
                                  onTap: () async {
                                    // await controller.fetchRequestDetailsById(
                                    //   item.id ?? 0,
                                    // );
                                    // final details =
                                    //     controller.state.requestDetails;
                                    KAppX.router.push(
                                      SalalahRequestDetailsTabRoute(
                                        id: item.requestId ?? 0,
                                        service: widget.service,
                                        subService: widget.subService,
                                        // data: details,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
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
