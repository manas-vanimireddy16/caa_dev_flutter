part of 'view.dart';

final selectedSalalahTabProvider = StateProvider<int>((ref) => 0);

// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");

// Filters data based on searchQuery + selected tab
// final filteredDataProvider = Provider<List<Map<String, dynamic>>>((ref) {
//   final query = ref.watch(searchQueryProvider).toLowerCase();
//   final selectedTab = ref.watch(selectedSalalahTabProvider);

//   // Pick correct dataset
//   // final data = selectedTab == 1 ? requestData : actionItems;

//   // No search → return all
//   if (query.isEmpty) return data;

//   // Filter by ID or Name
//   return data.where((item) {
//     final idMatch = item["requestId"]?.toString().contains(query) ?? false;
//     final nameMatch = (item["requestName"] ?? "")
//         .toString()
//         .toLowerCase()
//         .contains(query);
//     return idMatch || nameMatch;
//   }).toList();
// });

final selectedRoleSalalahProvider = StateProvider<String>((ref) {
  return '';
});

/// Holds all the controllers for the NewRequest form
class NewRequestControllers {
  final personNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final departmentController = TextEditingController();
  final problemController = TextEditingController();
  final descriptionController = TextEditingController();
  final extensionNumberController = TextEditingController();
  final emailController = TextEditingController();
}

/// AutoDispose so controllers are disposed when screen is popped
final newRequestControllerProvider =
    Provider.autoDispose<NewRequestControllers>((ref) {
      final controllers = NewRequestControllers();
      ref.onDispose(() {
        controllers.personNameController.dispose();
        controllers.contactNumberController.dispose();
        controllers.departmentController.dispose();
        controllers.problemController.dispose();
        controllers.descriptionController.dispose();
        controllers.extensionNumberController.dispose();
        controllers.emailController.dispose();
      });
      return controllers;
    });

// // final Map<String, ChartData> requestStatusData = {
//   'open': ChartData(label: 'Open', value: 40, color: Colors.blue),
//   'in_progress': ChartData(
//     label: 'In Progress',
//     value: 25,
//     color: Colors.orange,
//   ),
//   'closed': ChartData(label: 'Closed', value: 60, color: Colors.green),
//   'rejected': ChartData(label: 'Rejected', value: 15, color: Colors.red),
// };

// Example static dataset for 2025
final List<int> monthlyRequestData2025 = [
  30,
  40,
  20,
  50,
  60,
  45,
  70,
  90,
  55,
  65,
  35,
  80,
];

final List<String> monthLabels = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];

// final List<Map<String, dynamic>> requestData = [
//   {
//     "requestId": "REQ-1001",
//     "date": "2025-09-20",
//     "serviceType": "Maintenance",
//     "requestName": "Air Conditioner Repair",
//     "status": "Pending",
//     "assignedTo": "John Doe",
//   },
//   {
//     "requestId": "REQ-1002",
//     "date": "2025-09-21",
//     "serviceType": "Cleaning",
//     "requestName": "Office Cleaning",
//     "status": "Approved",
//     "assignedTo": "Jane Smith",
//   },
//   {
//     "requestId": "REQ-1003",
//     "date": "2025-09-22",
//     "serviceType": "IT Support",
//     "requestName": "Laptop Setup",
//     "status": "Rejected",
//     "assignedTo": "Michael Johnson",
//   },
// ];

final List<Map<String, dynamic>> actionItems = [
  {
    "requestId": "ACT-2001",
    "date": "2025-09-20",
    "serviceType": "Maintenance",
    "requestName": "Fix Projector",
    "status": "Pending",
    "assignedTo": "Alice Brown",
  },
  {
    "requestId": "ACT-2002",
    "date": "2025-09-21",
    "serviceType": "IT Support",
    "requestName": "Install Antivirus",
    "status": "In Progress",
    "assignedTo": "David Wilson",
  },
  {
    "requestId": "ACT-2003",
    "date": "2025-09-22",
    "serviceType": "HR",
    "requestName": "Update Employee Records",
    "status": "Completed",
    "assignedTo": "Emma Davis",
  },
];

//

