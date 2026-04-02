part of 'view.dart';

final selectedrequesteventTabProvider = StateProvider<int>((ref) => 0);

// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");

class _VSControllerParams extends Equatable {
  final Service service;
  final SubService subService;

  const _VSControllerParams({required this.service, required this.subService});

  @override
  List<Object?> get props => [service, subService];
}

final _vsProvider = StateNotifierProvider.autoDispose
    .family<_VSController, _ViewState, _VSControllerParams>((ref, params) {
      final controller = _VSController(
        service: params.service,
        subService: params.subService,
      );
      controller.initState();
      return controller;
    });

class _ViewState {
  final bool isLoading;

  final List<HotelReservationRequestModel> requestData;
  final List<HotelReservationRequestModel> actionItems;
  final RequestDetailData requestDetails;
  final KPIResponse kpiData;
  final KPIResponse approvalKpiData;
  final int tabIndex;
  final TrendBreakdownModel trendData;
  final TrendBreakdownModel approvalTrendData;
  final StatusBreakdownModel statusBreakdown;
  final StatusBreakdownModel approvalStatusBreakdown;
  final int requestDetailTab;
  _ViewState({
    required this.isLoading,
    required this.approvalKpiData,
    required this.requestDetails,
    required this.requestData,
    required this.actionItems,
    required this.kpiData,
    required this.tabIndex,
    required this.trendData,
    required this.approvalTrendData,
    required this.statusBreakdown,
    required this.approvalStatusBreakdown,
    required this.requestDetailTab,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        requestDetails: RequestDetailData(),
        requestData: [],
        actionItems: [],
        kpiData: KPIResponse(),
        approvalKpiData: KPIResponse(),
        tabIndex: 0,
        trendData: TrendBreakdownModel(),
        approvalTrendData: TrendBreakdownModel(),
        statusBreakdown: StatusBreakdownModel(),
        approvalStatusBreakdown: StatusBreakdownModel(),
        requestDetailTab: 0,
      );

  _ViewState copyWith({
    bool? isLoading,
    RequestDetailData? requestDetails,
    List<HotelReservationRequestModel>? requestData,
    List<HotelReservationRequestModel>? actionItems,
    KPIResponse? kpiData,
    KPIResponse? approvalKpiData,
    int? tabIndex,
    TrendBreakdownModel? trendData,
    TrendBreakdownModel? approvalTrendData,
    StatusBreakdownModel? statusBreakdown,
    int? requestDetailTab,
    StatusBreakdownModel? approvalStatusBreakdown,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      requestDetails: requestDetails ?? this.requestDetails,
      requestData: requestData ?? this.requestData,
      actionItems: actionItems ?? this.actionItems,
      kpiData: kpiData ?? this.kpiData,
      approvalKpiData: approvalKpiData ?? this.approvalKpiData,
      tabIndex: tabIndex ?? this.tabIndex,
      trendData: trendData ?? this.trendData,
      approvalTrendData: approvalTrendData ?? this.approvalTrendData,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      approvalStatusBreakdown:
          approvalStatusBreakdown ?? this.approvalStatusBreakdown,
      requestDetailTab: requestDetailTab ?? this.requestDetailTab,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final Service service;
  final SubService subService;
  late final _VSControllerParams params;
  _VSController({required this.service, required this.subService})
    : super(_ViewState.init()) {
    params = _VSControllerParams(service: service, subService: subService);
  }
  late TextEditingController personNameController;
  late TextEditingController contactNumberController;
  late TextEditingController departmentController;
  late TextEditingController emailController;
  late TextEditingController employeeIdController;
  late TextEditingController uniorOrgcontroller;
  late TextEditingController reasonController;
  late TextEditingController descriptionController;
  late TextEditingController vehicleRequiredLocationController;
  late TextEditingController contactNumberForeignController;
  late TextEditingController chatController;
  Timer? _searchDebounce;
  late TextEditingController searchController;

  void initState() {
    personNameController = TextEditingController();
    departmentController = TextEditingController();
    contactNumberController = TextEditingController();
    emailController = TextEditingController();
    reasonController = TextEditingController();
    employeeIdController = TextEditingController();
    uniorOrgcontroller = TextEditingController();
    reasonController = TextEditingController();
    vehicleRequiredLocationController = TextEditingController();
    contactNumberForeignController = TextEditingController();
    descriptionController = TextEditingController();
    chatController = TextEditingController();
    searchController = TextEditingController();
    fetchKpi();
    fetchApprovalKpi();
    fetchRequests();
    fetchActionItems();
  }

  int _searchVersion = 0;

  void onSearchChanged(String value) {
    _searchDebounce?.cancel();
    final int currentVersion = ++_searchVersion;

    _searchDebounce = Timer(const Duration(milliseconds: 400), () async {
      if (state.tabIndex == 0) {
        await fetchRequests(isRefresh: true, searchText: value);
      } else {
        await fetchActionItems(isRefresh: true, searchText: value);
      }

      if (currentVersion != _searchVersion) return; // ignore old response
    });
  }

  int get currentYear => DateTime.now().year;

  List<String> get filterLabelList =>
      List.generate(6, (index) => (currentYear - index).toString());
  List<StatSummaryData> get requestStatsList =>
      StatSummaryHelper.buildStatList(state.kpiData.data?.toJson());

  List<StatSummaryData> get approverStatsList =>
      StatSummaryHelper.buildStatList(state.approvalKpiData.data?.toJson());

  List<StatSummaryData> get currentStats =>
      state.tabIndex == 0 ? requestStatsList : approverStatsList;
  void onStatusFilterChanged(String? value) {
    if (state.tabIndex == 0) {
      // fetchStatusBreakdown(value ?? '');
    } else {
      // fetchApprovalStatusBreakdown(value ?? '');
    }
  }

  void onTrendFilterChanged(String? value) {
    if (value == null) return;

    if (state.tabIndex == 0) {
      // fetchTrendBreakDown(value);
    } else {
      // fetchApprovalTrendBreakDown(value);
    }
  }

  List<int> get trendCounts {
    final data = state.trendData.data?.trendData;
    if (data == null || data.isEmpty) {
      return List.filled(12, 0);
    }

    return data.map((e) => e.count ?? 0).toList();
  }

  List<int> get approvalTrendCounts {
    final data = state.approvalTrendData.data?.trendData;
    if (data == null || data.isEmpty) {
      return List.filled(12, 0);
    }

    return data.map((e) => e.count ?? 0).toList();
  }

  List<ChartData> get statusBreakdownList {
    return state.statusBreakdown.data?.breakdown ?? [];
  }

  List<ChartData> get approvalStatusBreakdownList {
    return state.approvalStatusBreakdown.data?.breakdown ?? [];
  }

  bool _isPendingOrInProgress(String? status) {
    final s = status?.toLowerCase();
    return s == 'in progress';
  }

  bool _isCompleted(String? status) {
    return status?.toLowerCase() == 'completed' ||
        status?.toLowerCase() == 'approved';
  }

  DateTime _parseDate(String? value) {
    try {
      return DateTime.parse(value ?? '');
    } catch (_) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
  }

  Map<String, String> resolveApproverMap(List<ApprovalDetailModel>? approvals) {
    if (approvals == null || approvals.isEmpty) {
      return {};
    }

    /// 1️⃣ NEXT PENDING / IN-PROGRESS (LOWEST LEVEL)
    final pendingList = approvals
        .where((a) => _isPendingOrInProgress(a.approvalStatus))
        .toList();

    if (pendingList.isNotEmpty) {
      pendingList.sort((a, b) => (a.level ?? 0).compareTo(b.level ?? 0));
      final next = pendingList.first;

      /// 🔹 RULE 1: approverId EXISTS → NAME + EMAIL
      if (next.approverRoleId != null) {
        final name = next.approverUser?.employeeName;
        final email = next.approverUser?.email;
        final roleName = next.approverRole?.name;

        if ((name ?? '').isNotEmpty) {
          return {
            'name': name!,
            if ((email ?? '').isNotEmpty) 'email': email!,
            if ((roleName ?? '').isNotEmpty) 'role': roleName!,
          };
        }
      }

      /// 🔹 RULE 2: approverId NULL → DEPARTMENT + SECTION
      final department = next.department?.departmentName;
      final section = next.section?.sectionName;

      if ((department ?? '').isNotEmpty) {
        return {
          'department': department!,
          if ((section ?? '').isNotEmpty) 'section': section!,
        };
      }

      return {};
    }

    /// 2️⃣ ALL COMPLETED → LAST APPROVER (NAME + EMAIL)
    final completedList = approvals
        .where((a) => _isCompleted(a.approvalStatus))
        .toList();

    if (completedList.isEmpty) {
      return {};
    }

    completedList.sort((a, b) {
      final levelCompare = (a.level ?? 0).compareTo(b.level ?? 0);
      if (levelCompare != 0) return levelCompare;
      return _parseDate(a.updatedAt).compareTo(_parseDate(b.updatedAt));
    });

    final last = completedList.last;

    final name =
        last.approvedByUser?.employeeName ?? last.approverUser?.employeeName;

    final email = last.approverUser?.email;

    if ((name ?? '').isNotEmpty) {
      return {'name': name!, if ((email ?? '').isNotEmpty) 'email': email!};
    }

    return {};
  }

  Map<String, String> buildRequestCardData(HotelReservationRequestModel item) {
    final approverMap = resolveApproverMap(item.approvalDetails ?? []);

    return {
      'Request Id': item.id?.toString() ?? '-',
      'status': item.status ?? '-',
      'Request By': item.createdByUser?.employeeName ?? '-',
      // 'Cycle Period': item.cyclePeriod ?? '-',
      'Request Submission Date': item.createdAt?.toString() ?? '-',
      // 'Type of Request': item.typeOfRequest ?? '-',
      // 'Request Classification': item.requestClassification ?? '-',
      // 'Application Name': item.applicationName ?? '-',
      // 'Date of Submission': item.submissionDate.toString() ?? '-',

      /// ================= EMPLOYEE INFO =================

      /// 👇 APPROVER (SINGLE LINE)
      if (approverMap.containsKey('role')) ...{
        'Approver': approverMap['role'] ?? '-',
      } else if (approverMap.containsKey('department')) ...{
        'Approver': _buildDepartmentSection(approverMap),
      },
    };
  }

  Map<String, String> buildRequestInformationData() {
    final request = state.requestDetails.request;
    return {
      /// ───── RIGHT COLUMN ─────
      "Service Type": request?.service?.name ?? 'N/A',

      /// ───── LEFT COLUMN ─────
      "Sub Service Type": request?.subService?.subServiceName ?? 'N/A',
      'Type of Request': request?.typeOfRequest ?? '-',
      'Request Classification': request?.requestClassification ?? '-',
      'Application Name': request?.applicationName ?? '-',
      'Date of Submission': request?.submissionDate.toString() ?? '-',
      'Application URL': request?.applicationUrl ?? '-',
      'IP Address': request?.ipAddress ?? '-',
      'Remarks': request?.remarks ?? '-',
    };
  }

  Map<String, String> buildStatusInformation() {
    final request = state.requestDetails.request;
    final approvals = state.requestDetails.approvalDetails;
    final nextApprover = resolveApproverMap(approvals);
    return {
      "Approval Status": request?.status ?? 'N/A',
      "Requested Date": request?.createdAt ?? 'N/A',
      // "Last Updated":
      //     request?.updatedAt?.split('T').first ?? 'N/A',
      if (nextApprover.containsKey('department'))
        'Department': nextApprover['department']!,
      if (nextApprover.containsKey('section'))
        'Section': nextApprover['section']!,

      if (nextApprover.containsKey('name'))
        'Approver Name': nextApprover['name']!,
      if (nextApprover.containsKey('email'))
        'Approver Email': nextApprover['email']!,
    };
  }

  Map<String, String> buildTechnicalInformation() {
    final request = state.requestDetails.request;
    return {
      'Extension Number':
          request?.createdByUser?.extensionNumber.toString() ?? '0',
    };
  }

  String _buildDepartmentSection(Map<String, String> approverMap) {
    final department = approverMap['department'];
    final section = approverMap['section'];

    if ((department ?? '').isNotEmpty && (section ?? '').isNotEmpty) {
      return '$department - $section';
    }

    return department ?? '-';
  }

  void updateRequestTab(int index) {
    state = state.copyWith(requestDetailTab: index);
  }

  Future<void> openRequestDetails(
    int id, {
    bool fromActionItems = false,
  }) async {
    updateRequestTab(0);

    await KAppX.router.push(
      RequestForInternalAuditDetailsRoute(
        id: id,
        from: fromActionItems ? 'action items' : '',
        service: service,
        subService: subService,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      ),
    );

    await refreshAfterReturn();
  }

  Future<void> refreshAfterReturn() async {
    await Future.wait([
      fetchRequests(),
      fetchKpi(),
      // fetchStatusBreakdown('weekly'),
      // fetchTrendBreakDown(DateTime.now().year.toString()),
    ]);
  }

  void openNewRequestForm() {
    // fetchbyCycleGoals(cycle: 'Jan-Jun');
    // state = state.copyWith(selectedUsersList: []);
    KAppX.router.push(
      RequestForInternalAuditNewRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
  }

  void updateTabIndex(int index) {
    state = state.copyWith(tabIndex: index);
    if (index == 0) {
      fetchRequests();
      fetchKpi();
      // fetchStatusBreakdown('weekly');
      // fetchTrendBreakDown('2026');
    } else {
      // fetchactionItems();
      fetchApprovalKpi();
      // fetchApprovalStatusBreakdown('monthly');
      // fetchApprovalTrendBreakDown('2026');
    }
  }

  final hotelReservationinstance = HotelReservationDashboardRepoistory();

  Future<void> fetchRequests({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    try {
      // Clear list only if explicitly refreshing or searching
      if (isRefresh || searchText.isNotEmpty || status.isNotEmpty) {
        state = state.copyWith(requestData: []);
      }

      final requests = await hotelReservationinstance.getRequests(
        offset: 0,
        limit: 10,
        searchText: searchText,
        status: status,
      );

      // No merging needed
      state = state.copyWith(requestData: requests);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> fetchActionItems({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      if (isRefresh || searchText.isNotEmpty || status.isNotEmpty) {
        state = state.copyWith(actionItems: []);
      }

      final items = await hotelReservationinstance.getActionItems(
        offset: 0,
        limit: 10,
        searchText: searchText,
        status: status,
      );

      // No merging needed
      state = state.copyWith(actionItems: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchApprovalKpi() async {
    try {
      final kpis = await hotelReservationinstance.getApprovalKpiData();

      if (kpis != null) {
        state = state.copyWith(approvalKpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchKpi() async {
    try {
      final kpis = await hotelReservationinstance.getKpiData();

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  // void onSelectFromDate(String date) => state = state.copyWith(fromDate: date);
  // void onSelectTravelTime(String time) =>
  //     state = state.copyWith(travelTime: time);

  // void onSelectedVehicleType(String value) =>
  //     state = state.copyWith(vehicleType: value);

  // void onSelectedTravelTime(String value) =>
  //     state = state.copyWith(travelTime: value);

  // void onSelectedVehicleRequiredFor(String value) =>
  //     state = state.copyWith(vehicleRequiredfor: value);

  // void onSelectedVehicleRequiredLocation(String value) =>
  //     state = state.copyWith(vehicleRequiredLocation: value);

  // void onSelectedPurposeOfTravel(String value) =>
  //     state = state.copyWith(purposeofTravel: value);

  // void onSelectedExpectedDaysInTravel(int value) =>
  //     state = state.copyWith(expectedDaysinTravel: value);

  // void onSelectedExpectedHoursInTravel(int value) =>
  //     state = state.copyWith(expectedHoursinTravel: value);
  // void onSelectTravelTimeUI(String time) =>
  //     state = state.copyWith(travelTimeForUI: time);

  // Future<String> sendChat(int id, String message, String type) async {
  //   try {
  //     state = state.copyWith(isLoading: true);

  //     List<dynamic> uploadedFiles = [];

  //     // 🧩 1️⃣ Upload only if not a text message
  //     if (type != 'text') {
  //       debugPrint('📎 Attachment Message: $message');
  //       uploadedFiles = await logisticsDashboardinstance.uploadAttachments(
  //         state.attachments,
  //       );

  //       // ✅ Safety check: ensure upload success
  //       if (uploadedFiles.isEmpty || uploadedFiles[0]["file_url"] == null) {
  //         throw Exception('File upload failed or returned empty response.');
  //       }
  //     }

  //     // 🧩 2️⃣ Detect image types (png, jpg, jpeg, gif, etc.)

  //     if (type != 'text') {
  //       final uploadedFileType = (uploadedFiles.first["file_type"] ?? '')
  //           .toLowerCase();
  //       if (uploadedFileType.contains('png') ||
  //           uploadedFileType.contains('jpg') ||
  //           uploadedFileType.contains('jpeg') ||
  //           uploadedFileType.contains('gif') ||
  //           uploadedFileType.contains('bmp') ||
  //           uploadedFileType.contains('webp') ||
  //           uploadedFileType.contains('tiff')) {
  //         type = 'image';
  //       } else {
  //         type = uploadedFileType;
  //       }
  //     }

  //     // 🧩 3️⃣ Build payload safely
  //     final payload = {
  //       "request_id": id,
  //       "service_id": 20,
  //       "sub_service_id": 12,
  //       "message": type == 'text'
  //           ? message
  //           : uploadedFiles.first["file_url"], // safe access
  //       "messageType": type,
  //       "file_name": type != 'text' ? uploadedFiles.first["file_name"] : null,
  //       "file_type": type != 'text' ? type : null,
  //       "file_size": type != 'text' ? uploadedFiles.first["file_size"] : null,
  //     };

  //     debugPrint("✅ Final Payload: $payload");

  //     // 🧩 4️⃣ Send request
  //     final resMessage = await logisticsDashboardinstance.sendChat(
  //       payload,
  //       id,
  //       type,
  //     );

  //     // 🧩 5️⃣ Refresh UI state
  //     await fetchRequestsById(id);

  //     chatController.clear();

  //     state = state.copyWith(attachments: []);
  //     // 🧩 6️⃣ Close chat modal or pop page
  //     // KAppX.router.pop();

  //     return resMessage;
  //   } catch (e, stack) {
  //     debugPrint('❌ Error submitting chat: $e');
  //     debugPrint('Stacktrace: $stack');
  //     return 'Not sent';
  //   } finally {
  //     state = state.copyWith(isLoading: false);
  //   }
  // }

  // Future<String> sendAttachment(int id, String message) async {
  //   try {
  //     state = state.copyWith(isLoading: true);

  //     // 2️⃣ Build payload
  //     final payload = {
  //       "request_id": id,
  //       "service_id": 20,
  //       "sub_service_id": 12,
  //       "message": message,
  //       "messageType": "text",
  //       "file_name": null,
  //       "file_type": null,
  //       "file_size": null,
  //     };

  //     debugPrint("✅ Final Payload: $payload");

  //     // 3️⃣ Send request
  //     final resMessage = await logisticsDashboardinstance.sendChat(payload, id);
  //     return resMessage;
  //   } catch (e) {
  //     debugPrint('❌ Error submitting request: $e');
  //     return 'Not sent';
  //   } finally {
  //     state = state.copyWith(isLoading: false);
  //   }
  // }

  // Future<void> vehicleRequest() async {
  //   try {
  //     state = state.copyWith(isLoading: true);

  //     // 1️⃣ Upload files
  //     final uploadedFiles = await logisticsDashboardinstance.uploadAttachments(
  //       state.attachments,
  //     );

  //     final userData = KAppX.globalProvider.read(userProvider);

  //     // 2️⃣ Build payload
  //     final payload = {
  //       "req_user_department_id": userData?.department,
  //       "req_user_section_id": userData?.section,
  //       "service_id": 20,
  //       "sub_service_id": 12,
  //       "category": state.selectedRole,
  //       "vehicle_required_for": state.vehicleRequiredfor,
  //       "vehicle_required_location": state.vehicleRequiredLocation,
  //       "title": eventTypeController.text,
  //       "purpose_of_travel": state.purposeofTravel,
  //       "type_of_vehicle_required": state.vehicleType,
  //       "date_of_travel": state.fromDate,
  //       "time_of_travel": state.travelTime,
  //       "exp_duration_of_use_hrs": state.expectedHoursinTravel,
  //       "exp_duration_of_use_days": state.expectedDaysinTravel,
  //       "type_of_request": 'New Request',
  //       "description": descriptionController.text,
  //       "attachments": uploadedFiles,
  //     };

  //     debugPrint("✅ Final Payload: $payload");
  //     print("✅ Final Payload=============: $payload");

  //     // 3️⃣ Send request
  //     await logisticsDashboardinstance.sendVehicleRequest(payload);
  //     state = state.copyWith(attachments: []);
  //   } catch (e) {
  //     debugPrint('❌ Error submitting request: $e');
  //   } finally {
  //     state = state.copyWith(isLoading: false);
  //   }
  // }

  // // --- Passenger Logic ---

  // void addPassenger() {
  //   final updatedList = [...state.passengers, PassengerUIModel()];
  //   state = state.copyWith(passengers: updatedList);
  // }

  // void removePassenger(int index) {
  //   if (state.passengers.length <= 1) return; // 👈 Prevent deleting last one

  //   final updatedList = [...state.passengers];
  //   updatedList[index].dispose();
  //   updatedList.removeAt(index);
  //   state = state.copyWith(passengers: updatedList);
  // }

  // // Validation check before submission
  // bool validatePassenge0rs(BuildContext context) {
  //   for (var i = 0; i < state.passengers.length; i++) {
  //     if (state.passengers[i].nameController.text.trim().isEmpty) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Please enter name for Passenger ${i + 1}')),
  //       );
  //       return false;
  //     }
  //   }
  //   return true;
  // }

  // List<PassengerModel> getPassengersAsModels() {
  //   return state.passengers
  //       .map((ui) => PassengerModel(name: ui.nameController.text))
  //       .toList();
  // }

  // Future<void> employeeUpdatedFetch() async {
  //   await Future.wait([
  //     // fetchAllMyRequests(),
  //     fetchDashboardMyRequests(),
  //     fetchRequestsById(id)
  //     // fetchKpiEmployee(),
  //     // fetchStatusBreakDown('weekly'),
  //     // fetchTrendBreakDown('2025'),
  //   ]);
  // }

  @override
  void dispose() {
    // for (var p in state.passengers) {
    //   p.dispose();
    // }
    super.dispose();
  }
}
