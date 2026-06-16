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
  final isRequestLoading;
  final isRequestDetailsLoading;

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
  final List<TemporaryDecision> requestData;
  final List<TemporaryDecision> actionItems;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final int approvalId;

  final bool isButtonDisabled;
  final List<ChatMessageModel> chatById;
  final List<AttachmentModel> attachmentsById;
  final List<EmployeeSummary> employeeList;
  final List<MasterRolesModel> rolesList;

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

  /// FORM KEY
  final formKey = GlobalKey<FormState>();

  _ViewState({
    required this.isLoading,
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
    required this.requestData,
    required this.actionItems,
    required this.requestDetails,
    required this.requestDetailTab,
    required this.approvalId,
    required this.isButtonDisabled,
    required this.chatById,
    required this.attachmentsById,
    required this.isRequestLoading,
    required this.isRequestDetailsLoading,
    required this.employeeList,
    required this.rolesList,
  });

  _ViewState.init()
    : this(
        isLoading: false,
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
        requestData: [],
        actionItems: [],
        requestDetails: RequestDetailData(),
        requestDetailTab: 0,
        approvalId: 0,
        isButtonDisabled: false,
        chatById: [],

        attachmentsById: [],
        isRequestLoading: false,
        isRequestDetailsLoading: false,
        employeeList: [],
        rolesList: [],
      );

  _ViewState copyWith({
    bool? isLoading,
    bool? isRequestLoading,
    bool? isRequestDetailsLoading,
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
    List<TemporaryDecision>? requestData,
    List<TemporaryDecision>? actionItems,
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
    List<EmployeeList>? usersList,
    String? selectedUserName,
    EmployeeList? selectedUser,
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
    List<GoalModel>? byCycleGoalsData,
    List<GoalListModel>? goalWeightList,
    List<HrTask>? hrTasks,
    String? hrTaskInput,
    String? hrResponsibilityInput,
    String? hrFrequencyInput,
    String? hrDurationInput,
    ValueGetter<int?>? hrEditingIndex,
    List<EmployeeList>? selectedUsersList,
    List<ResidentalUnitRentalLocationModel>? unitLocations,
    List<SectionModel>? sections,
    List<EmployeeSummary>? employeeList,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      isRequestLoading: isRequestLoading ?? this.isRequestLoading,
      isRequestDetailsLoading:
          isRequestDetailsLoading ?? this.isRequestDetailsLoading,
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
      requestData: requestData ?? this.requestData,
      actionItems: actionItems ?? this.actionItems,
      requestDetails: requestDetails ?? this.requestDetails,
      requestDetailTab: requestDetailTab ?? this.requestDetailTab,
      approvalId: approvalId ?? this.approvalId,
      isButtonDisabled: isButtonDisabled ?? this.isButtonDisabled,
      chatById: chatById ?? this.chatById,
      attachmentsById: attachmentsById ?? this.attachmentsById,
      employeeList: employeeList ?? this.employeeList,
      rolesList: rolesList ?? this.rolesList,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  static const List<String> requestListStatusFilters = [
    '',
    'Approved',
    'Pending',
    'Rejected',
  ];

  String _myRequestsStatusFilter = '';
  String _actionItemsStatusFilter = '';

  String get currentStatusFilter =>
      state.tabIndex == 0 ? _myRequestsStatusFilter : _actionItemsStatusFilter;

  String requestListStatusFilterLabel(String status, DashboardL10n l10n) {
    if (status.isEmpty) {
      return l10n.isArabic ? 'الكل' : 'All';
    }
    return l10n.statusLabel(status);
  }

  void onRequestStatusFilterChanged(String status) {
    final searchText = searchController.text.trim();

    if (state.tabIndex == 0) {
      _myRequestsStatusFilter = status;
      state = state.copyWith();
      fetchRequests(isRefresh: true, searchText: searchText, status: status);
      return;
    }

    _actionItemsStatusFilter = status;
    state = state.copyWith();
    fetchactionItems(isRefresh: true, searchText: searchText, status: status);
  }

  final Service service;
  final SubService subService;
  late final _VSControllerParams params;
  _VSController({required this.service, required this.subService})
    : super(_ViewState.init()) {
    params = _VSControllerParams(service: service, subService: subService);
  }

  Timer? _searchDebounce;

  late TextEditingController chatController;
  late TextEditingController titleController;
  late TextEditingController searchController;

  void initState() {
    chatController = TextEditingController();
    titleController = TextEditingController();
    searchController = TextEditingController();
    fetchKpi();
    fetchApprovalKpi();
    fetchRequests();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());

    // fetchbyCycleGoals(cycle: 'Jan-Jun');
  }

  int _searchVersion = 0;

  void onSearchChanged(String value) {
    _searchDebounce?.cancel();
    final int currentVersion = ++_searchVersion;

    _searchDebounce = Timer(const Duration(milliseconds: 400), () async {
      if (state.tabIndex == 0) {
        await fetchRequests(
          isRefresh: true,
          searchText: value,
          status: _myRequestsStatusFilter,
        );
      } else {
        await fetchactionItems(
          isRefresh: true,
          searchText: value,
          status: _actionItemsStatusFilter,
        );
      }

      if (currentVersion != _searchVersion) return; // ignore old response
    });
  }

  int get currentYear => DateTime.now().year;

  List<String> get filterLabelList =>
      List.generate(6, (index) => (currentYear - index).toString());
  List<StatSummaryData> requestStatsList(
    String Function(String key) titleForKey,
  ) => StatSummaryHelper.buildStatList(
    state.kpiData.data?.toJson(),
    // isSecurityThreat: true,
    titleForKey: titleForKey,
  );

  List<StatSummaryData> approverStatsList(
    String Function(String key) titleForKey,
  ) => StatSummaryHelper.buildStatList(
    state.approvalKpiData.data?.toJson(),
    // isSecurityThreat: true,
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

  Map<String, String> buildRequestCardData(TemporaryDecision item) {
    final approverMap = resolveApproverMap(item.base?.approvalDetails ?? []);

    return {
      'Request Id': item.base?.id?.toString() ?? '-',
      'status': item.base?.status ?? '-',
      'Employee Name': item.employeeName ?? '-',
      'Employee Id Number': item.employeeId ?? '',
      'Shift Start Date': item.shiftStartDate ?? '',
      'Request Type': item.base?.subService?.subServiceName ?? '-',
      'Date': item.base?.createdAt.toString() ?? '',
      // 'Vehicle Number': item.vehicleNumber ?? 'N/A',
      // 'Maintenance Type': item.typeOfMaintenanceRequired ?? 'N/A',
      // 'Request Submission Date': formatDate(
      //   item.base?.createdAt.toString() ?? 'N/A',
      // ),
      // 'Preferred Maintenance Date': formatDate(
      //   item.preferredMaintenanceDate ?? 'N/A',
      // ),

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
      "Employee Name": request?.employeeName ?? 'N/A',
      'Employee Id Number': request?.employeeId ?? 'N/A',
      "Job Title": request?.jobTitle ?? 'N/A',
      "Allowance Value": request?.allowanceValue ?? 'N/A',
      "Shift Start Date":
          formatDate(request?.shiftStartDate.toString()) ?? 'N/A',
      "Description": request?.description ?? 'N/A',

      // 'Salary Payment Source': request.salaryPaymentSource ?? '',
      // 'Vehicle Number': request?.vehicleNumber ?? 'N/A',
      // 'Maintenance Type': request?.typeOfMaintenanceRequired ?? 'N/A',
      // 'Preferred Maintenance Date': formatDate(
      //   request?.preferredMaintenanceDate ?? 'N/A',
      // ),
      // 'Issue Description': request?.issueDescription ?? 'N/A',
    };
  }

  Map<String, String> buildStatusInformation() {
    final request = state.requestDetails.request;
    final approvals = state.requestDetails.approvalDetails;
    final nextApprover = resolveApproverMap(approvals);
    return {
      "Approval Status": request?.status ?? 'N/A',
      "Requested Date": formatDate(request?.createdAt ?? 'N/A'),
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
    fetchRolesList();

    await KAppX.router.push(
      PaymentofShiftAllowanceDetailsRoute(
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
      RequestForVehicleMaintenanceNewRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
  }

  final shiftAllowanceInstance = PaymentofShiftAllowanceRepository();
  final residentalUnitRentalInstance = ResidentalUnitRentalRepository();

  /// ========================= API CALLS =========================

  Future<void> fetchRequestDetailsById(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      final requests = await shiftAllowanceInstance.getRequestsById(
        id: id,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      if (requests != null) {
        state = state.copyWith(requestDetails: requests, isLoading: false);
        // fetchAssignEmployeesList();

        fetchChatById(id);
        fetchAttachmentsById(id);
        updateButtonDisabledFromApprovals(requests.approvalDetails ?? []);

        /// ✅ CHECK ACTION TYPE HERE
        final actionType = getActionButtonsType(
          requests,
          requests.approvalDetails ?? [],
        );
        if (actionType == ActionButtonsType.assignReject) {
          // fetchAssignEmployeesList();
          debugPrint('this user can only approve');
        }
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      debugPrint(e.toString());
    }
  }

  Future<void> fetchChatById(int id) async {
    try {
      final requests = await shiftAllowanceInstance.getchatById(id);
      if (requests != null) {
        final chats = requests.reversed.toList();
        state = state.copyWith(chatById: chats);
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
      final attachments = await shiftAllowanceInstance.getAttachmentsById(id);
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

  Future<void> deleteAttachment(int attachmentId, {int? requestId}) async {
    if (attachmentId == 0) {
      Fluttertoast.showToast(msg: 'Attachment ID missing');
      return;
    }

    try {
      state = state.copyWith(isLoading: true);
      final effectiveRequestId = requestId ?? state.requestDetails.request?.id;
      await shiftAllowanceInstance.deleteAttachment(
        attachmentId,
        requestId: effectiveRequestId,
      );

      final updatedAttachments = state.attachmentsById
          .where((attachment) => attachment.id != attachmentId)
          .toList();
      state = state.copyWith(attachmentsById: updatedAttachments);

      if (effectiveRequestId != null && effectiveRequestId != 0) {
        await fetchAttachmentsById(effectiveRequestId);
        await fetchRequestDetailsById(effectiveRequestId);
      }
    } catch (e, st) {
      debugPrint('Failed to delete attachment: $e');
      debugPrintStack(stackTrace: st);
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchKpi() async {
    state = state.copyWith(isLoading: true);
    try {
      final kpis = await shiftAllowanceInstance.getKpiData(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
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
      final data = await shiftAllowanceInstance.getApprovalTrendBreakdownData(
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
      final statusBreakdown = await shiftAllowanceInstance
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
      final statusBreakdown = await shiftAllowanceInstance
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

  Future<void> fetchAssignEmployeesList() async {
    try {
      final id = findRoleId();
      final user = KAppX.globalProvider.read(rolesProvider);
      final employeeList = await shiftAllowanceInstance.getEmployeeList(
        departmentId: user?.departmentId ?? 0,

        sectionId: user?.sectionId ?? 0,
        roleId: id.toString(),
      );

      if (employeeList != null) {
        state = state.copyWith(employeeList: employeeList);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
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

      await shiftAllowanceInstance.onAssignEmployee(payload);
      KAppX.router.pop();

      // Refresh details after assigning
      // await fetchRequestDetailsById(state.requestDetails.request?.id ?? 0);
    } catch (e) {
      print("Error assigning engineer: $e");
    }
  }

  void showAssignEngineerDialog({
    required int requestId,
    required int approverId,
    // required int? departmentId,
    // required int? sectionId,
  }) {
    KAppX.extendedRouter.dialog.showKDialog(
      builder: (_) => AssignEngineerDialog(
        requestId: requestId,
        approverId: approverId,
        service: service,
        subService: subService,
        // departmentId: departmentId,
        // sectionId: sectionId,
      ),
    );
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

    // // 1️⃣ Try Employee Relations Section first
    // final ersRole = roles.where(
    //   (r) => matches(r, 'employee relations section'),
    // );

    // if (ersRole.isNotEmpty) {
    //   return ersRole.first.id;
    // }

    // 2️⃣ Fallback to Employee
    final employeeRole = roles.where((r) => matches(r, 'employee'));

    if (employeeRole.isNotEmpty) {
      return employeeRole.first.id;
    }

    // 3️⃣ Nothing found
    debugPrint("⚠️ Neither ERS nor Employee role found");
    return null;
  }

  Future<void> fetchRolesList() async {
    try {
      final rolesList = await shiftAllowanceInstance.getRolesList();

      if (rolesList != null) {
        state = state.copyWith(rolesList: rolesList);
        fetchAssignEmployeesList();
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchTrendBreakDown(String period) async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await shiftAllowanceInstance.getTrendBreakdownData(
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
      final kpis = await shiftAllowanceInstance.getApprovalKpiData(
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
    state = state.copyWith(isRequestLoading: true);
    try {
      // Clear list only if explicitly refreshing or searching

      final requests = await shiftAllowanceInstance.getRequests(
        offset: 1,
        limit: 8,
        searchText: searchText,
        status: status,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      // No merging needed
      state = state.copyWith(requestData: requests, isRequestLoading: false);
    } catch (e) {
      state = state.copyWith(isRequestLoading: false);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> fetchactionItems({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final items = await shiftAllowanceInstance.getActionItems(
        offset: 1,
        limit: 8,
        searchText: searchText,
        status: status,

        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      // No merging needed
      state = state.copyWith(actionItems: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
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

          await onApproveReject(
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

        final uploadedFiles = await shiftAllowanceInstance.uploadAttachments(
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

        await shiftAllowanceInstance.sendAttachment(payload, requestId);
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
          // "file_url": hasAttachment ? fileUrl : null,
          "file_name": hasAttachment ? fileName : null,
          "file_type": hasAttachment ? fileType : null,
          "file_size": hasAttachment ? fileSize : null,
        };

        debugPrint('💬 Chat payload: $payload');

        await shiftAllowanceInstance.sendChat(payload, requestId);
      }
      fetchChatById(requestId);
      fetchRequestDetailsById(requestId);
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
      // await shiftAllowanceInstance.onAssignRejectClose(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      fetchactionItems();
      fetchRequests();
      fetchApprovalKpi();
      fetchApprovalStatusBreakdown('weekly');
      fetchApprovalTrendBreakDown(DateTime.now().year.toString());
      fetchStatusBreakdown('weekly');
      fetchTrendBreakDown(DateTime.now().year.toString());
      fetchKpi();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
    return;
  }

  Future<void> onApproveReject(
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
      await shiftAllowanceInstance.onApprove(payload);
      await fetchRequestDetailsById(requestId);

      // await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      // if (decisionNo != null) {
      KAppX.router.pop();

      // }
      await _refreshDashboard();
      fetchApprovalKpi();
      if (isRequestApproved()) {
        await generateTemporaryAssignmentPdf();
      }
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  bool isRequestApproved() {
    if (state.requestDetails.status?.toLowerCase() != 'approved') return false;

    return true;
  }

  Future<void> generateTemporaryAssignmentPdf() async {
    try {
      final request = state.requestDetails;
      final pdf = pw.Document();
      final logos = await Future.wait([
        _loadPdfImage('assets/images/pdfimage1.png'),
        _loadPdfImage('assets/images/pdfimage.png'),
        _loadPdfImage('assets/images/caa_logo.png'),
      ]);

      final decisionNumber = _safePdfValue(request.decisionNumber);
      final employeeName = _safePdfValue(
        request.assignedEmployeeName ?? request.employeeName,
      );
      final fromEntity = _safePdfValue(
        request.fromEntity ?? request.currentEntity,
      );
      final toEntity = _safePdfValue(
        request.toEntity ?? request.transferredToEntity,
      );
      final jobPosition = _safePdfValue(
        request.assignedJobPosition ?? request.currentJobPosition,
      );
      final startDate = _formatPdfDate(request.startDate);
      final endDate = _formatPdfDate(request.endDate);
      final issuedDate = _getLastApproverDate();
      final regularFont = await PdfGoogleFonts.notoNaskhArabicRegular();
      final boldFont = await PdfGoogleFonts.notoNaskhArabicBold();
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.only(
            top: 20,
            left: 28,
            right: 28,
            bottom: 35,
          ),
          build: (context) {
            final normalStyle = pw.TextStyle(
              font: regularFont,
              fontSize: 11,
              height: 1.8,
              color: PdfColors.black,
            );

            final boldStyle = pw.TextStyle(
              font: boldFont,
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.black,
            );

            final titleStyle = pw.TextStyle(
              font: boldFont,
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            );

            final footerStyle = pw.TextStyle(
              font: regularFont,
              fontSize: 7,
              color: PdfColors.grey700,
            );

            return pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Container(
                height: PdfPageFormat.a4.availableHeight,

                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                  children: [
                    /// ================= HEADER =================
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
                      ),

                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(
                            color: PdfColors.black,
                            width: 1.5,
                          ),
                        ),
                      ),

                      child: pw.Directionality(
                        textDirection: pw.TextDirection.ltr,

                        child: pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.center,

                          children: [
                            /// LEFT LOGO
                            pw.Expanded(
                              flex: 2,

                              child: pw.Align(
                                alignment: pw.Alignment.centerLeft,

                                child: _logo(logos[0], width: 120, height: 70),
                              ),
                            ),

                            /// RIGHT SIDE
                            pw.Expanded(
                              flex: 3,

                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.end,

                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,

                                children: [
                                  _logo(logos[1], width: 95, height: 65),

                                  pw.SizedBox(width: 18),

                                  /// VERTICAL DIVIDER
                                  pw.Container(
                                    width: 1,
                                    height: 65,
                                    color: PdfColors.grey300,
                                  ),

                                  pw.SizedBox(width: 18),

                                  _logo(logos[2], width: 120, height: 75),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    pw.SizedBox(height: 20),

                    /// ================= TITLE =================
                    pw.Center(
                      child: pw.Text('قرار إداري تكليف رقم', style: titleStyle),
                    ),

                    pw.SizedBox(height: 22),

                    /// ================= PREAMBLE =================
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 18),

                      child: pw.Text(
                        'استنادا إلى قانون الخدمة المدنية الصادر بالمرسوم السلطاني رقم (٢٠٠٤ /١٢٠)، وإلى نظام هيئة الطيران المدني الصادر بالمرسوم السلطاني رقم (٢٠١٣/٤٣)، وإلى اللائحة التنفيذية لقانون الخدمة المدنية الصادرة بالقرار رقم (٢٠١٠/٩)، وبناء على ما تقتضيه مصلحة العمل',
                        style: normalStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                    ),

                    pw.SizedBox(height: 28),

                    /// ================= DECISION =================
                    pw.Center(
                      child: pw.Text(
                        'تقرر',
                        style: pw.TextStyle(
                          font: boldFont,
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),

                    pw.SizedBox(height: 38),

                    /// ================= ARTICLE 1 =================
                    _reactArticle(
                      title: 'المادة الأولى:',
                      body:
                          'يُكلف الفاضل/$employeeName رقمه ($decisionNumber) الشاغل لوظيفة "$fromEntity" إضافة إلى عمله الأصلي القيام بأعمال "$jobPosition" خلال الفترة من $startDate إلى $endDate',
                      titleStyle: boldStyle,
                      bodyStyle: normalStyle,
                    ),

                    pw.SizedBox(height: 28),

                    /// ================= ARTICLE 2 =================
                    _reactArticle(
                      title: 'المادة الثانية:',
                      body:
                          'يصرف للفاضل المكلف بدل تكليف بواقع 44.00% من الراتب الأساسي.',
                      titleStyle: boldStyle,
                      bodyStyle: normalStyle,
                    ),

                    pw.SizedBox(height: 28),

                    /// ================= ARTICLE 3 =================
                    _reactArticle(
                      title: 'المادة الثالثة:',
                      body:
                          'يلغى كل ما يخالف هذا القرار ، وعلى جهات الاختصاص تنفيذه.',
                      titleStyle: boldStyle,
                      bodyStyle: normalStyle,
                    ),

                    /// IMPORTANT
                    pw.Spacer(),

                    /// ================= SIGNATURE =================
                    pw.Align(
                      alignment: pw.Alignment.centerRight,

                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,

                        children: [
                          pw.Text('صدر في $issuedDate', style: normalStyle),

                          pw.SizedBox(height: 14),

                          pw.Text('الموافق: NA', style: normalStyle),

                          pw.SizedBox(height: 26),

                          pw.Text(
                            'م. نايف بن علي بن حمد العبري',
                            style: boldStyle,
                          ),

                          pw.SizedBox(height: 5),

                          pw.Text(
                            'رئيس هيئة الطيران المدني',
                            style: normalStyle,
                          ),
                        ],
                      ),
                    ),

                    pw.SizedBox(height: 34),

                    /// ================= FOOTER =================
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                        top: 10,
                        left: 6,
                        right: 6,
                        bottom: 4,
                      ),

                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          top: pw.BorderSide(
                            color: PdfColors.grey300,
                            width: 1,
                          ),
                        ),
                      ),

                      child: pw.Column(
                        children: [
                          /// FOOTER TOP
                          pw.Directionality(
                            textDirection: pw.TextDirection.ltr,

                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,

                              children: [
                                pw.Text(
                                  'P.C.: 111, Muscat - Sultanate of Oman',
                                  style: footerStyle,
                                ),

                                pw.Text(
                                  'صندوق البريد: ١١١، الرمز البريدي: ١١١ مسقط - سلطنة عمان',
                                  style: footerStyle,
                                  textDirection: pw.TextDirection.rtl,
                                ),
                              ],
                            ),
                          ),

                          pw.SizedBox(height: 6),

                          /// FOOTER BOTTOM
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,

                            child: pw.Text(
                              '+968 24354436 / +968 24354437 / +968 24354433 / +968 24354435 - Fax: +968 23368684 - www.caa.gov.om',
                              style: footerStyle,
                              textDirection: pw.TextDirection.ltr,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
      final pdfBytes = await pdf.save();
      final requestId = request.id?.toString() ?? 'NA';
      final fileDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final fileName =
          'Temporary_Assignment_Decision_${requestId}_$fileDate.pdf';

      await FilePicker.platform.saveFile(fileName: fileName, bytes: pdfBytes);
      Fluttertoast.showToast(msg: 'PDF downloaded successfully');
    } catch (e, st) {
      debugPrint('Failed to generate temporary assignment PDF: $e');
      debugPrintStack(stackTrace: st);
      Fluttertoast.showToast(msg: 'Error generating PDF. Please try again.');
    }
  }

  Future<pw.MemoryImage> _loadPdfImage(String assetPath) async {
    final bytes = await rootBundle.load(assetPath);
    return pw.MemoryImage(bytes.buffer.asUint8List());
  }

  pw.Widget _reactArticle({
    required String title,
    required String body,
    required pw.TextStyle titleStyle,
    required pw.TextStyle bodyStyle,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(title, style: titleStyle, textAlign: pw.TextAlign.right),

        pw.SizedBox(height: 10),

        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 10),

          child: pw.Text(body, style: bodyStyle, textAlign: pw.TextAlign.right),
        ),
      ],
    );
  }

  pw.Widget _logo(
    pw.MemoryImage image, {
    required double width,
    required double height,
  }) {
    return pw.Container(
      width: width,
      height: height,
      alignment: pw.Alignment.center,
      child: pw.Image(image, fit: pw.BoxFit.contain),
    );
  }

  pw.Widget _article({
    required String title,
    required String body,
    required pw.TextStyle textStyle,
    required pw.TextStyle boldStyle,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(title, style: boldStyle),
        pw.SizedBox(height: 8),
        pw.Text(body, style: textStyle, textAlign: pw.TextAlign.right),
      ],
    );
  }

  String _safePdfValue(Object? value) {
    if (value == null) return 'N/A';
    final text = value.toString().trim();
    return text.isEmpty ? 'N/A' : text;
  }

  String _formatPdfDate(String? value) {
    if (value == null || value.trim().isEmpty) return 'N/A';
    final parsed = DateTime.tryParse(value);
    if (parsed == null) return value;
    return DateFormat('dd/MM/yyyy').format(parsed);
  }

  String _getLastApproverDate() {
    final approvals = state.requestDetails.approvalDetails ?? [];
    if (approvals.isEmpty) {
      return DateFormat('dd/MM/yyyy').format(DateTime.now());
    }

    final approvedApprovals =
        approvals
            .where(
              (approval) =>
                  approval.approvalStatus?.toLowerCase() == 'approved',
            )
            .toList()
          ..sort((a, b) => (b.level ?? 0).compareTo(a.level ?? 0));

    if (approvedApprovals.isNotEmpty) {
      final latest = approvedApprovals.first;
      final date = latest.updatedAt ?? latest.createdAt;
      return _formatPdfDate(date);
    }

    final sortedByDate = List<ApprovalDetailModel>.from(approvals)
      ..sort((a, b) {
        final dateA = DateTime.tryParse(a.updatedAt ?? a.createdAt ?? '');
        final dateB = DateTime.tryParse(b.updatedAt ?? b.createdAt ?? '');
        return (dateB ?? DateTime.fromMillisecondsSinceEpoch(0)).compareTo(
          dateA ?? DateTime.fromMillisecondsSinceEpoch(0),
        );
      });

    return _formatPdfDate(
      sortedByDate.first.updatedAt ?? sortedByDate.first.createdAt,
    );
  }

  Future<void> onSendInProgress(int approverId, int requestId) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload
      final payload = {"request_id": requestId, "status": "In Progress"};

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      // await shiftAllowanceInstance.onSendInProgress(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      await fetchactionItems();
      await fetchRequests();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
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

    if (isManager == true) {
      debugPrint('this user can only approve');
      return ActionButtonsType.assignReject;
    } else if (level != null) {
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
    if (active.isAllowed != null && active.isAllowed != true) {
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
    _myRequestsStatusFilter = '';
    _actionItemsStatusFilter = '';
    state = state.copyWith(tabIndex: index);
    if (index == 0) {
      fetchRequests(status: '');
      fetchKpi();
      fetchStatusBreakdown('weekly');
      fetchTrendBreakDown(DateTime.now().year.toString());
    } else {
      fetchactionItems(isRefresh: true, status: '');
      fetchApprovalKpi();
      fetchApprovalStatusBreakdown('weekly');
      fetchApprovalTrendBreakDown(DateTime.now().year.toString());
    }
  }

  void onRemoveFile(int index) {
    final urls = List<FileUploadItem>.from(state.selectedFileUrl);
    urls.removeAt(index);
    state = state.copyWith(selectedFileUrl: urls);
  }

  void refreshUI() {
    // triggers rebuild in UI
    state = state.copyWith(isLoading: false);
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

  List<Map<String, dynamic>> _buildAttachments(Map<String, dynamic> values) {
    return (values['attachments'] as List<FileUploadItem>? ?? [])
        .map((file) => file.toJson())
        .toList();
  }

  Map<String, dynamic> _buildPayload(
    int serviceId,
    int subServiceId,
    Map<String, dynamic> values,
  ) {
    final userInfo = KAppX.globalProvider.read(userInfoProvider);

    return {
      /// ⭐ USER INFO
      "req_user_department_id": userInfo?.data?.department?.id ?? 0,

      "req_user_section_id": userInfo?.data?.section?.id ?? 0,

      /// ⭐ SERVICE INFO
      "service_id": serviceId,

      "sub_service_id": subServiceId,

      /// ⭐ VEHICLE MAINTENANCE DETAILS
      "vehicle_number": values['vehicle_number'] ?? "",

      "type_of_maintenance_required": values['maintenance_type'] ?? "",

      "preferred_maintenance_date": values['preferred_maintenance_date'] ?? "",

      "request_submission_date": values['request_submission_date'] ?? "",

      "issue_description": values['issue_description'] ?? "",

      /// ⭐ ATTACHMENTS
      "attachments": _buildAttachments(values),
    };
  }

  Future<void> submitProjectApprovalRequest(
    int serviceId,
    int subServiceId,
    Map<String, dynamic> values,
  ) async {
    try {
      state = state.copyWith(isLoading: true);

      final payload = _buildPayload(
        serviceId,
        subServiceId,
        values,
        // state.hrTasks,
      );

      debugPrint("✅ Final Payload: $payload");

      // final response = await shiftAllowanceInstance
      //     .createTemporaryDecisionRequest(payload);

      // // if (response['status'] == 'success') {
      // state = state.copyWith(isRequestLoading: true, requestData: []);
      // _refreshDashboard();
      // }
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _refreshDashboard() async {
    await Future.delayed(Duration(milliseconds: 2500));
    fetchKpi();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalStatusBreakdown('weekly');
    fetchApprovalTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalKpi();
    fetchRequests(isRefresh: true);
    fetchactionItems();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
