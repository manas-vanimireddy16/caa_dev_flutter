import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/bottomNavigation/index.dart';
import 'package:code_setup/presentation/common_widgets/requestCard.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/logistics/logistics_employee/widgets/multi_select.dart';
import 'package:code_setup/presentation/screens/logistics/logistics_employee/widgets/request_history_tab.dart';
import 'package:code_setup/presentation/screens/logistics/logistics_employee/widgets/workProgess.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/activityFeed.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/kpicard.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/popup.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';

import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/presentation/models/kpi.dart';
import 'package:code_setup/presentation/common_widgets/RadioButton.dart';
import 'package:code_setup/presentation/common_widgets/requestStatusBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/requestTrendBreakdown.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/dashBoardRequest.dart'
    hide ChatMessage;
import 'package:code_setup/presentation/screens/logistics/models/kpi.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/passengerModel.dart';
import 'package:code_setup/presentation/screens/logistics/models/passengeruiModel.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/attachments_tab.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/profileCard.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/request_details_tab.dart';
import 'package:code_setup/presentation/screens/request_details/models/attachmentModel.dart';
import 'package:code_setup/presentation/screens/request_details/models/commentItem.dart';
import 'package:code_setup/presentation/screens/request_details/models/taskModel.dart';
import 'package:code_setup/presentation/screens/logistics/models/activityField.dart';
import 'package:code_setup/repository/logistics/domain/logistics_dashboard.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/widgets/buildChangewidget.dart';
part 'controller.dart';
part 'widgets/remarksSend.dart';
part 'widgets/request_details.dart';
part 'widgets/request_tabs.dart';
part 'widgets/workflow_tab.dart';
part 'widgets/newRequestVehicle.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LogisticsRequestPortalScreen extends ConsumerStatefulWidget {
  const LogisticsRequestPortalScreen({super.key});

  @override
  ConsumerState<LogisticsRequestPortalScreen> createState() =>
      _LogisticsRequestPortalScreenState();
}

class _LogisticsRequestPortalScreenState
    extends ConsumerState<LogisticsRequestPortalScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController searchController;
  late FocusNode _focusNode;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final filterLabelList = List.generate(
      6,
      (index) => (currentYear - index).toString(),
    );

    final selectedTab = ref.watch(selectedrequesteventTabProvider);
    final data = ref.watch(filteredDataProvider);
    final state = ref.watch(_vsLEProvider);
    final controller = ref.read(_vsLEProvider.notifier);

    // Keep TabController in sync with provider
    if (_tabController.index != selectedTab) {
      _tabController.index = selectedTab;
    }

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: KAppBar(title: const Text('Logitics')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // KPI Cards
          StatSummaryRow(data: state.kpiDataEmployee.data),
          16.toHorizontalSizedBox,

          RequestStatusBreakdownCard(
            data: state.statusBreakdown.data?.breakdown ?? [],
            breakdown: state.statusBreakdown.data,
            title: "Requests Status Breakdown",
            //  filterLabel: "Monthly",
            onChanged: (value) {
              // send the text to your controller’s search function
              controller.fetchStatusBreakDown(value ?? '');
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
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Header
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
                        onPressed: () {
                          ref.invalidate(_vsLEProvider);
                          KAppX.router.push(LogisticsVehicleRequestRoute());
                        },
                        child: const Text('New Request'),
                      ),
                    ],
                  ),
                  12.toHorizontalSizedBox,

                  // Search box
                  KTextField(
                    focusNode: _focusNode,
                    hintText: "Search by ID or Name",
                    controller: controller.searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      // When the user presses 'Search' on the keyboard

                      controller.fetchAllMyRequests(
                        isRefresh: true, // reset pagination
                        searchText: value, // send search text to API
                      );
                    },
                    onChanged: (value) {
                      // Optional: to clear results when input becomes empty
                      if (value.isNotEmpty) {
                        controller.fetchAllMyRequests(
                          isRefresh: true,
                          searchText: controller.searchController.text,
                        );
                      }
                    },
                  ),
                  12.toVerticalSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: MultiSelectDropdown(
                          items: const [
                            'All Status',
                            'Approved',
                            'Pending',
                            'Rejected',
                          ],
                          onSelectionChanged: (selectedValues) {
                            controller.fetchAllMyRequests(
                              isRefresh: true,
                              status: selectedValues.isEmpty
                                  ? ''
                                  : selectedValues.join(','),
                              searchText: controller.searchController.text,
                            );
                          },
                        ),
                      ),
                    ],
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
                            final data = state.dashboardMyRequests;
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return RequestCard(
                                  from: 'logistics',
                                  data: {
                                    'id': item.id,
                                    'status': item.status,
                                    'Service Type':
                                        item.subService?.description ?? 'NA',
                                    'Purpose of Travel':
                                        item.purposeOfTravel ?? '',
                                    'Date': item.createdByUser?.createdAt,
                                    'Approver':
                                        item
                                            .approvalDetails?[0]
                                            .approverRole
                                            ?.name ??
                                        '',
                                  },
                                  onTap: () async {
                                    // await controller.fetchRequestsById(
                                    //   item.id ?? 0,
                                    // );
                                    // final details =
                                    //     controller.state.requestDataById;
                                    KAppX.router.push(
                                      LogisticsRequestDetailsTabRoute(
                                        from: 'employee',
                                        id: item.id ?? 0,
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
                            // final data = ref.watch(filteredDataProvider);
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return RequestCard(
                                  data: item,
                                  onTap: () {
                                    // KAppX.router.push(
                                    //   ReuseRequestDetailsTabRoute(
                                    //     taskData: tasksData1,
                                    //     comments: comments1,
                                    //     attachments: attachments1,
                                    //   ),
                                    // );
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
