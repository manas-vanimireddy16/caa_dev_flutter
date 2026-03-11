part of 'view.dart';

final selectedrequesteventTabProvider = StateProvider<int>((ref) => 0);

// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");

final List<Map<String, dynamic>> dataList = [
  {
    'id': 101,
    'status': 'Approved',
    'Service Type': 'Vehicle Hire',
    'Purpose of Travel': 'Client Meeting in Delhi',
    'Date': '28-10-2025',
    'Approver': 'Operations Manager',
  },
  {
    'id': 102,
    'status': 'Pending',
    'Service Type': 'Hotel Booking',
    'Purpose of Travel': 'Training Workshop',
    'Date': '29-10-2025',
    'Approver': 'HR Head',
  },
  {
    'id': 103,
    'status': 'Rejected',
    'Service Type': 'Flight Ticket',
    'Purpose of Travel': 'Conference in Mumbai',
    'Date': '30-10-2025',
    'Approver': 'Admin Supervisor',
  },
  {
    'id': 104,
    'status': 'Approved',
    'Service Type': 'Local Conveyance',
    'Purpose of Travel': 'Branch Visit',
    'Date': '01-11-2025',
    'Approver': 'Finance Officer',
  },
  {
    'id': 105,
    'status': 'Pending',
    'Service Type': 'Accommodation',
    'Purpose of Travel': 'Annual Conference',
    'Date': '02-11-2025',
    'Approver': 'Admin Executive',
  },
];

final StatusData sampleStatusData = StatusData(
  timePeriod: "October 2025",
  totalRequests: 150,
  approved: 90,
  pending: 40,
  rejected: 20,
  breakdown: [
    ChartData(status: "Approved", count: 90, percentage: 60.0),
    ChartData(status: "Pending", count: 40, percentage: 26.7),
    ChartData(status: "Rejected", count: 20, percentage: 13.3),
  ],
);

