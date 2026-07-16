part of 'view.dart';

final selectedrequesteventTabProvider = StateProvider<int>((ref) => 0);

// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");

final requestDeatilsTabSelectedProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);

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
  final String priority;
  final int threatType;
  final String threatOption;
  final List<String> mealPreference;
  final List<String> servicePreference;

  final List<FileUploadItem> selectedFileUrl;
  final List<Map<String, dynamic>> attachments;

  final List<AttachmentModel> attachmentsFromApi;

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
  final List<OrganizeSecurityAwarenessRequestData> requestData;
  final List<OrganizeSecurityAwarenessRequestData> actionItems;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final List<PendingApprovalUser> engineersList;
  final int approvalId;
  final String mediaCoverageRequired;
  final String departmentName;
  final List<MasterRolesModel> rolesList;
  final bool isFormValid;
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

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
    required this.requestData,
    required this.actionItems,
    required this.requestDetails,
    required this.requestDetailTab,
    required this.threatOption,
    required this.departmentName,
    required this.engineersList,
    required this.approvalId,
    required this.mediaCoverageRequired,
    required this.rolesList,
    required this.attachmentsFromApi,
    required this.isFormValid,
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
        requestData: [],
        actionItems: [],
        requestDetails: RequestDetailData(),
        requestDetailTab: 0,
        threatOption: '',
        departmentName: '',
        engineersList: [],
        approvalId: 0,
        mediaCoverageRequired: '',
        rolesList: [],
        attachmentsFromApi: [],
        isFormValid: false,
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
    List<OrganizeSecurityAwarenessRequestData>? requestData,
    List<OrganizeSecurityAwarenessRequestData>? actionItems,
    RequestDetailData? requestDetails,
    int? requestDetailTab,
    String? threatOption,
    String? departmentName,
    List<PendingApprovalUser>? engineersList,
    int? approvalId,
    String? mediaCoverageRequired,
    List<MasterRolesModel>? rolesList,
    List<AttachmentModel>? attachmentsFromApi,
    bool? isFormValid,
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
      requestData: requestData ?? this.requestData,
      actionItems: actionItems ?? this.actionItems,
      requestDetails: requestDetails ?? this.requestDetails,
      requestDetailTab: requestDetailTab ?? this.requestDetailTab,
      threatOption: threatOption ?? this.threatOption,
      departmentName: departmentName ?? this.departmentName,
      engineersList: engineersList ?? this.engineersList,
      approvalId: approvalId ?? this.approvalId,
      mediaCoverageRequired:
          mediaCoverageRequired ?? this.mediaCoverageRequired,
      rolesList: rolesList ?? this.rolesList,
      attachmentsFromApi: attachmentsFromApi ?? this.attachmentsFromApi,
      isFormValid: isFormValid ?? this.isFormValid,
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

  late TextEditingController contactNumberController;
  late TextEditingController descriptionController;
  late TextEditingController chatController;
  late TextEditingController titleController;
  late TextEditingController placeController;
  late TextEditingController dateOfSubmissionController;
  late TextEditingController eventDateController;
  late TextEditingController eventTimeController;
  late TextEditingController approvalComments;
  late TextEditingController searchController;
  int _searchVersion = 0;
  Timer? _searchDebounce;
  void initState() {
    contactNumberController = TextEditingController();
    descriptionController = TextEditingController();
    chatController = TextEditingController();
    titleController = TextEditingController();
    placeController = TextEditingController();
    dateOfSubmissionController = TextEditingController();
    eventDateController = TextEditingController();
    eventTimeController = TextEditingController();
    approvalComments = TextEditingController();
    searchController = TextEditingController();

    titleController.addListener(_validateForm);
    dateOfSubmissionController.addListener(_validateForm);
    contactNumberController.addListener(_validateForm);
    eventDateController.addListener(_validateForm);
    eventTimeController.addListener(_validateForm);

    fetchDepartmentName();
    fetchKpi();
    fetchStatusBreakdown('monthly');
    fetchTrendBreakDown('2025');
    fetchApprovalStatusBreakdown('monthly');
    fetchApprovalTrendBreakDown('2025');
    fetchApprovalKpi();
    fetchRequests();
    fetchActionItems();
    fetchRolesList();
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
      fetchStatusBreakdown(value ?? '');
    } else {
      fetchApprovalStatusBreakdown(value ?? '');
    }
  }

  void onTrendFilterChanged(String? value) {
    if (value == null) return;

    if (state.tabIndex == 0) {
      fetchTrendBreakDown(value);
    } else {
      fetchApprovalTrendBreakDown(value);
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

  Map<String, String> buildRequestCardData(
    OrganizeSecurityAwarenessRequestData item,
  ) {
    final approverMap = resolveApproverMap(item.approvalDetails ?? []);

    return {
      'Request Id': item.id?.toString() ?? '-',
      'status': item.status ?? '-',
      'Request By': item.createdByUser?.employeeName ?? '-',
      // 'Cycle Period': item.cyclePeriod ?? '-',
      'Request Submission Date': item.createdAt.toString() ?? '-',
      // 'Current Contract Start Date': item. ?? '-',
      // 'Current Contract End Date': item.currentContractEndDate ?? '-',
      // 'Requested cancellation Date': item.requestedCancellationDate ?? '-',
      // 'Handover Date': item.handoverDate ?? '-',
      // 'Current Unit Type': item.currentUnitType ?? '-',
      // 'Tasks Related to Projects': item.tasks?.first.toString() ?? '-',
      // 'Quarter': item.quater ?? '-',
      // // 'Year': item.year?.toString() ?? '-',

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

      'Extension Number':
          request?.createdByUser?.extensionNumber.toString() ?? '0',
      'Request Submission Date': request?.createdAt.toString() ?? '-',
      // 'Unit Type': request.currentUnitType ?? '-',
      'Current Contract Start Date': request?.currentContractStartDate ?? '-',
      'Current Contract End Date': request?.currentContractEndDate ?? '-',
      'Requested cancellation Date': request?.requestedCancellationDate ?? '-',
      'Handover Date': request?.handoverDate ?? '-',
      // 'Quarter': request?.quarter ?? 'N/A',
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

  Future<void> openRequestDetails(
    int id, {
    bool fromActionItems = false,
    int initialTabIndex = RequestDetailsTabIndex.requestDetails,
  }) async {
    updateRequestTab(initialTabIndex);

    await KAppX.router.push(
      OrganizeSecurityAwarenessRequestDetailsTabRoute(
        id: id,
        from: fromActionItems ? 'action items' : '',
        service: service,
        subService: subService,
      ),
    );

    await refreshAfterReturn();
  }

  Future<void> refreshAfterReturn() async {
    await Future.wait([
      fetchRequests(),
      fetchKpi(),
      fetchStatusBreakdown('weekly'),
      fetchTrendBreakDown(DateTime.now().year.toString()),
    ]);
  }

  void openNewRequestForm() {
    // fetchbyCycleGoals(cycle: 'Jan-Jun');
    // state = state.copyWith(selectedUsersList: []);
    KAppX.router.push(
      RequestForProjectApprovalNewRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
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

  final organizeSecurityAwarenessInstance =
      OrganizeSecurityAwarenessRepoistory();

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
      final requests = await organizeSecurityAwarenessInstance.getRequestsById(
        id,
      );
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

  Future<void> fetchRolesList() async {
    try {
      final rolesList = await organizeSecurityAwarenessInstance.getRolesList();

      if (rolesList != null) {
        state = state.copyWith(rolesList: rolesList);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  int? findRoleId() {
    if (state.rolesList == null || state.rolesList!.isEmpty) {
      print("⚠️ rolesList is empty or null");
      return null;
    }

    final role = state.rolesList!.firstWhere(
      (role) =>
          (role.name ?? "").trim().toLowerCase() ==
          'security information engineer'.toLowerCase(),
      orElse: () => MasterRolesModel(),
    );

    return role.id;
  }

  Future<void> fetchKpi() async {
    try {
      final kpis = await organizeSecurityAwarenessInstance.getKpiData();

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await organizeSecurityAwarenessInstance
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
      final data = await organizeSecurityAwarenessInstance
          .getTrendBreakdownData(period);

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalKpi() async {
    try {
      final kpis = await organizeSecurityAwarenessInstance.getApprovalKpiData();

      if (kpis != null) {
        state = state.copyWith(approvalKpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await organizeSecurityAwarenessInstance
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
      final id = findRoleId();
      if (id == null) {
        print("⚠️ Cannot call API: Role ID is null");
        return;
      }

      final engineersList = await organizeSecurityAwarenessInstance
          .getEngineersList(id);

      // No merging needed
      state = state.copyWith(engineersList: engineersList);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> fetchApprovalTrendBreakDown(String period) async {
    try {
      final data = await organizeSecurityAwarenessInstance
          .getApprovalTrendBreakdownData(period);

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
        state = state.copyWith(requestData: []);
      }

      final requests = await organizeSecurityAwarenessInstance.getRequests(
        offset: 0,
        limit: 5,
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

      final items = await organizeSecurityAwarenessInstance.getActionItems(
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
  }) async {
    // IMPORTANT: Await the dialog so pop happens AFTER it closes
    await KAppX.extendedRouter.dialog.showKDialog(
      builder: (_) => AssignEngineerDialog(
        requestId: requestId,
        approverRoleId: approverRoleId,
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

      await organizeSecurityAwarenessInstance.onAssignEngineer(body);

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
    print(user?.data?.section?.id);

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
      return ActionButtonsType.assign;
    }

    // ✔ Non-manager can "Close + Reject"
    return ActionButtonsType.assignReject;
  }

  // Future<ActionButtonsType> handleActionButtons(
  //   List<ApprovalDetailModel> approvals,
  // ) async {
  //   final type = getActionButtonsType(approvals);

  //   if (type == ActionButtonsType.assign ||
  //       type == ActionButtonsType.reassignCloseReject) {
  //     // Call the API here (correct place)
  //     await fetchRolesList();
  //   }

  //   return type;
  // }

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
      await organizeSecurityAwarenessInstance.onClose(payload);
      KAppX.router.pop();
      await Future.delayed(Duration(seconds: 3));
      fetchApprovalKpi();
      fetchApprovalStatusBreakdown('monthly');
      fetchApprovalTrendBreakDown('2025');
      await fetchActionItems();
      await fetchRequests();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> onEventChange() async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      final userData = KAppX.globalProvider.read(userInfoProvider);

      // 2️⃣ Build payload
      final payload = {
        "event_date": eventDateController.text,
        "event_time": eventTimeController.text,
        "approve_comments": approvalComments.text,
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await organizeSecurityAwarenessInstance.onEventChange(
        state.requestDetails.request?.id ?? 0,
        payload,
      );
      // await fetchActionItems();
      await fetchRequests();
      // KAppX.router.pop();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // Future<void> onAssignorReject(
  //   int approverId,
  //   int requestId,
  //   String status,
  // ) async {
  //   try {
  //     state = state.copyWith(isLoading: true);

  //     // 1️⃣ Upload files

  //     final userData = KAppX.globalProvider.read(userInfoProvider);

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
  //     await organizeSecurityAwarenessInstance.onClose(payload);
  //     // await fetchActionItems();
  //     await fetchRequests();
  //     KAppX.router.pop();
  //   } catch (e) {
  //     debugPrint('❌ Error submitting request: $e');
  //   } finally {
  //     state = state.copyWith(isLoading: false);
  //   }
  // }

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

  void onMediaCoverageChange(String value) {
    state = state.copyWith(mediaCoverageRequired: value);
    _validateForm();
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
    if (eventDateController.text.isEmpty) {
      return false;
    }

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

  bool isFormValid() {
    return titleController.text.trim().isNotEmpty &&
        dateOfSubmissionController.text.trim().isNotEmpty &&
        contactNumberController.text.trim().isNotEmpty &&
        eventDateController.text.trim().isNotEmpty &&
        eventTimeController.text.trim().isNotEmpty &&
        state.mediaCoverageRequired.trim().isNotEmpty;
  }

  void refreshUI() {
    // triggers rebuild in UI
    state = state.copyWith();
  }

  void fillAssignModeData() {
    // --- Controllers (UI fields) ---
    titleController.text = state.requestDetails.request?.title ?? "";
    contactNumberController.text =
        state.requestDetails.request?.phoneNumber ?? "";
    placeController.text = state.requestDetails.request?.place ?? "";
    descriptionController.text =
        state.requestDetails.request?.description ?? "";
    eventDateController.text = state.requestDetails.request?.eventDate ?? "";
    eventTimeController.text = state.requestDetails.request?.eventTime ?? "";
    dateOfSubmissionController.text =
        state.requestDetails.request?.dateOfSubmission ?? "";

    // --- Update media coverage in state ---
    onMediaCoverageChange(
      state.requestDetails.request?.mediaCoverageRequired ?? '',
    );

    // --- Update any other state variables you have ---
    state = state.copyWith(
      attachmentsFromApi: state.requestDetails.attachments ?? [],
    );
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

  Future<void> submitAwarenessRequest() async {
    try {
      state = state.copyWith(isLoading: true);

      final userData = KAppX.globalProvider.read(rolesProvider);

      // Build attachments list
      final List<Map<String, dynamic>> attachments = state.selectedFileUrl
          .map((file) => file.toJson())
          .toList();

      // BUILD FINAL PAYLOAD
      final payload = {
        "req_user_department_id": userData?.departmentId.toString() ?? 0,
        "req_user_section_id": userData?.sectionId.toString() ?? 0,
        "service_id": 27,
        "sub_service_id": 20,
        "title": titleController.text,
        "date_of_submission": dateOfSubmissionController.text,
        "phone_number": contactNumberController.text,
        "place": placeController.text,
        "description": descriptionController.text,
        "event_date": eventDateController.text,
        "event_time": eventTimeController.text,
        "media_coverage_required": state.mediaCoverageRequired,
        "attachments": state.selectedFileUrl,
      };

      debugPrint("✅ Final Payload: $payload");
      print("=====================================");
      print("FINAL PAYLOAD: $payload");
      print("=====================================");

      // SEND REQUEST

      KAppX.router.pop();
      await Future.delayed(Duration(seconds: 3));
      await organizeSecurityAwarenessInstance.sendSecurityAwarenessRequest(
        payload,
      );
      fetchKpi();
      fetchStatusBreakdown('monthly');
      fetchTrendBreakDown('2025');

      await fetchRequests();
      fetchApprovalStatusBreakdown('monthly');
      fetchApprovalTrendBreakDown('2025');
      fetchApprovalKpi();
      await fetchActionItems();
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    contactNumberController.dispose();
    descriptionController.dispose();
    chatController.dispose();
    titleController.dispose();
    placeController.dispose();
    dateOfSubmissionController.dispose();
    eventDateController.dispose();
    eventTimeController.dispose();
    approvalComments.dispose();
    super.dispose();
  }
}