// final List
// controller/_vs_controller.dart

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
  final String selectedRequestFor;
  final List<Map<String, dynamic>> attachments;
  final List<ServiceData> serviceDropDown;
  final List<RequestsData> requests;
  final RequestDetailData requestDetails;
  final StatusBreakdownModel statusBreakdownCard;
  final TrendBreakdownModel trendData;
  final int requestDetailTab;
  final List<UserItem> itTechnician;
  final List<DepartmentModel> departments;
  final List<SectionModel> sections;
  final int itTechnicianId;
  final List<SalalahActionItem> actionItems;

  final KPIResponse kpiData; //KpiModel kpiData;
  final int serviceId;
  final int subServiceId;
  final int serviceTypeId;
  final int departmentId;
  final int sectionId;
  final bool isPhoneValid;
  final bool isExtensionValid;
  final bool isEmailValid;
  final int tabIndex;

  final KPIResponse approvalKpiData;

  final StatusBreakdownModel statusBreakdown;

  final RequestDetailModel requestDataById;
  final int selectedTab;

  final StatusBreakdownModel approvalStatusBreakdown;
  final TrendBreakdownModel approvalTrendData;
  final bool isButtonDisabled;

  final List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  _ViewState({
    required this.isLoading,
    required this.selectedRequestFor,
    required this.attachments,
    required this.serviceDropDown,
    required this.requests,
    required this.serviceId,
    required this.subServiceId,
    required this.serviceTypeId,
    required this.requestDetails,
    required this.kpiData,
    required this.statusBreakdownCard,
    required this.trendData,
    required this.requestDetailTab,
    required this.itTechnician,
    required this.itTechnicianId,
    required this.departmentId,
    required this.sectionId,
    required this.departments,
    required this.sections,
    required this.isPhoneValid,
    required this.isExtensionValid,
    required this.isEmailValid,
    required this.actionItems,
    required this.tabIndex,
    required this.approvalKpiData,
    required this.statusBreakdown,
    required this.requestDataById,
    required this.selectedTab,
    required this.approvalStatusBreakdown,
    required this.approvalTrendData,
    required this.isButtonDisabled,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        selectedRequestFor: 'Self',
        attachments: [],
        serviceDropDown: [],
        requests: [],
        serviceId: 0,
        subServiceId: 0,
        serviceTypeId: 0,
        requestDetails: RequestDetailData(),
        kpiData: KPIResponse(),
        statusBreakdownCard: StatusBreakdownModel(),
        trendData: TrendBreakdownModel(),
        requestDetailTab: 0,
        itTechnician: [],
        itTechnicianId: 0,
        departmentId: 0,
        sectionId: 0,
        departments: [],
        sections: [],
        isPhoneValid: true,
        isExtensionValid: true,
        isEmailValid: true,
        actionItems: [],
        tabIndex: 0,
        approvalKpiData: KPIResponse(),
        statusBreakdown: StatusBreakdownModel(),
        requestDataById: RequestDetailModel(),
        selectedTab: 0,
        approvalStatusBreakdown: StatusBreakdownModel(),
        approvalTrendData: TrendBreakdownModel(),
        isButtonDisabled: false,
      );

  _ViewState copyWith({
    bool? isLoading,
    String? selectedRequestFor,
    List<Map<String, dynamic>>? attachments,
    List<ServiceData>? serviceDropDown,
    List<RequestsData>? requests,
    final int? serviceId,
    final int? subServiceId,
    final int? serviceTypeId,
    final int? itTechnicianId,
    RequestDetailData? requestDetails,
    KPIResponse? kpiData,
    StatusBreakdownModel? statusBreakdownCard,
    TrendBreakdownModel? trendData,
    int? requestDetailTab,
    List<UserItem>? itTechnician,
    final int? departmentId,
    final int? sectionId,
    final List<DepartmentModel>? departments,
    final List<SectionModel>? sections,
    final bool? isPhoneValid,
    final bool? isExtensionValid,
    final bool? isEmailValid,
    final List<SalalahActionItem>? actionItems,
    final int? tabIndex,
    final KPIResponse? approvalKpiData,
    final StatusBreakdownModel? statusBreakdown,
    final RequestDetailModel? requestDataById,
    final int? selectedTab,
    final StatusBreakdownModel? approvalStatusBreakdown,
    final TrendBreakdownModel? approvalTrendData,
    final bool? isButtonDisabled,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      selectedRequestFor: selectedRequestFor ?? this.selectedRequestFor,
      attachments: attachments ?? this.attachments,
      serviceDropDown: serviceDropDown ?? this.serviceDropDown,
      requests: requests ?? this.requests,
      serviceId: serviceId ?? this.serviceId,
      subServiceId: subServiceId ?? this.subServiceId,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      requestDetails: requestDetails ?? this.requestDetails,
      kpiData: kpiData ?? this.kpiData,
      statusBreakdownCard: statusBreakdownCard ?? this.statusBreakdownCard,
      trendData: trendData ?? this.trendData,
      requestDetailTab: requestDetailTab ?? this.requestDetailTab,
      itTechnician: itTechnician ?? this.itTechnician,
      itTechnicianId: itTechnicianId ?? this.itTechnicianId,
      departmentId: departmentId ?? this.departmentId,
      sectionId: sectionId ?? this.sectionId,
      departments: departments ?? this.departments,
      sections: sections ?? this.sections,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isExtensionValid: isExtensionValid ?? this.isExtensionValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      actionItems: actionItems ?? this.actionItems,
      tabIndex: tabIndex ?? this.tabIndex,
      approvalKpiData: approvalKpiData ?? this.approvalKpiData,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      requestDataById: requestDataById ?? this.requestDataById,
      selectedTab: selectedTab ?? this.selectedTab,
      approvalStatusBreakdown:
          approvalStatusBreakdown ?? this.approvalStatusBreakdown,
      approvalTrendData: approvalTrendData ?? this.approvalTrendData,
      isButtonDisabled: isButtonDisabled ?? this.isButtonDisabled,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final Service service;
  final SubService subService;
  _VSController({required this.service, required this.subService})
    : super(_ViewState.init());
  Timer? _searchDebounce;

  final dashboardinstance = DashboardRepository();

  // TextEditingControllers
  late TextEditingController personNameController;
  late TextEditingController contactNumberController;
  late TextEditingController departmentController;
  late TextEditingController sectionController;
  late TextEditingController problemController;
  late TextEditingController descriptionController;
  late TextEditingController extensionNumberController;
  late TextEditingController emailController;
  late TextEditingController chatController;

  Future<void> initState() async {
    personNameController = TextEditingController();
    contactNumberController = TextEditingController();
    departmentController = TextEditingController();
    sectionController = TextEditingController();
    problemController = TextEditingController();
    descriptionController = TextEditingController();
    extensionNumberController = TextEditingController();
    emailController = TextEditingController();
    chatController = TextEditingController();
    fetchServices();

    fetchKpi();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchDepartments();
    fetchitTechnician();
    await fetchRequests();
    fetchActionItems();
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

  Map<String, String> buildRequestCardData(RequestsData item) {
    final approverMap = resolveApproverMap(item.approvalDetails);

    return {
      'Request Id': item.id?.toString() ?? '-',
      'status': item.status ?? '-',
      'Request By': item.createdByUser?.employeeName ?? '-',

      /// ================= EMPLOYEE INFO =================
      // 'Employee ID': item.employeeId ?? '-',
      // 'Employee Name': item.employeeName ?? '-',

      // /// ================= CURRENT DETAILS =================
      // 'Current Job Title': item.currentJobTitle ?? '-',
      // 'Current Salary Grade': item.currentSalaryGrade ?? '-',
      // 'Current Basic Salary': item.currentBasicSalary ?? '-',

      // /// ================= PROPOSED DETAILS =================
      // 'Proposed Job Title': item.proposedJobTitle ?? '-',
      // 'Proposed Salary Grade': item.proposedSalaryGrade ?? '-',
      // 'Proposed Basic Salary': item.proposedBasicSalary ?? '-',

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
      "Position to be Filled": request?.positionToBeFilled ?? 'N/A',
      "Grade": request?.grade ?? 'N/A',
      "Role / Title of Resource": request?.roleTitle ?? 'N/A',
      "Education Requirements": request?.educationRequirements ?? 'N/A',
      "Required Skills / Expertise": request?.requiredSkills ?? 'N/A',
      "Number of Years of Experience": request?.yearsOfExperience ?? 'N/A',
      "Job Description": request?.jobDescription ?? 'N/A',
    };
  }

  Map<String, String> buildStatusInformation() {
    final request = state.requestDetails;
    final approvals = request.approvalDetails;
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
      PromotionsDetailsRoute(
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
      PromotionsNewRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
  }

  Future<void> fetchServices() async {
    try {
      final services = await dashboardinstance.getServices();

      if (services != null) {
        state = state.copyWith(serviceDropDown: services);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchDepartments() async {
    try {
      final departments = await dashboardinstance.getDepartments();

      if (departments != null) {
        state = state.copyWith(departments: departments);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchSections(int id) async {
    try {
      final sections = await dashboardinstance.getSections(id);

      if (sections != null) {
        state = state.copyWith(sections: sections);
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
    state = state.copyWith(isLoading: true);

    try {
      if (isRefresh || status.isNotEmpty) {
        state = state.copyWith(actionItems: [], isLoading: false);
      }
      final requests = await dashboardinstance.getRequests(
        offset: 1,
        limit: 10,
      );

      if (requests != null) {
        state = state.copyWith(requests: requests);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchActionItems({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      if (isRefresh || status.isNotEmpty) {
        state = state.copyWith(actionItems: [], isLoading: false);
      }
      final items = await dashboardinstance.getActionItems(
        offset: 0,
        limit: 10,
      );
      state = state.copyWith(actionItems: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchKpi() async {
    try {
      final kpis = await dashboardinstance.getKpiData();

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchitTechnician() async {
    try {
      final itTechnician = await dashboardinstance.getItTechnicianDetails();

      if (itTechnician != null) {
        state = state.copyWith(itTechnician: itTechnician.data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchTrendBreakDown(String period) async {
    try {
      final data = await dashboardinstance.getTrendBreakdownData(period);

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalTrendBreakDown(String period) async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await dashboardinstance.getApprovalTrendBreakdownData(
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
      final statusBreakdown = await dashboardinstance
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

  Future<void> fetchRequestDetailsById(int id) async {
    try {
      final requests = await dashboardinstance.getRequestsById(id);
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

  Future<void> fetchStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await dashboardinstance.getStatusBreakdownData(
        period,
      );
      if (statusBreakdown != null) {
        state = state.copyWith(statusBreakdownCard: statusBreakdown);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      // optionally handle other errors
      debugPrint(e.toString());
    }
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

  void validatePhone(String value) {
    final isValid = RegExp(r'^[0-9]{8}$').hasMatch(value);
    state = state.copyWith(isPhoneValid: isValid);
  }

  void validateExtension(String value) {
    final isValid = value.length <= 5;
    state = state.copyWith(isExtensionValid: isValid);
  }

  void validateEmail(String value) {
    final isValid = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
    state = state.copyWith(isEmailValid: isValid);
  }

  void updateServiceId(int value) {
    state = state.copyWith(serviceId: value);
  }

  void updateDepartmentId(int value) {
    state = state.copyWith(departmentId: value);
  }

  void updateSectionId(int value) {
    state = state.copyWith(sectionId: value);
  }

  void updateSubServiceId(int value) {
    state = state.copyWith(subServiceId: value);
  }

  void updateServiceTypeId(int value) {
    state = state.copyWith(serviceTypeId: value);
  }

  void updateTechnicianId(int value) {
    state = state.copyWith(itTechnicianId: value);
  }

  void updateRequestTab(int index) {
    state = state.copyWith(requestDetailTab: index);
  }

  // Pick File
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

  void onselectedRequestFor(String role) =>
      state = state.copyWith(selectedRequestFor: role);

  /// Upload files and send final request
  Future<void> submitRequest() async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files
      final uploadedFiles = await dashboardinstance.uploadAttachments(
        state.attachments,
      );

      final userData = KAppX.globalProvider.read(userInfoProvider);

      // 2️⃣ Build payload
      final payload = {
        "role_id": 2,
        "department_id": userData?.data?.department?.id,
        "section_id": userData?.data?.section?.id,
        "service_id": 1,
        "sub_service_id": 1,
        "service_type_id": state.serviceTypeId,
        "request_for": state.selectedRequestFor,
        "problem": problemController.text,
        "description": descriptionController.text,
        "extn_num": extensionNumberController.text,
        "contact_num": userData?.data?.mobile,
        'request_type': 'external',
        "attachments": uploadedFiles,
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await dashboardinstance.sendRequest(payload);
      fetchRequests();
      KAppX.router.pop();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> selfAssign(String workflowExecutionId, String requestId) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      final userData = KAppX.globalProvider.read(userInfoProvider);

      // 2️⃣ Build payload
      final payload = {
        "workflowInstanceId": workflowExecutionId,
        "user_id": userData?.data?.id,
        "request_id": requestId,
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await dashboardinstance.selfAssign(payload);
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
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
      await dashboardinstance.onClose(payload);
      await fetchActionItems();
      await fetchRequests();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> submitHOSRequest() async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files
      final uploadedFiles = await dashboardinstance.uploadAttachments(
        state.attachments,
      );

      final userData = KAppX.globalProvider.read(userInfoProvider);

      // 2️⃣ Build payload
      final payload = {
        "role_id": 4,
        "department_id": state.departmentId,
        "section_id": state.sectionId,
        "service_id": 1,
        "sub_service_id": 2,
        "service_type_id": state.serviceTypeId,
        "request_for": state.selectedRequestFor,
        "problem": problemController.text,
        "description": descriptionController.text,
        "contact_num": contactNumberController.text,
        "extn_num": extensionNumberController.text,
        "request_type": "internal",
        "approval_user_id": state.itTechnicianId,
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await dashboardinstance.sendRequest(payload);
      fetchRequests();
      KAppX.router.pop();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    personNameController.dispose();
    contactNumberController.dispose();
    departmentController.dispose();
    sectionController.dispose();
    problemController.dispose();
    descriptionController.dispose();
    extensionNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
