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
  final bool isRequestLoading;
  final String selectedPriority;

  final List<FileUploadItem> selectedFileUrl;
  final List<Map<String, dynamic>> attachments;

  final KPIResponse kpiData;
  final KPIResponse approvalKpiData;

  final StatusBreakdownModel statusBreakdown;
  final TrendBreakdownModel trendData;
  final RequestDetailModel requestDataById;

  final int tabIndex;

  final StatusBreakdownModel approvalStatusBreakdown;
  final TrendBreakdownModel approvalTrendData;
  final List<TaskItem> requestData;
  final List<TaskItem> actionItems;
  final String myRequestsStatusFilter;
  final String actionItemsStatusFilter;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final List<PendingApprovalUser> engineersList;
  final int approvalId;

  final bool isFormValid;
  final bool isButtonDisabled;
  final List<ChatMessageModel> chatById;
  final List<Position> positionsList;
  final List<EmployeeList> usersList;
  final String selectedPositionName;
  final EmployeeList? selectedUser;
  final String selectedUserName;
  final String selectedSalaryDetails;

  final int? selectedUserId;
  final List<EmployeeSummary> employeeList;
  final bool isStartDateSelected;

  final String selectedRequestType;
  final List<String> months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec',
  ];

  /// FORM KEY
  final formKey = GlobalKey<FormState>();

  _ViewState({
    required this.isLoading,
    required this.isRequestLoading,
    required this.selectedPriority,
    required this.selectedFileUrl,
    required this.attachments,
    required this.kpiData,
    required this.approvalKpiData,
    required this.statusBreakdown,
    required this.trendData,
    required this.requestDataById,
    required this.tabIndex,
    required this.approvalStatusBreakdown,
    required this.approvalTrendData,
    required this.requestData,
    required this.actionItems,
    required this.myRequestsStatusFilter,
    required this.actionItemsStatusFilter,
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
  });

  _ViewState.init()
    : this(
        isLoading: false,
        isRequestLoading: false,
        selectedPriority: '',
        selectedFileUrl: [],
        attachments: [],
        kpiData: KPIResponse(),
        approvalKpiData: KPIResponse(),
        statusBreakdown: StatusBreakdownModel(),
        trendData: TrendBreakdownModel(),
        requestDataById: RequestDetailModel(),
        tabIndex: 0,
        approvalStatusBreakdown: StatusBreakdownModel(),
        approvalTrendData: TrendBreakdownModel(),
        requestData: [],
        actionItems: [],
        myRequestsStatusFilter: '',
        actionItemsStatusFilter: '',
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
      );

  _ViewState copyWith({
    bool? isLoading,
    bool? isRequestLoading,
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
    List<TaskItem>? requestData,
    List<TaskItem>? actionItems,
    String? myRequestsStatusFilter,
    String? actionItemsStatusFilter,
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
    List<EmployeeSummary>? employeeList,
    bool? isStartDateSelected,
    String? selectedSalaryDetails,
    String? selectedRequestType,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      isRequestLoading: isRequestLoading ?? this.isRequestLoading,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedFileUrl: selectedFileUrl ?? this.selectedFileUrl,
      attachments: attachments ?? this.attachments,
      kpiData: kpiData ?? this.kpiData,
      approvalKpiData: approvalKpiData ?? this.approvalKpiData,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      trendData: trendData ?? this.trendData,
      requestDataById: requestDataById ?? this.requestDataById,
      tabIndex: tabIndex ?? this.tabIndex,
      approvalStatusBreakdown:
          approvalStatusBreakdown ?? this.approvalStatusBreakdown,
      approvalTrendData: approvalTrendData ?? this.approvalTrendData,
      requestData: requestData ?? this.requestData,
      actionItems: actionItems ?? this.actionItems,
      myRequestsStatusFilter:
          myRequestsStatusFilter ?? this.myRequestsStatusFilter,
      actionItemsStatusFilter:
          actionItemsStatusFilter ?? this.actionItemsStatusFilter,
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

  final Service service;
  final SubService subService;

  _VSController({required this.service, required this.subService})
    : super(_ViewState.init());

  VoidCallback? onMyRequestsListRefresh;
  VoidCallback? onActionItemsListRefresh;

  void refreshMyRequestsList() => onMyRequestsListRefresh?.call();
  void refreshActionItemsList() => onActionItemsListRefresh?.call();

  void refreshRequestLists() {
    refreshMyRequestsList();
    refreshActionItemsList();
  }

  void refreshActiveRequestList() {
    if (state.tabIndex == 0) {
      refreshMyRequestsList();
    } else {
      refreshActionItemsList();
    }
  }

  String get currentStatusFilter => state.tabIndex == 0
      ? state.myRequestsStatusFilter
      : state.actionItemsStatusFilter;

  String requestListStatusFilterLabel(String status, DashboardL10n l10n) {
    if (status.isEmpty) {
      return l10n.isArabic ? 'الكل' : 'All';
    }
    return l10n.statusLabel(status);
  }

  void onRequestStatusFilterChanged(String status) {
    if (state.tabIndex == 0) {
      state = state.copyWith(myRequestsStatusFilter: status);
      refreshMyRequestsList();
    } else {
      state = state.copyWith(actionItemsStatusFilter: status);
      refreshActionItemsList();
    }
  }

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
  late TextEditingController completionController;
  late TextEditingController endTimeController;
  late TextEditingController phoneController;
  late TextEditingController dateSubmitController;
  late TextEditingController civilIdCardNumberController;
  late TextEditingController currentJobPositionController;
  late TextEditingController taskDescriptionController;
  late TextEditingController taskTitleController;
  late TextEditingController allowancePercentageController;
  late TextEditingController socialServiceFundContribution;
  late TextEditingController searchController;
  Timer? _searchDebounce;

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
    completionController = TextEditingController();
    phoneController = TextEditingController();
    dateSubmitController = TextEditingController();
    civilIdCardNumberController = TextEditingController();
    currentJobPositionController = TextEditingController();
    taskDescriptionController = TextEditingController();
    endTimeController = TextEditingController();
    taskTitleController = TextEditingController();
    allowancePercentageController = TextEditingController();
    socialServiceFundContribution = TextEditingController();
    searchController = TextEditingController();

    phoneController.addListener(_validateForm);
    completionController.addListener(_validateForm);
    phoneController.addListener(_validateForm);
    fromEntityController.addListener(_validateForm);
    currentJobPositionController.addListener(_validateForm);
    civilIdCardNumberController.addListener(_validateForm);
    taskDescriptionController.addListener(_validateForm);
    empIdController.addListener(_validateForm);
    endTimeController.addListener(_validateForm);
    taskTitleController.addListener(_validateForm);
    toEntityController.addListener(_validateForm);
    allowancePercentageController.addListener(_validateForm);
    socialServiceFundContribution.addListener(_validateForm);
    // fetchDepartmentName();
    fetchKpi();
    fetchApprovalKpi();
    fetchUsers();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalStatusBreakdown('weekly');
    fetchApprovalTrendBreakDown(DateTime.now().year.toString());
  }

  void onSearchChanged(String value) {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      refreshActiveRequestList();
    });
  }

  int get currentYear => DateTime.now().year;

  List<String> get filterLabelList =>
      List.generate(6, (index) => (currentYear - index).toString());
  List<StatSummaryData> requestStatsList(
    String Function(String key) titleForKey,
  ) => StatSummaryHelper.buildStatList(
    state.kpiData.data?.toJson(),
    titleForKey: titleForKey,
  );

  List<StatSummaryData> approverStatsList(
    String Function(String key) titleForKey,
  ) => StatSummaryHelper.buildStatList(
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

  Map<String, String> buildRequestCardData(TaskItem item) {
    final approverMap = resolveApproverMap(item.approvalDetails ?? []);

    return {
      'Request Id': item.id?.toString() ?? '-',
      'status': item.status ?? '-',
      'Request By': item.createdByUser?.employeeName ?? '-',
      'Task Title': item.taskTitle ?? '-',
      'Priority': item.priority ?? '-',
      'Completion Date': item.completionDate ?? '-',
      // 'Cycle Period': item.cyclePeriod ?? '-',
      'Request Submission Date': item.createdAt.toString() ?? '-',
      // 'Asset CIA Impact': item.assetCiaImpact?.toString() ?? '-',
      // 'Asset Value': item.assetValue?.toString() ?? '-',
      // 'Asset Availability': item.availability?.toString() ?? '-',
      // 'Business Impact': item.businessImpact.toString() ?? '-',
      // 'Likelihood': item.likelihood?.toString() ?? '-',
      // 'Risk Owner': item.risk?.riskOwner ?? '-',

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
    final risk = state.requestDetails.risk;
    return {
      /// ───── RIGHT COLUMN ─────
      "Service Type": request?.service?.name ?? 'N/A',

      /// ───── LEFT COLUMN ─────
      "Sub Service Type": request?.subService?.subServiceName ?? 'N/A',
      'Priority': request?.priority ?? 'N/A',
      'Task Title': request?.taskTitle ?? 'N/A',

      // Request details
      'Task Description': request?.taskDescription ?? 'N/A',
      'Completion Date': request?.completionDate ?? 'N/A',
      // 'Assigned Employee': request?.assignedEmployeeName ?? 'N/A',
    };
  }

  Map<String, String> buildStatusInformation() {
    final request = state.requestDetails.request;
    final approvals = state.requestDetails.approvalDetails;
    final nextApprover = resolveApproverMap(approvals);
    return {
      "Approval Status": formatDisplayStatus(request?.status),
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

  String formatDisplayStatus(String? status) {
    if (status == null || status.trim().isEmpty) return 'N/A';
    final normalized = status
        .toLowerCase()
        .replaceAll('_', ' ')
        .replaceAll(' ', '');
    if (normalized == 'inprogress') return 'In Progress';
    return status[0].toUpperCase() + status.substring(1);
  }

  Future<void> openRequestDetails(
    int id, {
    bool fromActionItems = false,
  }) async {
    updateRequestTab(0);

    await KAppX.router.push(
      AssignaTasktoEmployeeDetailsRoute(
        id: id,
        from: fromActionItems ? 'action items' : '',
        service: service,
        subService: subService,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      ),
    );

    if (fromActionItems) {
      returnToMyRequestsTab();
    }

    await refreshAfterReturn();
  }

  void returnToMyRequestsTab() {
    MyRequestsTabPageSyncRegistry.syncToTab(
      serviceId: service.id,
      subServiceId: subService.id,
      index: 0,
    );
    updateTabIndex(0);
    MyRequestsTabPageSyncRegistry.syncToTab(
      serviceId: service.id,
      subServiceId: subService.id,
      index: 0,
    );
  }

  Future<void> refreshAfterReturn() async {
    await Future.wait([
      fetchKpi(),
      fetchStatusBreakdown('weekly'),
      fetchTrendBreakDown(DateTime.now().year.toString()),
    ]);
    refreshActiveRequestList();
  }

  void openNewRequestForm() {
    // fetchbyCycleGoals(cycle: 'Jan-Jun');
    // state = state.copyWith(selectedUsersList: []);
    KAppX.router.push(
      AssignaTasktoEmployeeDetailsRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
  }

  void _validateForm() {
    final valid = isFormValid();

    if (state.isFormValid != valid) {
      state = state.copyWith(isFormValid: valid);
    }
  }

  bool isFormValid() {
    return taskDescriptionController.text.isNotEmpty &&
        civilIdCardNumberController.text.isNotEmpty &&
        empIdController.text.isNotEmpty &&
        currentJobPositionController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        assignmentAllowanceController.text.isNotEmpty &&
        fromEntityController.text.isNotEmpty &&
        state.selectedUserId != null &&
        state.selectedPositionName.isNotEmpty &&
        completionController.text.isNotEmpty &&
        endTimeController.text.isNotEmpty &&
        taskTitleController.text.isNotEmpty &&
        toEntityController.text.isNotEmpty &&
        allowancePercentageController.text.isNotEmpty &&
        socialServiceFundContribution.text.isNotEmpty;
  }

  bool get isFormFilled {
    return taskDescriptionController.text.isNotEmpty &&
        civilIdCardNumberController.text.isNotEmpty &&
        empIdController.text.isNotEmpty &&
        currentJobPositionController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        state.selectedUserId != null &&
        state.selectedPositionName.isNotEmpty &&
        completionController.text.isNotEmpty &&
        endTimeController.text.isNotEmpty &&
        toEntityController.text.isNotEmpty &&
        socialServiceFundContribution.text.isNotEmpty &&
        fromEntityController.text.isNotEmpty &&
        state.selectedRequestType.isNotEmpty;
  }

  void updateFormValidity() {
    final formState = state.formKey.currentState;
    if (formState == null) return;

    final valid = formState.validate();
    if (state.isFormValid != valid) {
      state = state.copyWith(isFormValid: valid);
    }
  }

  List<DropdownOption<dynamic>> get bankNameOptions {
    return state.usersList
        .map(
          (e) => DropdownOption(
            value: e.id, // ✅ store id (or full object)
            label: e.employeeName,
          ),
        )
        .toList();
  }

  final assignatasktoemployeeInstance =
      AssignaTasktoEmployeeDetailsRepository();
  List<DynamicField> buildAssignTaskFields(DashboardL10n l10n) => [
    /// -------- TASK TITLE --------

    /// -------- ASSIGNED TO --------
    DynamicField(
      name: 'assignedUserId',
      label: l10n.assignedToEmployeeNameId,
      type: FieldType.select,
      required: true,
      optionsBuilder: (ref) {
        final formL10n = DashboardL10n.of(ref.context);

        return state.usersList
            .map(
              (e) => DropdownOption<String>(
                value: e.id.toString(),
                label: e.displayName(isArabic: formL10n.isArabic),
              ),
            )
            .toList();
      },
      placeholder: l10n.select,
    ),

    DynamicField(
      name: 'completionDate',
      label: l10n.completionDateOptional,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      // initialValue: DateTime.now(),
      type: FieldType.date,
      required: false,
      placeholder: l10n.select,
    ),
    DynamicField(
      name: 'taskTitle',
      label: l10n.taskTitle,
      type: FieldType.text,
      required: true,
      placeholder: l10n.enterRequestTitleLogistics,
      validator: (value, values) {
        final extension = value?.toString().trim() ?? '';

        // Required validation
        if (extension.isEmpty) {
          return l10n.taskTitleRequired;
        }

        // // Only digits validation
        // if (!RegExp(r'^\d+$').hasMatch(extension)) {
        //   return 'Extension Number must contain only digits';
        // }

        // Exact 5 digits validation
        if (extension.length < 5) {
          return l10n.taskTitleMinLength;
        }

        return null;
      },
      // minLength: 5,
    ),

    /// -------- PRIORITY --------
    DynamicField(
      name: 'priority',
      label: l10n.requestDetailsLabel('Priority'),
      type: FieldType.select,
      required: true,
      optionsBuilder: (ref) {
        final formL10n = DashboardL10n.of(ref.context);
        return [
          DropdownOption(value: 'High', label: formL10n.priorityOption('High')),
          DropdownOption(
            value: 'Medium',
            label: formL10n.priorityOption('Medium'),
          ),
          DropdownOption(value: 'Low', label: formL10n.priorityOption('Low')),
        ];
      },
      placeholder: l10n.select,
    ),

    /// -------- COMPLETION DATE --------

    /// -------- TASK DESCRIPTION --------
    DynamicField(
      name: 'taskDescription',
      label: l10n.taskDescription,
      type: FieldType.textarea, // or FieldType.text with maxLines
      required: true,
      placeholder: l10n.transportSpecialInstructionsPlaceholder,
      validator: (value, values) {
        final extension = value?.toString().trim() ?? '';

        // Required validation
        if (extension.isEmpty) {
          return l10n.taskDescriptionRequired;
        }

        // // Only digits validation
        // if (!RegExp(r'^\d+$').hasMatch(extension)) {
        //   return 'Extension Number must contain only digits';
        // }

        // Exact 5 digits validation
        if (extension.length < 5) {
          return l10n.taskDescriptionMinLength;
        }

        return null;
      },
    ),

    /// -------- ATTACHMENTS --------
    DynamicField(
      name: 'attachments',
      label: l10n.attachmentsOptional,
      type: FieldType.file,
      required: false,
    ),
    // DynamicField(
    //   name: 'attach',
    //   label: l10n.attachOptional,
    //   type: FieldType.file,
    //   required: false,
    // ),
  ];

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
      final requests = await assignatasktoemployeeInstance.getRequestsById(id);
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
      final requests = await assignatasktoemployeeInstance.getchatById(id);
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

  Future<void> deleteAttachment(int attachmentId, {int? requestId}) async {
    if (attachmentId == 0) {
      Fluttertoast.showToast(msg: 'Attachment ID missing');
      return;
    }

    try {
      state = state.copyWith(isLoading: true);
      final effectiveRequestId = requestId ?? state.requestDetails.request?.id;
      await assignatasktoemployeeInstance.deleteAttachment(
        attachmentId,
        requestId: effectiveRequestId,
      );

      if (effectiveRequestId != null && effectiveRequestId != 0) {
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

  // Future<void> getRoleDetails() async {
  //   final storage = KAuthCred();
  //   final saved = await storage.getSelectedRole();
  //   if (saved != null) {
  //     state = state.copyWith(currentRoleName: saved.roleName);
  //   }
  // }

  Future<void> fetchKpi() async {
    try {
      final kpis = await assignatasktoemployeeInstance.getKpiData(
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
      final data = await assignatasktoemployeeInstance
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
      final statusBreakdown = await assignatasktoemployeeInstance
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
      final statusBreakdown = await assignatasktoemployeeInstance
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
      final data = await assignatasktoemployeeInstance.getTrendBreakdownData(
        period,
      );

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchUsers() async {
    try {
      final userInfo = KAppX.globalProvider.read(rolesProvider);
      final departmentId = userInfo?.departmentId ?? 0;
      final users = await assignatasktoemployeeInstance.getUsers(departmentId);

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

  Future<void> fetchApprovalKpi() async {
    try {
      final kpis = await assignatasktoemployeeInstance.getApprovalKpiData(
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

  // Future<void> fetchEngineersList() async {
  //   try {
  //     // Clear list only if explicitly refreshing or searching

  //     final engineersList = await assignatasktoemployeeInstance
  //         .getEngineersList();

  //     // No merging needed
  //     state = state.copyWith(engineersList: engineersList);
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  Future<List<TaskItem>> loadMyRequestsPage(
    int pageKey, {
    String searchText = '',
    String status = '',
  }) async {
    if (!mounted) return [];

    try {
      return await assignatasktoemployeeInstance.getRequests(
        offset: ListPagination.offsetForPage(pageKey),
        limit: ListPagination.pageSize,
        searchText: searchText,
        status: status,
      );
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: e.toString());
      }
      rethrow;
    }
  }

  Future<List<TaskItem>> loadActionItemsPage(
    int pageKey, {
    String searchText = '',
    String status = '',
  }) async {
    if (!mounted) return [];

    try {
      return await assignatasktoemployeeInstance.getActionItems(
        offset: ListPagination.offsetForPage(pageKey),
        limit: ListPagination.pageSize,
        searchText: searchText,
        status: status,
      );
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: e.toString());
      }
      rethrow;
    }
  }

  Future<void> fetchRequests({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    try {
      // Clear list only if explicitly refreshing or searching
      // if (isRefresh || searchText.isNotEmpty || status.isNotEmpty) {
      //   state = state.copyWith(requestData: []);
      // }
      state = state.copyWith(isRequestLoading: true);
      final requests = await assignatasktoemployeeInstance.getRequests(
        offset: 0,
        limit: 8,
        searchText: searchText,
        status: status,
      );

      // No merging needed
      state = state.copyWith(requestData: requests, isRequestLoading: false);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      state = state.copyWith(isRequestLoading: false);
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

      final items = await assignatasktoemployeeInstance.getActionItems(
        offset: 0,
        limit: 8,
        searchText: searchText,
        status: status,
      );

      // No merging needed
      state = state.copyWith(actionItems: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Dialog for approve and reject request
  // void showApprovalCommentDialog({
  //   required ApprovalDialogType type,
  //   required int approverId,
  //   required int requestId,
  // }) {
  //   KAppX.extendedRouter.dialog.showKDialog(
  //     builder: (_) => ApprovalCommentDialog(
  //       type: type,
  //       onSubmit: (comment) async {
  //         if (type == ApprovalDialogType.approve) {
  //           await onApprove(
  //             approverId,
  //             requestId,
  //             comment, // optional
  //           );
  //         } else {
  //           await onReject(
  //             approverId,
  //             requestId,
  //             comment, // mandatory
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  // void showAssignEngineerDialog({
  //   required int requestId,
  //   required int approverRoleId,
  //   // required int? departmentId,
  //   // required int? sectionId,
  // }) {
  //   KAppX.extendedRouter.dialog.showKDialog(
  //     builder: (_) => AssignEngineerDialog(
  //       requestId: requestId,
  //       approverRoleId: approverRoleId,
  //       service: service,
  //       subService: subService,
  //       // departmentId: departmentId,
  //       // sectionId: sectionId,
  //     ),
  //   );
  // }

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

        final uploadedFiles = await assignatasktoemployeeInstance
            .uploadAttachments(state.attachments);

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

        await assignatasktoemployeeInstance.sendAttachment(payload, requestId);
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

        await assignatasktoemployeeInstance.sendChat(payload, requestId);
      }
      // fetchChatById(requestId);
      // fetchAttachmentsById(requestId);
      fetchRequestDetailsById(requestId);

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
      await assignatasktoemployeeInstance.onSendComplete(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      refreshRequestLists();
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

  Future<void> onSendInProgress(int approverId, int requestId) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload
      final payload = {"request_id": requestId, "status": "In Progress"};

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await assignatasktoemployeeInstance.onSendInProgress(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      refreshRequestLists();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  bool canUserActOnLevel({required ApprovalDetailModel approval}) {
    final selectedRole = KAppX.globalProvider.read(rolesProvider);
    final user = KAppX.globalProvider.read(userInfoProvider);

    final int userId = int.parse(user?.data?.id ?? "0");

    /// 1️⃣ Delegate always allowed
    if (approval.delegateUserId == userId) return true;

    /// 2️⃣ Approver user rule
    /// null → open approval
    /// not null → must match logged-in user
    if (approval.approverUserId != null && approval.approverUserId != userId) {
      return false;
    }

    /// 3️⃣ Role must match (if defined)
    if (approval.approverRoleId != null &&
        approval.approverRoleId != selectedRole?.roleId) {
      return false;
    }

    /// 4️⃣ Department must match (if defined)
    if (approval.departmentId != null &&
        approval.departmentId != selectedRole?.departmentId) {
      return false;
    }

    /// 5️⃣ Section must match (if defined)
    if (approval.sectionId != null &&
        approval.sectionId != selectedRole?.sectionId) {
      return false;
    }

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

    if (state.requestDetails.request?.status?.toLowerCase().trim() ==
        "assigned") {
      return ActionButtonsType.inProgress;
    }
    if (state.requestDetails.request?.status?.toLowerCase().trim() ==
        "in progress") {
      return ActionButtonsType.complete;
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

    final status = state.requestDetails.request?.status?.toLowerCase() ?? '';

    // ✅ Disable ONLY if ACTIVE is approved
    final shouldDisable = status == 'approved';

    state = state.copyWith(isButtonDisabled: shouldDisable);
  }

  void onPositionChange(String position) =>
      state = state.copyWith(selectedPositionName: position);
  void onSelectedSalaryDetailsChange(String salaryDetails) =>
      state = state.copyWith(selectedSalaryDetails: salaryDetails);

  void onselectedRequestTypeChange(String requestDetails) =>
      state = state.copyWith(selectedRequestType: requestDetails);
  void onUserChange(int userId) {
    final user = state.usersList.firstWhere((e) => e.id == userId);

    state = state.copyWith(
      selectedUserId: user.id,
      selectedUserName: user.employeeName,
    );

    // Auto-fill text field
    // taskDescriptionController.text = user.employeeName ?? '';
  }

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

  void updateRequestTab(int index) {
    state = state.copyWith(requestDetailTab: index);
  }

  void updateTabIndex(int index) {
    state = state.copyWith(
      tabIndex: index,
      myRequestsStatusFilter: index == 0 ? '' : state.myRequestsStatusFilter,
      actionItemsStatusFilter: index == 1 ? '' : state.actionItemsStatusFilter,
    );

    if (index == 0) {
      refreshMyRequestsList();
      fetchKpi();
      fetchStatusBreakdown('weekly');
      fetchTrendBreakDown(DateTime.now().year.toString());
    } else {
      refreshActionItemsList();
      fetchApprovalKpi();
      fetchApprovalStatusBreakdown('weekly');
      fetchApprovalTrendBreakDown(DateTime.now().year.toString());
    }
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
  //       uploadedFiles = await assignatasktoemployeeInstance.uploadAttachments(
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
  //     final resMessage = await assignatasktoemployeeInstance.sendChat(payload, id, type);

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

  Future<void> submitAssignaTasktoEmployeeRequest(
    int serviceId,
    int subServiceId,
    Map<String, dynamic> values,
  ) async {
    try {
      state = state.copyWith(isLoading: true);

      final userData = KAppX.globalProvider.read(rolesProvider);
      final userInfo = KAppX.globalProvider.read(userInfoProvider);

      // Build attachments list
      final List<Map<String, dynamic>> attachments =
          (values['attachments'] as List<FileUploadItem>? ?? [])
              .map((file) => file.toJson())
              .toList();

      // BUILD FINAL PAYLOAD
      final payload = {
        "req_user_department_id": userData?.departmentId ?? 0,
        "req_user_section_id": userData?.sectionId ?? 0,
        "service_id": serviceId,
        "sub_service_id": subServiceId,
        "user_id": values['assignedUserId'],
        "task_title": values['taskTitle'],
        "task_description": values['taskDescription'],
        "priority": values['priority'],
        "completion_date": values['completionDate'],
        "attachments": attachments,
      };

      debugPrint("✅ Final Payload: $payload");
      print("=====================================");
      print("FINAL PAYLOAD: $payload");
      print("=====================================");

      // SEND REQUEST
      await assignatasktoemployeeInstance.sendAssignaTasktoEmployeeRequest(
        payload,
      );
      // KAppX.router.pop();
      await Future.delayed(Duration(seconds: 2));
      fetchKpi();
      fetchStatusBreakdown('weekly');
      fetchTrendBreakDown(DateTime.now().year.toString());

      refreshRequestLists();
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    // // 🔥 Dispose ALL controllers
    // titleController.dispose();
    // startDateController.dispose();
    // eventTimeController.dispose();

    // Optional
    // eventDateController.dispose();

    super.dispose();
  }
}
