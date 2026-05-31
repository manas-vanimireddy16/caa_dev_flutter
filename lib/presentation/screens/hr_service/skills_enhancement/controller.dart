part of 'view.dart';

final selectedrequesteventTabProvider = StateProvider<int>((ref) => 0);

// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");

final requestDeatilsTabSelectedProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);

// final _vsProvider = StateNotifierProvider.autoDispose
//     .family<
//       _VSController,
//       _ViewState,
//       ({Service service, SubService subService})
//     >((ref, params) {
//       final controller = _VSController(
//         service: params.service,
//         subService: params.subService,
//       );
//       controller.initState();
//       return controller;
//     });
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
  final String selectedPriority;

  final List<FileUploadItem> selectedFileUrl;
  final List<Map<String, dynamic>> attachments;

  final KPIResponse kpiData;
  final KPIResponse approvalKpiData;

  final StatusBreakdownModel statusBreakdown;
  final TrendBreakdownModel trendData;
  final RequestDetailModel requestDataById;

  final int tabIndex;
  final int selectedTab;

  final StatusBreakdownModel approvalStatusBreakdown;
  final TrendBreakdownModel approvalTrendData;
  final List<SkillsEnhancementModel> RequestData;
  final List<SkillsEnhancementModel> ActionItems;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final List<PendingApprovalUser> engineersList;
  final int approvalId;

  final bool isFormValid;
  final bool isButtonDisabled;
  final List<ChatMessageModel> chatById;
  final List<AttachmentModel> attachmentsById;
  final List<Position> positionsList;
  final List<Employee> usersList;
  final String selectedPositionName;
  final EmployeeList? selectedUser;
  final String selectedUserName;
  final String selectedSalaryDetails;

  final int? selectedUserId;
  final List<EmployeeSummary> employeeList;
  final bool isStartDateSelected;

  final String selectedRequestType;
  final List<AllowanceEmployee> allowanceEmployees;
  final List<DepartmentModel> departments;
  final List<Grade> gradeList;
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final List<LocationModel> locations;

  final List<MasterRolesModel> rolesList;
  final List<SelectionDialogItem> selectionItems;

  /// FORM KEY
  final formKey = GlobalKey<FormState>();

  _ViewState({
    required this.isLoading,
    required this.selectedPriority,
    required this.selectedFileUrl,
    required this.attachments,
    required this.kpiData,
    required this.approvalKpiData,
    required this.statusBreakdown,
    required this.trendData,
    required this.requestDataById,
    required this.tabIndex,
    required this.selectedTab,
    required this.approvalStatusBreakdown,
    required this.approvalTrendData,
    required this.RequestData,
    required this.ActionItems,
    required this.requestDetails,
    required this.requestDetailTab,
    required this.engineersList,
    required this.approvalId,
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
    required this.selectedSalaryDetails,
    required this.selectedRequestType,
    required this.allowanceEmployees,
    required this.departments,
    required this.locations,
    required this.attachmentsById,
    required this.rolesList,
    required this.selectionItems,
    required this.gradeList,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        selectedPriority: '',
        selectedFileUrl: [],
        attachments: [],
        kpiData: KPIResponse(),
        approvalKpiData: KPIResponse(),
        statusBreakdown: StatusBreakdownModel(),
        trendData: TrendBreakdownModel(),
        requestDataById: RequestDetailModel(),
        tabIndex: 0,
        selectedTab: 0,
        approvalStatusBreakdown: StatusBreakdownModel(),
        approvalTrendData: TrendBreakdownModel(),
        RequestData: [],
        ActionItems: [],
        requestDetails: RequestDetailData(),
        requestDetailTab: 0,
        engineersList: [],
        approvalId: 0,
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
        selectedSalaryDetails: '',
        selectedRequestType: '',
        allowanceEmployees: [],
        departments: [],
        locations: [],
        attachmentsById: [],
        rolesList: [],
        selectionItems: [],
        gradeList: [],
      );

  _ViewState copyWith({
    bool? isLoading,
    int? threatType,
    String? selectedPriority,
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
    int? selectedTab,
    List<SkillsEnhancementModel>? RequestData,
    List<SkillsEnhancementModel>? ActionItems,
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
    EmployeeList? selectedUser,
    List<EmployeeSummary>? employeeList,
    bool? isStartDateSelected,
    String? selectedSalaryDetails,
    String? selectedRequestType,
    List<AllowanceEmployee>? allowanceEmployees,
    List<DepartmentModel>? departments,
    List<LocationModel>? locations,
    List<AttachmentModel>? attachmentsById,
    List<MasterRolesModel>? rolesList,
    List<SelectionDialogItem>? selectionItems,
    List<Grade>? gradeList,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedFileUrl: selectedFileUrl ?? this.selectedFileUrl,
      attachments: attachments ?? this.attachments,
      kpiData: kpiData ?? this.kpiData,
      approvalKpiData: approvalKpiData ?? this.approvalKpiData,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      trendData: trendData ?? this.trendData,
      requestDataById: requestDataById ?? this.requestDataById,
      tabIndex: tabIndex ?? this.tabIndex,
      selectedTab: selectedTab ?? this.selectedTab,
      approvalStatusBreakdown:
          approvalStatusBreakdown ?? this.approvalStatusBreakdown,
      approvalTrendData: approvalTrendData ?? this.approvalTrendData,
      RequestData: RequestData ?? this.RequestData,
      ActionItems: ActionItems ?? this.ActionItems,
      requestDetails: requestDetails ?? this.requestDetails,
      requestDetailTab: requestDetailTab ?? this.requestDetailTab,
      engineersList: engineersList ?? this.engineersList,
      approvalId: approvalId ?? this.approvalId,
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
      selectedSalaryDetails:
          selectedSalaryDetails ?? this.selectedSalaryDetails,
      selectedRequestType: selectedRequestType ?? this.selectedRequestType,
      allowanceEmployees: allowanceEmployees ?? this.allowanceEmployees,
      departments: departments ?? this.departments,
      locations: locations ?? this.locations,
      attachmentsById: attachmentsById ?? this.attachmentsById,
      rolesList: rolesList ?? this.rolesList,
      selectionItems: selectionItems ?? this.selectionItems,
      gradeList: gradeList ?? this.gradeList,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final Service service;
  final SubService subService;

  _VSController({required this.service, required this.subService})
    : super(_ViewState.init());
  Timer? _searchDebounce;

  late TextEditingController chatController;
  late TextEditingController titleController;
  late TextEditingController searchController;

  void initState() {
    chatController = TextEditingController();
    titleController = TextEditingController();
    searchController = TextEditingController();
    fetchKpi();
    // fetchApprovalKpi();
    // fetchUsers();
    // fetchLocations();
    fetchRequests();
    // fetchActionItems();
    fetchStatusBreakdown('monthly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    // fetchApprovalStatusBreakdown('monthly');
    // fetchApprovalTrendBreakDown(DateTime.now().year.toString());
    // fetchpositionsList();
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
  List<StatSummaryData> requestStatsList(
    String Function(String key) titleForKey,
  ) =>
      StatSummaryHelper.buildStatList(
        state.kpiData.data?.toJson(),
        titleForKey: titleForKey,
      );

  List<StatSummaryData> approverStatsList(
    String Function(String key) titleForKey,
  ) =>
      StatSummaryHelper.buildStatList(
        state.approvalKpiData.data?.toJson(),
        titleForKey: titleForKey,
      );

  List<StatSummaryData> currentStats(String Function(String key) titleForKey) =>
      state.tabIndex == 0
          ? requestStatsList(titleForKey)
          : approverStatsList(titleForKey);
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

  Map<String, String> buildRequestCardData(SkillsEnhancementModel item) {
    final approverMap = resolveApproverMap(item.base.approvalDetails);

    return {
      'Request Id': item.base.id?.toString() ?? '-',
      'status': item.base.status ?? '-',
      'Request By': item.base.createdByUser?.employeeName ?? '-',

      /// ================= EMPLOYEE INFO =================
      'Completion Date': item.completionDate ?? '-',
      'Certification Title': item.certificationTitle ?? '-',
      'Skill Category': item.skillCategory ?? '-',
      'Request Submission Date': item.base.createdAt.toString(),

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

      'Completion Date': request?.completionDate ?? '-',
      'Certification Title': request?.certificationTitle ?? '-',
      'Skill Category': request?.skillCategory ?? '-',
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

  String buildAssignedToLabel(List<ApprovalDetailModel>? approvals) {
    final approverMap = resolveApproverMap(approvals);
    if (approverMap.containsKey('name')) {
      return approverMap['name']!;
    }
    if (approverMap.containsKey('role')) {
      return approverMap['role']!;
    }
    if (approverMap.containsKey('department')) {
      return _buildDepartmentSection(approverMap);
    }
    return 'N/A';
  }

  Future<void> openRequestDetails(
    int id, {
    bool fromActionItems = false,
  }) async {
    updateRequestTab(0);

    await KAppX.router.push(
      SkillsEnhancementDetailsRoute(
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
      fetchStatusBreakdown('weekly'),
      fetchTrendBreakDown(DateTime.now().year.toString()),
    ]);
  }

  void openNewRequestForm() {
    KAppX.router.push(
      SkillsEnhancementNewRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
  }

  final skillsEnhancementInstance = SkillsEnhancementRepository();
  final securityAccessInstance = SecurityAccessRepoistory();

  final assignmentdecisionInstance = AssignmentDecisionRepoistory();
  List<DynamicField> get skillsEnhancementForm => [
    /// -------- CERTIFICATION TITLE --------
    DynamicField(
      name: 'certification_title',
      label: 'Certification Title',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter',
    ),

    /// -------- SKILL CATEGORY --------
    DynamicField(
      name: 'skill_category',
      label: 'Skill Category',
      type: FieldType.select,
      required: true,
      placeholder: 'Select',
      options: [
        DropdownOption(value: 'Technical', label: 'Technical'),
        DropdownOption(value: 'Compliance', label: 'Compliance'),
        DropdownOption(value: 'Management', label: 'Management'),
        DropdownOption(value: 'Safety', label: 'Safety'),
        DropdownOption(value: 'Soft Skills', label: 'Soft Skills'),
      ],
    ),

    /// -------- ISSUING AUTHORITY --------
    DynamicField(
      name: 'issuing_authority',
      label: 'Issuing Authority/Institution',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter',
    ),

    /// -------- COMPLETION DATE --------
    DynamicField(
      name: 'completion_date',
      label: 'Completion Date',
      type: FieldType.date,
      required: true,
      placeholder: 'DD-MM-YYYY',
    ),

    /// -------- SKILL SUMMARY / DESCRIPTION --------
    DynamicField(
      name: 'skill_summary',
      label: 'Description/Summary of Skill',
      type: FieldType.text,
      required: false,
      placeholder: 'Enter',
    ),

    /// -------- ATTACHMENTS --------
    DynamicField(
      name: 'attachments',
      label: 'Attachments',
      type: FieldType.file,
      required: true,
      maxFiles: 5,
      maxFileSizeInMB: 10,
      allowedExtensions: ['doc', 'docx', 'pdf', 'png', 'jpeg', 'jpg'],
    ),
  ];
  Future<void> fetchpositionsList() async {
    try {
      final position = await assignmentdecisionInstance.getPositions();

      if (position != null) {
        state = state.copyWith(positionsList: position);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchUsers() async {
    try {
      final users = await assignmentdecisionInstance.getUsers();

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

  Future<void> fetchRequestDetailsById(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      final requests = await skillsEnhancementInstance.getRequestsById(
        id: id,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      if (requests != null) {
        state = state.copyWith(requestDetails: requests, isLoading: false);

        fetchChatById(id);
        fetchAttachmentsById(id);
        updateButtonDisabledFromApprovals(requests.approvalDetails ?? []);

        /// ✅ CHECK ACTION TYPE HERE
        final actionType = getActionButtonsType(
          requests,
          requests.approvalDetails ?? [],
        );
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      debugPrint(e.toString());
    }
  }

  Future<void> fetchDepartments() async {
    try {
      final departments = await securityAccessInstance.getDepartments();

      if (departments != []) {
        state = state.copyWith(departments: departments);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchChatById(int id) async {
    try {
      final requests = await skillsEnhancementInstance.getchatById(id);
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

  Future<void> fetchAttachmentsById(int id) async {
    try {
      final attachments = await skillsEnhancementInstance.getAttachmentsById(
        id,
      );
      if (attachments != null) {
        state = state.copyWith(attachmentsById: attachments);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      // optionally handle other errors
      debugPrint(e.toString());
    }
  }

  Future<void> fetchLocations() async {
    try {
      final locations = await skillsEnhancementInstance.getLocations();

      if (locations != null) {
        state = state.copyWith(locations: locations.data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchKpi() async {
    state = state.copyWith(isLoading: true);
    try {
      final kpis = await skillsEnhancementInstance.getKpiData(
        service.id ?? 0,
        subService.id ?? 0,
      );

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis, isLoading: false);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchApprovalTrendBreakDown(String period) async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await skillsEnhancementInstance
          .getApprovalTrendBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );

      if (data != null) {
        state = state.copyWith(approvalTrendData: data, isLoading: false);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchApprovalStatusBreakdown(String period) async {
    state = state.copyWith(isLoading: true);
    try {
      final statusBreakdown = await skillsEnhancementInstance
          .getApprovalStatusBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );
      if (statusBreakdown != null) {
        state = state.copyWith(
          approvalStatusBreakdown: statusBreakdown,
          isLoading: false,
        );
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      // optionally handle other errors
      state = state.copyWith(isLoading: false);
      debugPrint(e.toString());
    }
  }

  Future<void> fetchStatusBreakdown(String period) async {
    state = state.copyWith(isLoading: true);
    try {
      final statusBreakdown = await skillsEnhancementInstance
          .getStatusBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );
      if (statusBreakdown != null) {
        state = state.copyWith(
          statusBreakdown: statusBreakdown,
          isLoading: false,
        );
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      // optionally handle other errors
      state = state.copyWith(isLoading: false);
      debugPrint(e.toString());
    }
  }

  Future<void> fetchTrendBreakDown(String period) async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await skillsEnhancementInstance.getTrendBreakdownData(
        period: period,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      if (data != null) {
        state = state.copyWith(trendData: data, isLoading: false);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchApprovalKpi() async {
    state = state.copyWith(isLoading: true);
    try {
      final kpis = await skillsEnhancementInstance.getApprovalKpiData(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      if (kpis != null) {
        state = state.copyWith(approvalKpiData: kpis, isLoading: false);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchRequests({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      // Clear list only if explicitly refreshing or searching
      if (isRefresh || status.isNotEmpty) {
        state = state.copyWith(RequestData: [], isLoading: false);
      }

      final requests = await skillsEnhancementInstance.getRequests(
        offset: 1,
        limit: 8,
        searchText: searchText,
        status: status,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      // No merging needed
      state = state.copyWith(RequestData: requests);
    } catch (e) {
      state = state.copyWith(isLoading: false);
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
      if (isRefresh || status.isNotEmpty) {
        state = state.copyWith(ActionItems: [], isLoading: false);
      }

      final items = await skillsEnhancementInstance.getActionItems(
        offset: 1,
        limit: 8,
        searchText: searchText,
        status: status,

        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      // No merging needed
      state = state.copyWith(ActionItems: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  int? findRoleId() {
    final roles = state.rolesList;

    if (roles == null || roles.isEmpty) {
      debugPrint("⚠️ rolesList is empty or null");
      return null;
    }

    // normalize helper
    bool matches(MasterRolesModel role, String target) {
      return (role.name ?? '').trim().toLowerCase() == target.toLowerCase();
    }

    // 1️⃣ Try Employee Relations Section first

    // 2️⃣ Fallback to Employee
    final employeeRole = roles.where((r) => matches(r, 'employee'));

    if (employeeRole.isNotEmpty) {
      return employeeRole.first.id;
    }

    // 3️⃣ Nothing found
    debugPrint("⚠️ Neither ERS nor Employee role found");
    return null;
  }

  List<SelectionDialogItem> _mapToSelectionItems(
    List<EmployeeSummary> employees,
  ) {
    return employees.map((e) {
      return SelectionDialogItem(
        id: e.userId ?? 0,
        name: e.employeeName ?? '',
        taskCount: e.inProgressCount ?? 0,
      );
    }).toList();
  }

  bool lastApprover(List<ApprovalDetailModel> approvals) {
    if (approvals.isEmpty) return false;

    if (approvals.any(
      (status) =>
          status.approvalStatus?.toLowerCase() == 'pending' ||
          status.approvalStatus?.toLowerCase() == 'rejected',
    )) {
      return false;
    }

    if (approvals
            .where(
              (status) => status.approvalStatus?.toLowerCase() == 'in progress',
            )
            .length ==
        1) {
      return true;
    }

    return false;
  }

  void showApprovalCommentDialog({
    required ApprovalDialogType type,
    required int approverId,
    required int requestId,
  }) {
    // final showDecionNumber = lastApprover(
    //   state.requestDetails.approvalDetails ?? [],
    // );
    KAppX.extendedRouter.dialog.showKDialog(
      builder: (_) => ApprovalCommentDialog(
        type: type,
        // showDecisionNumber: showDecionNumber,
        onSubmit: (comment, decisionNo) async {
          final status = type == ApprovalDialogType.approve
              ? ApprovalStatus.approved
              : ApprovalStatus.rejected;

          await onApprove(
            approverId,
            requestId,
            comment.trim(), // always safe
            status.apiValue,
            decisionNo, // ✅ backend-safe string
          );
        },
      ),
    );
  }

  Future<void> sendChatMessage({
    required int serviceId,
    required int subServiceId,
  }) async {
    try {
      final requestId = state.requestDetails.request?.id;
      if (requestId == null) {
        throw Exception("Request ID missing");
      }

      final hasMessage = chatController.text.trim().isNotEmpty;
      final hasAttachment = state.attachments.isNotEmpty;

      String messageType = 'text';

      String? fileUrl;
      String? fileName;
      String? fileType;
      String? fileSize;

      /// 1️⃣ Upload attachment if exists
      if (hasAttachment) {
        final localFile = state.attachments.first;

        final category = getFileTypeFromPath(localFile['file_name']);
        messageType = mapCategoryToMessageType(category); // image | file

        final uploadedFiles = await skillsEnhancementInstance.uploadAttachments(
          state.attachments,
        );

        if (uploadedFiles.isEmpty) {
          throw Exception("File upload failed");
        }

        final uploaded = uploadedFiles.first;

        fileUrl = uploaded['file_url'];
        fileName = uploaded['file_name'];
        fileType = messageType;
        fileSize = uploaded['file_size']?.toString();
      }

      /// ------------------------------------------------------------
      /// CASE 1️⃣ : ONLY ATTACHMENT (NO MESSAGE)
      /// ------------------------------------------------------------
      if (!hasMessage && hasAttachment) {
        final payload = {
          "request_id": requestId,
          "service_id": serviceId,
          "sub_service_id": subServiceId,
          "file_url": fileUrl,
          "file_name": fileName,
          "file_type": fileType,
          "file_size": fileSize,
        };

        debugPrint('📎 Attachment-only payload: $payload');

        await skillsEnhancementInstance.sendAttachment(payload, requestId);
      }

      /// ------------------------------------------------------------
      /// CASE 2️⃣ : CHAT (with OR without attachment)
      /// ------------------------------------------------------------
      if (hasMessage) {
        final payload = {
          "request_id": requestId,
          "service_id": serviceId,
          "sub_service_id": subServiceId,
          "message": chatController.text.trim(),
          "messageType": hasAttachment ? messageType : 'text',
          "file_url": hasAttachment ? fileUrl : null,
          "file_name": hasAttachment ? fileName : null,
          "file_type": hasAttachment ? fileType : null,
          "file_size": hasAttachment ? fileSize : null,
        };

        debugPrint('💬 Chat payload: $payload');

        await skillsEnhancementInstance.sendChat(payload, requestId);
      }
      fetchChatById(requestId);
      fetchAttachmentsById(requestId);

      /// 3️⃣ Clear UI state
      // chatController.clear();
      state.attachments.clear();
    } catch (e, st) {
      debugPrint('❌ Failed to send chat: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  Future<void> onComplete(int approverId, int requestId) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload
      final payload = {
        "request_id": requestId,
        "status": "Completed",
        "comment": '',
        "approval_id": approverId,
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await skillsEnhancementInstance.onApprove(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      fetchActionItems();
      fetchRequests();
      fetchApprovalKpi();
      fetchApprovalStatusBreakdown('monthly');
      fetchApprovalTrendBreakDown(DateTime.now().year.toString());
      fetchStatusBreakdown('monthly');
      fetchTrendBreakDown(DateTime.now().year.toString());
      fetchKpi();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
    return;
  }

  Future<void> onApprove(
    int approverId,
    int requestId,
    String comment,
    String status,
    String? decisionNo,
  ) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload
      final payload = {
        "request_id": requestId,
        "status": status,
        "comment": comment,
        "approval_id": approverId,
      };
      if (decisionNo != null) {
        payload['decision_number'] = decisionNo;
      }

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await skillsEnhancementInstance.onApprove(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      // if (decisionNo != null) {
      KAppX.router.pop();
      // }
      await fetchActionItems();
      await fetchRequests();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> onSendInProgress(int approverId, int requestId) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload
      final payload = {"request_id": requestId, "status": "In Progress"};

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      // await skillsEnhancementInstance.onSendInProgress(payload);
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

  void showAssignEngineerDialog({
    required BuildContext context,
    required int approverId,
  }) {
    KAppX.extendedRouter.dialog.showKDialog(
      builder: (_) => SelectionDialog(
        config: SelectionDialogConfig(
          title: "Assign to Engineer",
          items: state.selectionItems,
          isLoading: state.selectionItems.isEmpty,
          onItemSelected: (item) async {
            await assignEngineer(
              engineerUserId: item.id,
              approverId: approverId,
            );

            KAppX.router.pop(); // close dialog
            KAppX.router.pop(); // close details
          },
        ),
      ),
    );
  }

  Future<void> assignEngineer({
    required int engineerUserId,
    required int approverId,

    String comment = "Assigning engineer",
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client == null) return;
      final userInfo = KAppX.globalProvider.read(rolesProvider);
      final payload = {
        "request_id": state.requestDetails.request?.id,
        "approval_id": approverId,
        "assigned_to_user_id": engineerUserId,
        "comment": "assigning",
      };
      {}
      print(payload);

      await skillsEnhancementInstance.onAssignEmployee(payload);

      // Refresh details after assigning
      // await fetchRequestDetailsById(state.requestDetails.request?.id ?? 0);
    } catch (e) {
      print("Error assigning engineer: $e");
    }
  }

  bool canUserActOnLevel({required ApprovalDetailModel approval}) {
    final selectedRole = KAppX.globalProvider.read(rolesProvider);
    final user = KAppX.globalProvider.read(userInfoProvider);

    final int userId = int.parse(user!.data!.id!);

    debugPrint('---------------- APPROVAL CHECK ----------------');
    debugPrint('Logged User ID: $userId');
    debugPrint('Delegate User ID: ${approval.delegateUserId}');
    debugPrint('Approver User ID: ${approval.approverUserId}');
    debugPrint('Approver Role ID: ${approval.approverRoleId}');
    debugPrint('Selected Role ID: ${selectedRole?.roleId}');
    debugPrint('Approval Department ID: ${approval.departmentId}');
    debugPrint('User Department ID: ${selectedRole?.departmentId}');
    debugPrint('Approval Section ID: ${approval.sectionId}');
    debugPrint('User Section ID: ${selectedRole?.sectionId}');
    debugPrint('------------------------------------------------');

    /// 1️⃣ Delegate always allowed
    if (approval.delegateUserId == userId) {
      debugPrint('✅ Allowed: User is delegate approver');
      return true;
    }

    /// 2️⃣ Approver user rule
    if (approval.approverUserId != null && approval.approverUserId != userId) {
      debugPrint(
        '❌ Denied: Approver User ID mismatch (${approval.approverUserId} != $userId)',
      );
      return false;
    }

    /// 3️⃣ Role must match
    if (approval.approverRoleId != null &&
        approval.approverRoleId != selectedRole?.roleId) {
      debugPrint(
        '❌ Denied: Role mismatch (${approval.approverRoleId} != ${selectedRole?.roleId})',
      );
      return false;
    }

    /// 4️⃣ Department must match
    if (approval.departmentId != null &&
        approval.departmentId != selectedRole?.departmentId) {
      debugPrint(
        '❌ Denied: Department mismatch (${approval.departmentId} != ${selectedRole?.departmentId})',
      );
      return false;
    }

    /// 5️⃣ Section must match
    if (approval.sectionId != null &&
        approval.sectionId != selectedRole?.sectionId) {
      debugPrint(
        '❌ Denied: Section mismatch (${approval.sectionId} != ${selectedRole?.sectionId})',
      );
      return false;
    }

    debugPrint('✅ Allowed: User can act on this approval level');

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

    if (level != null) {
      debugPrint('this user can approve and reject');
      return ActionButtonsType.approveReject;
    }

    return ActionButtonsType.none;
  }

  void updateButtonDisabledFromApprovals(List<ApprovalDetailModel> approvals) {
    final active = getActiveApprovalLevel(approvals);

    // No active approval → disable
    if (active == null) {
      state = state.copyWith(isButtonDisabled: true);
      return;
    }

    // If active approval is NOT allowed → disable
    if (active.isAllowed != true) {
      state = state.copyWith(isButtonDisabled: true);
      return;
    }

    final status = active.approvalStatus?.toLowerCase();

    // ✅ Disable ONLY if ACTIVE is approved or assigned
    final shouldDisable = status == 'approved' || status == 'assigned';

    state = state.copyWith(isButtonDisabled: shouldDisable);
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

  void onUploadFileSuccess(FileUploadItem url) {
    final urls = List<FileUploadItem>.from(state.selectedFileUrl);
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
    if (index == 0) {
      fetchRequests();
      fetchKpi();
      fetchStatusBreakdown('weekly');
      fetchTrendBreakDown('2026');
    } else {
      fetchActionItems();
      fetchApprovalKpi();
      fetchApprovalStatusBreakdown('weekly');
      fetchApprovalTrendBreakDown('2026');
    }
  }

  void onRemoveFile(int index) {
    final urls = List<FileUploadItem>.from(state.selectedFileUrl);
    urls.removeAt(index);
    state = state.copyWith(selectedFileUrl: urls);
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

  void removeFile(Map<String, dynamic> file) {
    final updated = List<Map<String, dynamic>>.from(state.attachments)
      ..remove(file);
    state = state.copyWith(attachments: updated);
  }

  Future<void> submitSkillsEnhancementRequest(
    int serviceId,
    int subServiceId,
    Map<String, dynamic> values,
  ) async {
    try {
      state = state.copyWith(isLoading: true);

      // Build attachments list
      final List<Map<String, dynamic>> attachments =
          (values['attachments'] as List<FileUploadItem>? ?? [])
              .map((file) => file.toJson())
              .toList();
      debugPrint("✅ Attachments: $attachments");

      /// -------- FINAL PAYLOAD (PAYMENT OF SHIFT ALLOWANCE) --------
      final payload = {
        // ================= SERVICE INFO =================
        "service_id": serviceId,
        "sub_service_id": subServiceId,

        // ================= SKILLS ENHANCEMENT DETAILS =================
        "certification_title": values['certification_title'],
        "skill_category": values['skill_category'],
        "issuing_authority": values['issuing_authority'],
        "completion_date": values['completion_date'], // Format: yyyy-MM-dd
        "skill_summary": values['skill_summary'],
        "description": values['description'],

        // ================= ATTACHMENTS =================
        "attachments": attachments,
      };

      debugPrint("✅ Final Payload: $payload");

      // API CALL
      final response = await skillsEnhancementInstance
          .sendSkillsEnhancementRequest(payload);

      // KAppX.router.pop();
      if (response['status'] == 'success') {
        Future.delayed(Duration(seconds: 1));

        fetchKpi();
        fetchStatusBreakdown('monthly');
        fetchTrendBreakDown(DateTime.now().year.toString());
        fetchApprovalStatusBreakdown('monthly');
        fetchApprovalTrendBreakDown(DateTime.now().year.toString());
        fetchApprovalKpi();
        fetchRequests();
        fetchActionItems();
      }
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
