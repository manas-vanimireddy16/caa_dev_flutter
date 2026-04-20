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

  final String accommodationType;
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
  final List<HotelReservationRequestModel> requestData;
  final List<HotelReservationRequestModel> actionItems;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final bool isButtonDisabled;
  final List<String> months = const [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  /// FORM KEY
  final formKey = GlobalKey<FormState>();

  _ViewState({
    required this.isLoading,
    required this.accommodationType,
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
    required this.isButtonDisabled,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        accommodationType: '',
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
        isButtonDisabled: false,
      );

  _ViewState copyWith({
    bool? isLoading,
    String? accommodationType,
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
    List<HotelReservationRequestModel>? requestData,
    List<HotelReservationRequestModel>? actionItems,
    RequestDetailData? requestDetails,
    int? requestDetailTab,
    bool? isButtonDisabled,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      accommodationType: accommodationType ?? this.accommodationType,
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
      isButtonDisabled: isButtonDisabled ?? this.isButtonDisabled,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final Service service;
  final SubService subService;
  _VSController({required this.service, required this.subService})
    : super(_ViewState.init());

  late TextEditingController hotelNameController;
  late TextEditingController hotelPriceController;
  late TextEditingController noOfGuestsController;
  late TextEditingController checkInController;
  late TextEditingController checkOutController;
  late TextEditingController checkInTimeController;
  late TextEditingController checkOutTimeController;
  late TextEditingController descriptionController;
  late TextEditingController chatController;
  late TextEditingController searchController;
  
  Timer? _searchDebounce;
  void initState() {
    hotelNameController = TextEditingController();
    hotelPriceController = TextEditingController();
    noOfGuestsController = TextEditingController();
    checkInController = TextEditingController();
    checkOutController = TextEditingController();
    descriptionController = TextEditingController();
    checkInTimeController = TextEditingController();
    checkOutTimeController = TextEditingController();
    chatController = TextEditingController();
    searchController = TextEditingController();
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

  Map<String, String> buildRequestCardData(HotelReservationRequestModel item) {
    final approverMap = resolveApproverMap(item.approvalDetails ?? []);

    return {
      'Request Id': item.id?.toString() ?? '-',
      'status': item.status ?? '-',
      'Request By': item.createdByUser?.employeeName ?? '-',
      // 'Cycle Period': item.cyclePeriod ?? '-',
      'Request Submission Date': item.createdAt.toString() ?? '-',
      'Date': item.dateOfRequest.toString(),
      'Hotel Name': item.hotelName ?? '',
      'Check-In Date': item.checkInDate ?? '',

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

      'Hotel Name': request?.hotelName ?? 'N/A',
      'Accommodation Type': request?.typeOfAccommodation ?? 'N/A',
      'Number of Passengers': request?.numberOfGuests?.toString() ?? 'N/A',
      'Check-In Date': request?.checkInDate?.toString() ?? 'N/A',
      'Check-Out Date': request?.checkOutDate?.toString() ?? 'N/A',
      'Meal': (request?.meal?.isNotEmpty ?? false)
          ? request?.meal?.join(', ') ?? 'N/A'
          : 'N/A',
      'Hotel Price': request?.price?.toString() ?? 'N/A',
      'Service Type': request?.service?.name ?? 'N/A',
      // 'Quarter': request?.quarter ?? 'N/A',
    };
  }

  Map<String, String> buildStatusInformation() {
    final request = state.requestDetails;
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

  Future<void> openRequestDetails(
    int id, {
    bool fromActionItems = false,
  }) async {
    updateRequestTab(0);

    await KAppX.router.push(
      HotelReservationRequestDetailsTabRoute(
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
    // fetchbyCycleGoals(cycle: 'Jan-Jun');
    KAppX.router.push(
      HotelReservationNewRequestRoute
      (
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
  }

  final hotelReservationinstance = HotelReservationRepoistory();
  List<DynamicField> get hotelReservationFields => [
    /// -------- ACCOMMODATION TYPE --------
    DynamicField(
      name: 'accommodationType',
      label: 'Accommodation Type',
      type: FieldType.select,
      required: true,
      options: [
        DropdownOption(value: 'Single Room', label: 'Single Room'),
        DropdownOption(value: 'Double Room', label: 'Double Room'),
        DropdownOption(value: 'Suite', label: 'Suite'),
      ],
    ),

    /// -------- HOTEL NAME --------
    DynamicField(
      name: 'hotelName',
      label: 'Hotel Name',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter Hotel Name',
    ),

    /// -------- HOTEL PRICE --------
    DynamicField(
      name: 'hotelPrice',
      label: 'Hotel Price',
      type: FieldType.number,
      required: true,
      placeholder: 'Enter Hotel Price',
    ),

    /// -------- MEALS --------
    DynamicField(
      name: 'meals',
      label: 'Meals',
      type: FieldType.checkbox,
      required: false,
      options: ['Breakfast', 'Lunch', 'Dinner'],
    ),

    /// -------- SERVICES --------
    DynamicField(
      name: 'services',
      label: 'Services',
      type: FieldType.checkbox,
      required: false,
      options: ['Laundry', 'Telephone service'],
    ),

    /// -------- NO OF GUESTS --------
    DynamicField(
      name: 'noOfGuests',
      label: 'No of Guests',
      type: FieldType.number,
      required: true,
      placeholder: 'Enter number of guests',
    ),

    /// -------- CHECK-IN DATE --------
    DynamicField(
      name: 'checkInDate',
      label: 'Check In Date',
      type: FieldType.date,
      required: true,
    ),

    /// -------- CHECK-IN TIME --------
    DynamicField(
      name: 'checkInTime',
      label: 'Check In Time',
      type: FieldType.time,
      required: true,
    ),

    /// -------- CHECK-OUT DATE --------
    DynamicField(
      name: 'checkOutDate',
      label: 'Check Out Date',
      type: FieldType.date,
      required: true,
    ),

    /// -------- CHECK-OUT TIME --------
    DynamicField(
      name: 'checkOutTime',
      label: 'Check Out Time',
      type: FieldType.time,
      required: true,
    ),

    /// -------- DESCRIPTION --------
    DynamicField(
      name: 'description',
      label: 'Description',
      type: FieldType.textarea,
      required: true,
      placeholder: 'Enter description',
    ),

    /// -------- ATTACHMENT --------
    DynamicField(
      name: 'attachment',
      label: 'Attach File (Optional)',
      type: FieldType.file,
      required: false,
    ),
  ];

  Future<void> fetchRequestDetailsById(int id) async {
    try {
      final requests = await hotelReservationinstance.getRequestsById(id);
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
      final kpis = await hotelReservationinstance.getKpiData();

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await hotelReservationinstance
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
      final data = await hotelReservationinstance.getTrendBreakdownData(period);

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalKpi() async {
    try {
      final kpis = await hotelReservationinstance.getApprovalKpiData();

      if (kpis != null) {
        state = state.copyWith(approvalKpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await hotelReservationinstance
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
      final data = await hotelReservationinstance.getApprovalTrendBreakdownData(
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
        state = state.copyWith(requestData: []);
      }

      final requests = await hotelReservationinstance.getRequests(
        offset: 0,
        limit: 10,
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

      final items = await hotelReservationinstance.getActionItems(
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
      await hotelReservationinstance.onClose(payload);
      // await fetchActionItems();
      await fetchRequests();
      KAppX.router.pop();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void onSelectedAccomidationType(String value) =>
      state = state.copyWith(accommodationType: value);

  void onSelectedMealPreference(List<String> value) =>
      state = state.copyWith(mealPreference: value);
  void onSelectedServicePreference(List<String> value) =>
      state = state.copyWith(servicePreference: value);

  void onUploadFileSuccess(FileUploadItem url) {
    final urls = state.selectedFileUrl;
    urls.add(url);
    state = state.copyWith(selectedFileUrl: urls);
  }

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

  bool validateHotelRequestForm() {
    // 1. Validate all text fields inside the Form
    if (!state.formKey.currentState!.validate()) {
      return false;
    }

    // 2. Accommodation Type
    if (state.accommodationType.isEmpty) {
      return false;
    }

    // 3. Check-in Date
    if (checkInController.text.isEmpty) {
      return false;
    }

    // 4. Check-out Date
    if (checkOutController.text.isEmpty) {
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
    if (noOfGuestsController.text.isEmpty) {
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

  Future<void> sendChatMessage({
    required int serviceId,
    required int subServiceId,
  }) async {
    try {
      final requestId = state.requestDetails.id;
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

        final uploadedFiles = await hotelReservationinstance.uploadAttachments(
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

        // await hotelReservationinstance.sendAttachment(payload, requestId);
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

        await hotelReservationinstance.sendChat(payload, requestId);
      }
      // fetchChatById(requestId);
      // fetchAttachmentsById(requestId);

      /// 3️⃣ Clear UI state
      // chatController.clear();
      state.attachments.clear();
    } catch (e, st) {
      debugPrint('❌ Failed to send chat: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
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

  Future<void> sendHotelReservationRequest(
    int serviceId,
    int subServiceId,
    Map<String, dynamic> values,
  ) async {
    try {
      state = state.copyWith(isLoading: true);

      final userData = KAppX.globalProvider.read(rolesProvider);

      // Build attachments list
      final List<Map<String, dynamic>> attachments = state.selectedFileUrl
          .map((file) => file.toJson())
          .toList();

      // BUILD FINAL PAYLOAD
      final payload = {
        "role_id": userData?.roleId, // or state.selectedRole?.id
        "department_id": userData?.departmentId,
        "section_id": userData?.sectionId,

        "service_id": 26, // ← Replace with real service ID
        "sub_service_id": 17, // ← Replace with real sub-service ID

        "type_of_accommodation": state.accommodationType,
        "price": int.tryParse(hotelPriceController.text) ?? 0,
        "meal": state.mealPreference,
        "service": state.servicePreference,

        "hotel_name": hotelNameController.text.trim(),
        "booking_date": DateTime.now().toIso8601String().split("T").first,

        "check_in_date": checkInController.text.trim(),
        "check_in_time": checkInTimeController.text
            .trim(), // If you need picker; add controller
        "check_out_date": checkOutController.text.trim(),
        "check_out_time": checkOutTimeController.text.trim(),

        "number_of_guests": int.tryParse(noOfGuestsController.text.trim()) ?? 0,

        "description": descriptionController.text.trim(),

        "attachments": attachments,
      };

      debugPrint("✅ Final Payload: $payload");
      print("=====================================");
      print("FINAL PAYLOAD: $payload");
      print("=====================================");

      // SEND REQUEST
      await hotelReservationinstance.sendHotelReservationRequest(payload);
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
