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
  final List<AirportPermitRequestModel> requestData;
  final List<AirportPermitRequestModel> actionItems;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final int approvalId;

  final bool isButtonDisabled;
  final List<ChatMessageModel> chatById;
  final List<AttachmentModel> attachmentsById;
  final List<NationalityData> nationalityList;

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
  final List<AirportPermitAreaModel> airportAreas = [
    AirportPermitAreaModel(
      code: 'VIP',
      permit: 'VIP Building',
      color: const Color(0xFFD8C7E8),
    ),
    AirportPermitAreaModel(
      code: 'Carr',
      permit: 'Cargo Building (Imports & Exports)',
      color: const Color(0xFFD6EEF5),
    ),
    AirportPermitAreaModel(
      code: 'Arr',
      permit: 'Arrivals Hall / Arrivals Building',
      color: const Color(0xFFF6C293),
    ),
    AirportPermitAreaModel(
      code: 'Dep',
      permit: 'Departures Hall / Departures Building',
      color: const Color(0xFF2ECC71),
    ),
    AirportPermitAreaModel(
      code: 'ATC',
      permit: 'Information Center / Control Tower',
      color: const Color(0xFFF4F000),
    ),
    AirportPermitAreaModel(
      code: 'Apr',
      permit:
          'Aircraft Parking Area, Aircraft Maintenance Building, Vehicle Repair Workshop, Fire Station, and Fueling Stations',
      color: const Color(0xFF5B9BE6),
    ),
    AirportPermitAreaModel(
      code: 'BHS',
      permit: 'Baggage Sorting Area',
      color: const Color(0xFFE26AD8),
    ),
    AirportPermitAreaModel(
      code: 'Cat',
      permit: 'Catering Building',
      color: const Color(0xFFD9D9D9),
    ),
    AirportPermitAreaModel(
      code: 'MRO',
      permit: 'Aircraft Maintenance Building',
      color: const Color(0xFF9C622E),
    ),
    AirportPermitAreaModel(
      code: 'GLD',
      permit: 'Gold Building',
      color: const Color(0xFFD4A017),
    ),
  ];

  final List<Map<String, dynamic>> vehicles = [
    {
      'chassisNumber': "MHFKU8FS8R0198168",
      'engineNumber': "1GRH393291",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Fortuner 4x4",
      'vehicleNumber': "43/88",
      'no': "1",
    },
    {
      'chassisNumber': "MHFKU8FSXR0197944",
      'engineNumber': "1GRH394412",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Fortuner 4x4",
      'vehicleNumber': "47/88",
      'no': "2",
    },
    {
      'chassisNumber': "MHFKU8FS4R0198183",
      'engineNumber': "1GRH393738",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Fortuner 4x4",
      'vehicleNumber': "42/88",
      'no': "3",
    },
    {
      'chassisNumber': "MHFKU8FS1R0197895",
      'engineNumber': "1GRH3932364",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Fortuner 4x4",
      'vehicleNumber': "45/88",
      'no': "4",
    },
    {
      'chassisNumber': "MHFKU8FS8R0197893",
      'engineNumber': "1GRH392372",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Fortuner 4x4",
      'vehicleNumber': "46/88",
      'no': "5",
    },
    {
      'chassisNumber': "MHFKU8FS3R0198191",
      'engineNumber': "1GRH393620",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Fortuner 4x4",
      'vehicleNumber': "48/88",
      'no': "6",
    },
    {
      'chassisNumber': "MHFKU8FS2R0197906",
      'engineNumber': "1GRH394369",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Fortuner 4x4",
      'vehicleNumber': "37/88",
      'no': "7",
    },
    {
      'chassisNumber': "MHFKU8FS7R0197920",
      'engineNumber': "1GRH393135",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Fortuner 4x4",
      'vehicleNumber': "36/88",
      'no': "8",
    },
    {
      'chassisNumber': "MHFKU8FS3R0198224",
      'engineNumber': "1GRH393976",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Fortuner 4x4",
      'vehicleNumber': "44/88",
      'no': "9",
    },
    {
      'chassisNumber': "MHFKU8FS7R0198226",
      'engineNumber': "1GRH393932",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Fortuner 4x4",
      'vehicleNumber': "49/88",
      'no': "10",
    },
    {
      'chassisNumber': "JTNB19HK8R3246981",
      'engineNumber': "A250D74665",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Camry Sedan",
      'vehicleNumber': "98/88",
      'no': "11",
    },
    {
      'chassisNumber': "JTNB19HK2R3249147",
      'engineNumber': "A250D80919",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Camry Sedan",
      'vehicleNumber': "59/88",
      'no': "12",
    },
    {
      'chassisNumber': "JTNB19HK7R3247409",
      'engineNumber': "A250D76198",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Camry Sedan",
      'vehicleNumber': "57/88",
      'no': "13",
    },
    {
      'chassisNumber': "JTNB19HK7R3248771",
      'engineNumber': "A250D79786",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Camry Sedan",
      'vehicleNumber': "56/88",
      'no': "14",
    },
    {
      'chassisNumber': "JTNB19HK2R3248273",
      'engineNumber': "A250D78346",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Camry Sedan",
      'vehicleNumber': "54/88",
      'no': "15",
    },
    {
      'chassisNumber': "JTNB19HK4R3245794",
      'engineNumber': "A250D71332",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Camry Sedan",
      'vehicleNumber': "24/88",
      'no': "16",
    },
    {
      'chassisNumber': "JTNB19HK1R3245610",
      'engineNumber': "A250D70920",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Camry Sedan",
      'vehicleNumber': "97/88",
      'no': "17",
    },
    {
      'chassisNumber': "JTNB19HKxR3245394",
      'engineNumber': "A250D70280",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Camry Sedan",
      'vehicleNumber': "96/88",
      'no': "18",
    },
    {
      'chassisNumber': "JTNB19HK0R3244965",
      'engineNumber': "A250D69119",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Camry Sedan",
      'vehicleNumber': "76/88",
      'no': "19",
    },
    {
      'chassisNumber': "JTNB19HK1R3248796",
      'engineNumber': "A250D79746",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Camry Sedan",
      'vehicleNumber': "58/88",
      'no': "20",
    },
    {
      'chassisNumber': "JTNB19HK1R3245560",
      'engineNumber': "A250D70818",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Camry Sedan",
      'vehicleNumber': "95/88",
      'no': "21",
    },
    {
      'chassisNumber': "JTNB19HK0R3246909",
      'engineNumber': "A250D74461",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Camry Sedan",
      'vehicleNumber': "79/88",
      'no': "22",
    },
    {
      'chassisNumber': "JTEBU9FJ0PK239298",
      'engineNumber': "1GRC726969",
      'color': "Pearl White",
      'model': "2023",
      'vehicleType': "Toyota Prado 4x4",
      'vehicleNumber': "55/88",
      'no': "23",
    },
    {
      'chassisNumber': "JTEBU9FJ8PK247214",
      'engineNumber': "1GRC792827",
      'color': "Pearl White",
      'model': "2023",
      'vehicleType': "Toyota Prado 4x4",
      'vehicleNumber': "4./88",
      'no': "24",
    },
    {
      'chassisNumber': "JTEBU9FJ6PK246675",
      'engineNumber': "1GRC788110",
      'color': "Pearl White",
      'model': "2023",
      'vehicleType': "Toyota Prado 4x4",
      'vehicleNumber': "5./88",
      'no': "25",
    },
    {
      'chassisNumber': "JTEJU9FJ3B5013808",
      'engineNumber': "A237596",
      'color': "White",
      'model': "2011",
      'vehicleType': "Toyota Prado 4x4",
      'vehicleNumber': "8./88",
      'no': "26",
    },
    {
      'chassisNumber': "JTEJU9FJ8B5016574",
      'engineNumber': "A272362",
      'color': "White",
      'model': "2011",
      'vehicleType': "Toyota Prado 4x4",
      'vehicleNumber': "9./88",
      'no': "27",
    },
    {
      'chassisNumber': "5N1AN0N69CN801970",
      'engineNumber': "930446A",
      'color': "Silver",
      'model': "2011",
      'vehicleType': "Nissan Pathfinder 4x4",
      'vehicleNumber': "23/88",
      'no': "28",
    },
    {
      'chassisNumber': "5N1AR1N80BC600156",
      'engineNumber': "904776A",
      'color': "Silver",
      'model': "2011",
      'vehicleType': "Nissan Pathfinder 4x4",
      'vehicleNumber': "21/88",
      'no': "29",
    },
    {
      'chassisNumber': "5N1AN0N69CN801970",
      'engineNumber': "174185B",
      'color': "White",
      'model': "2012",
      'vehicleType': "Nissan X-Terra 4x4",
      'vehicleNumber': "10./88",
      'no': "30",
    },
    {
      'chassisNumber': "JMYLYV97WDJ703723",
      'engineNumber': "6G758E9XS3556",
      'color': "White",
      'model': "2013",
      'vehicleType': "Toyota Pajero 4x4",
      'vehicleNumber': "6./88",
      'no': "31",
    },
    {
      'chassisNumber': "1GKS27KD6PR329789",
      'engineNumber': "L84APR329789",
      'color': "Brown",
      'model': "2023",
      'vehicleType': "GMC Yukon 4x4",
      'vehicleNumber': "111/88",
      'no': "32",
    },
    {
      'chassisNumber': "MR0DX9CD0R2649011",
      'engineNumber': "2TRB145770",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Hilux Pickup",
      'vehicleNumber': "108/88",
      'no': "33",
    },
    {
      'chassisNumber': "MR0DX9CD3R2649021",
      'engineNumber': "2TRB146621",
      'color': "Pearl White",
      'model': "2024",
      'vehicleType': "Toyota Hilux Pickup",
      'vehicleNumber': "109/88",
      'no': "34",
    },
    {
      'chassisNumber': "MR0EW12G8D3020457",
      'engineNumber': "7433363",
      'color': "White",
      'model': "2013",
      'vehicleType': "Toyota Hilux Pickup",
      'vehicleNumber': "26/88",
      'no': "35",
    },
    {
      'chassisNumber': "MNTDD22S9C6003117",
      'engineNumber': "917712Z",
      'color': "White",
      'model': "2012",
      'vehicleType': "Nissan Pickup",
      'vehicleNumber': "18/88",
      'no': "36",
    },
    {
      'chassisNumber': "MMBJNKA50BD023348",
      'engineNumber': "4G64UCAJ3745",
      'color': "White",
      'model': "2011",
      'vehicleType': "Mitsubishi Pickup",
      'vehicleNumber': "30/88",
      'no': "37",
    },
    {
      'chassisNumber': "JL6BCE6J9DK008760",
      'engineNumber': "6D16A23924",
      'color': "White",
      'model': "2009",
      'vehicleType': "Mitsubishi Truck with Crane",
      'vehicleNumber': "40/88",
      'no': "38",
    },
    {
      'chassisNumber': "4P3SRDJ1ABE802237",
      'engineNumber': "4G69PD4331",
      'color': "White",
      'model': "2011",
      'vehicleType': "Mitsubishi Galant Sedan",
      'vehicleNumber': "29/88",
      'no': "39",
    },
    {
      'chassisNumber': "JL6BCE6J9DK008760",
      'engineNumber': "4D34N38913",
      'color': "White",
      'model': "2013",
      'vehicleType': "Mitsubishi Truck with Crane",
      'vehicleNumber': "27/88",
      'no': "40",
    },
    {
      'chassisNumber': "JTMHU09J0B5051720",
      'engineNumber': "A318476",
      'color': "White",
      'model': "2011",
      'vehicleType': "Toyota Land Cruiser 4x4",
      'vehicleNumber': "1./88",
      'no': "41",
    },
    {
      'chassisNumber': "JN8AY25Y0C9027176",
      'engineNumber': "038827A",
      'color': "Green",
      'model': "2012",
      'vehicleType': "Nissan Patrol 4x4",
      'vehicleNumber': "2./88",
      'no': "42",
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
    required this.isRequestLoading,
    required this.isRequestDetailsLoading,
    required this.nationalityList,
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
        nationalityList: [],
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
    List<AirportPermitRequestModel>? requestData,
    List<AirportPermitRequestModel>? actionItems,
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
    List<NationalityData>? nationalityList,
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
      nationalityList: nationalityList ?? this.nationalityList,
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

  Map<String, String> buildRequestCardData(AirportPermitRequestModel item) {
    final approverMap = resolveApproverMap(item.base?.approvalDetails ?? []);

    return {
      'Request Id': item.base?.id?.toString() ?? '-',
      'status': item.base?.status ?? '-',
      'Request By': item.base?.createdByUser?.employeeName ?? '-',
      'User Name': item.base?.createdByUser?.employeeName ?? '-',
      'Date': formatDate(item.base?.createdAt.toString() ?? 'N/A'),
      'Request Type': item.base?.service?.name ?? 'N/A',
      'Nationality': item.nationality ?? 'N/A',
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
      'Nationality': request?.nationality ?? 'N/A',
      'Date of Birth': request?.dob ?? 'N/A',
      'Airport Name': request?.place ?? 'N/A',

      'Passport/ID Number': request?.passportIdCardNo ?? 'N/A',
      'Category of Permit': request?.categoryOfPermit ?? 'N/A',
      'Date of Submission': formatDate(request?.createdAt ?? 'N/A'),
      'Phone Number': request?.phoneNumber ?? 'N/A',
      'Type of Permit': request?.typeOfPermit ?? 'N/A',
      'Permission to Required Areas':
          request?.permissionToRequiredAreas?.join(', ') ?? 'N/A',
      'Occupation/Staff': request?.occupationStaff ?? 'N/A',
      'Additional Services': request?.additionalServices?.join(', ') ?? 'N/A',
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

    await KAppX.router.push(
      AirportEntryRequestDetailsTabRoute(
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

  Future<void> openNewRequestForm() async {
    await fetchNationalityList();
    KAppX.router.push(
      AirportEntryPermitNewRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
  }

  final userInfo = KAppX.globalProvider.read(userInfoProvider);
  final airportPermitInstance = AirportEntryPermitRepository();
  final residentalUnitRentalInstance = ResidentalUnitRentalRepository();

  List<DynamicField> buildAirportEntryPermitFields(DashboardL10n l10n) => [
    /// ================= FULL NAME =================
    DynamicField(
      name: 'full_name',
      label: l10n.fullNameFamilyName,
      type: FieldType.text,
      required: true,
      placeholder: l10n.enter,
    ),

    /// ================= NATIONALITY =================
    DynamicField(
      name: 'nationality',
      label: l10n.nationality,
      type: FieldType.select,
      required: true,
      placeholder: l10n.select,

      options: state.nationalityList
          .map(
            (e) => DropdownOption(
              value: e.nationalityName ?? '',
              label: e.nationalityName ?? '',
            ),
          )
          .toList(growable: false),
    ),

    /// ================= DATE OF BIRTH =================
    DynamicField(
      name: 'date_of_birth',
      label: l10n.dob,
      type: FieldType.date,
      required: true,
      placeholder: 'dd-mm-yyyy',
    ),

    /// ================= PASSPORT / ID =================
    DynamicField(
      name: 'passport_id',
      label: l10n.passportIdCardNo,
      type: FieldType.text,
      required: true,
      placeholder: l10n.enter,
    ),

    /// ================= CATEGORY OF PERMIT =================
    DynamicField(
      name: 'permit_category',
      label: l10n.categoryOfPermit,
      type: FieldType.select,
      required: true,
      placeholder: l10n.select,

      options: [
        DropdownOption(
          value: 'Issuing New Permit',
          label: l10n.issuingNewPermit,
        ),
        DropdownOption(value: 'Renewal of Permit', label: l10n.renewalOfPermit),
        DropdownOption(value: 'Replacing lost', label: l10n.replacingLost),
        DropdownOption(
          value: 'Cancelling Airport Security Permits',
          label: l10n.cancellingAirportSecurityPermits,
        ),
      ],
    ),

    /// ================= DATE OF SUBMISSION =================
    DynamicField(
      name: 'submission_date',
      label: l10n.dateOfSubmission,
      type: FieldType.date,
      visibleWhen: (values) =>
          values['permit_category'] != 'Cancelling Airport Security Permits',
      required: true,
      initialValue: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    ),

    /// ================= PHONE NUMBER =================
    DynamicField(
      name: 'phone_number',
      label: l10n.phoneNumber,
      type: FieldType.number,
      required: true,
      visibleWhen: (values) =>
          values['permit_category'] != 'Cancelling Airport Security Permits',

      placeholder: l10n.enter,

      validator: (value, values) {
        final phone = value?.toString().trim() ?? '';

        if (phone.isEmpty) {
          return l10n.phoneNumberRequired;
        }

        if (phone.length != 8) {
          return l10n.securityThreatPhoneValidationError();
        }

        return null;
      },
    ),

    /// ================= AIRPORT NAME =================
    DynamicField(
      name: 'airport_name',
      label: l10n.airportName,
      type: FieldType.select,
      required: true,
      visibleWhen: (values) =>
          values['permit_category'] != 'Cancelling Airport Security Permits',

      placeholder: l10n.select,

      options: [
        DropdownOption(value: 'Salalah', label: l10n.salalah),
        DropdownOption(value: 'Muscat', label: l10n.muscat),
        DropdownOption(value: 'Marmul', label: l10n.marmul),
        DropdownOption(value: 'Duqm', label: l10n.duqm),
        DropdownOption(value: 'Sohar', label: l10n.sohar),
        DropdownOption(value: 'Fuhud', label: l10n.fuhud),
        DropdownOption(value: 'Mukhazina', label: l10n.mukhazina),
        DropdownOption(
          value: 'All Civil Airports',
          label: l10n.allCivilAirports,
        ),
      ],
    ),

    /// ================= TYPE OF PERMIT =================
    DynamicField(
      name: 'permit_type',
      label: l10n.typeOfPermit,
      type: FieldType.radio,
      required: true,
      visibleWhen: (values) =>
          values['permit_category'] != 'Cancelling Airport Security Permits',

      initialValue: 'temporary',

      options: [
        DropdownOption(value: 'permanent', label: l10n.permanent),
        DropdownOption(value: 'temporary', label: l10n.temporaryVisit),
      ],
    ),

    /// ================= START DATE =================
    DynamicField(
      name: 'start_date',
      label: l10n.startDate,
      type: FieldType.date,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      required: true,
      visibleWhen: (values) =>
          (values['permit_category'] != 'Cancelling Airport Security Permits' &&
          values['permit_type'] == 'temporary'),

      placeholder: 'dd-mm-yyyy',

      disabledWhen: (values) => values['permit_type'] == 'permanent',
    ),

    /// ================= END DATE =================
    DynamicField(
      name: 'end_date',
      label: l10n.endDate,
      type: FieldType.date,

      required: true,
      placeholder: 'dd-mm-yyyy',
      visibleWhen: (values) =>
          (values['permit_category'] != 'Cancelling Airport Security Permits' &&
          values['permit_type'] == 'temporary'),

      disabledWhen: (values) => values['permit_type'] == 'permanent',

      onChanged: (value, ref) {
        // final values =
        //     ref.read(dynamicFormProvider).formValues;

        // final start = values['start_date'];
        // final end = value;

        // if (start != null && end != null) {
        //   final startDate = DateTime.parse(start);
        //   final endDate = DateTime.parse(end);

        //   final days =
        //       endDate.difference(startDate).inDays;

        //   ref
        //       .read(dynamicFormProvider.notifier)
        //       .updateFieldValue(
        //         'duration_days',
        //         days > 0 ? days.toString() : '0',
        //       );
        // }
      },
    ),

    /// ================= DURATION =================
    DynamicField(
      name: 'duration_days',
      label: l10n.durationDaysAirportEntry,
      type: FieldType.text,
      required: true,
      disabled: true,
      visibleWhen: (values) =>
          (values['permit_category'] != 'Cancelling Airport Security Permits' &&
          values['permit_type'] == 'temporary'),

      placeholder: l10n.autoFilled,
    ),

    DynamicField(
      name: 'required_areas',
      label: l10n.permissionToRequiredAreas,
      type: FieldType.custom,
      required: true,
      visibleWhen: (values) =>
          values['permit_category'] != 'Cancelling Airport Security Permits',
      validator: (value, values) {
        if (!_hasValidRequiredAreas(values)) {
          return l10n.permissionAreaTaskRequired;
        }
        return null;
      },

      builder: (context, ref) {
        return AirportPermissionWidget(
          onChanged: (data) {
            /// FINAL OUTPUT
            /// [
            ///   {
            ///     "permit": "Arrivals Hall / Arrivals Building",
            ///     "text": "srsg"
            ///   }
            /// ]

            debugPrint(data.toString());

            ref
                .read(dynamicFormProvider.notifier)
                .updateValue('required_areas', data);
          },
          service: service,
          subService: subService,
        );
      },
    ),

    /// ================= COMMENTS =================
    DynamicField(
      name: 'comments',
      label: l10n.comments,
      type: FieldType.textarea,
      visibleWhen: (values) =>
          values['permit_category'] != 'Cancelling Airport Security Permits',

      required: false,
      placeholder: l10n.writeHereAr,
    ),

    /// ================= JOB TITLE =================
    DynamicField(
      name: 'job_title',
      label: l10n.jobTitle,
      type: FieldType.text,
      visibleWhen: (values) =>
          values['permit_category'] != 'Cancelling Airport Security Permits',

      required: true,
      initialValue: userInfo?.data?.position?.name ?? '',
      disabled: false,
    ),

    /// ================= ADDITIONAL SERVICES =================
    DynamicField(
      name: 'additional_services',
      label: l10n.additionalServices,
      type: FieldType.select,
      visibleWhen: (values) =>
          values['permit_category'] != 'Cancelling Airport Security Permits',

      required: true,
      placeholder: l10n.select,

      options: [
        DropdownOption(value: 'Laptop / Tablet', label: l10n.laptopTablet),
        DropdownOption(
          value: 'Boarding the Aircraft',
          label: l10n.boardingTheAircraft,
        ),
        DropdownOption(
          value: 'Employee Assisting People with Special Needs',
          label: l10n.employeeAssistingPeopleWithSpecialNeeds,
        ),
      ],
    ),
    DynamicField(
      name: 'additional_services_details',
      label: l10n.enterDeviceSerialNumber,
      type: FieldType.text,
      visibleWhen: (values) =>
          (values['additional_services'] == 'Laptop / Tablet' &&
          values['permit_category'] != 'Cancelling Airport Security Permits'),
      disabledWhen: (values) =>
          values['additional_services'] != 'Laptop / Tablet',
      required: true,

      maxFileSizeInMB: 10,
    ),

    /// ================= ATTACHMENTS =================

    /// ================= COMMON ATTACHMENT =================
    DynamicField(
      name: 'general_attachments',
      label: l10n.attachmentsTabLabel,
      type: FieldType.file,
      required: false,

      visibleWhen: (values) =>
          (values['permit_category'] != 'Renewal of Permit' &&
          values['permit_category'] != 'Issuing New Permit'),

      disabledWhen: (values) =>
          (values['permit_category'] == 'Issuing New Permit' &&
          values['permit_category'] == 'Renewal of Permit'),

      maxFileSizeInMB: 10,
    ),

    /// =====================================================
    /// ISSUING NEW PERMIT
    /// =====================================================
    DynamicField(
      name: 'id_resident_card',
      label: l10n.idCardResidenceCard,
      type: FieldType.file,
      required: true,

      visibleWhen: (values) =>
          (values['permit_category'] == 'Issuing New Permit' &&
          values['permit_category'] != 'Cancelling Airport Security Permits'),

      disabledWhen: (values) =>
          values['permit_category'] != 'Issuing New Permit',

      maxFileSizeInMB: 10,
    ),

    DynamicField(
      name: 'employment_contract',
      label: l10n.employmentContract,
      type: FieldType.file,
      required: true,

      visibleWhen: (values) =>
          (values['permit_category'] == 'Issuing New Permit' &&
          values['permit_category'] != 'Cancelling Airport Security Permits'),

      disabledWhen: (values) =>
          values['permit_category'] != 'Issuing New Permit',

      maxFileSizeInMB: 10,
    ),

    DynamicField(
      name: 'passport_copy',
      label: l10n.passport,
      type: FieldType.file,
      required: false,

      visibleWhen: (values) =>
          (values['permit_category'] == 'Issuing New Permit' &&
          values['permit_category'] != 'Cancelling Airport Security Permits'),

      disabledWhen: (values) =>
          values['permit_category'] != 'Issuing New Permit',

      maxFileSizeInMB: 10,
    ),

    DynamicField(
      name: 'permit_application_form',
      label: l10n.permitApplicationForm,
      type: FieldType.file,
      required: true,

      visibleWhen: (values) =>
          (values['permit_category'] == 'Issuing New Permit' &&
          values['permit_category'] != 'Cancelling Airport Security Permits'),

      disabledWhen: (values) =>
          values['permit_category'] != 'Issuing New Permit',

      maxFileSizeInMB: 10,
    ),

    DynamicField(
      name: 'security_awareness_form',
      label: l10n.securityAwarenessForm,
      type: FieldType.file,
      required: true,

      visibleWhen: (values) =>
          (values['permit_category'] == 'Issuing New Permit' &&
          values['permit_category'] != 'Cancelling Airport Security Permits'),

      disabledWhen: (values) =>
          values['permit_category'] != 'Issuing New Permit',

      maxFileSizeInMB: 10,
    ),

    /// =====================================================
    /// RENEWAL OF PERMIT
    /// =====================================================
    DynamicField(
      name: 'renewal_id_copy',
      label: l10n.copyOfIdCard,
      type: FieldType.file,
      required: true,

      visibleWhen: (values) =>
          (values['permit_category'] == 'Renewal of Permit' &&
          values['permit_category'] != 'Cancelling Airport Security Permits'),

      disabledWhen: (values) =>
          values['permit_category'] != 'Renewal of Permit',

      maxFileSizeInMB: 10,
    ),

    DynamicField(
      name: 'previous_permit_copy',
      label: l10n.copyOfPreviousPermit,
      type: FieldType.file,
      required: true,

      visibleWhen: (values) =>
          (values['permit_category'] == 'Renewal of Permit' &&
          values['permit_category'] != 'Cancelling Airport Security Permits'),

      disabledWhen: (values) =>
          values['permit_category'] != 'Renewal of Permit',

      maxFileSizeInMB: 10,
    ),

    /// =====================================================
    /// REPLACING LOST
    /// =====================================================
    // DynamicField(
    //   name: 'replacement_attachment',
    //   label: 'Attachments',
    //   type: FieldType.file,
    //   required: false,

    //   visibleWhen: (values) =>
    //       (values['permit_category'] == 'Replacing lost' &&
    //       values['permit_category'] != 'Cancelling Airport Security Permits'),

    //   disabledWhen: (values) => values['permit_category'] != 'Replacing lost',

    //   maxFileSizeInMB: 10,
    // ),

    /// =====================================================
    /// CANCELLING AIRPORT SECURITY PERMITS
    /// =====================================================
    /// No attachment fields required
    /// Only acknowledgements will remain visible

    /// ================= ACKNOWLEDGEMENT 1 =================
    DynamicField(
      name: 'acknowledgement_1',
      label: l10n.acknowledgements,
      type: FieldType.acknowledgement,
      required: true,

      acknowledgements: [
        AcknowledgementItem(
          id: 'privacy_policy',
          text: l10n.airportEntryPermitSecurityPrivacyPolicy,
          hasAction: true,
          onTap: (context) async {
            return await KAppX.extendedRouter.dialog.showKDialog<bool>(
              context: context,
              builder: (_) => const CommonPolicyDialog(
                title: 'Security Policies',
                content: '''


Your Privacy Policy
(Last Update: 26 March 2024)

CAA's Security & Privacy policy addresses CAA's practices related to information collection & usage of your personal information.

Information Collection & Usage
Personal information is not collected unless specified or provided by the user. The IP address, from which you access the Internet, the date and time of your access to our website, and the pages you visited (recorded by the text and graphics files that compose the page) are automatically collected. This information is used for statistical and monitoring purposes, and to identify website performance. Third-party consultants are used for statistical analysis, and only aggregated, non-personal information is collected, which does not identify individuals. Collected information is kept confidential, except when legally required or to protect CAA's rights/properties.

Security of Transactions
CAA has implemented generally accepted standards of technology and operational security. The site has security measures, including encryption, to protect sensitive information and meet legal requirements.

Links to third-party websites
CAA's website may link to other sites but is not responsible for their content accuracy or information collection mechanisms. Users are advised to read the Security & Privacy Policy of any third-party site accessed through CAA's website.

Security & Privacy Policy Changes
CAA reserves the right to change the policy at any time, with amended versions always published on CAA's website.

Privacy intrusion
If you suspect privacy compromise: Close all tabs and windows you are browsing CAA's website with and inform us through by email info [at] CAA [dot]gov[dot]om.


            ''',
                acceptText: 'Accept',
                cancelText: 'Close',
              ),
            );
          },
        ),
      ],
    ),

    /// ================= ACKNOWLEDGEMENT 2 =================
    DynamicField(
      name: 'acknowledgement_2',
      label: l10n.acknowledgements,
      type: FieldType.acknowledgement,
      required: true,

      acknowledgements: [
        AcknowledgementItem(
          id: 'disciplinary_action',
          text: l10n.misuseMayResultDisciplinaryAction,
        ),
      ],
    ),
  ];

  bool canSubmitAirportEntryPermit(Map<String, dynamic> values) {
    final permitCategory = values['permit_category'];
    if (!_hasValue(values['full_name']) ||
        !_hasValue(values['nationality']) ||
        !_hasValue(values['date_of_birth']) ||
        !_hasValue(values['passport_id']) ||
        !_hasCheckedAcknowledgements(values['acknowledgement_1']) ||
        !_hasCheckedAcknowledgements(values['acknowledgement_2'])) {
      return false;
    }

    if (permitCategory == 'Cancelling Airport Security Permits') {
      return true;
    }

    if (!_hasValue(values['submission_date']) ||
        !_hasValue(values['phone_number']) ||
        !_hasValue(values['airport_name']) ||
        !_hasValue(values['permit_type']) ||
        !_hasValue(values['job_title']) ||
        !_hasValue(values['additional_services']) ||
        !_hasValidRequiredAreas(values)) {
      return false;
    }

    if (values['permit_type'] == 'temporary' &&
        (!_hasValue(values['start_date']) ||
            !_hasValue(values['end_date']) ||
            !_hasValue(values['duration_days']))) {
      return false;
    }

    if (values['additional_services'] == 'Laptop / Tablet' &&
        !_hasValue(values['additional_services_details'])) {
      return false;
    }

    if (permitCategory == 'Issuing New Permit') {
      return _hasValue(values['id_resident_card']) &&
          _hasValue(values['employment_contract']) &&
          _hasValue(values['permit_application_form']) &&
          _hasValue(values['security_awareness_form']);
    }

    if (permitCategory == 'Renewal of Permit') {
      return _hasValue(values['renewal_id_copy']) &&
          _hasValue(values['previous_permit_copy']);
    }

    return true;
  }

  static bool _hasValidRequiredAreas(Map<String, dynamic> values) {
    final requiredAreas = values['required_areas'];
    if (requiredAreas is! List || requiredAreas.isEmpty) {
      return false;
    }

    return requiredAreas.every((area) {
      if (area is! Map) return false;
      final text = area['text']?.toString().trim() ?? '';
      return text.isNotEmpty;
    });
  }

  static bool _hasValue(dynamic value) {
    if (value == null) return false;
    if (value is String) return value.trim().isNotEmpty;
    if (value is List) return value.isNotEmpty;
    return true;
  }

  static bool _hasCheckedAcknowledgements(dynamic value) {
    if (value is! List || value.isEmpty) return false;
    return value.every((item) {
      if (item is AcknowledgementItem) {
        return !item.isRequired || item.isChecked;
      }
      return false;
    });
  }

  /// ========================= API CALLS =========================

  Future<void> fetchRequestDetailsById(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      final requests = await airportPermitInstance.getRequestsById(
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
      final requests = await airportPermitInstance.getchatById(
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
      final attachments = await airportPermitInstance.getAttachmentsById(
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
      final kpis = await airportPermitInstance.getKpiData(
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
      final data = await airportPermitInstance.getApprovalTrendBreakdownData(
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
      final statusBreakdown = await airportPermitInstance
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
      final statusBreakdown = await airportPermitInstance
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
      final data = await airportPermitInstance.getTrendBreakdownData(
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
      final kpis = await airportPermitInstance.getApprovalKpiData(
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

  Future<void> fetchNationalityList() async {
    state = state.copyWith(isLoading: true);
    try {
      // Clear list only if explicitly refreshing or searching

      final requests = await airportPermitInstance.getNationalityList();

      // No merging needed
      state = state.copyWith(nationalityList: requests, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      Fluttertoast.showToast(msg: e.toString());
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

      final requests = await airportPermitInstance.getRequests(
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
      final items = await airportPermitInstance.getActionItems(
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

        final uploadedFiles = await airportPermitInstance.uploadAttachments(
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

        await airportPermitInstance.sendAttachment(payload, requestId);
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

        await airportPermitInstance.sendChat(payload, requestId);
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
      await airportPermitInstance.onApprove(payload);
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
      await airportPermitInstance.onApprove(payload);
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
      await airportPermitInstance.onAllocateVehicle(
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

  Future<void> onSendInProgress(int approverId, int requestId) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload
      final payload = {"request_id": requestId, "status": "In Progress"};

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      // await airportPermitInstance.onSendInProgress(payload);
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
      return ActionButtonsType.approveReject;
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
    state = state.copyWith(tabIndex: index);
    if (index == 0) {
      fetchRequests();
      fetchKpi();
      fetchStatusBreakdown('weekly');
      fetchTrendBreakDown(DateTime.now().year.toString());
    } else {
      fetchactionItems(isRefresh: true);
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

    final permitCategory = values['permit_category'] ?? '';

    final permitType = values['permit_type'];

    /// =====================================================
    /// ✅ COMMON PAYLOAD
    /// =====================================================

    final payload = <String, dynamic>{
      /// USER INFO
      "req_user_department_id": userInfo?.data?.department?.id ?? 0,

      "req_user_section_id": userInfo?.data?.section?.id ?? 0,

      /// SERVICE INFO
      "service_id": serviceId,

      "sub_service_id": subServiceId,

      /// PERSONAL DETAILS
      "name_full_family_name": values['full_name'] ?? "",

      "nationality": values['nationality'] ?? "",

      "dob": _formatDate(values['date_of_birth']),

      "place": values['location'] ?? "",

      "passport_id_card_no": values['passport_id'] ?? "",

      /// PERMIT
      "category_of_permit": permitCategory,

      "date_of_submission": _formatDate(values['submission_date']),

      "location": "Muscat",

      "details": values['comments'] ?? "",

      "occupation_staff": values['job_title'] ?? "",
    };

    /// =====================================================
    /// ✅ TYPE OF PERMIT
    /// =====================================================

    if (permitCategory != 'Cancelling Airport Security Permits') {
      if (permitType == 'temporary') {
        payload["type_of_permit"] = "Temporary";

        payload["temporary_start_time"] = _formatDate(values['start_date']);

        payload["temporary_duration"] =
            values['duration_days']?.toString().replaceAll(' Day(s)', '') ?? "";
      } else if (permitType == 'permanent') {
        payload["type_of_permit"] = "Permanent";
      }
    }

    /// =====================================================
    /// ✅ REQUIRED AREAS
    /// =====================================================

    if (values['required_areas'] != null &&
        values['required_areas'] is List &&
        (values['required_areas'] as List).isNotEmpty) {
      payload["permission_to_required_areas"] = values['required_areas'];
    }

    /// =====================================================
    /// ✅ ADDITIONAL SERVICES
    /// =====================================================

    if (values['additional_services'] != null &&
        values['additional_services'].toString().trim().isNotEmpty) {
      payload["additional_services"] = [values['additional_services']];

      /// =====================================================
      /// ✅ DEVICE SERIAL NUMBER
      /// =====================================================

      if (values['additional_services'] == 'Laptop / Tablet' &&
          values['device_serial_number'] != null &&
          values['device_serial_number'].toString().trim().isNotEmpty) {
        payload["device_serial_number"] = values['device_serial_number'];
      }
    }

    /// =====================================================
    /// ✅ END DATE
    /// =====================================================

    if (values['end_date'] != null &&
        values['end_date'].toString().trim().isNotEmpty) {
      payload["end_date"] = _formatDate(values['end_date']);
    }

    /// =====================================================
    /// ✅ ATTACHMENTS
    /// =====================================================

    final attachments = <Map<String, dynamic>>[];

    /// =====================================================
    /// ✅ ISSUING NEW PERMIT
    /// =====================================================

    if (permitCategory == 'Issuing New Permit') {
      final idCard =
          (values['id_resident_card'] as List<FileUploadItem>?)?.firstOrNull;

      final employment =
          (values['employment_contract'] as List<FileUploadItem>?)?.firstOrNull;

      final passport =
          (values['passport_copy'] as List<FileUploadItem>?)?.firstOrNull;

      final permitForm =
          (values['permit_application_form'] as List<FileUploadItem>?)
              ?.firstOrNull;

      final securityForm =
          (values['security_awareness_form'] as List<FileUploadItem>?)
              ?.firstOrNull;

      payload["new_permit_issuance_file"] = permitForm?.filename;

      if (idCard != null) {
        attachments.add({
          ...idCard.toJson(),
          "description": "id-resident-card",
        });
      }

      if (employment != null) {
        attachments.add({
          ...employment.toJson(),
          "description": "employment-contract",
        });
      }

      if (passport != null) {
        attachments.add({...passport.toJson(), "description": "passport-copy"});
      }

      if (permitForm != null) {
        attachments.add({
          ...permitForm.toJson(),
          "description": "permit-application-form",
        });
      }

      if (securityForm != null) {
        attachments.add({
          ...securityForm.toJson(),
          "description": "security-awareness-form",
        });
      }
    }

    /// =====================================================
    /// ✅ RENEWAL OF PERMIT
    /// =====================================================

    if (permitCategory == 'Renewal of Permit') {
      final renewalIdCopy =
          (values['renewal_id_copy'] as List<FileUploadItem>?)?.firstOrNull;

      final previousPermitCopy =
          (values['previous_permit_copy'] as List<FileUploadItem>?)
              ?.firstOrNull;

      /// API expects STRING URL
      payload["permit_renewal_file"] = previousPermitCopy?.filename;

      if (renewalIdCopy != null) {
        attachments.add({
          ...renewalIdCopy.toJson(),
          "description": "renewal-id-card-copy",
        });
      }

      if (previousPermitCopy != null) {
        attachments.add({
          ...previousPermitCopy.toJson(),
          "description": "renewal-previous-permit-copy",
        });
      }
    }

    /// =====================================================
    /// ✅ GENERAL ATTACHMENTS
    /// =====================================================

    final generalAttachments =
        values['general_attachments'] as List<FileUploadItem>?;

    if (generalAttachments != null && generalAttachments.isNotEmpty) {
      attachments.addAll(
        generalAttachments.map(
          (file) => {...file.toJson(), "description": "general-attachment"},
        ),
      );
    }

    /// =====================================================
    /// ✅ FINAL ATTACHMENTS
    /// =====================================================

    if (attachments.isNotEmpty) {
      payload["attachments"] = attachments;
    }

    /// =====================================================
    /// ✅ REMOVE NULL / EMPTY
    /// =====================================================

    payload.removeWhere((key, value) {
      if (value == null) {
        return true;
      }

      if (value is String && value.trim().isEmpty) {
        return true;
      }

      if (value is List && value.isEmpty) {
        return true;
      }

      if (value is Map && value.isEmpty) {
        return true;
      }

      return false;
    });

    return payload;
  }

  /// =====================================================
  /// ✅ DATE FORMATTER
  /// =====================================================

  String _formatDate(dynamic date) {
    if (date == null) {
      return "";
    }

    try {
      if (date is DateTime) {
        return DateFormat('yyyy-MM-dd').format(date);
      }

      final parsedDate = DateTime.parse(date.toString());

      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      return date.toString();
    }
  }

  /// =====================================================
  /// ✅ DATE FORMATTER
  /// =====================================================

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

      final response = await airportPermitInstance.airportEntryCreateRequest(
        payload,
      );

      if (response['status'] == 'success') {
        state = state.copyWith(isRequestLoading: true, requestData: []);
        _refreshDashboard();
      }
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
