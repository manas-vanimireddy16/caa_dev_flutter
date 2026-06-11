import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/radio_button.dart';
import 'package:code_setup/presentation/common_widgets/request_details/approval_comment_dialog.dart';
import 'package:code_setup/presentation/common_widgets/request_details/chat.dart';
import 'package:code_setup/presentation/common_widgets/check_box.dart';
import 'package:code_setup/presentation/common_widgets/request_details/common_attachments.dart';
import 'package:code_setup/presentation/common_widgets/request_details/common_request_details.dart';
import 'package:code_setup/presentation/common_widgets/request_details/common_workflow.dart';
import 'package:code_setup/presentation/common_widgets/file_upload.dart';
import 'package:code_setup/presentation/common_widgets/request_card.dart';
import 'package:code_setup/presentation/common_widgets/analytics/request_status_breakdown.dart';
import 'package:code_setup/presentation/common_widgets/analytics/request_trend_breakdown.dart';
import 'package:code_setup/presentation/common_widgets/analytics/stat_summary_data.dart';
import 'package:code_setup/presentation/common_widgets/tab_item.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_notifier.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/select_field_widget.dart';
import 'package:code_setup/presentation/dynamic_form/widget/fields/text_field_widget.dart';
import 'package:code_setup/presentation/models/activity_feed_model.dart';
import 'package:code_setup/presentation/models/allowance_employee.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/area_permission.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/chat_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/allowance_entry.dart';
import 'package:code_setup/presentation/screens/hr_service/models/duty_mission_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/employee_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/position_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/request_data_model.dart';
import 'package:code_setup/presentation/screens/hr_service/request_for_duty_mission_planned/view.dart';
import 'package:code_setup/presentation/screens/hr_service/request_for_duty_mission_planned/widgets/allowance_card.dart';
import 'package:code_setup/presentation/screens/hr_service/request_for_duty_mission_planned/widgets/travel_details_card.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/profileCard.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_awareness_request_data.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_reassign.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/presentation/screens/task_management/models/request_data_model.dart';
import 'package:code_setup/repository/aviation_security_facilitation/airport_entry/domain/domain.dart';
import 'package:code_setup/repository/hr_service/annual_duty_mission/domain/domain.dart';
import 'package:code_setup/repository/hr_service/assignment_decision/domain/domain.dart';
import 'package:code_setup/repository/hr_service/secondment_decision/domain/domain.dart';
import 'package:code_setup/repository/hr_service/temporary_assignment_decision/domain/domain.dart';
import 'package:code_setup/repository/hr_service/service_transfer/domain/domain.dart';
import 'package:code_setup/repository/task_management/assign_a_task_to_employee/domain/domain.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/stat_summary_helper.dart';
import 'package:code_setup/utils/helper/type_checker.dart' hide FileType;
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

part 'widgets/request_for_assign_a_task_to_employee.dart';
part 'controller.dart';
part 'widgets/request_details.dart';
part 'widgets/request_tabs.dart';
// part 'widgets/assign_engineer_dialog.dart';

part 'allowance_summary_page.dart';
part 'travel_details_summary_page.dart';

@RoutePage()
class RequestforDutyMissionUnplannedScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  const RequestforDutyMissionUnplannedScreen({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<RequestforDutyMissionUnplannedScreen> createState() =>
      _RequestforDutyMissionUnplannedScreenState();
}

class _RequestforDutyMissionUnplannedScreenState
    extends ConsumerState<RequestforDutyMissionUnplannedScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController searchController;
  late FocusNode _focusNode;
  late TabController _tabController;

  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    /// ✅ Pass full objects (Service & SubService)
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    /// Search controller
    searchController = TextEditingController(
      text: ref.read(searchQueryProvider),
    );

    _focusNode = FocusNode();

    searchController.addListener(() {
      setState(() {}); // rebuild suffixIcon
    });

    /// Tabs
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_tabController.index != state.tabIndex) {
        _tabController.animateTo(state.tabIndex);
      }
    });

    final active = controller.getActiveApprovalLevel(
      state.requestDetails.approvalDetails ?? [],
    );
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
                          // ProviderScope(
                          //   overrides: [
                          //     dynamicFormProvider.overrideWith(
                          //       (ref) => DynamicFormNotifier(),
                          //     ),
                          //   ],
                          //   child: DynamicForm(
                          //     stepTitles: const [''],
                          //     steps: [controller.missionTransferFields],
                          //     onSubmit: (values) {
                          //       debugPrint('FORM SUBMITTED');
                          //       debugPrint(values.toString());
                          //       // Navigator.pop(context);
                          //     },
                          //     title: 'Mission Transfer Request',
                          //   ),
                          // );
                          KAppX.router.push(
                            RequestforDutyMissionUnplannedRequestRoute(
                              serviceId: widget.service.id ?? 0,
                              subServiceId: widget.subService.id ?? 0,
                              service: widget.service,
                              subService: widget.subService,
                            ),
                          );
                        },
                        child: const Text('Assign New Task'),
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
                            final data = state
                                .assignaTasktoEmployeeRequestDataRequestData;
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
                                      RequestforDutyMissionDetailsRoute(
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
                                state.assignaTasktoEmployeeActionItemsData;
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
                                      RequestforDutyMissionDetailsRoute(
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
