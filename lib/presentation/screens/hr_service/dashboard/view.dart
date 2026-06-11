import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/radio_button.dart';
import 'package:code_setup/presentation/common_widgets/request_card.dart';
import 'package:code_setup/presentation/common_widgets/analytics/stat_summary_data.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/models/activity_feed_model.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/request_detail.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/hotel_reservation/models/request_data.dart';
import 'package:code_setup/repository/housing_accommodation_service/dashboard/domain/domain.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'controller.dart';
// part 'widgets/remarksSend.dart';
// part 'widgets/request_details.dart';

@RoutePage()
class AssignmentDecisionDashboardScreen extends ConsumerStatefulWidget {
  const AssignmentDecisionDashboardScreen({super.key});

  @override
  ConsumerState<AssignmentDecisionDashboardScreen> createState() =>
      _AssignmentDecisionDashboardScreenState();
}

class _AssignmentDecisionDashboardScreenState
    extends ConsumerState<AssignmentDecisionDashboardScreen>
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
    final state = ref.watch(_vsProvider);
    final controller = ref.read(_vsProvider.notifier);
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
      // appBar: AppBar(title: const Text('Hotel Accomidation')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // KPI Cards
          StatSummaryRow(
            stats: state.tabIndex == 0 ? statsList : statsApproverList,
          ),

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
                            final data = state
                                .hotelReservationRequestData; //state.dashboardMyRequests;
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return RequestCard(
                                  from: 'hotelreservation',

                                  data: {
                                    'id': item.id,
                                    'status': item.status,
                                    'User Name':
                                        item.createdByUser?.employeeName ??
                                        'NA',
                                    'Date': item.dateOfRequest,
                                    'Hotel Name': item.hotelName,
                                    'Check-In Date': item.checkInDate,
                                  },
                                  onTap: () async {
                                    // KAppX.router.push(
                                    // HotelReservationRequestDetailsTabRoute(
                                    //   from: 'employee',
                                    //   id: item.id ?? 0,
                                    // ),
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
                            final data = state.hotelReservationActionItemsData;
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return RequestCard(
                                  from: 'hotelreservation',

                                  data: {
                                    'id': item.id,
                                    'status': item.status,
                                    'User Name':
                                        item.createdByUser?.employeeName ??
                                        'NA',
                                    'Date': item.dateOfRequest,
                                    'Hotel Name': item.hotelName,
                                    'Check-In Date': item.checkInDate,
                                  },
                                  onTap: () async {
                                    // KAppX.router.push(
                                    //   HotelReservationRequestDetailsTabRoute(
                                    //     from: 'employee',
                                    //     id: item.id ?? 0,
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
