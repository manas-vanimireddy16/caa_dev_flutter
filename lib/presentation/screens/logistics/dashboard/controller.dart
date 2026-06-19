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
  final List<SubService> subServices;

  const _VSControllerParams({
    required this.service,
    required this.subService,
    required this.subServices,
  });

  @override
  List<Object?> get props => [service, subService];
}

final _vsProvider = StateNotifierProvider.autoDispose
    .family<_VSController, _ViewState, _VSControllerParams>((ref, params) {
      return _VSController(
        service: params.service,
        subService: params.subService,
        subServices: params.subServices,
      );
    });

class _ViewState {
  final bool isLoading;
  final bool isRequestLoading;
  final bool isActionItemLoading;

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
  final List<DashboardRequestModel> requestData;
  final List<DashboardRequestModel> actionItems;
  final String myRequestsStatusFilter;
  final String actionItemsStatusFilter;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final int approvalId;

  final bool isButtonDisabled;
  final List<ChatMessageModel> chatById;
  final List<AttachmentModel> attachmentsById;
  final List<StationModel> stationsList;
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
    required this.isRequestLoading,
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
    required this.myRequestsStatusFilter,
    required this.actionItemsStatusFilter,
    required this.requestDetails,
    required this.requestDetailTab,
    required this.approvalId,
    required this.isButtonDisabled,
    required this.chatById,
    required this.attachmentsById,
    required this.stationsList,
    required this.isActionItemLoading,
  });

  _ViewState.init()
    : this(
        isLoading: false,
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
        myRequestsStatusFilter: '',
        actionItemsStatusFilter: '',
        requestDetails: RequestDetailData(),
        requestDetailTab: 0,
        approvalId: 0,
        isButtonDisabled: false,
        chatById: [],

        attachmentsById: [],
        stationsList: [],
        isActionItemLoading: false,
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
    int? selectedTab,
    List<DashboardRequestModel>? requestData,
    List<DashboardRequestModel>? actionItems,
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
    List<StationModel>? stationsList,
    bool? isActionItemLoading,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
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
      myRequestsStatusFilter:
          myRequestsStatusFilter ?? this.myRequestsStatusFilter,
      actionItemsStatusFilter:
          actionItemsStatusFilter ?? this.actionItemsStatusFilter,
      requestDetails: requestDetails ?? this.requestDetails,
      requestDetailTab: requestDetailTab ?? this.requestDetailTab,
      approvalId: approvalId ?? this.approvalId,
      isButtonDisabled: isButtonDisabled ?? this.isButtonDisabled,
      chatById: chatById ?? this.chatById,
      attachmentsById: attachmentsById ?? this.attachmentsById,
      stationsList: stationsList ?? this.stationsList,
      isActionItemLoading: isActionItemLoading ?? this.isActionItemLoading,
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
  final List<SubService> subServices;
  late final _VSControllerParams params;
  _VSController({
    required this.service,
    required this.subService,
    required this.subServices,
  }) : super(_ViewState.init()) {
    params = _VSControllerParams(
      service: service,
      subService: subService,
      subServices: subServices,
    );
    chatController = TextEditingController();
    titleController = TextEditingController();
    searchController = TextEditingController();
  }

  Timer? _searchDebounce;

  late TextEditingController chatController;
  late TextEditingController titleController;
  late TextEditingController searchController;
  bool _didInitialize = false;

  /// Called by [RequestsPage] to refresh paginated lists.
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

  void ensureInitialized() {
    if (_didInitialize) return;
    _didInitialize = true;
    fetchUserRoles();
    fetchKpi();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalKpi();
  }

  int _searchVersion = 0;

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
  List<StatSummaryData> currentStats(String Function(String key) titleForKey) =>
      state.tabIndex == 0
      ? StatSummaryHelper.buildStatList(
          state.kpiData.data?.toJson(),
          titleForKey: titleForKey,
        )
      : StatSummaryHelper.buildStatList(
          state.approvalKpiData.data?.toJson(),
          titleForKey: titleForKey,
        );
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

  Map<String, String> buildRequestCardData(DashboardRequestModel item) {
    // final approverMap = resolveApproverMap(item.base?.approvalDetails ?? []);

    return {
      'Request Id': item.requestId?.toString() ?? '-',
      'status': item.base?.status ?? '-',
      "Request For": item.base?.subService?.subServiceName ?? '',
      'Request By': item.base?.createdByUser?.employeeName ?? '-',
      'Request Submission Date': item.base?.createdAt.toString() ?? '-',

      // 'Type of Project': item.titleOfProject ?? 'NA',

      /// 👇 APPROVER (SINGLE LINE)
    };
  }

  Future<void> navigateToRoute({
    required String name,
    required int requestId,
    Service? service,
    SubService? subService,
    bool fromActionItems = false,
  }) => navigateToDashboardRequestDetails(
    subServiceCode: name,
    requestId: requestId,
    service: service,
    subService: subService,
    fromActionItems: fromActionItems,
  );

  Future<void> refreshAfterReturn() async {
    await Future.wait([
      fetchKpi(),
      fetchStatusBreakdown('weekly'),
      fetchTrendBreakDown(DateTime.now().year.toString()),
    ]);
    refreshRequestLists();
  }

  final dashboardInstance = CommonDashboardRepository();

  Future<void> selectOrStoreRole(UserRoleResponse userRoles) async {
    final storage = KAuthCred();
    final saved = await storage.getSelectedRole();

    if (saved != null) {
      print("🔵 Using saved role ${saved.roleName}");
      return;
    }

    // First role from summary
    final first = userRoles.data!.rolesSummary!.first;

    // Match it inside role_details
    final detail = userRoles.data!.roleDetails!.firstWhere(
      (e) => e.role?.id == first.roleId,
      orElse: () => userRoles.data!.roleDetails!.first,
    );

    final selected = SelectedUserRole(
      roleId: first.roleId!,
      roleName: first.roleName!,
      departmentId: detail.department?.id ?? 0,
      sectionId: detail.section?.id ?? 0,
      services: detail.services ?? [],
    );

    await storage.storeSelectedRole(selected);

    print("🎯 Selected Role: ${selected.roleName}");
  }

  Future<void> fetchUserRoles() async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);

    try {
      final userInfo = KAppX.globalProvider.read(userInfoProvider);
      final id = int.tryParse((userInfo?.data?.id ?? 0).toString()) ?? 0;
      final userRoles = await dashboardInstance.getUserRoles(id);
      if (!mounted) return;

      await selectOrStoreRole(userRoles);
      await Future.wait([
        fetchApprovalKpi(),
        fetchKpi(),
        fetchStatusBreakdown('weekly'),
        fetchTrendBreakDown(DateTime.now().year.toString()),
      ]);
      refreshRequestLists();

      if (!mounted) return;

      state = state.copyWith(isLoading: false);
    } catch (e) {
      debugPrint("fetchUserRoles error: $e");
      if (mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  (List<int>, List<int>) getServiceAndSubServiceIds() {
    final role = KAppX.globalProvider.read(rolesProvider);

    final services = role?.services ?? [];

    final currentService = services.firstWhere((e) => e.id == service.id);

    final List<int> serviceIds = [
      if (currentService.id != null) currentService.id ?? 0,
    ];

    final List<int> subServiceIds = (currentService.subservices ?? [])
        .map((subService) => subService.id)
        .whereType<int>()
        .toSet()
        .toList();

    return (serviceIds, subServiceIds);
  }

  Future<void> fetchApprovalTrendBreakDown(String period) async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);

    try {
      final (serviceIds, subServiceIds) = getServiceAndSubServiceIds();

      final data = await dashboardInstance.getApprovalTrendBreakdownData(
        period: period,
        serviceIds: serviceIds,
        subServiceIds: subServiceIds,
      );

      if (!mounted) return;

      if (data != null) {
        state = state.copyWith(approvalTrendData: data, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: apiError.message);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchApprovalStatusBreakdown(String period) async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);

    try {
      final (serviceIds, subServiceIds) = getServiceAndSubServiceIds();

      final statusBreakdown = await dashboardInstance
          .getApprovalStatusBreakdownData(
            period: period,
            serviceIds: serviceIds,
            subServiceIds: subServiceIds,
          );

      if (!mounted) return;

      if (statusBreakdown != null) {
        state = state.copyWith(
          approvalStatusBreakdown: statusBreakdown,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: apiError.message);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false);
      debugPrint(e.toString());
    }
  }

  Future<void> fetchStatusBreakdown(String period) async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);

    try {
      final (serviceIds, subServiceIds) = getServiceAndSubServiceIds();

      final statusBreakdown = await dashboardInstance.getStatusBreakdownData(
        period: period,
        serviceIds: serviceIds,
        subServiceIds: subServiceIds,
      );

      if (!mounted) return;

      if (statusBreakdown != null) {
        state = state.copyWith(
          statusBreakdown: statusBreakdown,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: apiError.message);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false);
      debugPrint(e.toString());
    }
  }

  Future<void> fetchTrendBreakDown(String period) async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);

    try {
      final (serviceIds, subServiceIds) = getServiceAndSubServiceIds();

      final data = await dashboardInstance.getTrendBreakdownData(
        period: period,
        serviceIds: serviceIds,
        subServiceIds: subServiceIds,
      );

      if (!mounted) return;

      if (data != null) {
        state = state.copyWith(trendData: data, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: apiError.message);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchKpi() async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);

    try {
      final (serviceIds, subServiceIds) = getServiceAndSubServiceIds();

      final kpis = await dashboardInstance.getKpiData(
        serviceIds: serviceIds,
        subServiceIds: subServiceIds,
      );

      if (!mounted) return;

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: apiError.message);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchApprovalKpi() async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);

    try {
      final (serviceIds, subServiceIds) = getServiceAndSubServiceIds();

      final kpis = await dashboardInstance.getApprovalKpiData(
        serviceIds: serviceIds,
        subServiceIds: subServiceIds,
      );

      if (!mounted) return;

      if (kpis != null) {
        state = state.copyWith(approvalKpiData: kpis, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: apiError.message);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false);
    }
  }

  Future<List<DashboardRequestModel>> loadMyRequestsPage(
    int pageKey, {
    String searchText = '',
    String status = '',
  }) async {
    if (!mounted) return [];

    try {
      final (serviceIds, subServiceIds) = getServiceAndSubServiceIds();

      return await dashboardInstance.getRequests(
        offset: ListPagination.offsetForPage(pageKey),
        limit: ListPagination.pageSize,
        searchText: searchText,
        serviceIds: serviceIds,
        subServiceIds: subServiceIds,
      );
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: e.toString());
      }
      rethrow;
    }
  }

  Future<List<DashboardRequestModel>> loadActionItemsPage(
    int pageKey, {
    String searchText = '',
    String status = '',
  }) async {
    if (!mounted) return [];

    try {
      final (serviceIds, subServiceIds) = getServiceAndSubServiceIds();

      return await dashboardInstance.getActionItems(
        offset: ListPagination.offsetForPage(pageKey),
        limit: ListPagination.pageSize,
        searchText: searchText,
        serviceIds: serviceIds,
        subServiceIds: subServiceIds,
      );
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: e.toString());
      }
      rethrow;
    }
  }

  String formatTime(String? time) {
    if (time == null || time.isEmpty) return '';

    final parts = time.split(':');

    if (parts.length >= 2) {
      return '${parts[0]}:${parts[1]}';
    }

    return time;
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
      fetchTrendBreakDown('2026');
    } else {
      refreshActionItemsList();
      fetchApprovalKpi();
      fetchApprovalStatusBreakdown('weekly');
      fetchApprovalTrendBreakDown('2026');
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    chatController.dispose();
    titleController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
