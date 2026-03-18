import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/attachments_tab.dart';
import 'package:code_setup/presentation/common_widgets/checkBox.dart';
import 'package:code_setup/presentation/common_widgets/profile_card.dart';
import 'package:code_setup/presentation/common_widgets/requestCard.dart';
import 'package:code_setup/presentation/common_widgets/requestStatusBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/requestTrendBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/request_details_tab.dart';
import 'package:code_setup/presentation/common_widgets/request_history_tab.dart';
import 'package:code_setup/presentation/common_widgets/statSummaryData.dart';
import 'package:code_setup/presentation/common_widgets/tab_item.dart';
import 'package:code_setup/presentation/common_widgets/workflow_tab.dart';
import 'package:code_setup/presentation/models/kpi.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/it_services/vpn/models/technician.dart';
import 'package:code_setup/presentation/screens/it_services/vpn/models/vpn_request.dart';
import 'package:code_setup/presentation/screens/it_services/vpn/models/vpn_request_by_id.dart'
    hide ApprovalDetail;
import 'package:code_setup/presentation/screens/it_services/vpn/widgets/RadioButton.dart';
import 'package:code_setup/repository/vpn/domain/domain.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:code_setup/presentation/screens/request_details/models/attachmentModel.dart';
import 'package:code_setup/presentation/screens/request_details/models/commentItem.dart';
import 'package:code_setup/presentation/screens/request_details/models/taskModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
part 'controller.dart';
part 'widgets/newRequest.dart';
part 'widgets/request_details.dart';
part 'widgets/remarks_send.dart';
part 'widgets/request_tabs.dart';
part 'widgets/technician_dialog.dart';

@RoutePage()
class VpnDashboard extends ConsumerStatefulWidget {
  const VpnDashboard({super.key});

