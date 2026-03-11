part of 'view.dart';

// import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
// import 'package:code_setup/presentation/Models/commentItem.dart';
// import 'package:code_setup/presentation/Models/kpi.dart';
// import 'package:code_setup/presentation/screens/logistics/models/activityField.dart';
// import 'package:code_setup/presentation/screens/logistics/models/dashBoardRequest.dart';
// import 'package:code_setup/presentation/screens/logistics/models/kpi.dart';
// import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
// import 'package:code_setup/presentation/screens/logistics/models/logistics_trend_breakdown_model.dart';
// import 'package:code_setup/presentation/screens/logistics/models/passengerModel.dart';
// import 'package:code_setup/presentation/screens/logistics/models/passengeruiModel.dart';
// import 'package:code_setup/presentation/screens/logistics/models/status_breakdown.dart';
// import 'package:code_setup/presentation/screens/request_details/models/attachmentModel.dart';
// import 'package:code_setup/presentation/screens/request_details/models/taskModel.dart';
// import 'package:code_setup/repository/logistics/domain/logistics_dashboard.dart';
// import 'package:code_setup/utils/app_extensions/app_extension.dart';
// import 'package:code_setup/utils/helper/exception_handling.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttertoast/fluttertoast.dart';

final selectedrequesteventTabProvider = StateProvider<int>((ref) => 0);

// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");

// Filters data based on searchQuery + selected tab
final filteredDataProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final selectedTab = ref.watch(selectedrequesteventTabProvider);

  // Pick correct dataset
  final data = selectedTab == 1 ? requestData : actionItems;

  // No search → return all
  if (query.isEmpty) return data;

  // Filter by ID or Name
  return data.where((item) {
    final idMatch = item["requestId"]?.toString().contains(query) ?? false;
    final nameMatch = (item["requestName"] ?? "")
        .toString()
        .toLowerCase()
        .contains(query);
    return idMatch || nameMatch;
  }).toList();
});

final selectedRolerequesteventProvider = StateProvider<String>((ref) {
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

/// Provider returning read-only list
final ticketProvider = Provider<List<StatSummaryRData>>((ref) {
  return [
    StatSummaryRData(
      title: "Total Tickets",
      count: "48",
      description: "All tickets recorded so far",
      icon: Icons.list_alt_outlined,
      iconBgColor: Colors.grey,
    ),
    StatSummaryRData(
      title: "Open Tickets",
      count: "32",
      description: "Tickets waiting for action",
      icon: Icons.lock_open_rounded,
      iconBgColor: Colors.blue,
    ),
    StatSummaryRData(
      title: "In Progress",
      count: "8",
      description: "Currently being worked on",
      icon: Icons.access_time,
      iconBgColor: Colors.orange,
    ),
    StatSummaryRData(
      title: "Closed",
      count: "8",
      description: "Completed and resolved tickets",
      icon: Icons.lock,
      iconBgColor: Colors.green,
    ),
  ];
});

// final Map<String, ChartData> requestStatusData = {
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

final List<Map<String, dynamic>> requestData = [
  {
    "requestId": "REQ-1001",
    "date": "2025-09-20",
    "serviceType": "Maintenance",
    "requestName": "Air Conditioner Repair",
    "status": "Pending",
    "assignedTo": "John Doe",
  },
  {
    "requestId": "REQ-1002",
    "date": "2025-09-21",
    "serviceType": "Cleaning",
    "requestName": "Office Cleaning",
    "status": "Approved",
    "assignedTo": "Jane Smith",
  },
  {
    "requestId": "REQ-1003",
    "date": "2025-09-22",
    "serviceType": "IT Support",
    "requestName": "Laptop Setup",
    "status": "Rejected",
    "assignedTo": "Michael Johnson",
  },
];

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

final List<CommentItemRD> comments1 = [
  CommentItemRD(
    userName: "Evelyn Parker",
    initials: "EP",
    message: "Shared the updated budget file for your review.",
    status: "Submitted",
    dateTime: DateTime.now().subtract(const Duration(hours: 1, minutes: 15)),
  ),
  CommentItemRD(
    userName: "Frank Miller",
    initials: "FM",
    message: "The technical feasibility looks fine. Proceeding ahead.",
    status: "Approved",
    dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
  ),
  CommentItemRD(
    userName: "Grace Thompson",
    initials: "GT",
    message: "Need more clarity on vendor selection process.",
    status: "Pending",
    dateTime: DateTime.now().subtract(const Duration(days: 2, hours: 6)),
  ),
  CommentItemRD(
    userName: "Henry Wilson",
    initials: "HW",
    message: "Declined due to incomplete compliance documents.",
    status: "Rejected",
    dateTime: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
  ),
];

List<TaskRD> tasksData1 = [
  TaskRD(
    taskName: "Initial Request Logged",
    status: "completed",
    approvedBy: "Sophia Ali",
    date: "05 Sep, 2025",
  ),
  TaskRD(
    taskName: "Reviewed by Department Head",
    status: "completed",
    approvedBy: "Omar Hassan",
    date: "06 Sep, 2025",
  ),
  TaskRD(
    taskName: "Awaiting Finance Team Approval",
    status: "pending",
    approvedBy: "NA",
  ),
  TaskRD(
    taskName: "Final Notification Dispatch",
    status: "not_started",
    approvedBy: "",
  ),
];

final requestDeatilsTabSelectedProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);
final List<AttachmentsmodelRD> attachments1 = [
  AttachmentsmodelRD(
    documentName: "Updated Budget Sheet",
    fileType: "budget.xlsx",
    uploadedDate: "10 Sep 2025",
    downloadUrl: "https://example.com/budget.xlsx",
    action: "Edit/Delete",
  ),
  AttachmentsmodelRD(
    documentName: "Technical Proposal",
    fileType: "proposal.docx",
    uploadedDate: "11 Sep 2025",
    downloadUrl: "https://example.com/proposal.docx",
    action: "Edit/Delete",
  ),
  AttachmentsmodelRD(
    documentName: "Compliance Report",
    fileType: "compliance.pdf",
    uploadedDate: "13 Sep 2025",
    downloadUrl: "https://example.com/compliance.pdf",
    action: "Edit/Delete",
  ),
  AttachmentsmodelRD(
    documentName: "Vendor Quotation",
    fileType: "quotation.pdf",
    uploadedDate: "14 Sep 2025",
    downloadUrl: "https://example.com/quotation.pdf",
    action: "Edit/Delete",
  ),
];

final _vsProvider =
    StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
      final stateController = _VSController();
      stateController.initState();
      return stateController;
    });

