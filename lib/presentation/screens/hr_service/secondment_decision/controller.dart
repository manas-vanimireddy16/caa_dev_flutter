part of 'view.dart';

final selectedrequesteventTabProvider = StateProvider<int>((ref) => 0);

// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");

final requestDeatilsTabSelectedProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);

final _vsProvider = StateNotifierProvider.autoDispose
    .family<
      _VSController,
      _ViewState,
      ({Service service, SubService subService})
    >((ref, params) {
      final controller = _VSController(
        service: params.service,
        subService: params.subService,
      );
      controller.initState();
      return controller;
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
  final List<AssignmentDecision> secondmentDecisionRequestData;
  final List<AssignmentDecision> assignmentDecisionActionItemsData;
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
  final List<Position> positionsList;
  final List<Employee> usersList;
  final String selectedPositionName;
  final Employee? selectedUser;
  final String selectedUserName;
  final int? selectedUserId;
  final List<EmployeeSummary> employeeList;
  final bool isStartDateSelected;

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
    required this.secondmentDecisionRequestData,
    required this.assignmentDecisionActionItemsData,
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
    required this.positionsList,
    required this.selectedPositionName,
    this.selectedUserId,
    required this.usersList,
    required this.selectedUserName,
    this.selectedUser,
    required this.employeeList,
    required this.isStartDateSelected,
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
        secondmentDecisionRequestData: [],
        assignmentDecisionActionItemsData: [],
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
        positionsList: [],
        selectedPositionName: '',
        selectedUserId: null,
        usersList: [],
        selectedUserName: '',
        selectedUser: null,
        employeeList: [],
        isStartDateSelected: false,
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
    List<AssignmentDecision>? secondmentDecisionRequestData,
    List<AssignmentDecision>? assignmentDecisionActionItemsData,
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
    List<Position>? positionsList,
    String? selectedPositionName,
    int? selectedUserId,
    List<Employee>? usersList,
    String? selectedUserName,
    Employee? selectedUser,
    List<EmployeeSummary>? employeeList,
    bool? isStartDateSelected,
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
      secondmentDecisionRequestData:
          secondmentDecisionRequestData ?? this.secondmentDecisionRequestData,
      assignmentDecisionActionItemsData:
          assignmentDecisionActionItemsData ??
          this.assignmentDecisionActionItemsData,
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
      positionsList: positionsList ?? this.positionsList,
      selectedPositionName: selectedPositionName ?? this.selectedPositionName,
      selectedUserId: selectedUserId ?? this.selectedUserId,
      usersList: usersList ?? this.usersList,
      selectedUserName: selectedUserName ?? this.selectedUserName,
      selectedUser: selectedUser ?? this.selectedUser,
      employeeList: employeeList ?? this.employeeList,
      isStartDateSelected: isStartDateSelected ?? this.isStartDateSelected,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final Service service;
  final SubService subService;

  _VSController({required this.service, required this.subService})
    : super(_ViewState.init());

  late TextEditingController chatController;
  late TextEditingController titleController;
  late TextEditingController fromEntityController;
  late TextEditingController toEntityController;
  late TextEditingController startDateController;
  late TextEditingController empIdController;
  late TextEditingController eventTimeController;
  late TextEditingController occupationController;
  late TextEditingController detailsController;
  late TextEditingController assignmentAllowanceController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController phoneController;
  late TextEditingController dateSubmitController;
  late TextEditingController civilIdCardNumberController;
  late TextEditingController currentJobPositionController;
  late TextEditingController assignedEmployeeController;
  late TextEditingController reasonForRequestController;
  void initState() {
    chatController = TextEditingController();
    titleController = TextEditingController();
    fromEntityController = TextEditingController();
    toEntityController = TextEditingController();
    startDateController = TextEditingController();
    empIdController = TextEditingController();
    eventTimeController = TextEditingController();
    occupationController = TextEditingController();
    detailsController = TextEditingController();
    assignmentAllowanceController = TextEditingController();
    startTimeController = TextEditingController();
    phoneController = TextEditingController();
    dateSubmitController = TextEditingController();
    civilIdCardNumberController = TextEditingController();
    currentJobPositionController = TextEditingController();
    assignedEmployeeController = TextEditingController();
    endTimeController = TextEditingController();
    reasonForRequestController = TextEditingController();

    phoneController.addListener(_validateForm);
    startTimeController.addListener(_validateForm);
    phoneController.addListener(_validateForm);
    fromEntityController.addListener(_validateForm);
    toEntityController.addListener(_validateForm);
    currentJobPositionController.addListener(_validateForm);
    civilIdCardNumberController.addListener(_validateForm);
    assignedEmployeeController.addListener(_validateForm);
    empIdController.addListener(_validateForm);
    endTimeController.addListener(_validateForm);
    reasonForRequestController.addListener(_validateForm);
    // fetchDepartmentName();
    fetchKpi();
    fetchApprovalKpi();
    fetchpositionsList();
    fetchUsers();
    fetchRequests();
    fetchActionItems();
    fetchAssignEmployeesList();
    // fetchActivityFeed();
    // fetchDashboardMyRequests();
    // fetchAllMyRequests();
    fetchStatusBreakdown('monthly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalStatusBreakdown('monthly');
    fetchApprovalTrendBreakDown(DateTime.now().year.toString());
  }

  void _validateForm() {
    final valid = isFormValid();

    if (state.isFormValid != valid) {
      state = state.copyWith(isFormValid: valid);
    }
  }

  bool isFormValid() {
    return assignedEmployeeController.text.isNotEmpty &&
        civilIdCardNumberController.text.isNotEmpty &&
        empIdController.text.isNotEmpty &&
        currentJobPositionController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        assignmentAllowanceController.text.isNotEmpty &&
        fromEntityController.text.isNotEmpty &&
        toEntityController.text.isNotEmpty &&
        state.selectedUserId != null &&
        state.selectedPositionName.isNotEmpty &&
        startTimeController.text.isNotEmpty &&
        endTimeController.text.isNotEmpty &&
        reasonForRequestController.text.isNotEmpty;
  }

  bool get isFormFilled {
    return assignedEmployeeController.text.isNotEmpty &&
        civilIdCardNumberController.text.isNotEmpty &&
        empIdController.text.isNotEmpty &&
        currentJobPositionController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        assignmentAllowanceController.text.isNotEmpty &&
        fromEntityController.text.isNotEmpty &&
        toEntityController.text.isNotEmpty &&
        state.selectedUserId != null &&
        state.selectedPositionName.isNotEmpty &&
        startTimeController.text.isNotEmpty &&
        endTimeController.text.isNotEmpty;
  }

  void updateFormValidity() {
    final formState = state.formKey.currentState;
    if (formState == null) return;

    final valid = formState.validate();
    if (state.isFormValid != valid) {
      state = state.copyWith(isFormValid: valid);
    }
  }

  final secondmentdecisionInstance = SecondmentDecisionReposiroty();

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
      final requests = await secondmentdecisionInstance.getRequestsById(id);
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
      final requests = await secondmentdecisionInstance.getchatById(id);
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
      final kpis = await secondmentdecisionInstance.getKpiData(
        service.id ?? 0,
        subService.id ?? 0,
      );

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalTrendBreakDown(String period) async {
    try {
      final data = await secondmentdecisionInstance
          .getApprovalTrendBreakdownData(period);

      if (data != null) {
        state = state.copyWith(approvalTrendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await secondmentdecisionInstance
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

  Future<void> fetchStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await secondmentdecisionInstance
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
      final data = await secondmentdecisionInstance.getTrendBreakdownData(
        period,
      );

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchpositionsList() async {
    try {
      final position = await secondmentdecisionInstance.getPositions();

      if (position != null) {
        state = state.copyWith(positionsList: position);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchUsers() async {
    try {
      final users = await secondmentdecisionInstance.getUsers();

      state = state.copyWith(usersList: users);
      print('✅ Users fetched: ${users.length}');
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
      print('❌ API ERROR: ${apiError.message}');
    } catch (e, stack) {
      print('❌ UNKNOWN ERROR: $e');
      print(stack);
    }
  }

  Future<void> fetchAssignEmployeesList() async {
    try {
      final user = KAppX.globalProvider.read(rolesProvider);
      final employeeList = await secondmentdecisionInstance.getEmployeeList(
        departmentId: user?.departmentId ?? 0,

        sectionId: user?.sectionId ?? 0,
        roleId: user?.roleName ?? '',
      );

      if (employeeList != null) {
        state = state.copyWith(employeeList: employeeList);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalKpi() async {
    try {
      final kpis = await secondmentdecisionInstance.getApprovalKpiData(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      if (kpis != null) {
        state = state.copyWith(approvalKpiData: kpis);
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
        state = state.copyWith(secondmentDecisionRequestData: []);
      }

      final requests = await secondmentdecisionInstance.getRequests(
        offset: 0,
        limit: 8,
        searchText: searchText,
        status: status,
      );

      // No merging needed
      state = state.copyWith(secondmentDecisionRequestData: requests);
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
        state = state.copyWith(assignmentDecisionActionItemsData: []);
      }

      final items = await secondmentdecisionInstance.getActionItems(
        offset: 0,
        limit: 8,
        searchText: searchText,
        status: status,
      );

      // No merging needed
      state = state.copyWith(
        assignmentDecisionActionItemsData: items,
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
        service: service,
        subService: subService,
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
      final payload = {
        "request_id": state.requestDetails.request?.id,
        "assigned_to_user_id": engineerUserId,
      };
      print(payload);

      await secondmentdecisionInstance.onAssignEmployee(payload);

      // Refresh details after assigning
      // await fetchRequestDetailsById(state.requestDetails.request?.id ?? 0);
    } catch (e) {
      print("Error assigning engineer: $e");
    }
  }

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
            await secondmentdecisionInstance.uploadAttachments(
              state.attachments,
            );

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
      await secondmentdecisionInstance.sendChat(
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

  ApprovalDetailModel? getNextApprovalDetails(List<ApprovalDetailModel> list) {
    // 1️⃣ Prefer IN PROGRESS approval
    for (final a in list) {
      if (a.approvalStatus?.toLowerCase() == 'in progress') {
        return a;
      }
    }

    // 2️⃣ Fallback → highest approved / assigned level
    return getActiveApprovalLevel(list);
  }

  ApprovalDetailModel? getActiveApprovalLevel(List<ApprovalDetailModel> list) {
    ApprovalDetailModel? highestLevelCandidate;

    for (final approval in list) {
      if (!canUserActOnLevel(approval: approval)) continue;

      final status = approval.approvalStatus?.toLowerCase();
      final level = approval.level ?? -1;

      // 1️⃣ IN PROGRESS always wins
      if (status == 'in progress') {
        return approval;
      }

      // 2️⃣ ONLY approved / assigned participate in comparison
      if (status == 'approved' || status == 'assigned') {
        if (highestLevelCandidate == null ||
            level > (highestLevelCandidate.level ?? -1)) {
          highestLevelCandidate = approval;
        }
      }
    }

    return highestLevelCandidate;
  }

  ActionButtonsType getActionButtonsType(
    RequestDetailData? request,
    List<ApprovalDetailModel> approvals,
  ) {
    final selectedRole = KAppX.globalProvider.read(rolesProvider);
    final user = KAppX.globalProvider.read(userInfoProvider);
    print(user?.data?.section?.id);

    if (selectedRole == null) return ActionButtonsType.none;

    final int userId = int.parse(user?.data?.id ?? "0");

    // Get active approval level
    final level = getActiveApprovalLevel(approvals);

    if (level == null) return ActionButtonsType.none;

    // Check user permission
    final canAct = canUserActOnLevel(approval: level);

    if (!canAct) return ActionButtonsType.none;

    if (!state.isButtonDisabled && !canUserActOnLevel(approval: level)) {
      return ActionButtonsType.none;
    }

    final bool? isManager = level.isManager;
    final bool? isPresident = level.isPresident;
    final int approvalLevel = level.level ?? 0;
    final bool ishasReplace = level.isReplace ?? false;

    if (request?.status?.toLowerCase() == 'approved' &&
        (isPresident ?? false) &&
        ishasReplace) {
      return ActionButtonsType.replace;
    }

    if (isPresident == true) {
      return ActionButtonsType.approveReject;
    }
    if (isManager == null || isManager == false) {
      return ActionButtonsType.approve;
    }

    if (isManager == true) {
      return ActionButtonsType.assign;
    }

    return ActionButtonsType.none;
  }

  void showApprovalCommentDialog({
    required ApprovalDialogType type,
    required int approverId,
    required int requestId,
  }) {
    KAppX.extendedRouter.dialog.showKDialog(
      builder: (_) => ApprovalCommentDialog(
        type: type,
        onSubmit: (comment, decisionNo) async {
          if (type == ApprovalDialogType.approve) {
            await onApprove(
              approverId,
              requestId,
              comment, // optional
            );
          } else {
            await onReject(
              approverId,
              requestId,
              comment, // mandatory
            );
          }
        },
      ),
    );
  }

  Future<void> onApprove(int approverId, int requestId, String status) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload
      final payload = {
        "request_id": requestId,
        "status": 'Approved',
        "comment": chatController.text,
        "approval_id": approverId,
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await secondmentdecisionInstance.onApprove(payload);
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

  Future<void> onReject(int approverId, int requestId, String status) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload
      final payload = {
        "request_id": requestId,
        "status": 'Rejected',
        "comment": chatController.text,
        "approval_id": approverId,
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await secondmentdecisionInstance.onReject(payload);
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

  // Future<void> onClose(int approverId, int requestId, String status) async {
  //   try {
  //     state = state.copyWith(isLoading: true);

  //     // 1️⃣ Upload files

  //     // 2️⃣ Build payload
  //     final payload = {
  //       "request_id": requestId,
  //       "status": status,
  //       "comment": chatController.text,
  //       "approval_id": approverId,
  //     };

  //     debugPrint("✅ Final Payload: $payload");

  //     // 3️⃣ Send request
  //     await secondmentdecisionInstance.onAssignRejectClose(payload);
  //     // await fetchActionItems();
  //     // await fetchRequests();
  //     KAppX.router.pop();
  //   } catch (e) {
  //     debugPrint('❌ Error submitting request: $e');
  //   } finally {
  //     state = state.copyWith(isLoading: false);
  //   }
  // }

  // Future<void> onAssignorReject(
  //   int approverId,
  //   int requestId,
  //   String status,
  // ) async {
  //   try {
  //     state = state.copyWith(isLoading: true);

  //     // 1️⃣ Upload files

  //     // 2️⃣ Build payload
  //     final payload = {
  //       "request_id": requestId,
  //       "engineer_user_id": 1024,
  //       "approver_role_id": 4, // Optional
  //       "department_id": 50, // Optional
  //       "section_id": 99,
  //       "comment": chatController.text,
  //     };

  //     debugPrint("✅ Final Payload: $payload");

  //     // 3️⃣ Send request
  //     await secondmentdecisionInstance.onAssignRejectClose(payload);
  //     // await fetchActionItems();
  //     // await fetchRequests();
  //     KAppX.router.pop();
  //   } catch (e) {
  //     debugPrint('❌ Error submitting request: $e');
  //   } finally {
  //     state = state.copyWith(isLoading: false);
  //   }
  // }

  void onPositionChange(String position) =>
      state = state.copyWith(selectedPositionName: position);

  void onUserChange(int userId) {
    final user = state.usersList.firstWhere((e) => e.id == userId);

    state = state.copyWith(
      selectedUserId: user.id,
      selectedUserName: user.employeeName,
    );

    assignedEmployeeController.text = user.employeeName ?? '';
    civilIdCardNumberController.text = user.civilEmployeeId ?? '';
    empIdController.text = user.employeeId ?? '';
    phoneController.text = user.mobile ?? '';
    currentJobPositionController.text = user.position?.name ?? '';
    // Auto-fill text field
    // assignedEmployeeController.text = user.employeeName ?? '';
  }

  /// Form field handlers

  /// End Date enabled/disabled handler
  void updateStartDateSelected(bool value) {
    state = state.copyWith(isStartDateSelected: value);
  }

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
    if (startDateController.text.isEmpty) {
      return false;
    }

    // 6. Services (optional)
    // if (contactNumberController.text.isEmpty) {
    //   return false;
    // }

    // 7. Guests Count Validation (controller-based)
    // if (eventDateController.text.isEmpty) {
    //   return false;
    // }

    // 8. Description
    // if (descriptionController.text.isEmpty) {
    //   return false;
    // }

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
  //       uploadedFiles = await secondmentdecisionInstance.uploadAttachments(
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
  //     final resMessage = await secondmentdecisionInstance.sendChat(payload, id, type);

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
  Future<void> submitSecondmentDecisionRequest(
    int serviceId,
    int subServiceId,
  ) async {
    try {
      state = state.copyWith(isLoading: true);

      final userData = KAppX.globalProvider.read(rolesProvider);

      final List<Map<String, dynamic>> attachments = state.selectedFileUrl
          .map((e) => e.toJson())
          .toList();

      final payload = {
        "service_id": serviceId,
        "sub_service_id": subServiceId,
        "assigned_employee_name": assignedEmployeeController.text.trim(),
        "employee_id": state.selectedUserId,
        "current_job_position": currentJobPositionController.text.trim(),
        "assigned_job_position": state.selectedUserName,
        "civil_id_card_number": civilIdCardNumberController.text.trim(),
        "original_department_id": null,
        "assigned_department_id": null,
        "phone_number": phoneController.text.trim(),
        "start_date": startTimeController.text.trim(),
        "end_date": endTimeController.text.trim(),
        "reason_for_request": reasonForRequestController.text.trim(),
        "from_entity": fromEntityController.text.trim(),
        "to_entity": toEntityController.text.trim(),
        "attachments": attachments,
      };

      debugPrint("✅ Final Payload: $payload");

      // 1️⃣ POST API
      await secondmentdecisionInstance.sendAssignmentDecisionRequest(payload);

      // 2️⃣ Close screen immediately (good UX)
      KAppX.router.pop();

      // 3️⃣ WAIT intentionally (backend consistency / UX)
      await Future.delayed(const Duration(seconds: 3));

      // 4️⃣ Parallel refresh (FAST & CLEAN)
      await Future.wait([
        fetchKpi(),
        fetchStatusBreakdown('monthly'),
        fetchTrendBreakDown('2025'),
        fetchApprovalStatusBreakdown('monthly'),
        fetchApprovalTrendBreakDown('2025'),
        fetchApprovalKpi(),
      ]);

      // 5️⃣ Sequential (if dependent)
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
    // 🔥 Dispose ALL controllers
    titleController.dispose();
    startDateController.dispose();
    eventTimeController.dispose();

    // Optional
    // eventDateController.dispose();

    super.dispose();
  }
}
