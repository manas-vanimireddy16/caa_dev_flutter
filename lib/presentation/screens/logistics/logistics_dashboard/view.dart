import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/bottomNavigation/index.dart';
import 'package:code_setup/presentation/common_widgets/requestCard.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/logistics/models/all_request_dashboard.dart'
    hide ChatMessage;
import 'package:code_setup/presentation/screens/logistics/widgets/activityFeed.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/attachments_tab.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/kpicard.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/popup.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/profileCard.dart'
    show ProfileCard;
import 'package:code_setup/presentation/screens/logistics/widgets/request_details_tab.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/workProgess.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';

import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/models/kpi.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/dashBoardRequest.dart'
    hide ChatMessage;
import 'package:code_setup/presentation/screens/logistics/models/kpi.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/passengerModel.dart';
import 'package:code_setup/presentation/screens/logistics/models/passengeruiModel.dart';
import 'package:code_setup/presentation/screens/request_details/models/attachmentModel.dart';
import 'package:code_setup/presentation/screens/request_details/models/commentItem.dart';
import 'package:code_setup/presentation/screens/request_details/models/taskModel.dart';
import 'package:code_setup/presentation/screens/logistics/models/activityField.dart';
import 'package:code_setup/repository/logistics/domain/logistics_dashboard.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';

part 'controller.dart';
// part 'widgets/remarksSend.dart';
// part 'widgets/request_details.dart';
// part 'widgets/workflow_tab.dart';
// part 'widgets/request_tabs.dart';

// import 'package:auto_route/auto_route.dart';
// import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
// import 'package:code_setup/presentation/bottomNavigation/index.dart';
// import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
// import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
// import 'package:code_setup/presentation/screens/logistics/controller.dart';
// import 'package:code_setup/presentation/screens/logistics/widgets/activityFeed.dart';
// import 'package:code_setup/presentation/screens/logistics/widgets/kpicard.dart';
// import 'package:code_setup/presentation/screens/logistics/widgets/popup.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LogisticsDashboardScreen extends ConsumerStatefulWidget {
  const LogisticsDashboardScreen({super.key});

  @override
  ConsumerState<LogisticsDashboardScreen> createState() =>
      _LogisticsDashboardScreenState();
}

class _LogisticsDashboardScreenState
    extends ConsumerState<LogisticsDashboardScreen>
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
    final tickets = ref.watch(ticketProvider);
    final selectedTab = ref.watch(selectedrequesteventTabProvider);
    final data = ref.watch(filteredDataProvider);
    final selectedService = ref.watch(bottomNavIndexProvider);
    final state = ref.watch(_vsProvider);
    final controller = ref.read(_vsProvider.notifier);

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
          StatSummaryRow(data: state.kpiData.data),
          16.toHorizontalSizedBox,

          // Activity Feed Section
          ActivityFeed(activities: state.activityFeed),

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
                          // NewRequestPopup.show(context);
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   width: 200,
                      //   child: MultiSelectDropdown(
                      //     items: const [
                      //       'All Status',
                      //       'Approved',
                      //       'Pending',
                      //       'Rejected',
                      //     ],
                      //     onSelectionChanged: (selectedValues) {
                      //       controller.fetchAllMyRequests(
                      //         isRefresh: true,
                      //         status: selectedValues.isEmpty
                      //             ? ''
                      //             : selectedValues.join(','),
                      //         // searchText: controller.searchController.text,
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),

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
                            final data = state.allRequests;
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return RequestCard(
                                  from: 'logistics',
                                  data: {
                                    'id': item.id,
                                    'status': item.status,
                                    // 'Service Type':
                                    //     item.subService?.description ?? 'NA',
                                    'Purpose of Travel':
                                        item.purposeOfTravel ?? '',
                                  },
                                  // 'Date': item.createdByUser?.createdAt,
                                  //   'Approver':
                                  //       item
                                  //           ?.approvalDetails?[0]
                                  //           .approverRole
                                  //           ?.name ??
                                  //       '',
                                  // },
                                  onTap: () async {
                                    // If you want to fetch data first, uncomment this part:
                                    // await controller.fetchRequestsById(item.id ?? 0);
                                    // final details = controller.state.requestDataById;

                                    if (item.category == 'Emergency' ||
                                        item.category == 'Daily') {
                                      // KAppX.router.push(
                                      // LogisticsRequestDetailsTabRoute(
                                      //   from: 'employee',
                                      //   id: item.id ?? 0,
                                      // ),
                                      // );
                                    } else {
                                      // KAppX.router.push(
                                      //   LogisticsForeignRequestDetailsTabRoute(
                                      //     from: 'foreign',
                                      //     id: item.id ?? 0,
                                      //     // data: details, // uncomment if needed
                                      //   ),
                                      // );
                                    }
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