class _ViewState {
  final bool isLoading;
  // final String fromDate;
  // final String toDate;
  // final String selectedRole;
  // final String travelTime;
  // final String vehicleRequiredfor;
  // final String vehicleRequiredLocation;
  // final String purposeofTravel;
  // final String vehicleTypeDaily;
  // final int expectedDaysinTravel;
  // final int expectedHoursinTravel;
  // final List<PassengerUIModel> passengers;
  // final List<Map<String, dynamic>> attachments;
  // final String vehicleType;
  // final String travelTimeForUI;
  final CombinedKpiLogisticsResponse kpiData;
  final CombinedKpiLogisticsResponse kpiDataEmployee;
  final CombinedKpiLogisticsResponse kpiDataForeigner;
  final List<ActivityFeedData> activityFeed;
  final List<RequestData> dashboardMyRequests;
  final List<AllRequestsDashboardData> allRequests;
  // final StatusBreakdownModel statusBreakdown;
  // final LogisticsTrendBreakdownModel trendData;
  final LogisticsRequestDetailModel requestDataById;

  _ViewState({
    required this.isLoading,
    // required this.fromDate,
    // required this.toDate,
    // required this.selectedRole,
    // required this.travelTime,
    // required this.passengers,
    // required this.vehicleRequiredfor,
    // required this.vehicleRequiredLocation,
    // required this.purposeofTravel,
    // required this.vehicleTypeDaily,
    // required this.expectedDaysinTravel,
    // required this.expectedHoursinTravel,
    // required this.attachments,
    // required this.vehicleType,
    // required this.travelTimeForUI,
    required this.kpiData,
    required this.kpiDataEmployee,
    required this.kpiDataForeigner,
    required this.activityFeed,
    required this.dashboardMyRequests,
    // required this.statusBreakdown,
    // required this.trendData,
    required this.requestDataById,
    required this.allRequests,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        // fromDate: '',
        // toDate: '',
        // selectedRole: '',
        // travelTime: '',
        // passengers: [PassengerUIModel()],
        // vehicleRequiredfor: '',
        // vehicleRequiredLocation: '',
        // purposeofTravel: '',
        // vehicleTypeDaily: '',
        // expectedDaysinTravel: 0,
        // expectedHoursinTravel: 0,
        // attachments: [],
        // vehicleType: '',
        // travelTimeForUI: '',
        kpiData: CombinedKpiLogisticsResponse(),
        kpiDataEmployee: CombinedKpiLogisticsResponse(),
        kpiDataForeigner: CombinedKpiLogisticsResponse(),
        activityFeed: [],
        dashboardMyRequests: [],
        // statusBreakdown: StatusBreakdownModel(),
        // trendData: LogisticsTrendBreakdownModel(),
        requestDataById: LogisticsRequestDetailModel(),
        allRequests: [],
      );

  _ViewState copyWith({
    bool? isLoading,
    String? fromDate,
    String? toDate,
    String? selectedRole,
    String? travelTime,
    List<PassengerUIModel>? passengers,
    String? vehicleRequiredfor,
    String? vehicleRequiredLocation,
    String? purposeofTravel,
    String? vehicleTypeDaily,
    int? expectedDaysinTravel,
    int? expectedHoursinTravel,
    List<Map<String, dynamic>>? attachments,
    String? vehicleType,
    String? travelTimeForUI,
    CombinedKpiLogisticsResponse? kpiData,
    CombinedKpiLogisticsResponse? kpiDataEmployee,
    CombinedKpiLogisticsResponse? kpiDataForeigner,
    List<ActivityFeedData>? activityFeed,
    List<RequestData>? dashboardMyRequests,
    StatusBreakdownModel? statusBreakdown,
    LogisticsTrendBreakdownModel? trendData,
    LogisticsRequestDetailModel? requestDataById,
    List<AllRequestsDashboardData>? allRequests,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      // fromDate: fromDate ?? this.fromDate,
      // toDate: toDate ?? this.toDate,
      // selectedRole: selectedRole ?? this.selectedRole,
      // travelTime: travelTime ?? this.travelTime,
      // passengers: passengers ?? this.passengers,
      // vehicleRequiredfor: vehicleRequiredfor ?? this.vehicleRequiredfor,
      // vehicleRequiredLocation:
      //     vehicleRequiredLocation ?? this.vehicleRequiredLocation,
      // purposeofTravel: purposeofTravel ?? this.purposeofTravel,
      // vehicleTypeDaily: vehicleTypeDaily ?? this.vehicleTypeDaily,
      // expectedDaysinTravel: expectedDaysinTravel ?? this.expectedDaysinTravel,
      // expectedHoursinTravel:
      //     expectedHoursinTravel ?? this.expectedHoursinTravel,
      // attachments: attachments ?? this.attachments,
      // vehicleType: vehicleType ?? this.vehicleType,
      // travelTimeForUI: travelTimeForUI ?? this.travelTimeForUI,
      kpiData: kpiData ?? this.kpiData,
      kpiDataEmployee: kpiDataEmployee ?? this.kpiDataEmployee,
      kpiDataForeigner: kpiDataForeigner ?? this.kpiDataForeigner,
      activityFeed: activityFeed ?? this.activityFeed,
      dashboardMyRequests: dashboardMyRequests ?? this.dashboardMyRequests,
      // statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      // trendData: trendData ?? this.trendData,
      requestDataById: requestDataById ?? this.requestDataById,
      allRequests: allRequests ?? this.allRequests,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());
  late TextEditingController eventTypeController;
  late TextEditingController departmentController;
  late TextEditingController contactNumberController;
  late TextEditingController reasonController;
  late TextEditingController descriptionController;
  late TextEditingController employeeIdController;
  late TextEditingController originCityController;
  late TextEditingController destinationCityController;
  late TextEditingController vehicleRequiredLocationController;
  late TextEditingController contactNumberForeignController;
  late TextEditingController chatController;

  void initState() {
    eventTypeController = TextEditingController();
    departmentController = TextEditingController();
    contactNumberController = TextEditingController();
    reasonController = TextEditingController();
    employeeIdController = TextEditingController();
    originCityController = TextEditingController();
    destinationCityController = TextEditingController();
    vehicleRequiredLocationController = TextEditingController();
    contactNumberForeignController = TextEditingController();
    descriptionController = TextEditingController();
    chatController = TextEditingController();
    fetchKpi();
    fetchKpiEmployee();
    fetchKpiForeigner();
    fetchActivityFeed();
    // fetchDashboardMyRequests();
    fetchAllMyRequests();
    fetchStatusBreakDown('weekly');
    fetchTrendBreakDown('2025');
  }

  final logisticsDashboardinstance = LogisticsDashboardRepository();

  Future<void> fetchKpi() async {
    try {
      final kpis = await logisticsDashboardinstance.getKpiData();

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  // Future<void> fetchDetialsById(int id) async {
  //   try {
  //     final data = await logisticsDashboardinstance.getRequestDetailsById(id);

  //     if (data != null) {
  //       state = state.copyWith(requestDataById: data);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {}
  // }

  Future<void> fetchKpiEmployee() async {
    try {
      final kpis = await logisticsDashboardinstance.getKpiDataEmployee();

      if (kpis != null) {
        state = state.copyWith(kpiDataEmployee: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchKpiForeigner() async {
    try {
      final kpis = await logisticsDashboardinstance.getKpiDataForeigner();

      if (kpis != null) {
        state = state.copyWith(kpiDataForeigner: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchActivityFeed() async {
    try {
      final activityFeed = await logisticsDashboardinstance.getActivityFeed();

      if (activityFeed != null) {
        state = state.copyWith(activityFeed: activityFeed);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  // Future<void> fetchDashboardMyRequests() async {
  //   try {
  //     final myrequests = await logisticsDashboardinstance
  //         .getDashboardRequestData();

  //     if (myrequests != null) {
  //       state = state.copyWith(dashboardMyRequests: myrequests);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {}
  // }

  Future<void> fetchAllMyRequests({
    bool isRefresh = false,
    String? searchText,
    String? status,
  }) async {
    try {
      // Ensure safe defaults (no null → empty string)
      final safeSearchText = searchText?.trim() ?? '';
      final safeStatus = status?.trim() ?? '';

      // Clear list only on refresh or when new search applied
      if (isRefresh || safeSearchText.isNotEmpty) {
        state = state.copyWith(allRequests: []);
      }

      // Fetch API data
      final response = await logisticsDashboardinstance.getAllRequestData(
        offset: 1,
        limit: 10,
        sortBy: 'created_at',
        sortOrder: 'DESC',
        status: safeStatus,
        searchText: safeSearchText,
      );

      // Defensive check in case response is null
      if (response != null && response.isNotEmpty) {
        final updatedList = (isRefresh || safeSearchText.isNotEmpty)
            ? response
            : [...state.allRequests, ...response];

        // Remove duplicates by ID (avoids crashing if null IDs exist)
        final uniqueList = {
          for (var item in updatedList)
            if (item.id != null) item.id!: item,
        }.values.toList();

        state = state.copyWith(allRequests: uniqueList);
      } else {
        // If response empty on refresh/search, clear list
        if (isRefresh || safeSearchText.isNotEmpty) {
          state = state.copyWith(allRequests: []);
        }
      }
    } catch (e, stack) {
      debugPrint('fetchAllMyRequests error: $e\n$stack');
      Fluttertoast.showToast(msg: 'Error fetching requests: $e');
    }
  }

  Future<void> fetchRequestsById(int id) async {
    try {
      final data = await logisticsDashboardinstance.getRequestDetailsById(id);

      if (data != null) {
        state = state.copyWith(requestDataById: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchStatusBreakDown(String period) async {
    try {
      final data = await logisticsDashboardinstance.getStatusBreakdown(period);

      if (data != null) {
        state = state.copyWith(statusBreakdown: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchTrendBreakDown(String period) async {
    try {
      final data = await logisticsDashboardinstance.getTrendBreakdown(period);

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  void onSelectFromDate(String date) => state = state.copyWith(fromDate: date);
  void onSelectTravelTime(String time) =>
      state = state.copyWith(travelTime: time);
  void onSelectedRole(String role) =>
      state = state.copyWith(selectedRole: role);

  void onSelectedVehicleType(String value) =>
      state = state.copyWith(vehicleType: value);

  void onSelectedTravelTime(String value) =>
      state = state.copyWith(travelTime: value);

  void onSelectedVehicleRequiredFor(String value) =>
      state = state.copyWith(vehicleRequiredfor: value);

  void onSelectedVehicleRequiredLocation(String value) =>
      state = state.copyWith(vehicleRequiredLocation: value);

  void onSelectedPurposeOfTravel(String value) =>
      state = state.copyWith(purposeofTravel: value);

  void onSelectedExpectedDaysInTravel(int value) =>
      state = state.copyWith(expectedDaysinTravel: value);

  void onSelectedExpectedHoursInTravel(int value) =>
      state = state.copyWith(expectedHoursinTravel: value);
  void onSelectTravelTimeUI(String time) =>
      state = state.copyWith(travelTimeForUI: time);
  void refreshUI() {
    // triggers rebuild in UI
    state = state.copyWith();
  }

  // Future<void> pickFile() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     allowMultiple: true,
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'doc', 'docx'],
  //   );

  //   if (result != null) {
  //     final newFiles = result.files.map((file) {
  //       return {
  //         "file_name": file.name,
  //         "file_type": file.extension,
  //         "file_size": file.size,
  //         "path": file.path,
  //         "file_url": file.path, // local file location added here
  //         "description": '', // optional, can be updated later
  //       };
  //     }).toList();

  //     state = state.copyWith(attachments: [...state.attachments, ...newFiles]);
  //   }
  // }

  // void removeFile(Map<String, dynamic> file) {
  //   final updated = List<Map<String, dynamic>>.from(state.attachments)
  //     ..remove(file);
  //   state = state.copyWith(attachments: updated);
  // }

  // Future<String> sendChat(int id, String message, String type) async {
  //   try {
  //     state = state.copyWith(isLoading: true);

  //     List<dynamic> uploadedFiles = [];

  //     // 🧩 1️⃣ Upload only if not a text message
  //     if (type != 'text') {
  //       debugPrint('📎 Attachment Message: $message');
  //       uploadedFiles = await logisticsDashboardinstance.uploadAttachments(
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
  //     final resMessage = await logisticsDashboardinstance.sendChat(
  //       payload,
  //       id,
  //       type,
  //     );

  //     // 🧩 5️⃣ Refresh UI state
  //     await fetchRequestsById(id);

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

  // Future<void> vehicleRequest() async {
  //   try {
  //     state = state.copyWith(isLoading: true);

  //     // 1️⃣ Upload files
  //     final uploadedFiles = await logisticsDashboardinstance.uploadAttachments(
  //       state.attachments,
  //     );

  //     final userData = KAppX.globalProvider.read(userProvider);

  //     // 2️⃣ Build payload
  //     final payload = {
  //       "req_user_department_id": userData?.department,
  //       "req_user_section_id": userData?.section,
  //       "service_id": 20,
  //       "sub_service_id": 12,
  //       "category": state.selectedRole,
  //       "vehicle_required_for": state.vehicleRequiredfor,
  //       "vehicle_required_location": state.vehicleRequiredLocation,
  //       "title": eventTypeController.text,
  //       "purpose_of_travel": state.purposeofTravel,
  //       "type_of_vehicle_required": state.vehicleType,
  //       "date_of_travel": state.fromDate,
  //       "time_of_travel": state.travelTime,
  //       "exp_duration_of_use_hrs": state.expectedHoursinTravel,
  //       "exp_duration_of_use_days": state.expectedDaysinTravel,
  //       "type_of_request": 'New Request',
  //       "description": descriptionController.text,
  //       "attachments": uploadedFiles,
  //     };

  //     debugPrint("✅ Final Payload: $payload");
  //     print("✅ Final Payload=============: $payload");

  //     // 3️⃣ Send request
  //     await logisticsDashboardinstance.sendVehicleRequest(payload);
  //     state = state.copyWith(attachments: []);
  //   } catch (e) {
  //     debugPrint('❌ Error submitting request: $e');
  //   } finally {
  //     state = state.copyWith(isLoading: false);
  //   }
  // }

  // // --- Passenger Logic ---

  // void addPassenger() {
  //   final updatedList = [...state.passengers, PassengerUIModel()];
  //   state = state.copyWith(passengers: updatedList);
  // }

  // void removePassenger(int index) {
  //   if (state.passengers.length <= 1) return; // 👈 Prevent deleting last one

  //   final updatedList = [...state.passengers];
  //   updatedList[index].dispose();
  //   updatedList.removeAt(index);
  //   state = state.copyWith(passengers: updatedList);
  // }

  // // Validation check before submission
  // bool validatePassenge0rs(BuildContext context) {
  //   for (var i = 0; i < state.passengers.length; i++) {
  //     if (state.passengers[i].nameController.text.trim().isEmpty) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Please enter name for Passenger ${i + 1}')),
  //       );
  //       return false;
  //     }
  //   }
  //   return true;
  // }

  // List<PassengerModel> getPassengersAsModels() {
  //   return state.passengers
  //       .map((ui) => PassengerModel(name: ui.nameController.text))
  //       .toList();
  // }

  // Future<void> employeeUpdatedFetch() async {
  //   await Future.wait([
  //     // fetchAllMyRequests(),
  //     fetchDashboardMyRequests(),
  //     fetchRequestsById(id)
  //     // fetchKpiEmployee(),
  //     // fetchStatusBreakDown('weekly'),
  //     // fetchTrendBreakDown('2025'),
  //   ]);
  // }

  @override
  void dispose() {
    // for (var p in state.passengers) {
    //   p.dispose();
    // }
    super.dispose();
    eventTypeController.dispose();
    departmentController.dispose();
    contactNumberController.dispose();
    reasonController.dispose();
    descriptionController.dispose();
    employeeIdController.dispose();
    originCityController.dispose();
    destinationCityController.dispose();
    vehicleRequiredLocationController.dispose();
    contactNumberForeignController.dispose();
    chatController.dispose();
  }
}
