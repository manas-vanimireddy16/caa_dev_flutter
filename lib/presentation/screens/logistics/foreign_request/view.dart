import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/models/chartModel.dart' show ChartData;
import 'package:code_setup/presentation/models/kpi.dart';
import 'package:code_setup/presentation/bottomNavigation/index.dart';
import 'package:code_setup/presentation/common_widgets/RadioButton.dart';
import 'package:code_setup/presentation/common_widgets/requestCard.dart';
import 'package:code_setup/presentation/common_widgets/requestStatusBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/requestTrendBreakdown.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/screens/logistics/foreign_request/widgets/attachments_tab.dart';
import 'package:code_setup/presentation/screens/logistics/foreign_request/widgets/request_details_tab.dart';
import 'package:code_setup/presentation/screens/logistics/foreign_request/widgets/request_history_tab.dart';
import 'package:code_setup/presentation/screens/logistics/foreign_request/widgets/workProgess.dart';
import 'package:code_setup/presentation/screens/logistics/models/foreign_model.dart'
    hide ApprovalDetail;
import 'package:code_setup/presentation/screens/logistics/models/kpi.dart';
import 'package:code_setup/presentation/screens/logistics/models/kpi_employee.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_foreign_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/passengerModel.dart';
import 'package:code_setup/presentation/screens/logistics/models/passengeruiModel.dart';
import 'package:code_setup/presentation/screens/logistics/models/status_breakdown.dart';
import 'package:code_setup/presentation/screens/logistics/view.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/kpicard.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/profileCard.dart';
import 'package:code_setup/repository/logistics/domain/logistics_dashboard.dart';
import 'package:code_setup/repository/logistics/domain/logistics_foreign.dart';
import 'package:code_setup/repository/request_details/domain/request_detail.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
import 'package:code_setup/presentation/screens/logistics/view.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/widgets/buildChangewidget.dart';
import 'package:code_setup/presentation/screens/logistics/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'controller.dart';
part 'widgets/remarksSend.dart';
part 'widgets/request_details.dart';
part 'widgets/request_tabs.dart';
part 'widgets/workflow_tab.dart';
part 'widgets/newRequestForeign.dart';
part 'widgets/passengerComponenet.dart';

@RoutePage()
class LogisticsForeignersRequestPortalScreen extends ConsumerStatefulWidget {
  const LogisticsForeignersRequestPortalScreen({super.key});

  @override
  ConsumerState<LogisticsForeignersRequestPortalScreen> createState() =>
      _LogisticsForeignersRequestPortalScreenState();
}

class _LogisticsForeignersRequestPortalScreenState
    extends ConsumerState<LogisticsForeignersRequestPortalScreen>
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
      6, // current year + last 5 years
      (index) => (currentYear - index).toString(),
    );
    final selectedService = ref.watch(bottomNavIndexProvider);
    final state = ref.watch(_vsProvider);
    final controller = ref.read(_vsProvider.notifier);
    final selectedTab = ref.watch(selectedrequesteventTabProvider);

    final monthlyCounts =
        state.trendData.data?.trendData?.map((e) => e.count ?? 0).toList() ??
        [];
    // print('✅ Trend data count: ${monthlyCounts.length}');
    // print(
    //   '✅ Trend data months: ${state.trendData.data?.trendData?.map((e) => e.month).toList()}',
    // );

    // Keep TabController in sync with provider
    if (_tabController.index != selectedTab) {
      _tabController.index = selectedTab;
    }

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Logistics')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // KPI Cards
          StatSummaryRow(data: state.kpiDataForeigner.data),
          16.toHorizontalSizedBox,

          RequestStatusBreakdownCard(
            breakdown: state.statusBreakdown.data,
            data: state.statusBreakdown.data?.breakdown ?? [],
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
            selectedYear: '2025',
            barColor: Colors.blue,
            onYearTap: () => debugPrint("Year dropdown tapped"),
            onChanged: (value) {
              // send the text to your controller’s search function
              if (value != null) {
                controller.fetchTrendBreakDown(value);
              }
            },
            filterLabelList: [],
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
                          KAppX.router.push(
                            LogisticsPassengersVehicleRequestRoute(),
                          );
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
                                    'Vehicle Location':
                                        item.vehicleRequiredLocation,
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
                                    //     controller.state.requestForeignDataById;
                                    KAppX.router.push(
                                      LogisticsForeignRequestDetailsTabRoute(
                                        from: 'foreign',
                                        id: item.id ?? 0,
                                        // data: details,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        Center(child: Text("No Action Items available")),
                        // Tab 1
                        // Consumer(
                        //   builder: (context, ref, _) {
                        //     // final data = ref.watch(filteredDataProvider);
                        //     return ListView.builder(
                        //       itemCount: data.length,
                        //       itemBuilder: (context, index) {
                        //         final item = data[index];
                        //         return RequestCard(
                        //           data: item,
                        //           onTap: () {
                        //             // KAppX.router.push(
                        //             //   ReuseRequestDetailsTabRoute(
                        //             //     taskData: tasksData1,
                        //             //     comments: comments1,
                        //             //     attachments: attachments1,
                        //             //   ),
                        //             // );
                        //           },
                        //         );
                        //       },
                        //     );
                        //   },
                        // ),
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
