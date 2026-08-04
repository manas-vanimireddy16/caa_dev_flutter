part of 'view.dart';

const Object _copyWithUnset = Object();

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
      ref.onDispose(() {
        debugPrint('_VSController disposed');
        controller.disposeResources();
      });
      return controller;
    });

class _ViewState {
  final bool isLoading;
  final bool isDetailsLoading;
  final bool isActionSubmitting;
  final bool isDashboardLoading;
  final bool isAssignDataLoading;
  final bool isActionItemLoading;
  final bool isRequestLoading;

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
  final List<LegalRequestModel> requestData;
  final List<LegalRequestModel> actionItems;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final int approvalId;

  final bool isButtonDisabled;
  final List<ChatMessageModel> chatById;
  final List<AttachmentModel> attachmentsById;
  final List<SectionModel> sections;
  final List<DepartmentModel> departments;
  final String myRequestsStatusFilter;
  final String actionItemsStatusFilter;

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

  final UsersResponseModel? usersData;
  final RolesResponseModel? rolesData;
  final int? selectedSectionId;
  final int? selectedRoleId;
  final int? selectedUserId;

  /// FORM KEY
  final formKey = GlobalKey<FormState>();

  _ViewState({
    required this.isLoading,
    required this.isDetailsLoading,
    required this.isActionSubmitting,
    required this.isDashboardLoading,
    required this.isAssignDataLoading,
    required this.isRequestLoading,
    required this.isActionItemLoading,
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
    required this.usersData,
    required this.rolesData,
    required this.selectedSectionId,
    required this.selectedRoleId,
    required this.selectedUserId,
    required this.sections,
    required this.departments,
    required this.myRequestsStatusFilter,
    required this.actionItemsStatusFilter,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        isDetailsLoading: false,
        isActionSubmitting: false,
        isDashboardLoading: false,
        isAssignDataLoading: false,
        isActionItemLoading: false,
        isRequestLoading: false,
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
        usersData: null,
        rolesData: null,
        selectedSectionId: null,
        selectedRoleId: null,
        selectedUserId: null,
        sections: [],
        departments: [],
        myRequestsStatusFilter: '',
        actionItemsStatusFilter: '',
      );

  _ViewState copyWith({
    bool? isLoading,
    bool? isDetailsLoading,
    bool? isActionSubmitting,
    bool? isDashboardLoading,
    bool? isAssignDataLoading,
    bool? isRequestLoading,
    bool? isActionItemLoading,
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
    List<LegalRequestModel>? requestData,
    List<LegalRequestModel>? actionItems,
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
    List<EmployeeList>? usersList,
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
    String? myRequestsStatusFilter,
    String? actionItemsStatusFilter,
    Object? usersData = _copyWithUnset,
    Object? rolesData = _copyWithUnset,
    Object? selectedSectionId = _copyWithUnset,
    Object? selectedRoleId = _copyWithUnset,
    Object? selectedUserId = _copyWithUnset,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      isDetailsLoading: isDetailsLoading ?? this.isDetailsLoading,
      isActionSubmitting: isActionSubmitting ?? this.isActionSubmitting,
      isDashboardLoading: isDashboardLoading ?? this.isDashboardLoading,
      isAssignDataLoading: isAssignDataLoading ?? this.isAssignDataLoading,
      isActionItemLoading: isActionItemLoading ?? this.isActionItemLoading,
      isRequestLoading: isRequestLoading ?? this.isRequestLoading,
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
      usersData: identical(usersData, _copyWithUnset)
          ? this.usersData
          : usersData as UsersResponseModel?,
      rolesData: identical(rolesData, _copyWithUnset)
          ? this.rolesData
          : rolesData as RolesResponseModel?,
      selectedSectionId: identical(selectedSectionId, _copyWithUnset)
          ? this.selectedSectionId
          : selectedSectionId as int?,
      selectedRoleId: identical(selectedRoleId, _copyWithUnset)
          ? this.selectedRoleId
          : selectedRoleId as int?,
      selectedUserId: identical(selectedUserId, _copyWithUnset)
          ? this.selectedUserId
          : selectedUserId as int?,
      sections: sections ?? this.sections,
      departments: departments ?? this.departments,
      actionItemsStatusFilter:
          actionItemsStatusFilter ?? this.actionItemsStatusFilter,
      myRequestsStatusFilter:
          myRequestsStatusFilter ?? this.myRequestsStatusFilter,
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
  late final _VSControllerParams params;
  _VSController({required this.service, required this.subService})
    : super(_ViewState.init()) {
    params = _VSControllerParams(service: service, subService: subService);
    chatController = TextEditingController();
    titleController = TextEditingController();
    searchController = TextEditingController();
  }

  Timer? _searchDebounce;
  bool _assignInFlight = false;

  late TextEditingController chatController;
  late TextEditingController titleController;
  late TextEditingController searchController;

  VoidCallback? onMyRequestsListRefresh;
  VoidCallback? onActionItemsListRefresh;

  void refreshMyRequestsList() => onMyRequestsListRefresh?.call();
  void refreshActionItemsList() => onActionItemsListRefresh?.call();

  void refreshRequestLists() {
    refreshMyRequestsList();
    refreshActionItemsList();
    unawaited(fetchApprovalKpi(suppressDashboardLoading: true));
  }

  Future<void> refreshRequestListsAsync() async {
    refreshMyRequestsList();
    refreshActionItemsList();
    await fetchApprovalKpi(suppressDashboardLoading: true);
  }

  void disposeResources() {
    _searchDebounce?.cancel();
    chatController.dispose();
    titleController.dispose();
    searchController.dispose();
  }

  @override
  void dispose() {
    disposeResources();
    super.dispose();
  }

  void initState() {
    unawaited(_loadInitialDashboard());
  }

  Future<void> _loadInitialDashboard() async {
    state = state.copyWith(isDashboardLoading: true);
    try {
      await Future.wait([
        fetchKpi(suppressDashboardLoading: true),
        fetchApprovalKpi(suppressDashboardLoading: true),
        fetchStatusBreakdown('weekly', suppressDashboardLoading: true),
        fetchTrendBreakDown(
          DateTime.now().year.toString(),
          suppressDashboardLoading: true,
        ),
        fetchApprovalStatusBreakdown('weekly', suppressDashboardLoading: true),
        fetchApprovalTrendBreakDown(
          DateTime.now().year.toString(),
          suppressDashboardLoading: true,
        ),
      ]);
    } finally {
      if (mounted) {
        state = state.copyWith(isDashboardLoading: false);
      }
    }
  }

  void refreshActiveRequestList() {
    if (state.tabIndex == 0) {
      refreshMyRequestsList();
    } else {
      refreshActionItemsList();
    }
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

  Map<String, String> buildRequestCardData(LegalRequestModel item) {
    final approverMap = resolveApproverMap(item.base?.approvalDetails ?? []);

    return {
      'Request Id': item.base?.id?.toString() ?? '-',
      'status': item.base?.status ?? '-',
      'Request By': item.base?.createdByUser?.employeeName ?? '-',
      // 'Cycle Period': item.cyclePeriod ?? '-',
      'Request Submission Date': item.base?.createdAt.toString() ?? '-',
      // 'Request Title': item.requestTitle ?? '-',
      // 'Request Type': item.requestType ?? '-',

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
    final request = state.requestDetails;
    return {
      /// ───── RIGHT COLUMN ─────
      "Service Type": request?.service?.name ?? 'N/A',

      /// ───── LEFT COLUMN ─────
      "Sub Service Type": request?.subService?.subServiceName ?? 'N/A',
      // 'Request Classification': request?.requestClassification ?? '-',
      // 'Date of Submission': request?.submissionDate.toString() ?? '-',
      // 'Request Title': request?.requestTitle ?? '-',
      'Request Type': request?.requestType ?? '-',
    };
  }

  String _displayApprovalStatus(String? status) {
    final normalized =
        status?.toLowerCase().replaceAll('_', ' ').trim() ?? '';
    if (normalized == 'in progress' || normalized == 'inprogress') {
      return 'Pending';
    }
    return status?.trim().isNotEmpty == true ? status!.trim() : 'N/A';
  }

  /// Keeps full datetime including time, e.g. `2026-08-04T06:56`.
  String _formatFullRequestedDate(String? raw) {
    if (raw == null || raw.trim().isEmpty) return 'N/A';
    try {
      final dt = DateTime.parse(raw).toLocal();
      final y = dt.year.toString().padLeft(4, '0');
      final m = dt.month.toString().padLeft(2, '0');
      final d = dt.day.toString().padLeft(2, '0');
      final h = dt.hour.toString().padLeft(2, '0');
      final min = dt.minute.toString().padLeft(2, '0');
      return '$y-$m-${d}T$h:$min';
    } catch (_) {
      return raw;
    }
  }

  Map<String, String> buildStatusInformation() {
    final request = state.requestDetails;
    final approvals = state.requestDetails.approvalDetails;
    final nextApprover = resolveApproverMap(approvals);
    final assignedTo = _buildDepartmentSection(nextApprover);

    return {
      if (assignedTo.isNotEmpty && assignedTo != '-')
        'Assigned To': assignedTo,
      'Approval Status': _displayApprovalStatus(request?.status),
      'Requested Date': _formatFullRequestedDate(request?.createdAt),
      if (nextApprover.containsKey('name'))
        'Approver Name': nextApprover['name']!,
      if (nextApprover.containsKey('email'))
        'Approver Email': nextApprover['email']!,
    };
  }

  Map<String, String> buildTechnicalInformation() {
    final request = state.requestDetails;
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
    final departmentSection = _buildDepartmentSection(approverMap);
    if (departmentSection.isNotEmpty && departmentSection != '-') {
      return departmentSection;
    }
    if (approverMap.containsKey('name')) {
      return approverMap['name']!;
    }
    if (approverMap.containsKey('role')) {
      return approverMap['role']!;
    }
    return 'N/A';
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

  Future<void> openRequestDetails(
    int id, {
    bool fromActionItems = false,
    int initialTabIndex = RequestDetailsTabIndex.requestDetails,
  }) async {
    updateRequestTab(initialTabIndex);
    fetchDepartments();

    await KAppX.router.push(
      LegalConsultationandReviewofAdministrativeDecisionsDetailsRoute(
        id: id,
        from: fromActionItems ? 'action items' : '',
        service: service,
        subService: subService,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      ),
    );

    returnToMyRequestsTab();
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
      LegalConsultationandReviewofAdministrativeDecisionsNewRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
  }

  final legalConsultationandReviewoInstance =
      LegalConsultationandReviewofAdministrativeDecisionsRepository();
  final residentalUnitRentalInstance = ResidentalUnitRentalRepository();
  List<DynamicField> get legalConsultationFormFields => [
    /// ================= DATE =================
    DynamicField(
      name: 'date',
      label: 'Date',
      type: FieldType.date,
      placeholder: 'Select',
      required: true,
    ),

    /// ================= TITLE =================
    DynamicField(
      name: 'title',
      label: 'Title',
      type: FieldType.text,
      placeholder: 'Enter',
      required: true,
    ),

    /// ================= DESCRIPTION =================
    DynamicField(
      name: 'description',
      label: 'Description',
      type: FieldType.text,
      placeholder: 'Enter',
      required: true,
    ),

    /// ================= ATTACHMENT =================
    DynamicField(
      name: 'attachments',
      label: 'Attachment',
      type: FieldType.file,
      required: false,
    ),
  ];

  /// ========================= API CALLS =========================

  Future<void> fetchRequestDetailsById(
    int id, {
    bool showLoading = true,
  }) async {
    if (showLoading) {
      state = state.copyWith(isDetailsLoading: true);
    }
    try {
      final requests = await legalConsultationandReviewoInstance
          .getRequestsById(
            id: id,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );

      if (requests != null) {
        state = state.copyWith(requestDetails: requests);
        fetchChatById(id);
        fetchAttachmentsById(id);
        updateButtonDisabledFromApprovals(requests.approvalDetails ?? []);

        final actionType = getActionButtonsType(
          requests,
          requests.approvalDetails ?? [],
        );
        if (actionType == ActionButtonsType.assignReject) {
          debugPrint('this user can only approve');
        }
      }
    } on ApiException catch (apiError) {
      state = state.copyWith(isDetailsLoading: false);
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted && showLoading) {
        state = state.copyWith(isDetailsLoading: false);
      }
    }
  }

  Future<void> fetchChatById(int id) async {
    try {
      final requests = await legalConsultationandReviewoInstance.getchatById(
        id,
      );
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
      final attachments = await legalConsultationandReviewoInstance
          .getAttachmentsById(id);
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
      await legalConsultationandReviewoInstance.deleteAttachment(
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

  Future<void> fetchKpi({bool suppressDashboardLoading = false}) async {
    if (!suppressDashboardLoading) {
      state = state.copyWith(isDashboardLoading: true);
    }
    try {
      final kpis = await legalConsultationandReviewoInstance.getKpiData(
        service.id ?? 0,
        subService.id ?? 0,
      );

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (!suppressDashboardLoading && mounted) {
        state = state.copyWith(isDashboardLoading: false);
      }
    }
  }

  Future<void> fetchApprovalTrendBreakDown(
    String period, {
    bool suppressDashboardLoading = false,
  }) async {
    if (!suppressDashboardLoading) {
      state = state.copyWith(isDashboardLoading: true);
    }
    try {
      final data = await legalConsultationandReviewoInstance
          .getApprovalTrendBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );

      if (data != null) {
        state = state.copyWith(approvalTrendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (!suppressDashboardLoading && mounted) {
        state = state.copyWith(isDashboardLoading: false);
      }
    }
  }

  Future<void> fetchApprovalStatusBreakdown(
    String period, {
    bool suppressDashboardLoading = false,
  }) async {
    if (!suppressDashboardLoading) {
      state = state.copyWith(isDashboardLoading: true);
    }
    try {
      final statusBreakdown = await legalConsultationandReviewoInstance
          .getApprovalStatusBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );
      if (statusBreakdown != null) {
        state = state.copyWith(approvalStatusBreakdown: statusBreakdown);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (!suppressDashboardLoading && mounted) {
        state = state.copyWith(isDashboardLoading: false);
      }
    }
  }

  Future<void> fetchStatusBreakdown(
    String period, {
    bool suppressDashboardLoading = false,
  }) async {
    if (!suppressDashboardLoading) {
      state = state.copyWith(isDashboardLoading: true);
    }
    try {
      final statusBreakdown = await legalConsultationandReviewoInstance
          .getStatusBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );
      if (statusBreakdown != null) {
        state = state.copyWith(statusBreakdown: statusBreakdown);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (!suppressDashboardLoading && mounted) {
        state = state.copyWith(isDashboardLoading: false);
      }
    }
  }

  Future<void> fetchTrendBreakDown(
    String period, {
    bool suppressDashboardLoading = false,
  }) async {
    if (!suppressDashboardLoading) {
      state = state.copyWith(isDashboardLoading: true);
    }
    try {
      final data = await legalConsultationandReviewoInstance
          .getTrendBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (!suppressDashboardLoading && mounted) {
        state = state.copyWith(isDashboardLoading: false);
      }
    }
  }

  Future<void> fetchApprovalKpi({bool suppressDashboardLoading = false}) async {
    if (!suppressDashboardLoading) {
      state = state.copyWith(isDashboardLoading: true);
    }
    try {
      final kpis = await legalConsultationandReviewoInstance.getApprovalKpiData(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      if (kpis != null) {
        state = state.copyWith(approvalKpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (!suppressDashboardLoading && mounted) {
        state = state.copyWith(isDashboardLoading: false);
      }
    }
  }

  Future<void> fetchDepartments() async {
    try {
      final departments = await legalConsultationandReviewoInstance
          .getDepartments();

      if (departments != null) {
        state = state.copyWith(departments: departments);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchSections(int id) async {
    try {
      /// ✅ CLEAR OLD SECTIONS FIRST
      state = state.copyWith(sections: []);

      final sections = await legalConsultationandReviewoInstance.getSections(
        userDepartmentId: id.toString(),
      );

      /// ✅ UPDATE NEW SECTIONS
      state = state.copyWith(sections: sections);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> onSectionChanged({
    required int sectionId,
    required int departmentId,
  }) async {
    state = state.copyWith(
      selectedSectionId: sectionId,

      /// RESET
      selectedRoleId: null,
      selectedUserId: null,

      rolesData: null,
      usersData: null,
    );

    await fetchRoles(sectionId: sectionId, departmentId: departmentId);
  }

  void clearSelectedSection() {
    state = state.copyWith(
      sections: [],
      selectedSectionId: null,
      rolesData: null,
      usersData: null,
    );
  }

  // Future<void> onRoleChanged(int roleId) async {
  //   state = state.copyWith(
  //     selectedRoleId: roleId,

  //     /// RESET
  //     selectedUserId: null,
  //     usersData: null,
  //   );

  //   await fetchUsers(sectionId: state.selectedSectionId ?? 0, roleId: roleId,departmentId: departmentId);
  // }

  void updateSelectedUser(int? userId) {
    state = state.copyWith(selectedUserId: userId);
  }

  Future<void> fetchRoles({
    required int sectionId,
    required int departmentId,
  }) async {
    state = state.copyWith(isAssignDataLoading: true);
    try {
      final users = await legalConsultationandReviewoInstance.getRoles(
        departmentId: departmentId,
        sectionId: sectionId,
      );

      state = state.copyWith(rolesData: users);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) {
        state = state.copyWith(isAssignDataLoading: false);
      }
    }
  }

  Future<void> onAssign(
    int roleId,
    int sectionId,
    int userId,
    int departmentId,
  ) async {
    if (_assignInFlight || state.isActionSubmitting) return;

    _assignInFlight = true;
    try {
      state = state.copyWith(isActionSubmitting: true);

      final active = getActiveApprovalLevel(
        state.requestDetails.approvalDetails ?? [],
      );
      final approvalId = active?.id;
      final requestId =
          state.requestDetails.request?.id ?? state.requestDetails.id;

      if (requestId == null ||
          requestId == 0 ||
          approvalId == null ||
          approvalId == 0) {
        Fluttertoast.showToast(
          msg: 'Unable to resolve request/approval for assign action',
        );
        return;
      }

      if (roleId == 0 || sectionId == 0 || userId == 0 || departmentId == 0) {
        Fluttertoast.showToast(
          msg: 'Please select department, section, role, and user',
        );
        return;
      }

      final payload = <String, dynamic>{
        'request_id': requestId,
        'approval_id': approvalId,
        'status': 'Approved',
        'comment': '',
        'reassign_approver_user_id': userId,
        'reassign_delegate_user_id': null,
        'reassign_department_id': departmentId,
        'reassign_section_id': sectionId,
        'reassign_approver_role_id': roleId,
        'routing_branch': 'REASSIGN',
        'routingBranch': 'REASSIGN',
      };

      debugPrint('✅ Final Assign Payload: $payload');

      await legalConsultationandReviewoInstance.onAssign(payload);
      if (!mounted) return;
      await Future.delayed(const Duration(seconds: 1));
      KAppX.router.pop();
      KAppX.router.pop();
      refreshRequestLists();
    } catch (e) {
      debugPrint('❌ Error submitting assign request: $e');
      Fluttertoast.showToast(msg: 'Failed to assign request');
    } finally {
      _assignInFlight = false;
      if (mounted) {
        state = state.copyWith(isActionSubmitting: false);
      }
    }
  }

  Future<void> fetchUsers({
    required int sectionId,
    required int roleId,
    required int departmentId,
  }) async {
    state = state.copyWith(isAssignDataLoading: true);
    try {
      final users = await legalConsultationandReviewoInstance.getUsersList(
        roleId: roleId,
        departmentId: departmentId,
        sectionId: sectionId,
      );

      state = state.copyWith(usersData: users);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) {
        state = state.copyWith(isAssignDataLoading: false);
      }
    }
  }

  Future<List<LegalRequestModel>> loadMyRequestsPage(
    int pageKey, {
    String searchText = '',
    String status = '',
  }) async {
    if (!mounted) return [];

    try {
      return await legalConsultationandReviewoInstance.getRequests(
        offset: ListPagination.offsetForPage(pageKey),
        limit: ListPagination.pageSize,
        searchText: searchText,
        status: status,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: e.toString());
      }
      rethrow;
    }
  }

  Future<List<LegalRequestModel>> loadActionItemsPage(
    int pageKey, {
    String searchText = '',
    String status = '',
  }) async {
    if (!mounted) return [];

    try {
      return await legalConsultationandReviewoInstance.getActionItems(
        offset: ListPagination.offsetForPage(pageKey),
        limit: ListPagination.pageSize,
        searchText: searchText,
        status: status,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: e.toString());
      }
      rethrow;
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

  Future<void> showAllocateUserDialog(BuildContext context) async {
    final l10n = DashboardL10n.of(context);

    await resetAllocateDialog();

    KAppX.extendedRouter.dialog.showKDialog(
      barrierDismissible: false,
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      builder: (_) {
        return SizedBox(
          width: 650,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.allocateUserTitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => KAppX.router.pop(),
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                /// BODY
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    ),
                    child: AssignUser(
                      service: service,
                      subService: subService,
                      onSuccess: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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

        final uploadedFiles = await legalConsultationandReviewoInstance
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

        await legalConsultationandReviewoInstance.sendAttachment(
          payload,
          requestId,
        );
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

        await legalConsultationandReviewoInstance.sendChat(payload, requestId);
      }
      await fetchRequestDetailsById(requestId, showLoading: false);

      /// 3️⃣ Clear UI state
      chatController.clear();
      state.attachments.clear();
    } catch (e, st) {
      debugPrint('❌ Failed to send chat: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  

  Future<void> onApprove(
    int approverId,
    int requestId,
    String comment,
    String status,
    String? decisionNo,
  ) async {
    if (state.isActionSubmitting) return;

    try {
      state = state.copyWith(isActionSubmitting: true);

      ApprovalDetailModel? approvalForAction;
      for (final approval in state.requestDetails.approvalDetails ?? []) {
        if (approval.id == approverId) {
          approvalForAction = approval;
          break;
        }
      }

      final payload = {
        "request_id": requestId,
        "status": status,
        "comment": comment,
        "approval_id": approverId,
      };
      if (approvalForAction?.level == 2) {
        payload['routing_branch'] = "DIRECT";
      }
      if (decisionNo != null) {
        payload['decision_number'] = decisionNo;
      }

      debugPrint("✅ Final Payload: $payload");

      await legalConsultationandReviewoInstance.onApprove(payload);
      await Future.delayed(const Duration(seconds: 1));
      KAppX.router.pop();
      // KAppX.router.pop();
      refreshRequestLists();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      if (mounted) {
        state = state.copyWith(isActionSubmitting: false);
      }
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
      // await legalConsultationandReviewoInstance.onSendInProgress(payload);
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
    for (final a in list) {
      if (a.approvalStatus?.toLowerCase() == 'in progress') {
        return a;
      }
    }
    return null;
  }

  ApprovalDetailModel? getActiveApprovalLevel(List<ApprovalDetailModel> list) {
    for (final approval in list) {
      if (!canUserActOnLevel(approval: approval)) continue;

      final status = approval.approvalStatus?.toLowerCase().trim() ?? '';
      if (status == 'in progress') {
        return approval;
      }
    }

    return null;
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
    } else if (level.level == 2) {
      debugPrint('this user can approve and reject');
      return ActionButtonsType.assignApproveReject;
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
    final s = status?.toLowerCase().replaceAll('_', ' ').trim();
    return s == 'pending' || s == 'in progress' || s == 'assigned';
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

      final department = next.department?.departmentName;
      final section = next.section?.sectionName;

      /// 🔹 RULE 1: approver user EXISTS → NAME + EMAIL (+ dept/section)
      if (next.approverRoleId != null) {
        final name = next.approverUser?.employeeName;
        final email = next.approverUser?.email;
        final roleName = next.approverRole?.name;

        if ((name ?? '').isNotEmpty) {
          return {
            'name': name!,
            if ((email ?? '').isNotEmpty) 'email': email!,
            if ((roleName ?? '').isNotEmpty) 'role': roleName!,
            if ((department ?? '').isNotEmpty) 'department': department!,
            if ((section ?? '').isNotEmpty) 'section': section!,
          };
        }
      }

      /// 🔹 RULE 2: NO USER → DEPARTMENT + SECTION
      if ((department ?? '').isNotEmpty) {
        return {
          'department': department!,
          if ((section ?? '').isNotEmpty) 'section': section!,
        };
      }

      /// 🔹 RULE 3: ROLE ONLY
      final fallbackRole = next.approverRole?.name;
      if ((fallbackRole ?? '').isNotEmpty) {
        return {'role': fallbackRole!};
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

  void updateRequestTab(int index, {bool refreshDetails = false}) {
    state = state.copyWith(requestDetailTab: index);
    if (!refreshDetails) return;

    final requestId = state.requestDetails.request?.id;
    if (requestId != null && requestId != 0) {
      fetchRequestDetailsById(requestId, showLoading: false);
    }
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



  Future<void> resetAllocateDialog() async {
    state = state.copyWith(
      rolesData: null,

      sections: [],

      usersData: null,

      selectedSectionId: null,
      selectedRoleId: null,
      selectedUserId: null,
    );

    print('✅ Allocate Dialog Reset');
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

    final payload = {
      /// ⭐ USER / DEPARTMENT INFO
      "req_user_department_id": userInfo?.data?.department?.id ?? 0,
      "req_user_section_id": userInfo?.data?.section?.id ?? 0,

      /// ⭐ SERVICE INFO
      "service_id": serviceId,
      "sub_service_id": subServiceId,

      /// ⭐ DATES
      // "request_date": values['date'] ?? "",
      "date": values['date'] ?? "",

      /// ⭐ REQUEST DETAILS
      "title": values['title'] ?? "",
      "description": values['description'] ?? "",
      // "comment": values['comment'] ?? "",

      /// ⭐ ATTACHMENTS
      "attachments": _buildAttachments(values),
    };

    return payload;
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

      final response = await legalConsultationandReviewoInstance
          .sendLegalConsultationReviewNewRequest(payload);

      if (response['status'] == 'success') {
        state = state.copyWith(isRequestLoading: true);
        _refreshDashboard();
      }
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _refreshDashboard() async {
    await Future.delayed(Duration(seconds: 2));
    fetchKpi();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalStatusBreakdown('weekly');
    fetchApprovalTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalKpi();
    refreshRequestLists();
  }
}
