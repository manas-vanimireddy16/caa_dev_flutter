import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/RadioButton.dart';
import 'package:code_setup/presentation/common_widgets/approval_comment_dialog.dart';
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
import 'package:code_setup/presentation/models/activity_feed_model.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/area_permission.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/chat_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/employee_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/position_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/request_data_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/user_model.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/profileCard.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_awareness_request_data.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_reassign.dart';
import 'package:code_setup/repository/aviation_security_facilitation/airport_entry/domain/domain.dart';
import 'package:code_setup/repository/hr_service/assignment_decision/domain/domain.dart';
import 'package:code_setup/repository/hr_service/secondment_decision/domain/domain.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
import 'package:code_setup/utils/helper/type_checker.dart' hide FileType;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

import '../../../../modules/data/core/theme/services/dimensional/dimensional.dart';

part 'widgets/request_for_secondment_decision.dart';
part 'controller.dart';
part 'widgets/request_details.dart';
part 'widgets/request_tabs.dart';
part 'widgets/assign_engineer_dialog.dart';

@RoutePage()
class SecondmentDecisionScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  const SecondmentDecisionScreen({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<SecondmentDecisionScreen> createState() =>
      _SecondmentDecisionScreenState();
}

class _SecondmentDecisionScreenState
    extends ConsumerState<SecondmentDecisionScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController searchController;
  late FocusNode _focusNode;
  late TabController _tabController;

  late final ({Service service, SubService subService}) _providerArgs;

  @override
  void initState() {
    super.initState();
    _providerArgs = (service: widget.service, subService: widget.subService);
    searchController = TextEditingController(
      text: ref.read(searchQueryProvider),
    );
    _focusNode = FocusNode();

    searchController.addListener(() {
      setState(() {}); // rebuild suffixIcon
    });

    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      ref
          .read(_vsProvider(_providerArgs).notifier)
          .updateTabIndex(_tabController.index);
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_tabController.index != state.tabIndex) {
        _tabController.animateTo(state.tabIndex);
      }
    });

    // if (_tabController.index != state.tabIndex) {
    //   _tabController.animateTo(state.tabIndex);
    // }
    final active = controller.getActiveApprovalLevel(
      state.requestDetails.approvalDetails ?? [],
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

          // // Trend breakdown
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
            // selectedYear: DateTime.now().year.toString(),
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
                            NewSecondmentDecisionRequestRoute(
                              serviceId: widget.service.id ?? 0,
                              subServiceId: widget.subService.id ?? 0,
                              service: widget.service,
                              subService: widget.subService,
                            ),
                          );
                        },
                        child: const Text('Create New Assignment'),
                      ),
                    ],
                  ),
                  12.toHorizontalSizedBox,

                  // Search box
                  KTextField(
                    focusNode: _focusNode,
                    hintText: "Search by ID or Name",
                    controller: searchController,
                    // textInputAction: TextInputAction.search,
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
                            final data = state.secondmentDecisionRequestData;
                            if (state.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (data.isEmpty) {
                              return const Center(
                                child: Text(
                                  "No Data Found",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }
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
                                    'Date': item.createdAt,
                                    'Approver Name':
                                        active?.approverUser?.employeeName ??
                                        '',
                                  },
                                  onTap: () async {
                                    KAppX.router.push(
                                      SecondmentDecisionDetailsRoute(
                                        from: 'employee',
                                        id: item.id ?? 0,
                                        serviceId: widget.service.id ?? 0,
                                        subServiceId: widget.subService.id ?? 0,
                                        service: widget.service,
                                        subService: widget.subService,
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
                            final data =
                                state.assignmentDecisionActionItemsData;
                            if (state.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (data.isEmpty) {
                              return const Center(
                                child: Text(
                                  "No Data Found",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }
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
                                    'Date': item.createdAt,
                                    'Approver Name':
                                        active?.approverUser?.employeeName ??
                                        '',
                                  },
                                  onTap: () async {
                                    KAppX.router.push(
                                      SecondmentDecisionDetailsRoute(
                                        from: 'action items',
                                        id: item.id ?? 0,
                                        service: widget.service,
                                        subService: widget.subService,

                                        serviceId: widget.service.id ?? 0,
                                        subServiceId: widget.subService.id ?? 0,
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
