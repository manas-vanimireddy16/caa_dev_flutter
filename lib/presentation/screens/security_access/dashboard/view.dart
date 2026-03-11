import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/RadioButton.dart';
import 'package:code_setup/presentation/common_widgets/requestCard.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/models/activity_feed_model.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/request_detail.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/dashBoardRequest.dart';
import 'package:code_setup/presentation/screens/security_access/widgets/activityFeed.dart';
import 'package:code_setup/presentation/screens/security_access/widgets/kpicard.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'controller.dart';
part 'widgets/remarksSend.dart';
// part 'widgets/request_details.dart';

@RoutePage()
class AccessCardDashboardScreen extends ConsumerStatefulWidget {
  const AccessCardDashboardScreen({super.key});

  @override
  ConsumerState<AccessCardDashboardScreen> createState() =>
      _AccessCardDashboardScreenState();
}

class _AccessCardDashboardScreenState
    extends ConsumerState<AccessCardDashboardScreen>
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
    // final tickets = ref.watch(ticketProvider);
    // final selectedTab = ref.watch(selectedrequesteventTabProvider);
    // final data = ref.watch(filteredDataProvider);
    // final selectedService = ref.watch(bottomNavIndexProvider);
    // final state = ref.watch(_vsProvider);
    // final controller = ref.read(_vsProvider.notifier);

    // // Keep TabController in sync with provider
    // if (_tabController.index != selectedTab) {
    //   _tabController.index = selectedTab;
    // }

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Security & Access')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // KPI Cards
          //  StatSummaryRow(
          //   stats: state.tabIndex == 0
          //       ? statsList
          //       : statsApproverList,
          // ),
          16.toHorizontalSizedBox,

          ActivityFeed(activities: mockActivities),
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
                          // KAppX.router.push(AccessCardDashboardRequestRoute());
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
                            final data = dataList; //state.dashboardMyRequests;
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return RequestCard(
                                  from: 'logistics',
                                  data: {
                                    'id': item['id'],
                                    'status': item['status'],
                                    'Service Type': item['Service Type'],
                                    'Purpose of Travel':
                                        item['Purpose of Travel'],
                                    'Date': item['Date'],
                                    'Approver': item['Approver'],
                                  },
                                  // data: {
                                  //   'id': item.id,
                                  //   'status': item.status,
                                  //   'Service Type':
                                  //       item.subService?.description ?? 'NA',
                                  //   'Purpose of Travel':
                                  //       item.purposeOfTravel ?? '',
                                  //   'Date': item.createdByUser?.createdAt,
                                  //   'Approver':
                                  //       item
                                  //           .approvalDetails?[0]
                                  //           .approverRole
                                  //           ?.name ??
                                  //       '',
                                  // },
                                  onTap: () async {
                                    // await controller.fetchRequestsById(
                                    //   item.id ?? 0,
                                    // );
                                    // final details =
                                    //     controller.state.requestDataById;
                                    // KAppX.router.push(
                                    //   LogisticsRequestDetailsTabRoute(
                                    //     from: 'employee',
                                    //     id: item.id ?? 0,
                                    //     data: details,
                                    //   ),
                                    // );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        // Tab 1
                        Consumer(
                          builder: (context, ref, _) {
                            final data = dataList; //state.dashboardActionItems;
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
