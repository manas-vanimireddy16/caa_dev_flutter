import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/RadioButton.dart';
import 'package:code_setup/presentation/common_widgets/chat.dart';
import 'package:code_setup/presentation/common_widgets/checkBox.dart';
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
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_notifier.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/models/activity_feed_model.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/hotel_reservation/models/request_data.dart';
import 'package:code_setup/presentation/screens/logistics/models/dashBoardRequest.dart'
    hide ChatMessage, Service;
import 'package:code_setup/presentation/screens/logistics/widgets/profileCard.dart';
import 'package:code_setup/repository/housing_accommodation_service/hotel_reservation/domain/domain.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

part 'widgets/new_request_hotel_reservation.dart';
part 'controller.dart';
part 'widgets/request_details.dart';
part 'widgets/request_tabs.dart';

@RoutePage()
class HotelReservationScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  const HotelReservationScreen({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<HotelReservationScreen> createState() =>
      _HotelReservationScreenState();
}

class _HotelReservationScreenState extends ConsumerState<HotelReservationScreen>
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
    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
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
      appBar: KAppBar(title: const Text('Request Event Support')),
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
            selectedYear: '2025',
            barColor: Colors.blue,
            onYearTap: () => debugPrint("Year dropdown tapped"),
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
                            HotelReservationNewRequestRoute(
                              serviceId: widget.service.id ?? 0,
                              subServiceId: widget.subService.id ?? 0,
                              service: widget.service,
                              subService: widget.subService,
                            ),
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
                    onSubmitted: (value) {
                      // When the user presses 'Search' on the keyboard

                      controller.fetchRequests(
                        isRefresh: true, // reset pagination
                        searchText: value, // send search text to API
                      );
                    },
                    onChanged: (value) {
                      // Optional: to clear results when input becomes empty
                      if (value.isNotEmpty) {
                        controller.fetchRequests(
                          isRefresh: true,
                          searchText: searchController.text,
                        );
                      }
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
                                    KAppX.router.push(
                                      HotelReservationRequestDetailsTabRoute(
                                        serviceId: widget.service.id ?? 0,
                                        subServiceId: widget.subService.id ?? 0,
                                        service: widget.service,
                                        subService: widget.subService,
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
                                    KAppX.router.push(
                                      HotelReservationRequestDetailsTabRoute(
                                        serviceId: widget.service.id ?? 0,
                                        subServiceId: widget.subService.id ?? 0,
                                        service: widget.service,
                                        subService: widget.subService,
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
