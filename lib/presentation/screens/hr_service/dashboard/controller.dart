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

  final List<HotelReservationRequestModel> hotelReservationRequestData;
  final List<HotelReservationRequestModel> hotelReservationActionItemsData;
  final RequestDetailModel requestDataById;
  final KPIResponse kpiData;
  final KPIResponse approvalKpiData;
  final int tabIndex;

  _ViewState({
    required this.isLoading,
    required this.approvalKpiData,
    required this.requestDataById,
    required this.hotelReservationRequestData,
    required this.hotelReservationActionItemsData,
    required this.kpiData,
    required this.tabIndex,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        requestDataById: RequestDetailModel(),
        hotelReservationRequestData: [],
        hotelReservationActionItemsData: [],
        kpiData: KPIResponse(),
        approvalKpiData: KPIResponse(),
        tabIndex: 0,
      );

  _ViewState copyWith({
    bool? isLoading,
    RequestDetailModel? requestDataById,
    List<HotelReservationRequestModel>? hotelReservationRequestData,
    List<HotelReservationRequestModel>? hotelReservationActionItemsData,
    KPIResponse? kpiData,
    KPIResponse? approvalKpiData,
    int? tabIndex,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      requestDataById: requestDataById ?? this.requestDataById,
      hotelReservationRequestData:
          hotelReservationRequestData ?? this.hotelReservationRequestData,
      hotelReservationActionItemsData:
          hotelReservationActionItemsData ??
          this.hotelReservationActionItemsData,
      kpiData: kpiData ?? this.kpiData,
      approvalKpiData: approvalKpiData ?? this.approvalKpiData,
      tabIndex: tabIndex ?? this.tabIndex,
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
    fetchKpi();
    fetchApprovalKpi();
    fetchRequests();
    fetchActionItems();
  }

  final hotelReservationinstance = HotelReservationDashboardRepoistory();

  Future<void> fetchRequests({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    try {
      // Clear list only if explicitly refreshing or searching
      if (isRefresh || searchText.isNotEmpty || status.isNotEmpty) {
        state = state.copyWith(hotelReservationRequestData: []);
      }

      final requests = await hotelReservationinstance.getRequests(
        offset: 0,
        limit: 10,
        searchText: searchText,
        status: status,
      );

      // No merging needed
      state = state.copyWith(hotelReservationRequestData: requests);
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
        state = state.copyWith(hotelReservationActionItemsData: []);
      }

      final items = await hotelReservationinstance.getActionItems(
        offset: 0,
        limit: 10,
        searchText: searchText,
        status: status,
      );

      // No merging needed
      state = state.copyWith(
        hotelReservationActionItemsData: items,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
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

  // void onSelectFromDate(String date) => state = state.copyWith(fromDate: date);
  // void onSelectTravelTime(String time) =>
  //     state = state.copyWith(travelTime: time);

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
