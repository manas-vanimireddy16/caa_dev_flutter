part of 'view.dart';

final selectedrequesteventTabProvider = StateProvider<int>((ref) => 0);

// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");

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
  final String permitCategory;
  final String visitorChecks;
  final List<String> servicePreference;

  final List<FileUploadItem> selectedFileUrl;
  final List<Map<String, dynamic>> attachments;

  final KPIResponse kpiData;
  final KPIResponse approvalKpiData;

  final List<ActivitiesFeedData> activityFeed;

  final StatusBreakdownModel statusBreakdown;
  final TrendBreakdownModel trendData;
  final RequestDetailModel requestDataById;

  final int tabIndex;

  final StatusBreakdownModel approvalStatusBreakdown;
  final TrendBreakdownModel approvalTrendData;
  final List<OrganizeSecurityAwarenessRequestData> securityThreatRequestData;
  final List<OrganizeSecurityAwarenessRequestData>
  securityThreatActionItemsData;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final List<PendingApprovalUser> engineersList;
  final int approvalId;
  final String mediaCoverageRequired;
  final String departmentName;
  final String location;
  final String permitType;
  final List<String> selectedpermissionAreas;
  final List<String> acknowledgement;
  final String threatOption;
  final bool isFormValid;
  final bool isButtonDisabled;
  final List<ChatMessageModel> chatById;

  final List<String> threatTypes = [
    "Malware Threat",
    "Email Threat",
    "Identity & Access Threat",
    "Application & System Threat",
    "Other's",
  ];

  final List<String> categoryOfPermitList = [
    "Issuing New Permit",
    "Renewal of Permit",
    "Amending",
    "Replacing lost",
    "Cancelling airport security permits",
  ];
  List<String> locations = [
    "Muscat",
    "Salalah",
    "Marmul",
    "Durum",
    "Sohar",
    "Fuhud",
    "Mukhaizna",
  ];
  final List<AreaPermission> permissionAreas = [
    AreaPermission(
      id: 1,
      name: "VIP building",
      color: Color(0xFFC7B5E8), // light purple
    ),
    AreaPermission(
      id: 2,
      name: "Cargo Building with import and export sections",
      color: Color(0xFFD4EFEF), // light cyan
    ),
    AreaPermission(
      id: 3,
      name: "[ Arrivals Hall ] and Arrivals building",
      color: Color(0xFFFBC8A9), // light peach
    ),
    AreaPermission(
      id: 4,
      name: "[departures Hall ] and departures building",
      color: Color(0xFF4CAF50), // green
    ),
    AreaPermission(
      id: 5,
      name: "Information centre and control tower building",
      color: Color(0xFFFFFF00), // yellow
    ),
    AreaPermission(
      id: 6,
      name:
          "Vehicle, Aircraft building, Aircraft parking area, fire station and fuel filling stations, repair shop",
      color: Color(0xFF2196F3), // blue
    ),
    AreaPermission(
      id: 7,
      name: "Baggage sorting area",
      color: Color(0xFFE1BEE7), // purple
    ),
    AreaPermission(
      id: 8,
      name: "Supply building",
      color: Color(0xFFBDBDBD), // grey
    ),
    AreaPermission(
      id: 9,
      name: "All Civil Airports",
      color: Color(0xFFF44336), // red
    ),
  ];

  /// FORM KEY
  final formKey = GlobalKey<FormState>();

  _ViewState({
    required this.isLoading,
    required this.priority,
    required this.threatType,
    required this.visitorChecks,
    required this.servicePreference,
    required this.selectedFileUrl,
    required this.attachments,
    required this.kpiData,
    required this.approvalKpiData,
    required this.activityFeed,
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
    required this.permitCategory,
    required this.departmentName,
    required this.engineersList,
    required this.approvalId,
    required this.mediaCoverageRequired,
    required this.location,
    required this.permitType,
    required this.selectedpermissionAreas,
    required this.acknowledgement,
    required this.threatOption,
    required this.isFormValid,
    required this.isButtonDisabled,
    required this.chatById,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        priority: '',
        threatType: 0,
        visitorChecks: '',
        servicePreference: [],
        selectedFileUrl: [],
        attachments: [],
        kpiData: KPIResponse(),
        approvalKpiData: KPIResponse(),
        activityFeed: [],
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
        permitCategory: '',
        departmentName: '',
        engineersList: [],
        approvalId: 0,
        mediaCoverageRequired: '',
        location: '',
        permitType: 'Temporary',
        selectedpermissionAreas: [],
        acknowledgement: [],
        threatOption: '',
        isFormValid: false,
        isButtonDisabled: false,
        chatById: [],
      );

  _ViewState copyWith({
    bool? isLoading,
    int? threatType,
    String? priority,
    String? visitorChecks,
    List<String>? servicePreference,
    List<FileUploadItem>? selectedFileUrl,
    List<Map<String, dynamic>>? attachments,
    KPIResponse? kpiData,
    KPIResponse? approvalKpiData,
    List<ActivitiesFeedData>? activityFeed,
    StatusBreakdownModel? statusBreakdown,
    TrendBreakdownModel? trendData,
    RequestDetailModel? requestDataById,
    StatusBreakdownModel? approvalStatusBreakdown,
    TrendBreakdownModel? approvalTrendData,
    int? tabIndex,
    List<OrganizeSecurityAwarenessRequestData>? securityThreatRequestData,
    List<OrganizeSecurityAwarenessRequestData>? securityThreatActionItemsData,
    RequestDetailData? requestDetails,
    int? requestDetailTab,
    String? permitCategory,
    String? departmentName,
    List<PendingApprovalUser>? engineersList,
    int? approvalId,
    String? mediaCoverageRequired,
    String? location,
    String? permitType,
    List<String>? selectedpermissionAreas,
    List<String>? acknowledgement,
    String? threatOption,
    bool? isFormValid,
    bool? isButtonDisabled,
    List<ChatMessageModel>? chatById,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      threatType: threatType ?? this.threatType,
      priority: priority ?? this.priority,
      visitorChecks: visitorChecks ?? this.visitorChecks,
      servicePreference: servicePreference ?? this.servicePreference,
      selectedFileUrl: selectedFileUrl ?? this.selectedFileUrl,
      attachments: attachments ?? this.attachments,
      kpiData: kpiData ?? this.kpiData,
      approvalKpiData: approvalKpiData ?? this.approvalKpiData,
      activityFeed: activityFeed ?? this.activityFeed,
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
      permitCategory: permitCategory ?? this.permitCategory,
      departmentName: departmentName ?? this.departmentName,
      engineersList: engineersList ?? this.engineersList,
      approvalId: approvalId ?? this.approvalId,
      mediaCoverageRequired:
          mediaCoverageRequired ?? this.mediaCoverageRequired,
      location: location ?? this.location,
      permitType: permitType ?? this.permitType,
      selectedpermissionAreas:
          selectedpermissionAreas ?? this.selectedpermissionAreas,
      acknowledgement: acknowledgement ?? this.acknowledgement,
      threatOption: threatOption ?? this.threatOption,
      isFormValid: isFormValid ?? this.isFormValid,
      isButtonDisabled: isButtonDisabled ?? this.isButtonDisabled,
      chatById: chatById ?? this.chatById,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());

  late TextEditingController contactNumberController;
  late TextEditingController nationalityController;
  late TextEditingController descriptionController;
  late TextEditingController chatController;
  late TextEditingController titleController;
  late TextEditingController placeController;
  late TextEditingController dateOfSubmissionController;
  late TextEditingController permitCategoryController;
  late TextEditingController eventTimeController;
  late TextEditingController occupationController;
  late TextEditingController detailsController;
  late TextEditingController durationController;
  late TextEditingController startTimeController;
  late TextEditingController phoneController;
  late TextEditingController dateSubmitController;
  late TextEditingController passportController;
  late TextEditingController dobController;
  late TextEditingController fullNameController;
  void initState() {
    nationalityController = TextEditingController();
    contactNumberController = TextEditingController();
    descriptionController = TextEditingController();
    chatController = TextEditingController();
    titleController = TextEditingController();
    placeController = TextEditingController();
    dateOfSubmissionController = TextEditingController();
    permitCategoryController = TextEditingController();
    eventTimeController = TextEditingController();
    occupationController = TextEditingController();
    detailsController = TextEditingController();
    durationController = TextEditingController();
    startTimeController = TextEditingController();
    phoneController = TextEditingController();
    dateSubmitController = TextEditingController();
    passportController = TextEditingController();
    dobController = TextEditingController();
    fullNameController = TextEditingController();

    phoneController.addListener(_validateForm);
    startTimeController.addListener(_validateForm);
    phoneController.addListener(_validateForm);
    placeController.addListener(_validateForm);
    dobController.addListener(_validateForm);
    passportController.addListener(_validateForm);
    fullNameController.addListener(_validateForm);
    nationalityController.addListener(_validateForm);
    fetchDepartmentName();
    fetchKpi();
    fetchStatusBreakdown('monthly');
    fetchTrendBreakDown('2025');
    fetchApprovalStatusBreakdown('monthly');
    fetchApprovalTrendBreakDown('2025');
    fetchApprovalKpi();
    fetchRequests();
    fetchActionItems();
    // fetchActivityFeed();
    // fetchDashboardMyRequests();
    // fetchAllMyRequests();
    // fetchStatusBreakDown('weekly');
    // fetchTrendBreakDown('2025');
  }

  void _validateForm() {
    final valid = isFormValid();

    if (state.isFormValid != valid) {
      state = state.copyWith(isFormValid: valid);
    }
  }

  bool isFormValid() {
    return durationController.text.trim().isNotEmpty &&
        startTimeController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        passportController.text.trim().isNotEmpty &&
        placeController.text.trim().isNotEmpty &&
        dobController.text.trim().isNotEmpty &&
        nationalityController.text.trim().isNotEmpty &&
        fullNameController.text.trim().isNotEmpty &&
        state.acknowledgement.length == 2 &&
        state.visitorChecks.isNotEmpty &&
        state.permitType.isNotEmpty &&
        state.permitCategory.isNotEmpty;
  }

  final airportEntryInstance = AviationSecurityFacilitationRepoistory();

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
      final requests = await airportEntryInstance.getRequestsById(id);
      if (requests != null) {
        state = state.copyWith(requestDetails: requests);
        fetchChatById(id);
        updateButtonDisabledFromApprovals(requests.approvalDetails ?? []);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      // optionally handle other errors
      debugPrint(e.toString());
    }
  }

  Future<void> fetchChatById(int id) async {
    try {
      final requests = await airportEntryInstance.getchatById(id);
      if (requests != null) {
        state = state.copyWith(chatById: requests);
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
      final kpis = await airportEntryInstance.getKpiData();

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await airportEntryInstance.getStatusBreakdownData(
        period,
      );
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
      final data = await airportEntryInstance.getTrendBreakdownData(period);

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalKpi() async {
    try {
      final kpis = await airportEntryInstance.getApprovalKpiData();

      if (kpis != null) {
        state = state.copyWith(approvalKpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await airportEntryInstance
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

  // Future<void> fetchEngineersList() async {
  //   try {
  //     // Clear list only if explicitly refreshing or searching

  //     final engineersList = await airportEntryInstance
  //         .getEngineersList();

  //     // No merging needed
  //     state = state.copyWith(engineersList: engineersList);
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  Future<void> fetchApprovalTrendBreakDown(String period) async {
    try {
      final data = await airportEntryInstance.getApprovalTrendBreakdownData(
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

      final requests = await airportEntryInstance.getRequests(
        offset: 0,
        limit: 8,
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

      final items = await airportEntryInstance.getActionItems(
        offset: 0,
        limit: 8,
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

  void showAssignEngineerDialog({
    required int requestId,
    required int approverRoleId,
    // required int? departmentId,
    // required int? sectionId,
  }) {
    KAppX.extendedRouter.dialog.showKDialog(
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

      await airportEntryInstance.onAssignEngineer(body);

      // Refresh details after assigning
      // await fetchRequestDetailsById(state.requestDetails.request?.id ?? 0);
    } catch (e) {
      print("Error assigning engineer: $e");
    }
  }

  // String _resolveMessageType() {
  //   // No attachment → text
  //   if (state.attachments.isEmpty) {
  //     return 'text';
  //   }

  //   // Attachment exists → detect file type
  //   final file = state.attachments.first;
  //   final category = getFileTypeFromPath(file.);

  //   return mapCategoryToMessageType(category); // image | file
  // }
  Future<void> sendChatMessage({
    required int serviceId,
    required int subServiceId,
  }) async {
    try {
      String finalType = 'text';

      String? fileUrl;
      String? fileName;
      String? fileType;
      String? fileSize;

      // 1️⃣ If attachment exists → detect type from LOCAL file
      if (state.attachments.isNotEmpty) {
        final localFile = state.attachments.first;

        final category = getFileTypeFromPath(localFile['file_name']);
        finalType = mapCategoryToMessageType(category); // image | file

        debugPrint('📎 Uploading attachment as $finalType');

        // 2️⃣ Upload file
        final List<Map<String, dynamic>> uploadedFiles =
            await airportEntryInstance.uploadAttachments(state.attachments);

        if (uploadedFiles.isEmpty) {
          throw Exception("File upload failed");
        }

        final uploaded = uploadedFiles.first;

        // 3️⃣ SAFE Map access
        fileUrl = uploaded['file_url'];
        fileName = uploaded['file_name'];
        fileType = uploaded['file_type'];
        fileSize = uploaded['file_size']?.toString();
      }

      // 4️⃣ Build payload
      final payload = {
        "request_id": state.requestDetails.request?.id,
        "service_id": serviceId,
        "sub_service_id": subServiceId,
        "message": chatController.text,
        "messageType": finalType,

        // backend-required fields
        "file_url": finalType == 'text' ? null : fileUrl,
        "file_name": finalType == 'text' ? null : fileName,
        "file_type": finalType == 'text' ? null : finalType,
        "file_size": finalType == 'text' ? null : fileSize,
      };

      debugPrint('📤 Chat payload: $payload');

      // 5️⃣ Send chat
      await airportEntryInstance.sendChat(
        payload,
        state.requestDetails.request?.id ?? 0,
      );

      // 6️⃣ Clear state
      chatController.clear();
      state.attachments.clear();
    } catch (e) {
      debugPrint('❌ Failed to send chat: $e');
      rethrow;
    }
  }

  bool canUserActOnLevel({required ApprovalDetailModel approval}) {
    //checking delegate id
    final selectedRole = KAppX.globalProvider.read(rolesProvider);
    final user = KAppX.globalProvider.read(userInfoProvider);

    final int userId = int.parse(user!.data!.id!);

    if (approval.delegateUserId == userId) return true;
    // Must be the assigned approver
    if (approval.approverUserId != userId) return false; //userId

    // Must match approver role
    if (approval.approverRoleId != selectedRole?.roleId)
      return false; //selectedRole.roleId

    if (approval.departmentId != selectedRole?.departmentId)
      return false; //selectedRole.departmentId

    if (approval.sectionId != selectedRole?.sectionId) return false;

    return true;
  }

  ApprovalDetailModel? getActiveApprovalLevel(List<ApprovalDetailModel> list) {
    if (list.isEmpty) return null;

    final inProgress = list
        .where((e) => e.approvalStatus?.toLowerCase() == "in progress")
        .toList();

    if (inProgress.isNotEmpty) {
      inProgress.sort((a, b) => (a.level ?? 999).compareTo(b.level ?? 999));
      if (canUserActOnLevel(approval: inProgress.first)) {
        return inProgress.first;
      }
    }

    final approved = list
        .where((e) => e.approvalStatus?.toLowerCase() == "approved")
        .toList();

    for (final approval in approved) {
      if (canUserActOnLevel(approval: approval)) {
        return approval;
      }
    }

    return null;
  }

  ActionButtonsType getActionButtonsType(List<ApprovalDetailModel> approvals) {
    final level = getActiveApprovalLevel(approvals);
    if (level == null) return ActionButtonsType.none;

    if (!state.isButtonDisabled && !canUserActOnLevel(approval: level)) {
      return ActionButtonsType.none;
    }

    final bool? isManager = level.isManager;
    final int approvalLevel = level.level ?? 0;

    if (isManager == null || approvalLevel == 2) {
      return ActionButtonsType.approveReject;
    }

    if (isManager == true || approvalLevel == 3) {
      return ActionButtonsType.approve;
    }

    if (isManager == false || approvalLevel == 4) {
      return ActionButtonsType.approveReject;
    }

    return ActionButtonsType.none;
  }

  Future<void> onAssignRejectClose(
    int approverId,
    int requestId,
    String status,
  ) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload
      final payload = {
        "request_id": requestId,
        "status": status,
        "comment": chatController.text,
        "approval_id": approverId,
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await airportEntryInstance.onAssignRejectClose(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      await fetchActionItems();
      await fetchRequests();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void updateButtonDisabledFromApprovals(List<ApprovalDetailModel> approvals) {
    final active = getActiveApprovalLevel(approvals);
    if (active?.isAllowed == true) {
    } else {
      state = state.copyWith(isButtonDisabled: true);
      return;
    }
    final shouldDisable = approvals.any(
      (a) =>
          a.approvalStatus?.toLowerCase() == "approved" &&
          canUserActOnLevel(approval: a),
    );

    state = state.copyWith(isButtonDisabled: shouldDisable);
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
      await airportEntryInstance.onAssignRejectClose(payload);
      // await fetchActionItems();
      // await fetchRequests();
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
      await airportEntryInstance.onAssignRejectClose(payload);
      // await fetchActionItems();
      // await fetchRequests();
      KAppX.router.pop();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void downloadThreatForm() {}
  void onPermitCategoryChange(String threat) =>
      state = state.copyWith(permitCategory: threat);

  void onLocationChange(String value) =>
      state = state.copyWith(location: value);
  void onAreaPermissionChange(List<AreaPermission> list) {
    final List<String> permissionAreas = list.map((e) => e.name).toList();
    state = state.copyWith(selectedpermissionAreas: permissionAreas);
    _validateForm();
  }

  void onPermitChange(String value) =>
      state = state.copyWith(permitType: value);
  void onSelectedServicePreference(List<String> value) =>
      state = state.copyWith(servicePreference: value);

  void onUploadFileSuccess(FileUploadItem url) {
    final urls = List<FileUploadItem>.from(state.selectedFileUrl);
    urls.add(url);
    state = state.copyWith(selectedFileUrl: urls);
  }

  void onVisitorCheckChange(String value) {
    state = state.copyWith(visitorChecks: value);
  }

  void onMediaCoverageChange(String value) =>
      state = state.copyWith(mediaCoverageRequired: value);

  void onSelectedApprovalId(int value) =>
      state = state.copyWith(approvalId: value);

  void updateRequestTab(int index) {
    state = state.copyWith(requestDetailTab: index);
  }

  void updateTabIndex(int index) {
    state = state.copyWith(tabIndex: index);
  }

  void onPriorityChange(String value) =>
      state = state.copyWith(priority: value);

  void onSelectedAcknowledgements(List<String> value) =>
      state = state.copyWith(acknowledgement: value);
  void onRemoveFile(int index) {
    final urls = List<FileUploadItem>.from(state.selectedFileUrl);
    urls.removeAt(index);
    state = state.copyWith(selectedFileUrl: urls);
  }

  bool submitSecurityAwarenessRequest() {
    // 1. Validate all text fields inside the Form
    if (!state.formKey.currentState!.validate()) {
      return false;
    }

    // 2. Accommodation Type
    if (titleController.text.isEmpty) {
      return false;
    }

    // 5. Meal Preference (optional but recommended)
    if (dateOfSubmissionController.text.isEmpty) {
      return false;
    }

    // 6. Services (optional)
    if (contactNumberController.text.isEmpty) {
      return false;
    }

    // 7. Guests Count Validation (controller-based)
    // if (eventDateController.text.isEmpty) {
    //   return false;
    // }

    // 8. Description
    if (descriptionController.text.isEmpty) {
      return false;
    }

    // 9. File Upload (optional)
    if (eventTimeController.text.isEmpty) {
      return false;
    }

    if (state.mediaCoverageRequired.isEmpty) {
      return false;
    }

    return true;
  }

  void refreshUI() {
    // triggers rebuild in UI
    state = state.copyWith();
  }

  Future<void> pickFile() async {
    const int maxFileSizeInBytes = 10 * 1024 * 1024; // 5 MB

    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'doc', 'docx'],
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;

    /// ❌ SIZE CHECK
    if (file.size > maxFileSizeInBytes) {
      Fluttertoast.showToast(msg: "File size must be less than 10 MB");
      return;
    }

    final attachment = {
      "file_name": file.name,
      "file_type": file.extension,
      "file_size": file.size,
      "path": file.path,
      "file_url": file.path,
      "description": '',
    };

    /// ✅ ONLY ONE ATTACHMENT
    state = state.copyWith(attachments: [attachment]);
  }

  void removeAttachment() {
    state = state.copyWith(attachments: []);
  }

  void onThreatTypeChange(int value, String threat) =>
      state = state.copyWith(threatType: value, threatOption: threat);

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
  //       uploadedFiles = await airportEntryInstance.uploadAttachments(
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
  //     final resMessage = await airportEntryInstance.sendChat(payload, id, type);

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

  Future<void> submitAwarenessRequest(int serviceId, int subServiceId) async {
    try {
      state = state.copyWith(isLoading: true);

      final userData = KAppX.globalProvider.read(rolesProvider);

      // Build attachments list
      final List<Map<String, dynamic>> attachments = state.selectedFileUrl
          .map((file) => file.toJson())
          .toList();

      // BUILD FINAL PAYLOAD
      final payload = {
        "service_id": serviceId, // e.g. 29
        "sub_service_id": subServiceId, // e.g. 21

        "req_user_department_id": userData?.departmentId ?? 0,
        "req_user_section_id": userData?.sectionId ?? 0,

        "name_full_family_name": fullNameController.text,
        "nationality": nationalityController.text,
        "dob": dobController.text, // yyyy-MM-dd
        "place": placeController.text,
        "passport_id_card_no": passportController.text,

        "category_of_permit": state.permitCategory,
        "date_of_submission": startTimeController.text,
        "phone_number": phoneController.text,
        "location": state.location,
        "type_of_permit": state.permitType,

        "permission_to_required_areas": state.selectedpermissionAreas,

        // List<String>
        "details": detailsController.text,
        "occupation_staff": occupationController.text,

        "temporary_start_time": startTimeController.text,
        "temporary_duration": durationController.text,

        "for_visitor": state.visitorChecks,
      };

      debugPrint("✅ Final Payload: $payload");
      print("=====================================");
      print("FINAL PAYLOAD: $payload");
      print("=====================================");

      // SEND REQUEST
      await airportEntryInstance.sendAirportEntryRequest(payload);
      KAppX.router.pop();

      // fetchKpi();
      // fetchStatusBreakdown('monthly');
      // fetchTrendBreakDown('2025');

      // await fetchRequests();
      // fetchApprovalStatusBreakdown('monthly');
      // fetchApprovalTrendBreakDown('2025');
      // fetchApprovalKpi();
      // await fetchActionItems();
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    // 🔥 Dispose ALL controllers
    titleController.dispose();
    dateOfSubmissionController.dispose();
    contactNumberController.dispose();
    descriptionController.dispose();
    eventTimeController.dispose();

    // Optional
    // eventDateController.dispose();

    super.dispose();
  }
}
