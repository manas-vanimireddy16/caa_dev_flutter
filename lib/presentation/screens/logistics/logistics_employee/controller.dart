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
  final List<LogisticsVehicleRequestModel> requestData;
  final List<LogisticsVehicleRequestModel> actionItems;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final int approvalId;

  final bool isButtonDisabled;
  final List<ChatMessageModel> chatById;
  final List<AttachmentModel> attachmentsById;

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
  final List<Map<String, String>> vehicle = [
    {
      "chassisNumber": "MHFKU8FS8R0198168",
      "engineNumber": "1GRH393291",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Fortuner 4x4",
      "vehicleNumber": "43/88",
      "no": "1",
    },
    {
      "chassisNumber": "MHFKU8FSXR0197944",
      "engineNumber": "1GRH394412",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Fortuner 4x4",
      "vehicleNumber": "47/88",
      "no": "2",
    },
    {
      "chassisNumber": "MHFKU8FS4R0198183",
      "engineNumber": "1GRH393738",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Fortuner 4x4",
      "vehicleNumber": "42/88",
      "no": "3",
    },
    {
      "chassisNumber": "MHFKU8FS1R0197895",
      "engineNumber": "1GRH3932364",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Fortuner 4x4",
      "vehicleNumber": "45/88",
      "no": "4",
    },
    {
      "chassisNumber": "MHFKU8FS8R0197893",
      "engineNumber": "1GRH392372",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Fortuner 4x4",
      "vehicleNumber": "46/88",
      "no": "5",
    },
    {
      "chassisNumber": "MHFKU8FS3R0198191",
      "engineNumber": "1GRH393620",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Fortuner 4x4",
      "vehicleNumber": "48/88",
      "no": "6",
    },
    {
      "chassisNumber": "MHFKU8FS2R0197906",
      "engineNumber": "1GRH394369",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Fortuner 4x4",
      "vehicleNumber": "37/88",
      "no": "7",
    },
    {
      "chassisNumber": "MHFKU8FS7R0197920",
      "engineNumber": "1GRH393135",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Fortuner 4x4",
      "vehicleNumber": "36/88",
      "no": "8",
    },
    {
      "chassisNumber": "MHFKU8FS3R0198224",
      "engineNumber": "1GRH393976",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Fortuner 4x4",
      "vehicleNumber": "44/88",
      "no": "9",
    },
    {
      "chassisNumber": "MHFKU8FS7R0198226",
      "engineNumber": "1GRH393932",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Fortuner 4x4",
      "vehicleNumber": "49/88",
      "no": "10",
    },
    {
      "chassisNumber": "JTNB19HK8R3246981",
      "engineNumber": "A250D74665",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Camry Sedan",
      "vehicleNumber": "98/88",
      "no": "11",
    },
    {
      "chassisNumber": "JTNB19HK2R3249147",
      "engineNumber": "A250D80919",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Camry Sedan",
      "vehicleNumber": "59/88",
      "no": "12",
    },
    {
      "chassisNumber": "JTNB19HK7R3247409",
      "engineNumber": "A250D76198",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Camry Sedan",
      "vehicleNumber": "57/88",
      "no": "13",
    },
    {
      "chassisNumber": "JTNB19HK7R3248771",
      "engineNumber": "A250D79786",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Camry Sedan",
      "vehicleNumber": "56/88",
      "no": "14",
    },
    {
      "chassisNumber": "JTNB19HK2R3248273",
      "engineNumber": "A250D78346",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Camry Sedan",
      "vehicleNumber": "54/88",
      "no": "15",
    },
    {
      "chassisNumber": "JTNB19HK4R3245794",
      "engineNumber": "A250D71332",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Camry Sedan",
      "vehicleNumber": "24/88",
      "no": "16",
    },
    {
      "chassisNumber": "JTNB19HK1R3245610",
      "engineNumber": "A250D70920",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Camry Sedan",
      "vehicleNumber": "97/88",
      "no": "17",
    },
    {
      "chassisNumber": "JTNB19HKxR3245394",
      "engineNumber": "A250D70280",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Camry Sedan",
      "vehicleNumber": "96/88",
      "no": "18",
    },
    {
      "chassisNumber": "JTNB19HK0R3244965",
      "engineNumber": "A250D69119",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Camry Sedan",
      "vehicleNumber": "76/88",
      "no": "19",
    },
    {
      "chassisNumber": "JTNB19HK1R3248796",
      "engineNumber": "A250D79746",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Camry Sedan",
      "vehicleNumber": "58/88",
      "no": "20",
    },
    {
      "chassisNumber": "JTNB19HK1R3245560",
      "engineNumber": "A250D70818",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Camry Sedan",
      "vehicleNumber": "95/88",
      "no": "21",
    },
    {
      "chassisNumber": "JTNB19HK0R3246909",
      "engineNumber": "A250D74461",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Camry Sedan",
      "vehicleNumber": "79/88",
      "no": "22",
    },
    {
      "chassisNumber": "JTEBU9FJ0PK239298",
      "engineNumber": "1GRC726969",
      "color": "Pearl White",
      "model": "2023",
      "vehicleType": "Toyota Prado 4x4",
      "vehicleNumber": "55/88",
      "no": "23",
    },
    {
      "chassisNumber": "JTEBU9FJ8PK247214",
      "engineNumber": "1GRC792827",
      "color": "Pearl White",
      "model": "2023",
      "vehicleType": "Toyota Prado 4x4",
      "vehicleNumber": "4./88",
      "no": "24",
    },
    {
      "chassisNumber": "JTEBU9FJ6PK246675",
      "engineNumber": "1GRC788110",
      "color": "Pearl White",
      "model": "2023",
      "vehicleType": "Toyota Prado 4x4",
      "vehicleNumber": "5./88",
      "no": "25",
    },
    {
      "chassisNumber": "JTEJU9FJ3B5013808",
      "engineNumber": "A237596",
      "color": "White",
      "model": "2011",
      "vehicleType": "Toyota Prado 4x4",
      "vehicleNumber": "8./88",
      "no": "26",
    },
    {
      "chassisNumber": "JTEJU9FJ8B5016574",
      "engineNumber": "A272362",
      "color": "White",
      "model": "2011",
      "vehicleType": "Toyota Prado 4x4",
      "vehicleNumber": "9./88",
      "no": "27",
    },
    {
      "chassisNumber": "5N1AN0N69CN801970",
      "engineNumber": "930446A",
      "color": "Silver",
      "model": "2011",
      "vehicleType": "Nissan Pathfinder 4x4",
      "vehicleNumber": "23/88",
      "no": "28",
    },
    {
      "chassisNumber": "5N1AR1N80BC600156",
      "engineNumber": "904776A",
      "color": "Silver",
      "model": "2011",
      "vehicleType": "Nissan Pathfinder 4x4",
      "vehicleNumber": "21/88",
      "no": "29",
    },
    {
      "chassisNumber": "5N1AN0N69CN801970",
      "engineNumber": "174185B",
      "color": "White",
      "model": "2012",
      "vehicleType": "Nissan X-Terra 4x4",
      "vehicleNumber": "10./88",
      "no": "30",
    },
    {
      "chassisNumber": "JMYLYV97WDJ703723",
      "engineNumber": "6G758E9XS3556",
      "color": "White",
      "model": "2013",
      "vehicleType": "Toyota Pajero 4x4",
      "vehicleNumber": "6./88",
      "no": "31",
    },
    {
      "chassisNumber": "1GKS27KD6PR329789",
      "engineNumber": "L84APR329789",
      "color": "Brown",
      "model": "2023",
      "vehicleType": "GMC Yukon 4x4",
      "vehicleNumber": "111/88",
      "no": "32",
    },
    {
      "chassisNumber": "MR0DX9CD0R2649011",
      "engineNumber": "2TRB145770",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Hilux Pickup",
      "vehicleNumber": "108/88",
      "no": "33",
    },
    {
      "chassisNumber": "MR0DX9CD3R2649021",
      "engineNumber": "2TRB146621",
      "color": "Pearl White",
      "model": "2024",
      "vehicleType": "Toyota Hilux Pickup",
      "vehicleNumber": "109/88",
      "no": "34",
    },
    {
      "chassisNumber": "MR0EW12G8D3020457",
      "engineNumber": "7433363",
      "color": "White",
      "model": "2013",
      "vehicleType": "Toyota Hilux Pickup",
      "vehicleNumber": "26/88",
      "no": "35",
    },
    {
      "chassisNumber": "MNTDD22S9C6003117",
      "engineNumber": "917712Z",
      "color": "White",
      "model": "2012",
      "vehicleType": "Nissan Pickup",
      "vehicleNumber": "18/88",
      "no": "36",
    },
    {
      "chassisNumber": "MMBJNKA50BD023348",
      "engineNumber": "4G64UCAJ3745",
      "color": "White",
      "model": "2011",
      "vehicleType": "Mitsubishi Pickup",
      "vehicleNumber": "30/88",
      "no": "37",
    },
    {
      "chassisNumber": "JL6BCE6J9DK008760",
      "engineNumber": "6D16A23924",
      "color": "White",
      "model": "2009",
      "vehicleType": "Mitsubishi Truck with Crane",
      "vehicleNumber": "40/88",
      "no": "38",
    },
    {
      "chassisNumber": "4P3SRDJ1ABE802237",
      "engineNumber": "4G69PD4331",
      "color": "White",
      "model": "2011",
      "vehicleType": "Mitsubishi Galant Sedan",
      "vehicleNumber": "29/88",
      "no": "39",
    },
    {
      "chassisNumber": "JL6BCE6J9DK008760",
      "engineNumber": "4D34N38913",
      "color": "White",
      "model": "2013",
      "vehicleType": "Mitsubishi Truck with Crane",
      "vehicleNumber": "27/88",
      "no": "40",
    },
    {
      "chassisNumber": "JTMHU09J0B5051720",
      "engineNumber": "A318476",
      "color": "White",
      "model": "2011",
      "vehicleType": "Toyota Land Cruiser 4x4",
      "vehicleNumber": "1./88",
      "no": "41",
    },
    {
      "chassisNumber": "JN8AY25Y0C9027176",
      "engineNumber": "038827A",
      "color": "Green",
      "model": "2012",
      "vehicleType": "Nissan Patrol 4x4",
      "vehicleNumber": "2./88",
      "no": "42",
    },
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
    List<LogisticsVehicleRequestModel>? requestData,
    List<LogisticsVehicleRequestModel>? actionItems,
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
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
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

  Timer? _searchDebounce;

  late TextEditingController chatController;
  late TextEditingController titleController;
  late TextEditingController searchController;

  void initState() {
    chatController = TextEditingController();
    titleController = TextEditingController();
    searchController = TextEditingController();
    fetchKpi();
    fetchRequests();
    fetchStatusBreakdown('monthly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    // fetchbyCycleGoals(cycle: 'Jan-Jun');
  }

  int _searchVersion = 0;

  void onSearchChanged(String value) {
    _searchDebounce?.cancel();
    final int currentVersion = ++_searchVersion;

    _searchDebounce = Timer(const Duration(milliseconds: 400), () async {
      if (state.tabIndex == 0) {
        await fetchRequests(isRefresh: true, searchText: value);
      } else {
        await fetchactionItems(isRefresh: true, searchText: value);
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

  Map<String, String> buildRequestCardData(LogisticsVehicleRequestModel item) {
    final approverMap = resolveApproverMap(item.base?.approvalDetails ?? []);

    return {
      'Request Id': item.base?.id?.toString() ?? '-',
      'status': item.base?.status ?? '-',
      'Request By': item.base?.createdByUser?.employeeName ?? '-',
      'Request Name': item.title ?? 'N/A',
      'Category': item.category ?? 'N/A',
      'Date': formatDate(item.base?.createdAt.toString() ?? ''),

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
      /// ───── RIGHT /COLUMN ─────
      //"Request For": request?.requestFor ?? 'N/A',
      "Service Type": request?.service?.name ?? 'N/A',

      /// ───── LEFT COLUMN ─────
      "Sub Service Type": request?.subService?.subServiceName ?? 'N/A',
      "Purpose of Travel": request?.purposeOfTravel ?? 'N/A',
      "Travel Date": formatDate(request?.dateOfTravel ?? 'N/A'),
      "Travel Time": formatTime(request?.timeOfTravel ?? 'N/A'),
      "Location": request?.vehicleRequiredLocation ?? 'N/A',
      // "Driver Name": request?.driverName ?? 'N/A',
      // "Vehicle Number": request?.vehicleNumber ?? 'N/A',
      "Description": request?.description ?? 'N/A',
      // 'Type Of Enquire': request?.titleOfEnquiry ?? 'N/A',
      // 'Phone Number': request?.phone ?? 'N/A',
      // 'Budget Code': request?.budgetCode ?? 'N/A',
      // 'Estimated Cost': request?.estimatedCost ?? 'N/A',
      // 'Request Type': request?.requestType ?? 'N/A',
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

  Future<void> openRequestDetails(
    int id, {
    bool fromActionItems = false,
  }) async {
    updateRequestTab(0);

    await KAppX.router.push(
      LogisticsRequestDetailsTabRoute(
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
      LogisticsVehicleRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
  }

  final logisticsRequestVehicleInstanceInstance = RequestAVehicleRepository();
  final residentalUnitRentalInstance = ResidentalUnitRentalRepository();
  List<DynamicField> get logisticsVehicleRequestFields => [
    /// ================= REQUEST TYPE =================
    DynamicField(
      name: 'request_type',
      label: 'Request Type',
      type: FieldType.radio,
      required: true,
      initialValue: 'Daily',
      options: ['Daily', 'Emergency'],
    ),

    /// ================= VEHICLE REQUIRED FOR =================
    DynamicField(
      name: 'vehicle_required_for',
      label: 'Vehicle Required For',
      type: FieldType.select,
      required: true,
      placeholder: 'Select ',
      options: const [
        DropdownOption(value: 'Conferences', label: 'Conferences'),
        DropdownOption(
          value: 'Celebrations and Official Meetings',
          label: 'Celebrations and Official Meetings',
        ),
        DropdownOption(value: 'others', label: 'Others'),
      ],
    ),

    /// ================= VEHICLE REQUIRED LOCATION =================
    DynamicField(
      name: 'vehicle_required_location',
      label: 'Vehicle Required Location',
      type: FieldType.select,
      placeholder: 'Select ',
      required: true,
      options: const [
        DropdownOption(value: 'Inside Muscat', label: 'Inside Muscat'),
        DropdownOption(value: 'Outside Muscat', label: 'Outside Muscat'),
      ],
    ),

    /// ================= REQUEST TITLE =================
    DynamicField(
      name: 'request_title',
      label: 'Request Title',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter request title (min 5, max 250 characters)',
    ),

    /// ================= TYPE OF REQUEST =================
    DynamicField(
      name: 'type_of_request',
      label: 'Type of Request',
      type: FieldType.select,
      required: true,
      placeholder: 'Select ',
      options: const [
        DropdownOption(value: 'New Request', label: 'New Request'),
        DropdownOption(
          value: 'Extension of Previous Request',
          label: 'Extension of Previous Request',
        ),
      ],
    ),

    /// ================= PURPOSE OF TRAVEL =================
    DynamicField(
      name: 'purpose_of_travel',
      label: 'Purpose of Travel',
      type: FieldType.select,
      required: true,
      placeholder: 'Select ',
      options: const [
        DropdownOption(value: 'Site Visit', label: 'Site Visit'),
        DropdownOption(value: 'Airport Duty', label: 'Airport Duty'),
        DropdownOption(value: 'Official Meeting', label: 'Official Meeting'),
        DropdownOption(value: 'Other', label: 'Other'),
      ],
    ),

    /// ================= TYPE OF VEHICLE REQUIRED =================
    DynamicField(
      name: 'type_of_vehicle_required',
      label: 'Type of Vehicle Required',
      type: FieldType.select,
      placeholder: 'Select ',
      required: true,
      options: const [
        DropdownOption(value: 'Light vehicle', label: 'Light Vehicle'),
        DropdownOption(value: 'Heavy vehicle', label: 'Heavy Vehicle'),
      ],
    ),

    /// ================= TRAVEL DATE =================
    DynamicField(
      name: 'travel_date_from',
      label: 'Travel Date From',
      placeholder: 'Select',
      type: FieldType.date,
      required: true,
    ),

    /// ================= TRAVEL DATE TO =================
    DynamicField(
      name: 'travel_date_to',
      label: 'Travel Date To',
      placeholder: 'Select',
      type: FieldType.date,
      required: true,
    ),

    DynamicField(
      name: 'duration',
      label: 'Duration',
      placeholder: 'Auto calculated',
      type: FieldType.time,
      required: true,
    ),

    /// ================= TRAVEL TIME =================
    DynamicField(
      name: 'travel_time',
      label: 'Travel Time',
      placeholder: 'Select',
      type: FieldType.time,
      required: true,
    ),

    /// ================= DESCRIPTION =================
    DynamicField(
      name: 'description',
      label: 'Description',
      type: FieldType.text,
      required: false,
      placeholder: 'Write Here...',
      // hintText: 'Write Here...',
    ),

    /// ================= ATTACHMENT =================
    DynamicField(
      name: 'attachment',
      label: 'Attach File',
      type: FieldType.file,
      required: false,
    ),

    /// ================= REQUEST FOR =================
  ];

  /// ========================= API CALLS =========================

  Future<void> fetchRequestDetailsById(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      final requests = await logisticsRequestVehicleInstanceInstance
          .getRequestsById(
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
      final requests = await logisticsRequestVehicleInstanceInstance
          .getchatById(
            id: id,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
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
      final attachments = await logisticsRequestVehicleInstanceInstance
          .getAttachmentsById(
            id: id,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
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

  Future<void> fetchKpi() async {
    state = state.copyWith(isLoading: true);
    try {
      final kpis = await logisticsRequestVehicleInstanceInstance.getKpiData(
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
      final data = await logisticsRequestVehicleInstanceInstance
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
      final statusBreakdown = await logisticsRequestVehicleInstanceInstance
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
      final statusBreakdown = await logisticsRequestVehicleInstanceInstance
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
      final data = await logisticsRequestVehicleInstanceInstance
          .getTrendBreakdownData(
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
      final kpis = await logisticsRequestVehicleInstanceInstance
          .getApprovalKpiData(
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
        state = state.copyWith(requestData: [], isLoading: false);
      }

      final requests = await logisticsRequestVehicleInstanceInstance
          .getRequests(
            offset: 1,
            limit: 8,
            searchText: searchText,
            status: status,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );

      // No merging needed
      state = state.copyWith(requestData: requests);
    } catch (e) {
      state = state.copyWith(isLoading: false);
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
      if (isRefresh || status.isNotEmpty) {
        state = state.copyWith(actionItems: [], isLoading: false);
      }

      final items = await logisticsRequestVehicleInstanceInstance
          .getActionItems(
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

          await onReject(
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

        final uploadedFiles = await logisticsRequestVehicleInstanceInstance
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

        await logisticsRequestVehicleInstanceInstance.sendAttachment(
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

        await logisticsRequestVehicleInstanceInstance.sendChat(
          payload,
          requestId,
        );
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
      await logisticsRequestVehicleInstanceInstance.onApprove(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      fetchactionItems();
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

  Future<void> onApprove(Map<String, dynamic> payload) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await logisticsRequestVehicleInstanceInstance.onApprove(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      // if (decisionNo != null) {
      KAppX.router.pop();
      // }
      await fetchactionItems();
      await fetchRequests();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> onReject(
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
      await logisticsRequestVehicleInstanceInstance.onApprove(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      // if (decisionNo != null) {
      KAppX.router.pop();
      // }
      await fetchactionItems();
      await fetchRequests();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> onVehicleAllocate(Map<String, dynamic> payload) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await logisticsRequestVehicleInstanceInstance.onAllocateVehicle(
        payload,
        state.requestDetails.request?.id ?? 0,
      );
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      // if (decisionNo != null) {
      // }
      await fetchactionItems();
      await fetchRequests();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void showApproveForm(BuildContext context, int approverId) {
    KAppX.extendedRouter.dialog.showKDialog(
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Container(
            width: 650,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Approve Vehicle Request',
                          style: TextStyle(
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    ),
                    child: ApproveRequestDialogWidget(
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

  void showVehicleAllocateForm(BuildContext context, int approverId) {
    KAppX.extendedRouter.dialog.showKDialog(
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Container(
            width: 650,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Allocate Vehicle',
                          style: TextStyle(
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    ),
                    child: AllocateVehicleDialogWidget(
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

  Future<void> onSendInProgress(int approverId, int requestId) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload
      final payload = {"request_id": requestId, "status": "In Progress"};

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      // await logisticsRequestVehicleInstanceInstance.onSendInProgress(payload);
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
      if (status.toString().toLowerCase() == 'in progress') {
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
      return ActionButtonsType.approveRejectAllocateVehicle;
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
    state = state.copyWith(tabIndex: index);
    if (index == 0) {
      fetchRequests();
      fetchKpi();
      fetchStatusBreakdown('weekly');
      fetchTrendBreakDown('2026');
    } else {
      fetchactionItems();
      fetchApprovalKpi();
      fetchApprovalStatusBreakdown('monthly');
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
      "req_user_department_id": userInfo?.data?.department?.id ?? 0,

      "req_user_section_id": userInfo?.data?.section?.id ?? 0,

      "service_id": serviceId,
      "sub_service_id": subServiceId,

      "category": values['request_type'] ?? "",

      "vehicle_required_for": values['vehicle_required_for'] ?? "",

      "other_vehicle_required_for": values['other_vehicle_required_for'] ?? "",

      "vehicle_required_location": values['vehicle_required_location'] ?? "",

      "title": values['request_title'] ?? "",

      "purpose_of_travel": values['purpose_of_travel'] ?? "",

      "type_of_vehicle_required": values['type_of_vehicle_required'] ?? "",

      "travel_date_from": values['travel_date_from'] ?? "",

      "travel_date_to": values['travel_date_to'] ?? "",

      "duration": values['duration'] ?? 0,

      "time_of_travel": values['travel_time'] ?? "",

      "type_of_request": values['type_of_request'] ?? "",

      "description": values['description'] ?? "",

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

      final response = await logisticsRequestVehicleInstanceInstance
          .logisticsRequestVehicleCreateRequest(payload);

      if (response['status'] == 'success') {
        _refreshDashboard();
      }
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void _refreshDashboard() {
    fetchKpi();
    fetchStatusBreakdown('monthly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalStatusBreakdown('monthly');
    fetchApprovalTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalKpi();
    fetchRequests();
    fetchactionItems();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