  @override
  ConsumerState<VpnDashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<VpnDashboard>
    with SingleTickerProviderStateMixin {
  late TextEditingController searchController = TextEditingController();
  late FocusNode _focusNode;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _tabController = TabController(
      length: 2, // <-- Set number of tabs
      vsync: this,
    );
    // searchController = TextEditingController();
    searchController.addListener(() {
      setState(() {}); // rebuild suffixIcon
    });

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final controller = ref.read(_vsProvider.notifier);
        controller.updateVpnTab(_tabController.index);
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

    // final data = ref.watch(filteredDataProvider);
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final state = ref.watch(_vsProvider);
    final controller = ref.read(_vsProvider.notifier);
    final selectedTab = state.selectedVpnTab;
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
      appBar: AppBar(title: const Text('Vpn Service')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // KPI Cards
          StatSummaryRow(stats: statsList), 16.toHorizontalSizedBox,

          // Status breakdown
          RequestStatusBreakdownCard(
            data: state.statusBreakdown.data?.breakdown ?? [],
            breakdown: state.statusBreakdown.data,
            title: "Requests Status Breakdown",

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
            // selectedYear: '2025',
            barColor: Colors.blue,
            // onYearTap: () => debugPrint("Year dropdown tapped"),
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
                      Text(
                        "Ticket Requests",
                        style: TextStyle(
                          fontWeight: currentTheme.fontWeights.wBold,
                          fontSize: currentTheme.fontSizes.s16,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          KAppX.router.push(VpnNewRequestRoute());
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
                      // ref.read(searchQueryProvider.notifier).state = value;
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
                                // searchController.clear();
                                // ref.read(searchQueryProvider.notifier).state =
                                //     "";
                                // Future.microtask(() {
                                //   if (!_focusNode.hasFocus) {
                                //     _focusNode.requestFocus();
                                //   }
                                // });
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
                    height: 400.toAutoScaledHeight, // adjust height as needed
                    child: TabBarView(
                      controller: _tabController,
                      // physics:   const NeverScrollableScrollPhysics(), // ❌ disables swipe
                      children: [
                        // Tab 0
                        Consumer(
                          builder: (context, ref, _) {
                            final data = state.myRequests;
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return RequestCard(
                                  from: 'vpn',
                                  data: {
                                    'id': item.id,
                                    'status': item.status,
                                    'Request Type':
                                        item.reasonForRequest?[0] ?? 'NA',
                                    'Request For': item.requestFor,

                                    'Start Date': item.startDate,
                                    'End Date': item.endDate,
                                    // 'Assigned To': item.assignedAt,
                                  },
                                  onTap: () {
                                    ref.invalidate(_vsProvider);

                                    KAppX.router.push(
                                      VPNRequestDetailsTabRoute(
                                        from: 'vpn',
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
                            final data = state.myActionItems;
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return RequestCard(
                                  from: 'vpn',
                                  data: {
                                    'id': item.id,
                                    'status':
                                        item.approvalDetails?[0].approvalStatus,
                                    'Request Type':
                                        item.reasonForRequest?[0] ?? 'NA',
                                    'Request For': item.requestFor,

                                    'Start Date': item.startDate,
                                    'End Date': item.endDate,
                                    // 'Assigned To': item.assignedAt,
                                  },
                                  onTap: () {
                                    ref.invalidate(_vsProvider);

                                    KAppX.router.push(
                                      VPNRequestDetailsTabRoute(
                                        from: 'vpn approval details',
                                        id: item.id ?? 0,
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

// --- keep your existing imports for KAppX, KScaffold, KTextField, RequestCard, KPIResponse, VpnRequestData, etc.
// import '...';

// @RoutePage()
// class VpnDashboard extends ConsumerStatefulWidget {
//   const VpnDashboard({super.key});

//   @override
//   ConsumerState<VpnDashboard> createState() => _DashboardState();
// }

// class _DashboardState extends ConsumerState<VpnDashboard>
//     with SingleTickerProviderStateMixin {
//   late TextEditingController searchController;
//   late FocusNode _focusNode;
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     searchController = TextEditingController(
//       // text: ref.read(searchQueryProvider),
//     );
//     _focusNode = FocusNode();

//     // removed: searchController.addListener(() { setState(() {}); });

//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging) {
//         final Controller = ref.read(_vsProvider.notifier);
//         Controller.updateVpnTab(_tabController.index);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     _focusNode.dispose();
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(_vsProvider);
//     final controller = ref.read(_vsProvider.notifier);
//     final currentYear = DateTime.now().year;
//     final filterLabelList = List.generate(
//       6,
//       (index) => (currentYear - index).toString(),
//     );
//     final selectedTab = state.selectedVpnTab;
//     // final data = ref.watch(filteredDataProvider);
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;

//     // Keep TabController in sync with provider in a safe post-frame callback (avoids layout thrash)
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_tabController.index != selectedTab) {
//         // only animate to avoid forcing immediate rebuild loops
//         _tabController.animateTo(selectedTab);
//       }
//     });

//     return KScaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: const Text('Vpn Service')),
//       body: ListView(
//         padding: const EdgeInsets.all(12),
//         children: [
//           // KPI Cards
//           StatSummaryRow(data: state.kpiData.data),
//           16.toHorizontalSizedBox,

//           // Status breakdown
//           RequestStatusBreakdownCard(
//             data: state.statusBreakdown.data?.breakdown ?? [],
//             breakdown: state.statusBreakdown.data,
//             title: "Requests Status Breakdown",
//             onChanged: (value) {
//               // send the text to your controller’s search function
//               controller.fetchStatusBreakDown(value ?? '');
//             },
//           ),
//           16.toHorizontalSizedBox,

//           // Trend breakdown
//           RequestTrendBreakdownCard(
//             monthlyData:
//                 state.trendData.data?.trendData
//                     ?.map((e) => e.count ?? 0)
//                     .toList() ??
//                 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//             monthLabels: monthLabels,
//             metric: "Total Tickets",
//             selectedYear: '2025',
//             barColor: Colors.blue,
//             onYearTap: () => debugPrint("Year dropdown tapped"),
//             onChanged: (value) {
//               if (value != null) {
//                 controller.fetchTrendBreakDown(value);
//               }
//             },
//             filterLabelList: filterLabelList,
//           ),
//           16.toHorizontalSizedBox,

//           // Ticket Requests Section
//           Card(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   // Header
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Ticket Requests",
//                         style: TextStyle(
//                           fontWeight: currentTheme.fontWeights.wBold,
//                           fontSize: currentTheme.fontSizes.s16,
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           KAppX.router.push(VpnNewRequestRoute());
//                         },
//                         child: const Text('New Request'),
//                       ),
//                     ],
//                   ),
//                   12.toHorizontalSizedBox,

//                   // Search box
//                   // Use ValueListenableBuilder so only the search field rebuilds when text changes.
//                   ValueListenableBuilder<TextEditingValue>(
//                     valueListenable: searchController,
//                     builder: (context, value, _) {
//                       return KTextField(
//                         focusNode: _focusNode,
//                         hintText: "Search by ID or Name",
//                         controller: searchController,
//                         textInputAction: TextInputAction.search,
//                         onSubmitted: (v) {
//                           // ref.read(searchQueryProvider.notifier).state = v;
//                           // trigger controller fetch with new search text
//                           controller.fetchMyRequests(
//                             isRefresh: true,
//                             searchText: v,
//                           );
//                           controller.fetchMyActionItems(
//                             isRefresh: true,
//                             searchText: v,
//                           );
//                         },
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(
//                             Icons.search,
//                             color: Colors.black,
//                           ),
//                           suffixIcon: searchController.text.isNotEmpty
//                               ? IconButton(
//                                   icon: const Icon(
//                                     Icons.clear,
//                                     color: Colors.black,
//                                   ),
//                                   onPressed: () {
//                                     // searchController.clear();
//                                     // ref
//                                     //         .read(searchQueryProvider.notifier)
//                                     //         .state =
//                                     //     "";
//                                     // // ensure focus returns to search after clearing
//                                     // Future.microtask(() {
//                                     //   if (!_focusNode.hasFocus) {
//                                     //     _focusNode.requestFocus();
//                                     //   }
//                                     // });
//                                     // // clear search results (refresh)
//                                     // controller.fetchMyRequests(
//                                     //   isRefresh: true,
//                                     //   searchText: '',
//                                     // );
//                                     // controller.fetchMyActionItems(
//                                     //   isRefresh: true,
//                                     //   searchText: '',
//                                     // );
//                                   },
//                                 )
//                               : null,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   12.toHorizontalSizedBox,

//                   // Tabs below the search bar
//                   TabBar(
//                     controller: _tabController,
//                     indicatorColor: Colors.blue,
//                     labelColor: Colors.blue,
//                     unselectedLabelColor: Colors.grey,
//                     tabs: const [
//                       Tab(text: "My Requests"),
//                       Tab(text: "Action Items"),
//                     ],
//                   ),

//                   // Tab content
//                   SizedBox(
//                     height:
//                         400.toAutoScaledHeight, // kept identical to original UI
//                     child: TabBarView(
//                       controller: _tabController,
//                       children: const [
//                         // Tab 0: MyRequestsTab (kept alive to avoid rebuilds)
//                         MyRequestsTab(),
//                         // Tab 1: ActionItemsTab (kept alive to avoid rebuilds)
//                         ActionItemsTab(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// -----------------------
// /// MyRequestsTab widget
// /// -----------------------
// class MyRequestsTab extends ConsumerStatefulWidget {
//   const MyRequestsTab({super.key});

//   @override
//   ConsumerState<MyRequestsTab> createState() => _MyRequestsTabState();
// }

// class _MyRequestsTabState extends ConsumerState<MyRequestsTab>
//     with AutomaticKeepAliveClientMixin<MyRequestsTab> {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context); // required for keepAlive
//     final state = ref.watch(_vsProvider);

//     final data = state.myRequests;
//     if (data.isEmpty) {
//       return Center(
//         child: Text(
//           'No requests available',
//           style: Theme.of(context).textTheme.bodyMedium,
//         ),
//       );
//     }

//     return ListView.builder(
//       itemCount: data.length,
//       itemBuilder: (context, index) {
//         final item = data[index];
//         return RequestCard(
//           from: 'vpn',
//           data: {
//             'id': item.id,
//             'status': item.status,
//             'Request Type': item.reasonForRequest?[0] ?? 'NA',
//             'Request For': item.requestFor,
//             'Start Date': item.startDate,
//             'End Date': item.endDate,
//             // other fields unique to My Requests can remain here
//           },
//           onTap: () {
//             // Removed ref.invalidate(_vsProvider) to prevent heavy reloads.
//             KAppX.router.push(
//               VPNRequestDetailsTabRoute(from: 'vpn', id: item.id ?? 0),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }

// /// -----------------------
// /// ActionItemsTab widget
// /// -----------------------
// class ActionItemsTab extends ConsumerStatefulWidget {
//   const ActionItemsTab({super.key});

//   @override
//   ConsumerState<ActionItemsTab> createState() => _ActionItemsTabState();
// }

// class _ActionItemsTabState extends ConsumerState<ActionItemsTab>
//     with AutomaticKeepAliveClientMixin<ActionItemsTab> {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context); // required for keepAlive
//     final state = ref.watch(_vsProvider);

//     final data = state.myActionItems;
//     if (data.isEmpty) {
//       return Center(
//         child: Text(
//           'No action items',
//           style: Theme.of(context).textTheme.bodyMedium,
//         ),
//       );
//     }

//     return ListView.builder(
//       itemCount: data.length,
//       itemBuilder: (context, index) {
//         final item = data[index];
//         return RequestCard(
//           from: 'vpn',
//           data: {
//             'id': item.id,
//             'status': item.approvalDetails?[0].approvalStatus,
//             'Request Type': item.reasonForRequest?[0] ?? 'NA',
//             'Request For': item.requestFor,
//             'Start Date': item.startDate,
//             'End Date': item.endDate,
//             // other fields unique to Action Items can remain here
//           },
//           onTap: () {
//             // Removed ref.invalidate(_vsProvider) to prevent heavy reloads.
//             KAppX.router.push(
//               VPNRequestDetailsTabRoute(
//                 from: 'vpn approval details',
//                 id: item.id ?? 0,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }
