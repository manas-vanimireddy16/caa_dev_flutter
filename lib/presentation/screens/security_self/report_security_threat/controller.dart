part of 'view.dart';

final selectedrequesteventTabProvider = StateProvider<int>((ref) => 0);

// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");

final List<Map<String, dynamic>> dataList = [
  {
    'id': 101,
    'status': 'Approved',
    'Service Type': 'Vehicle Hire',
    'Purpose of Travel': 'Client Meeting in Delhi',
    'Date': '28-10-2025',
    'Approver': 'Operations Manager',
  },
  {
    'id': 102,
    'status': 'Pending',
    'Service Type': 'Hotel Booking',
    'Purpose of Travel': 'Training Workshop',
    'Date': '29-10-2025',
    'Approver': 'HR Head',
  },
  {
    'id': 103,
    'status': 'Rejected',
    'Service Type': 'Flight Ticket',
    'Purpose of Travel': 'Conference in Mumbai',
    'Date': '30-10-2025',
    'Approver': 'Admin Supervisor',
  },
  {
    'id': 104,
    'status': 'Approved',
    'Service Type': 'Local Conveyance',
    'Purpose of Travel': 'Branch Visit',
    'Date': '01-11-2025',
    'Approver': 'Finance Officer',
  },
  {
    'id': 105,
    'status': 'Pending',
    'Service Type': 'Accommodation',
    'Purpose of Travel': 'Annual Conference',
    'Date': '02-11-2025',
    'Approver': 'Admin Executive',
  },
];

final StatusData sampleStatusData = StatusData(
  timePeriod: "October 2025",
  totalRequests: 150,
  approved: 90,
  pending: 40,
  rejected: 20,
  breakdown: [
    ChartData(status: "Approved", count: 90, percentage: 60.0),
    ChartData(status: "Pending", count: 40, percentage: 26.7),
    ChartData(status: "Rejected", count: 20, percentage: 13.3),
  ],
);

final List<ActivitiesFeedData> mockActivities = [
  ActivitiesFeedData(
    id: 1,
    requestNumber: 'REQ-001',
    title: 'Vehicle Maintenance Request',
    status: 'Approved',
    subType: 'Maintenance',
    type: 'Logistics',
    category: 'Vehicle',
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  ActivitiesFeedData(
    id: 2,
    requestNumber: 'REQ-002',
    title: 'Office Supplies Request',
    status: 'Pending',
    subType: 'Procurement',
    type: 'Inventory',
    category: 'Stationery',
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  ActivitiesFeedData(
    id: 3,
    requestNumber: 'REQ-003',
    title: 'IT Equipment Repair',
    status: 'In Progress',
    subType: 'Repair',
    type: 'IT Support',
    category: 'Hardware',
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
];

final requestDeatilsTabSelectedProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);

final _vsProvider =
    StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
      final stateController = _VSController();
      stateController.initState();
      return stateController;
    });

class _ViewState {
  final bool isLoading;
  final String priority;
  final int threatType;
  final String threatOption;
  final List<String> mealPreference;
  final List<String> servicePreference;

  final List<FileUploadItem> selectedFileUrl;
  final List<Map<String, dynamic>> attachments;

  final KPIResponse kpiData;
  final KPIResponse approvalKpiData;

  final List<ActivitiesFeedData> activityFeed;
  final List<RequestData> dashboardMyRequests;
  final List<RequestData> allRequests;

  final StatusBreakdownModel statusBreakdown;
  final TrendBreakdownModel trendData;
  final RequestDetailModel requestDataById;

  final int tabIndex;

  final StatusBreakdownModel approvalStatusBreakdown;
  final TrendBreakdownModel approvalTrendData;
  final List<ThreatRequestDetail> securityThreatRequestData;
  final List<ThreatRequestDetail> securityThreatActionItemsData;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final List<PendingApprovalUser> engineersList;
  final int approvalId;
  final List<String> threatTypes = [
    "Malware Threat",
    "Email Threat",
    "Identity & Access Threat",
    "Application & System Threat",
    "Other's",
  ];

  final String departmentName;

  /// FORM KEY
  final formKey = GlobalKey<FormState>();

  _ViewState({
    required this.isLoading,
    required this.priority,
    required this.threatType,
    required this.mealPreference,
    required this.servicePreference,
    required this.selectedFileUrl,
    required this.attachments,
    required this.kpiData,
    required this.approvalKpiData,
    required this.activityFeed,
    required this.dashboardMyRequests,
    required this.allRequests,
    required this.statusBreakdown,
    required this.trendData,
    required this.requestDataById,
    required this.tabIndex,
    required this.approvalStatusBreakdown,
    required this.approvalTrendData,
    required this.securityThreatRequestData,
    required this.securityThreatActionItemsData,
    required this.requestDetails,
    required this.requestDetailTab,
    required this.threatOption,
    required this.departmentName,
    required this.engineersList,
    required this.approvalId,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        priority: '',
        threatType: 0,
        mealPreference: [],
        servicePreference: [],
        selectedFileUrl: [],
        attachments: [],
        kpiData: KPIResponse(),
        approvalKpiData: KPIResponse(),
        activityFeed: [],
        dashboardMyRequests: [],
        allRequests: [],
        statusBreakdown: StatusBreakdownModel(),
        trendData: TrendBreakdownModel(),
        requestDataById: RequestDetailModel(),
        tabIndex: 0,
        approvalStatusBreakdown: StatusBreakdownModel(),
        approvalTrendData: TrendBreakdownModel(),
        securityThreatRequestData: [],
        securityThreatActionItemsData: [],
        requestDetails: RequestDetailData(),
        requestDetailTab: 0,
        threatOption: '',
        departmentName: '',
        engineersList: [],
        approvalId: 0,
      );

  _ViewState copyWith({
    bool? isLoading,
    int? threatType,
    String? priority,
    List<String>? mealPreference,
    List<String>? servicePreference,
    List<FileUploadItem>? selectedFileUrl,
    List<Map<String, dynamic>>? attachments,
    KPIResponse? kpiData,
    KPIResponse? approvalKpiData,
    List<ActivitiesFeedData>? activityFeed,
    List<RequestData>? dashboardMyRequests,
    List<RequestData>? allRequests,
    StatusBreakdownModel? statusBreakdown,
    TrendBreakdownModel? trendData,
    RequestDetailModel? requestDataById,
    StatusBreakdownModel? approvalStatusBreakdown,
    TrendBreakdownModel? approvalTrendData,
    int? tabIndex,
    List<ThreatRequestDetail>? securityThreatRequestData,
    List<ThreatRequestDetail>? securityThreatActionItemsData,
    RequestDetailData? requestDetails,
    int? requestDetailTab,
    String? threatOption,
    String? departmentName,
    List<PendingApprovalUser>? engineersList,
    int? approvalId,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      threatType: threatType ?? this.threatType,
      priority: priority ?? this.priority,
      mealPreference: mealPreference ?? this.mealPreference,
      servicePreference: servicePreference ?? this.servicePreference,
      selectedFileUrl: selectedFileUrl ?? this.selectedFileUrl,
      attachments: attachments ?? this.attachments,
      kpiData: kpiData ?? this.kpiData,
      approvalKpiData: approvalKpiData ?? this.approvalKpiData,
      activityFeed: activityFeed ?? this.activityFeed,
      dashboardMyRequests: dashboardMyRequests ?? this.dashboardMyRequests,
      allRequests: allRequests ?? this.allRequests,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      trendData: trendData ?? this.trendData,
      requestDataById: requestDataById ?? this.requestDataById,
      tabIndex: tabIndex ?? this.tabIndex,
      approvalStatusBreakdown:
          approvalStatusBreakdown ?? this.approvalStatusBreakdown,
      approvalTrendData: approvalTrendData ?? this.approvalTrendData,
      securityThreatRequestData:
          securityThreatRequestData ?? this.securityThreatRequestData,
      securityThreatActionItemsData:
          securityThreatActionItemsData ?? this.securityThreatActionItemsData,
      requestDetails: requestDetails ?? this.requestDetails,
      requestDetailTab: requestDetailTab ?? this.requestDetailTab,
      threatOption: threatOption ?? this.threatOption,
      departmentName: departmentName ?? this.departmentName,
      engineersList: engineersList ?? this.engineersList,
      approvalId: approvalId ?? this.approvalId,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());

  late TextEditingController contactNumberController;
  late TextEditingController descriptionController;
  late TextEditingController chatController;
  Future<void> initState() async {
    contactNumberController = TextEditingController();
    descriptionController = TextEditingController();
    chatController = TextEditingController();
    fetchDepartmentName();
    fetchKpi();
    fetchStatusBreakdown('monthly');
    fetchTrendBreakDown('2025');
    fetchApprovalStatusBreakdown('monthly');
    fetchApprovalTrendBreakDown('2025');
    fetchApprovalKpi();
    await fetchRequests();
    fetchActionItems();
    // fetchActivityFeed();
    // fetchDashboardMyRequests();
    // fetchAllMyRequests();
    // fetchStatusBreakDown('weekly');
    // fetchTrendBreakDown('2025');
  }

  final securityThreatInstance = SecurityThreatRepoistory();

  void fetchDepartmentName() {
    final selectedRole = KAppX.globalProvider.read(userInfoProvider);
    if (selectedRole != null) {
      state = state.copyWith(
        departmentName: selectedRole.data?.department?.departmentName ?? '',
      );
    }
  }

  Future<void> fetchRequestDetailsById(int id) async {
    try {
      final requests = await securityThreatInstance.getRequestsById(id);
      if (requests != null) {
        state = state.copyWith(requestDetails: requests);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      // optionally handle other errors
      debugPrint(e.toString());
    }
  }

  // Future<void> getRoleDetails() async {
  //   final storage = KAuthCred();
  //   final saved = await storage.getSelectedRole();
  //   if (saved != null) {
  //     state = state.copyWith(currentRoleName: saved.roleName);
  //   }
  // }

  Future<void> fetchKpi() async {
    try {
      final kpis = await securityThreatInstance.getKpiData();

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await securityThreatInstance
          .getStatusBreakdownData(period);
      if (statusBreakdown != null) {
        state = state.copyWith(statusBreakdown: statusBreakdown);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      // optionally handle other errors
      debugPrint(e.toString());
    }
  }

  Future<void> fetchTrendBreakDown(String period) async {
    try {
      final data = await securityThreatInstance.getTrendBreakdownData(period);

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalKpi() async {
    try {
      final kpis = await securityThreatInstance.getApprovalKpiData();

      if (kpis != null) {
        state = state.copyWith(approvalKpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await securityThreatInstance
          .getApprovalStatusBreakdownData(period);
      if (statusBreakdown != null) {
        state = state.copyWith(approvalStatusBreakdown: statusBreakdown);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      // optionally handle other errors
      debugPrint(e.toString());
    }
  }

  Future<void> fetchEngineersList() async {
    try {
      // Clear list only if explicitly refreshing or searching

      final engineersList = await securityThreatInstance.getEngineersList();

      // No merging needed
      state = state.copyWith(engineersList: engineersList);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> fetchApprovalTrendBreakDown(String period) async {
    try {
      final data = await securityThreatInstance.getApprovalTrendBreakdownData(
        period,
      );

      if (data != null) {
        state = state.copyWith(approvalTrendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchRequests({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    try {
      // Clear list only if explicitly refreshing or searching
      if (isRefresh || searchText.isNotEmpty || status.isNotEmpty) {
        state = state.copyWith(securityThreatRequestData: []);
      }

      final requests = await securityThreatInstance.getRequests(
        offset: 0,
        limit: 10,
        searchText: searchText,
        status: status,
      );

      // No merging needed
      state = state.copyWith(securityThreatRequestData: requests);
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
        state = state.copyWith(securityThreatActionItemsData: []);
      }

      final items = await securityThreatInstance.getActionItems(
        offset: 0,
        limit: 10,
        searchText: searchText,
        status: status,
      );

      // No merging needed
      state = state.copyWith(
        securityThreatActionItemsData: items,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  ApprovalDetailModel? getActiveApprovalLevel(List<ApprovalDetailModel> list) {
    if (list.isEmpty) return null;

    // 1️⃣ First try to get lowest level with status "In Progress"
    final inProgress = list
        .where((e) => e.approvalStatus?.toLowerCase() == "in progress")
        .toList();

    if (inProgress.isNotEmpty) {
      inProgress.sort((a, b) => (a.level ?? 999).compareTo(b.level ?? 999));
      return inProgress.first;
    }

    // 2️⃣ If no "In Progress", get lowest "Assigned"
    // final assigned = list
    //     .where((e) => e.approvalStatus?.toLowerCase() == "assigned")
    //     .toList();

    // if (assigned.isNotEmpty) {
    //   assigned.sort((a, b) => (a.level ?? 999).compareTo(b.level ?? 999));
    //   return assigned.first;
    // }

    return null;
  }

  Future<void> showAssignEngineerDialog({
    required int requestId,
    required int approverRoleId,
    // required int? departmentId,
    // required int? sectionId,
  }) async {
    await KAppX.extendedRouter.dialog.showKDialog(
      builder: (_) => AssignEngineerDialog(
        requestId: requestId,
        approverRoleId: approverRoleId,
        // departmentId: departmentId,
        // sectionId: sectionId,
      ),
    );
  }

  Future<void> assignEngineer({
    required int engineerUserId,
    required int approverRoleId,

    String comment = "Assigning engineer",
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client == null) return;
      final userInfo = KAppX.globalProvider.read(rolesProvider);
      final body = {
        "request_id": state.requestDetails.request?.id,
        "engineer_user_id": engineerUserId,
        "approver_role_id": approverRoleId,
        "department_id": userInfo?.departmentId ?? 0,
        "section_id": userInfo?.sectionId ?? 0,
        "comment": comment,
      };

      await securityThreatInstance.onAssignEngineer(body);

      // Refresh details after assigning
      // await fetchRequestDetailsById(state.requestDetails.request?.id ?? 0);
    } catch (e) {
      print("Error assigning engineer: $e");
    }
  }

  bool canUserActOnLevel({
    required ApprovalDetailModel approval,
    required int userId,
    required SelectedUserRole selectedRole,
  }) {
    // Must be the assigned approver
    if (approval.approverUserId != userId) return false;

    // Must match approver role
    if (approval.approverRoleId != selectedRole.roleId) return false;

    if (approval.departmentId != selectedRole.departmentId) return false;

    if (approval.sectionId != selectedRole.sectionId) return false;

    return true;
  }

  ActionButtonsType getActionButtonsType(List<ApprovalDetailModel> approvals) {
    final selectedRole = KAppX.globalProvider.read(rolesProvider);
    final user = KAppX.globalProvider.read(userInfoProvider);

    if (selectedRole == null) return ActionButtonsType.none;

    final int userId = int.parse(user?.data?.id ?? "0");

    // Get active approval level
    final level = getActiveApprovalLevel(approvals);

    if (level == null) return ActionButtonsType.none;

    // Check user permission
    final canAct = canUserActOnLevel(
      approval: level,
      userId: userId,
      selectedRole: selectedRole,
    );

    if (!canAct) return ActionButtonsType.none;

    // ✔ Manager can "Assign + Reject"
    if (level.isManager == true) {
      return ActionButtonsType.assignReject;
    }

    // ✔ Non-manager can "Close + Reject"
    return ActionButtonsType.reassignCloseReject;
  }

  Future<void> onClose(int approverId, int requestId, String status) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      final userData = KAppX.globalProvider.read(userInfoProvider);

      // 2️⃣ Build payload
      final payload = {
        "request_id": requestId,
        "status": status,
        "comment": chatController.text,
        "approval_id": approverId,
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await securityThreatInstance.onClose(payload);
      // await fetchActionItems();
      await fetchRequests();
      KAppX.router.pop();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> onAssignorReject(
    int approverId,
    int requestId,
    String status,
  ) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      final userData = KAppX.globalProvider.read(userInfoProvider);

      // 2️⃣ Build payload
      final payload = {
        "request_id": requestId,
        "engineer_user_id": 1024,
        "approver_role_id": 4, // Optional
        "department_id": 50, // Optional
        "section_id": 99,
        "comment": chatController.text,
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await securityThreatInstance.onClose(payload);
      // await fetchActionItems();
      await fetchRequests();
      KAppX.router.pop();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void downloadThreatForm() {}
  void onThreatTypeChange(int value, String threat) =>
      state = state.copyWith(threatType: value, threatOption: threat);

  void onPriorityChange(String value) =>
      state = state.copyWith(priority: value);
  void onSelectedServicePreference(List<String> value) =>
      state = state.copyWith(servicePreference: value);

  void onUploadFileSuccess(FileUploadItem url) {
    final urls = state.selectedFileUrl;
    urls.add(url);
    state = state.copyWith(selectedFileUrl: urls);
  }

  void onSelectedApprovalId(int value) =>
      state = state.copyWith(approvalId: value);

  void updateRequestTab(int index) {
    state = state.copyWith(requestDetailTab: index);
  }

  void updateTabIndex(int index) {
    state = state.copyWith(tabIndex: index);
  }

  void onRemoveFile(int index) {
    final urls = state.selectedFileUrl;
    urls.removeAt(index);
    state = state.copyWith(selectedFileUrl: urls);
  }

  bool submitSecurityThreatRequest() {
    // 1. Validate all text fields inside the Form
    if (!state.formKey.currentState!.validate()) {
      return false;
    }

    // 2. Accommodation Type
    if (state.threatType == 0) {
      return false;
    }

    // 5. Meal Preference (optional but recommended)
    if (state.mealPreference.isEmpty) {
      return false;
    }

    // 6. Services (optional)
    if (state.servicePreference.isEmpty) {
      return false;
    }

    // 7. Guests Count Validation (controller-based)
    if (contactNumberController.text.isEmpty) {
      return false;
    }

    // 8. Description
    if (descriptionController.text.isEmpty) {
      return false;
    }

    // 9. File Upload (optional)
    if (state.selectedFileUrl.isEmpty) {
      return false;
    }

    return true;
  }

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
  void refreshUI() {
    // triggers rebuild in UI
    state = state.copyWith();
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'doc', 'docx'],
    );

    if (result != null) {
      final newFiles = result.files.map((file) {
        return {
          "file_name": file.name,
          "file_type": file.extension,
          "file_size": file.size,
          "path": file.path,
          "file_url": file.path, // local file location added here
          "description": '', // optional, can be updated later
        };
      }).toList();

      state = state.copyWith(attachments: [...state.attachments, ...newFiles]);
    }
  }

  void removeFile(Map<String, dynamic> file) {
    final updated = List<Map<String, dynamic>>.from(state.attachments)
      ..remove(file);
    state = state.copyWith(attachments: updated);
  }

  // Future<String> sendChat(int id, String message) async {
  //   try {
  //     state = state.copyWith(isLoading: true);

  //     List<dynamic> uploadedFiles = [];

  //     // 🧩 1️⃣ Upload only if not a text message
  //     if (type != 'text') {
  //       debugPrint('📎 Attachment Message: $message');
  //       uploadedFiles = await hotelReservationinstance.uploadAttachments(
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
  //     final resMessage = await hotelReservationinstance.sendChat(
  //       payload,
  //       id,
  //       type,
  //     );

  //     // 🧩 5️⃣ Refresh UI state
  //     await fetchRequestDetailsById(id);

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

  Future<void> sendSecurityThreatRequest() async {
    try {
      state = state.copyWith(isLoading: true);

      final userData = KAppX.globalProvider.read(rolesProvider);

      // Build attachments list
      final List<Map<String, dynamic>> attachments = state.selectedFileUrl
          .map((file) => file.toJson())
          .toList();

      // BUILD FINAL PAYLOAD
      final payload = {
        "req_user_department_id": userData?.departmentId ?? 0,
        "req_user_section_id": userData?.sectionId ?? 0,
        'department': state.departmentName,
        "service_id": 27,
        "sub_service_id": 19,
        "type_of_threat": state.threatType,
        "description": descriptionController.text,
        "contact_number": contactNumberController.text,
        "priority": state.priority,
        "attachments": state.selectedFileUrl,
      };

      debugPrint("✅ Final Payload: $payload");
      print("=====================================");
      print("FINAL PAYLOAD: $payload");
      print("=====================================");

      // SEND REQUEST
      await securityThreatInstance.sendSecurityThreatRequest(payload);
      KAppX.router.pop();
      await fetchRequests();
      await fetchActionItems();
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    // for (var p in state.passengers) {
    //   p.dispose();
    // }
    super.dispose();
  }
}