final List<ActivitiesFeedData> mockActivities = [
  ActivitiesFeedData(
    id: 1,
    requestNumber: 'REQ-001',
    title: 'Vehicle Maintenance Request',
    status: 'Approved',
    subType: 'Maintenance',
    type: 'Logistics',
    category: 'Vehicle',
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  ActivitiesFeedData(
    id: 2,
    requestNumber: 'REQ-002',
    title: 'Office Supplies Request',
    status: 'Pending',
    subType: 'Procurement',
    type: 'Inventory',
    category: 'Stationery',
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  ActivitiesFeedData(
    id: 3,
    requestNumber: 'REQ-003',
    title: 'IT Equipment Repair',
    status: 'In Progress',
    subType: 'Repair',
    type: 'IT Support',
    category: 'Hardware',
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
];

///====================================================
///
///
final _vsProvider =
    StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
      final stateController = _VSController();
      stateController.initState();
      return stateController;
    });

class _ViewState {
  final bool isLoading;
  final String date;
  final String toDate;
  final String selectedRole;
  final String travelTime;
  final String vehicleRequiredfor;
  final String vehicleRequiredLocation;
  final String purposeofTravel;
  final String vehicleTypeDaily;
  final String requestBy;
  final int expectedDaysinTravel;
  final int expectedHoursinTravel;
  final List<Map<String, dynamic>> attachments;
  final String vehicleType;
  final String travelTimeForUI;
  final KPIResponse kpiData;
  final KPIResponse kpiDataEmployee;
  final KPIResponse kpiDataForeigner;
  final List<ActivitiesFeedData> activityFeed;
  final List<RequestData> dashboardMyRequests;
  final List<RequestData> allRequests;
  final StatusBreakdownModel statusBreakdown;
  final TrendBreakdownModel trendData;
  final RequestDetailModel requestDataById;

  _ViewState({
    required this.isLoading,
    required this.date,
    required this.toDate,
    required this.selectedRole,
    required this.travelTime,
    required this.vehicleRequiredfor,
    required this.vehicleRequiredLocation,
    required this.purposeofTravel,
    required this.vehicleTypeDaily,
    required this.expectedDaysinTravel,
    required this.expectedHoursinTravel,
    required this.attachments,
    required this.vehicleType,
    required this.travelTimeForUI,
    required this.kpiData,
    required this.kpiDataEmployee,
    required this.kpiDataForeigner,
    required this.activityFeed,
    required this.dashboardMyRequests,
    required this.statusBreakdown,
    required this.trendData,
    required this.requestDataById,
    required this.allRequests,
    required this.requestBy,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        date: '',
        toDate: '',
        selectedRole: '',
        travelTime: '',
        vehicleRequiredfor: '',
        vehicleRequiredLocation: '',
        purposeofTravel: '',
        vehicleTypeDaily: '',
        expectedDaysinTravel: 0,
        expectedHoursinTravel: 0,
        attachments: [],
        vehicleType: '',
        travelTimeForUI: '',
        kpiData: KPIResponse(),
        kpiDataEmployee: KPIResponse(),
        kpiDataForeigner: KPIResponse(),
        activityFeed: [],
        dashboardMyRequests: [],
        statusBreakdown: StatusBreakdownModel(),
        trendData: TrendBreakdownModel(),
        requestDataById: RequestDetailModel(),
        allRequests: [],
        requestBy: '',
      );

  _ViewState copyWith({
    bool? isLoading,
    String? date,
    String? toDate,
    String? selectedRole,
    String? travelTime,
    String? vehicleRequiredfor,
    String? vehicleRequiredLocation,
    String? purposeofTravel,
    String? vehicleTypeDaily,
    int? expectedDaysinTravel,
    int? expectedHoursinTravel,
    List<Map<String, dynamic>>? attachments,
    String? vehicleType,
    String? travelTimeForUI,
    KPIResponse? kpiData,
    KPIResponse? kpiDataEmployee,
    KPIResponse? kpiDataForeigner,
    List<ActivitiesFeedData>? activityFeed,
    List<RequestData>? dashboardMyRequests,
    StatusBreakdownModel? statusBreakdown,
    TrendBreakdownModel? trendData,
    RequestDetailModel? requestDataById,
    List<RequestData>? allRequests,
    String? requestBy,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      date: date ?? this.date,
      toDate: toDate ?? this.toDate,
      selectedRole: selectedRole ?? this.selectedRole,
      travelTime: travelTime ?? this.travelTime,
      vehicleRequiredfor: vehicleRequiredfor ?? this.vehicleRequiredfor,
      vehicleRequiredLocation:
          vehicleRequiredLocation ?? this.vehicleRequiredLocation,
      purposeofTravel: purposeofTravel ?? this.purposeofTravel,
      vehicleTypeDaily: vehicleTypeDaily ?? this.vehicleTypeDaily,
      expectedDaysinTravel: expectedDaysinTravel ?? this.expectedDaysinTravel,
      expectedHoursinTravel:
          expectedHoursinTravel ?? this.expectedHoursinTravel,
      attachments: attachments ?? this.attachments,
      vehicleType: vehicleType ?? this.vehicleType,
      travelTimeForUI: travelTimeForUI ?? this.travelTimeForUI,
      kpiData: kpiData ?? this.kpiData,
      kpiDataEmployee: kpiDataEmployee ?? this.kpiDataEmployee,
      kpiDataForeigner: kpiDataForeigner ?? this.kpiDataForeigner,
      activityFeed: activityFeed ?? this.activityFeed,
      dashboardMyRequests: dashboardMyRequests ?? this.dashboardMyRequests,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      trendData: trendData ?? this.trendData,
      requestDataById: requestDataById ?? this.requestDataById,
      allRequests: allRequests ?? this.allRequests,
      requestBy: requestBy ?? this.requestBy,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());
  late TextEditingController personNameController;
  late TextEditingController contactNumberController;
  late TextEditingController departmentController;
  late TextEditingController emailController;
  late TextEditingController employeeIdController;
  late TextEditingController uniorOrgcontroller;
  late TextEditingController reasonController;
  late TextEditingController descriptionController;
  late TextEditingController vehicleRequiredLocationController;
  late TextEditingController contactNumberForeignController;
  late TextEditingController chatController;

  void initState() {
    personNameController = TextEditingController();
    departmentController = TextEditingController();
    contactNumberController = TextEditingController();
    emailController = TextEditingController();
    reasonController = TextEditingController();
    employeeIdController = TextEditingController();
    uniorOrgcontroller = TextEditingController();
    reasonController = TextEditingController();
    vehicleRequiredLocationController = TextEditingController();
    contactNumberForeignController = TextEditingController();
    descriptionController = TextEditingController();
    chatController = TextEditingController();
    // fetchKpi();
    // fetchKpiEmployee();
    // fetchKpiForeigner();
    // fetchActivityFeed();
    // fetchDashboardMyRequests();
    // fetchAllMyRequests();
    // fetchStatusBreakDown('weekly');
    // fetchTrendBreakDown('2025');
  }

  // final logisticsDashboardinstance = LogisticsDashboardRepository();

  // Future<void> fetchKpi() async {
  //   try {
  //     final kpis = await logisticsDashboardinstance.getKpiData();

  //     if (kpis != null) {
  //       state = state.copyWith(kpiData: kpis);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {}
  // }

  // // Future<void> fetchDetialsById(int id) async {
  // //   try {
  // //     final data = await logisticsDashboardinstance.getRequestDetailsById(id);

  // //     if (data != null) {
  // //       state = state.copyWith(requestDataById: data);
  // //     }
  // //   } on ApiException catch (apiError) {
  // //     Fluttertoast.showToast(msg: apiError.message);
  // //   } catch (e) {}
  // // }

  // Future<void> fetchKpiEmployee() async {
  //   try {
  //     final kpis = await logisticsDashboardinstance.getKpiDataEmployee();

  //     if (kpis != null) {
  //       state = state.copyWith(kpiDataEmployee: kpis);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {}
  // }

  // Future<void> fetchKpiForeigner() async {
  //   try {
  //     final kpis = await logisticsDashboardinstance.getKpiDataForeigner();

  //     if (kpis != null) {
  //       state = state.copyWith(kpiDataForeigner: kpis);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {}
  // }

  // Future<void> fetchActivityFeed() async {
  //   try {
  //     final activityFeed = await logisticsDashboardinstance.getActivityFeed();

  //     if (activityFeed != null) {
  //       state = state.copyWith(activityFeed: activityFeed);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {}
  // }

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

  // Future<void> fetchAllMyRequests() async {
  //   try {
  //     final myrequests = await logisticsDashboardinstance
  //         .getDashboardRequestData();

  //     if (myrequests != null) {
  //       state = state.copyWith(allRequests: myrequests);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {}
  // }

  // Future<void> fetchRequestsById(int id) async {
  //   try {
  //     final data = await logisticsDashboardinstance.getRequestDetailsById(id);

  //     if (data != null) {
  //       state = state.copyWith(requestDataById: data);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {}
  // }

  // Future<void> fetchStatusBreakDown(String period) async {
  //   try {
  //     final data = await logisticsDashboardinstance.getStatusBreakdown(period);

  //     if (data != null) {
  //       state = state.copyWith(statusBreakdown: data);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {}
  // }

  // Future<void> fetchTrendBreakDown(String period) async {
  //   try {
  //     final data = await logisticsDashboardinstance.getTrendBreakdown(period);

  //     if (data != null) {
  //       state = state.copyWith(trendData: data);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {}
  // }

  // void onSelectFromDate(String date) => state = state.copyWith(fromDate: date);
  // void onSelectTravelTime(String time) =>
  //     state = state.copyWith(travelTime: time);
  void onSelectedRole(String role) =>
      state = state.copyWith(selectedRole: role);
  void setRequestedBy(String role) => state = state.copyWith(requestBy: role);

  // void onSelectedVehicleType(String value) =>
  //     state = state.copyWith(vehicleType: value);

  // void onSelectedTravelTime(String value) =>
  //     state = state.copyWith(travelTime: value);

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
  }
}
