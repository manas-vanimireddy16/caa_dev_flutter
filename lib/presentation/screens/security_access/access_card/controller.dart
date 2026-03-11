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
  final String date;
  final String toDate;
  final String selectedRequestFor;
  final String requestType;
  final String requestBy;
  final String category;
  final String requestDate;
  final KPIResponse kpiData;
  final List<ActivitiesFeedData> activityFeed;
  final List<AccessCardRequest> actionItems;
  final List<AccessCardRequest> requestsData;
  final KPIResponse approvalKpiData;
  final StatusBreakdownModel approvalStatusBreakdown;
  final TrendBreakdownModel approvalTrendData;
  final StatusBreakdownModel statusBreakdown;
  final TrendBreakdownModel trendData;
  final RequestDetailModel requestDataById;
  final List<FileUploadItem> selectedFileUrl;
  final List<Map<String, dynamic>> attachments;
  final List<DepartmentModel> departments;
  final int departmentId;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final int tabIndex;
  final String currentRoleName;

  _ViewState({
    required this.isLoading,
    required this.date,
    required this.attachments,
    required this.toDate,
    required this.selectedRequestFor,
    required this.category,
    required this.requestDate,
    required this.kpiData,
    required this.activityFeed,
    required this.actionItems,
    required this.statusBreakdown,
    required this.trendData,
    required this.requestDataById,
    required this.requestsData,
    required this.requestType,
    required this.selectedFileUrl,
    required this.requestBy,
    required this.departments,
    required this.departmentId,
    required this.requestDetails,
    required this.requestDetailTab,
    required this.approvalKpiData,
    required this.approvalStatusBreakdown,
    required this.approvalTrendData,
    required this.tabIndex,
    required this.currentRoleName,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        date: '',
        toDate: '',
        selectedRequestFor: 'Self',
        category: '',
        requestDate: '',
        kpiData: KPIResponse(),
        activityFeed: [],
        actionItems: [],
        statusBreakdown: StatusBreakdownModel(),
        trendData: TrendBreakdownModel(),
        requestDataById: RequestDetailModel(),
        requestsData: [],
        requestType: '',
        selectedFileUrl: [],
        requestBy: '',
        attachments: [],
        departments: [],
        departmentId: 0,
        requestDetails: RequestDetailData(),
        requestDetailTab: 0,
        approvalKpiData: KPIResponse(),
        approvalStatusBreakdown: StatusBreakdownModel(),
        approvalTrendData: TrendBreakdownModel(),
        tabIndex: 0,
        currentRoleName: '',
      );

  _ViewState copyWith({
    bool? isLoading,
    String? date,
    String? toDate,
    String? selectedRequestFor,
    String? category,
    String? requestDate,
    KPIResponse? kpiData,
    List<ActivitiesFeedData>? activityFeed,
    List<AccessCardRequest>? actionItems,
    StatusBreakdownModel? statusBreakdown,
    TrendBreakdownModel? trendData,
    RequestDetailModel? requestDataById,
    List<AccessCardRequest>? requestsData,
    String? requestType,
    List<FileUploadItem>? selectedFileUrl,
    String? requestBy,
    List<Map<String, dynamic>>? attachments,
    List<DepartmentModel>? departments,
    int? departmentId,
    RequestDetailData? requestDetails,
    int? requestDetailTab,
    KPIResponse? approvalKpiData,
    StatusBreakdownModel? approvalStatusBreakdown,
    TrendBreakdownModel? approvalTrendData,

    int? tabIndex,
    String? currentRoleName,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      date: date ?? this.date,
      toDate: toDate ?? this.toDate,
      selectedRequestFor: selectedRequestFor ?? this.selectedRequestFor,
      category: category ?? this.category,
      requestDate: requestDate ?? this.requestDate,
      kpiData: kpiData ?? this.kpiData,
      activityFeed: activityFeed ?? this.activityFeed,
      actionItems: actionItems ?? this.actionItems,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      trendData: trendData ?? this.trendData,
      requestDataById: requestDataById ?? this.requestDataById,
      requestsData: requestsData ?? this.requestsData,
      requestType: requestType ?? this.requestType,
      selectedFileUrl: selectedFileUrl ?? this.selectedFileUrl,
      requestBy: requestBy ?? this.requestBy,
      attachments: attachments ?? this.attachments,
      departments: departments ?? this.departments,
      departmentId: departmentId ?? this.departmentId,
      requestDetails: requestDetails ?? this.requestDetails,
      requestDetailTab: requestDetailTab ?? this.requestDetailTab,
      approvalKpiData: approvalKpiData ?? this.approvalKpiData,
      approvalStatusBreakdown:
          approvalStatusBreakdown ?? this.approvalStatusBreakdown,
      approvalTrendData: approvalTrendData ?? this.approvalTrendData,
      tabIndex: tabIndex ?? this.tabIndex,
      currentRoleName: currentRoleName ?? this.currentRoleName,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());
  late TextEditingController personNameController;
  late TextEditingController contactNumberController;
  late TextEditingController departmentController;
  late TextEditingController emailController;
  late TextEditingController employeeIdController;
  late TextEditingController uniorOrgcontroller;
  late TextEditingController reasonController;
  late TextEditingController chatController;
  late TextEditingController accessCardno;

  Future<void> initState() async {
    personNameController = TextEditingController();
    departmentController = TextEditingController();
    contactNumberController = TextEditingController();
    emailController = TextEditingController();
    reasonController = TextEditingController();
    employeeIdController = TextEditingController();
    uniorOrgcontroller = TextEditingController();
    reasonController = TextEditingController();
    chatController = TextEditingController();
    accessCardno = TextEditingController();

    fetchKpi();
    // fetchDashboardMyRequests();
    // fetchAllMyRequests();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown('2025');
    await fetchRequests();
    fetchActionItems();
    getRoleDetails();
  }

  final securityAccessInstance = SecurityAccessRepoistory();
  // Future<void> fetchKpi() async {
  //   try {
  //     final kpis = await logisticsDashboardinstance.getKpiData();

  //     if (kpis != null) {
  //       state = state.copyWith(kpiData: kpis);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {}
  // }

  Future<void> fetchRequestDetailsById(int id) async {
    try {
      final requests = await securityAccessInstance.getRequestsById(id);
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

  Future<void> getRoleDetails() async {
    final storage = KAuthCred();
    final saved = await storage.getSelectedRole();
    if (saved != null) {
      state = state.copyWith(currentRoleName: saved.roleName);
    }
  }

  Future<void> fetchKpi() async {
    try {
      final kpis = await securityAccessInstance.getKpiData();

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await securityAccessInstance
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
      final data = await securityAccessInstance.getTrendBreakdownData(period);

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalKpi() async {
    try {
      final kpis = await securityAccessInstance.getApprovalKpiData();

      if (kpis != null) {
        state = state.copyWith(approvalKpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await securityAccessInstance
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

  Future<void> fetchApprovalTrendBreakDown(String period) async {
    try {
      final data = await securityAccessInstance.getApprovalTrendBreakdownData(
        period,
      );

      if (data != null) {
        state = state.copyWith(approvalTrendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchRequests() async {
    try {
      final requests = await securityAccessInstance.getRequests(
        offset: 0,
        limit: 10,
      );

      if (requests != null) {
        state = state.copyWith(requestsData: requests);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchActionItems() async {
    state = state.copyWith(isLoading: true);

    try {
      final items = await securityAccessInstance.getActionItems(
        offset: 0,
        limit: 10,
      );
      state = state.copyWith(actionItems: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
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
      await securityAccessInstance.onClose(payload);
      await fetchActionItems();
      await fetchRequests();
      KAppX.router.pop();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchDepartments() async {
    try {
      final departments = await securityAccessInstance.getDepartments();

      if (departments != null) {
        state = state.copyWith(departments: departments);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }
  // Future<void> fetchActivityFeed() async {
  //   try {
  //     final activityFeed = await logisticsDashboardinstance.getActivityFeed();

  //     if (activityFeed != null) {
  //       state = state.copyWith(activityFeed: activityFeed);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {}
  // }

  void onUploadFileSuccess(FileUploadItem url) {
    final urls = state.selectedFileUrl;
    urls.add(url);
    state = state.copyWith(selectedFileUrl: urls);
  }

  void updateTabIndex(int index) {
    state = state.copyWith(tabIndex: index);
  }

  void onRemoveFile(int index) {
    final urls = state.selectedFileUrl;
    urls.removeAt(index);
    state = state.copyWith(selectedFileUrl: urls);
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

  bool shouldShowApprovalButtons(List<ApprovalDetailModel> approvals) {
    final selectedRole = KAppX.globalProvider.read(rolesProvider);
    final user = KAppX.globalProvider.read(userInfoProvider);

    if (selectedRole == null) return false;

    final int userId = int.parse(user?.data?.id ?? '0');

    // Get active level (lowest active)
    final level = getActiveApprovalLevel(approvals);
    if (level == null) return false;

    // Only show approval button for "assigned" status
    // if (level.approvalStatus?.toLowerCase() != "assigned") return false;

    // Check user permissions
    if (!canUserActOnLevel(
      approval: level,
      userId: userId,
      selectedRole: selectedRole,
    )) {
      return false;
    }

    return true;
  }

  // void onSelectFromDate(String date) => state = state.copyWith(fromDate: date);
  // void onSelectTravelTime(String time) =>
  //     state = state.copyWith(travelTime: time);
  void onSelectedRole(String role) {
    state = state.copyWith(selectedRequestFor: role);
    personNameController.clear();
    contactNumberController.clear();
    employeeIdController.clear();
    uniorOrgcontroller.clear();
    reasonController.clear();
    accessCardno.clear();
    emailController.clear();

    /// Optional: reset dropdown selections
  }

  void updateRequestTab(int index) {
    state = state.copyWith(requestDetailTab: index);
  }

  void onSelectedRequestType(String role) =>
      state = state.copyWith(requestType: role);
  void onSelectedRequestBy(String requestBy) =>
      state = state.copyWith(requestBy: requestBy);
  void onSelectedCategory(String category) =>
      state = state.copyWith(category: category);
  void updateDepartmentId(int value) {
    state = state.copyWith(departmentId: value);
  }

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

  void onSelectRequestDate(String value) =>
      state = state.copyWith(requestDate: value);
  void removeFile(Map<String, dynamic> file) {
    final updated = List<Map<String, dynamic>>.from(state.attachments)
      ..remove(file);
    state = state.copyWith(attachments: updated);
  }

  Future<void> sendAccessCardRequest() async {
    try {
      state = state.copyWith(isLoading: true);
      const routeMap = {'Employees': 'EMPLOYEE', 'Contractors': 'CONTRACTOR'};

      // 1️⃣ Upload files
      // final uploadedFiles = await securityAccessInstance.uploadAttachments(
      //   state.attachments,
      // );
      final userData = KAppX.globalProvider.read(userInfoProvider);

      List<Map<String, dynamic>> attachments = [];
      for (var file in state.selectedFileUrl) {
        attachments.add(file.toJson()); // ← REAL OBJECT, not string
      }

      // 2️⃣ Build payload
      final payload = {
        "req_user_department_id": userData?.data?.department?.id,
        "req_user_section_id": userData?.data?.section?.id,
        "service_id": 3,
        "sub_service_id": 6,
        "request_for": state.selectedRequestFor,
        "name": (state.selectedRequestFor == 'Self')
            ? userData?.data?.employeeName
            : personNameController.text,
        "id_number": employeeIdController.text,
        "phone_number": (state.selectedRequestFor == 'Self')
            ? userData?.data?.mobile
            : contactNumberController.text,
        "email_id": (state.selectedRequestFor == 'Self')
            ? userData?.data?.email
            : emailController.text,
        "request_type": state.requestType,
        "category": state.category,
        "organization": uniorOrgcontroller.text,
        "access_card_no": accessCardno.text,
        "reason": reasonController.text,
        "request_date": state.requestDate,
        "approval_route": routeMap[state.category] ?? 'CUSTOMER_SERVICE',
        "attachments": attachments,
      };

      debugPrint("✅ Final Payload: $payload");
      print("✅ Final Payload=============: $payload");

      // 3️⃣ Send request
      await securityAccessInstance.sendAccessCardRequest(payload);
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

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

  @override
  void dispose() {
    // for (var p in state.passengers) {
    //   p.dispose();
    // }
    super.dispose();
  }
}
