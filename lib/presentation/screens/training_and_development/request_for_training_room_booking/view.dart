import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/approval_comment_dialog.dart';
import 'package:code_setup/presentation/common_widgets/chat.dart';
import 'package:code_setup/presentation/common_widgets/common_attachments.dart';
import 'package:code_setup/presentation/common_widgets/common_request_details.dart';
import 'package:code_setup/presentation/common_widgets/common_workflow.dart';
import 'package:code_setup/presentation/common_widgets/requestCard.dart';
import 'package:code_setup/presentation/common_widgets/requestStatusBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/requestTrendBreakdown.dart';
import 'package:code_setup/presentation/common_widgets/statSummaryData.dart';
import 'package:code_setup/presentation/common_widgets/tab_item.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_notifier.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/models/activity_feed_model.dart';
import 'package:code_setup/presentation/models/allowance_employee.dart';
import 'package:code_setup/presentation/models/buttons_enum.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/employee_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/position_model.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/profileCard.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_reassign.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/presentation/screens/training_and_development/models/request_data_model.dart';
import 'package:code_setup/repository/security_access/domain/domain.dart';
import 'package:code_setup/repository/training_and_development/request_for_training_room_booking/domain/domain.dart';
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

part 'widgets/request_for_coverage_new_request.dart';
part 'controller.dart';
part 'widgets/request_details.dart';
part 'widgets/request_tabs.dart';
// part 'widgets/assign_engineer_dialog.dart';

@RoutePage()
class RequestforTrainingRoomBookingScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  const RequestforTrainingRoomBookingScreen({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<RequestforTrainingRoomBookingScreen> createState() =>
      _RequestforTrainingRoomBookingScreenState();
}

class _RequestforTrainingRoomBookingScreenState
    extends ConsumerState<RequestforTrainingRoomBookingScreen>
    with SingleTickerProviderStateMixin {
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

    _focusNode = FocusNode();

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
      // if (_focusNode.hasFocus) {
      //   _focusNode.unfocus();
      // }
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

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: KScaffold(
        backgroundColor: Colors.white,
        // appBar: KAppBar(title: const Text('Report Security Threat ')),
        body: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

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
              monthLabels: state.months,
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
                            controller.openNewRequestForm(context);
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
                      controller: controller.searchController,

                      onChanged: controller.onSearchChanged,

                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        suffixIcon: controller.searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  controller.searchController.clear();
                                  ref.read(searchQueryProvider.notifier).state =
                                      "";
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
                                  .requestForTrainingRoomBookingRequestData;
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
                                    data: controller.buildRequestCardData(item),

                                    onTap: () async {
                                      controller.openRequestDetails(
                                        item.id ?? 0,
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
                              final data = state
                                  .requestForTrainingRoomBookingActionItemsData;
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
                                    data: controller.buildRequestCardData(item),

                                    onTap: () async {
                                      controller.openRequestDetails(
                                        item.id ?? 0,
                                        fromActionItems: true,
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
      ),
    );
  }
}
