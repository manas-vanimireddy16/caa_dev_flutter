part of 'view.dart';

final selectedrequesteventTabProvider = StateProvider<int>((ref) => 0);
final requestDeatilsTabSelectedProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);
// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");
final _vsProvider =
    StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
      final controller = _VSController();
      controller.initState();
      return controller;
    });

/// --- STATE CLASS --- ///
class _ViewState {
  final bool isLoading;

  // Core Request Fields
  final int numberOfPassengers;
  final String purposeOfTravel;
  final String vehicleRequiredLocation;
  final String requestType;
  final String arrivalDepartureDate;
  final String arrivalDepartureDateISO;
  final String arrivalDepartureTime;
  final StatusBreakdownModel statusBreakdown;

  // Lists
  final List<PassengerUIModel> passengers;
  final List<Map<String, dynamic>> attachments;

  // KPI Data (if still needed)
  final CombinedKpiLogisticsResponse kpiData;
  final CombinedKpiLogisticsResponse kpiDataEmployee;
  final CombinedKpiLogisticsResponse kpiDataForeigner;
  final List<ForeignData> dashboardMyRequests;
  final LogisticsTrendBreakdownModel trendData;
  final LogisticsForeignDetailModel requestForeignDataById;

  _ViewState({
    required this.isLoading,
    required this.numberOfPassengers,
    required this.purposeOfTravel,
    required this.vehicleRequiredLocation,
    required this.requestType,
    required this.arrivalDepartureDate,
    required this.passengers,
    required this.attachments,
    required this.kpiData,
    required this.kpiDataEmployee,
    required this.kpiDataForeigner,
    required this.arrivalDepartureTime,
    required this.arrivalDepartureDateISO,
    required this.dashboardMyRequests,
    required this.statusBreakdown,
    required this.trendData,
    required this.requestForeignDataById,
  });

  /// --- INITIAL STATE --- ///
  _ViewState.init()
    : this(
        isLoading: false,
        numberOfPassengers: 0,
        purposeOfTravel: '',
        vehicleRequiredLocation: '',
        requestType: '',
        arrivalDepartureDate: '',
        passengers: [PassengerUIModel()],
        attachments: [],
        kpiData: CombinedKpiLogisticsResponse(),
        kpiDataEmployee: CombinedKpiLogisticsResponse(),
        kpiDataForeigner: CombinedKpiLogisticsResponse(),
        arrivalDepartureTime: '',
        arrivalDepartureDateISO: '',
        dashboardMyRequests: [],
        statusBreakdown: StatusBreakdownModel(),
        trendData: LogisticsTrendBreakdownModel(),
        requestForeignDataById: LogisticsForeignDetailModel(),
      );

  /// --- COPYWITH --- ///
  _ViewState copyWith({
    bool? isLoading,
    int? numberOfPassengers,
    String? purposeOfTravel,
    String? vehicleRequiredLocation,
    String? requestType,
    String? arrivalDepartureDate,
    List<PassengerUIModel>? passengers,
    List<Map<String, dynamic>>? attachments,
    CombinedKpiLogisticsResponse? kpiData,
    CombinedKpiLogisticsResponse? kpiDataEmployee,
    CombinedKpiLogisticsResponse? kpiDataForeigner,
    String? arrivalDepartureTime,
    String? arrivalDepartureDateISO,
    List<ForeignData>? dashboardMyRequests,
    StatusBreakdownModel? statusBreakdown,
    LogisticsTrendBreakdownModel? trendData,
    LogisticsForeignDetailModel? requestForeignDataById,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      numberOfPassengers: numberOfPassengers ?? this.numberOfPassengers,
      purposeOfTravel: purposeOfTravel ?? this.purposeOfTravel,
      vehicleRequiredLocation:
          vehicleRequiredLocation ?? this.vehicleRequiredLocation,
      requestType: requestType ?? this.requestType,
      arrivalDepartureDate: arrivalDepartureDate ?? this.arrivalDepartureDate,
      passengers: passengers ?? this.passengers,
      attachments: attachments ?? this.attachments,
      kpiData: kpiData ?? this.kpiData,
      kpiDataEmployee: kpiDataEmployee ?? this.kpiDataEmployee,
      kpiDataForeigner: kpiDataForeigner ?? this.kpiDataForeigner,
      arrivalDepartureTime: arrivalDepartureTime ?? this.arrivalDepartureTime,
      arrivalDepartureDateISO:
          arrivalDepartureDateISO ?? this.arrivalDepartureDateISO,
      dashboardMyRequests: dashboardMyRequests ?? this.dashboardMyRequests,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      trendData: trendData ?? this.trendData,
      requestForeignDataById:
          requestForeignDataById ?? this.requestForeignDataById,
    );
  }
}

/// --- CONTROLLER --- ///
class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());
  final instance = LogisticsForeignRepository();
  // Text Controllers (for form fields)
  late TextEditingController employeeIdPassportController;
  late TextEditingController contactNumberController;
  late TextEditingController originCityController;
  late TextEditingController destinationCityController;
  late TextEditingController specialInstructionsController;
  late TextEditingController foreignChatController;

  void initState() {
    employeeIdPassportController = TextEditingController();
    contactNumberController = TextEditingController();
    originCityController = TextEditingController();
    destinationCityController = TextEditingController();
    specialInstructionsController = TextEditingController();
    foreignChatController = TextEditingController();

    // Example initial data fetch
    fetchKpiEmployee();
    fetchKpiForeigner();
    fetchForeignMyRequests();
    fetchStatusBreakDown('weekly');
    fetchTrendBreakDown('2025');
  }

  /// --- UPDATE METHODS --- ///
  // void setDepartment(int id) => state = state.copyWith(reqUserDepartmentId: id);

  // void setSection(int id) => state = state.copyWith(reqUserSectionId: id);

  // void setServiceId(int id) => state = state.copyWith(serviceId: id);

  // void setSubServiceId(int id) => state = state.copyWith(subServiceId: id);

  void setPurposeOfTravel(String value) =>
      state = state.copyWith(purposeOfTravel: value);
  void setPassengerNo(int value) =>
      state = state.copyWith(numberOfPassengers: value);
  void setVehicleRequiredLocation(String value) =>
      state = state.copyWith(vehicleRequiredLocation: value);

  void setRequestType(String value) =>
      state = state.copyWith(requestType: value);

  void setArrivalDepartureDate(String value) =>
      state = state.copyWith(arrivalDepartureDate: value);
  void setArrivalDepartureDateISO(String value) =>
      state = state.copyWith(arrivalDepartureDateISO: value);
  void setArrivalDepartureTime(String value) =>
      state = state.copyWith(arrivalDepartureTime: value);
  void refreshUI() {
    // triggers rebuild in UI
    state = state.copyWith();
  }

  void addPassenger() {
    final newList = [...state.passengers, PassengerUIModel()];
    state = state.copyWith(passengers: newList);
  }

  void removePassenger(int index) {
    if (state.passengers.length <= 1) return; // 👈 Prevent deleting last one

    final updatedList = [...state.passengers];
    updatedList[index].dispose();
    updatedList.removeAt(index);
    state = state.copyWith(passengers: updatedList);
  }

  void addAttachment(Map<String, dynamic> attachment) {
    final updated = [...state.attachments, attachment];
    state = state.copyWith(attachments: updated);
  }

  /// Example KPI fetchers

  final logisticsDashboardinstance = LogisticsDashboardRepository();

  Future<void> fetchForeignMyRequests() async {
    try {
      final myrequests = await instance.getForeignRequestData();

      if (myrequests != null) {
        state = state.copyWith(dashboardMyRequests: myrequests);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchRequestsById(int id) async {
    try {
      state = state.copyWith(isLoading: true);
      final data = await instance.getRequestDetailsById(id);

      if (data != null) {
        state = state.copyWith(requestForeignDataById: data);
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

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

  Future<void> fetchStatusBreakDown(String period) async {
    try {
      final data = await instance.getStatusBreakdown(period);

      if (data != null) {
        state = state.copyWith(statusBreakdown: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchTrendBreakDown(String period) async {
    try {
      final data = await instance.getForeignTrendBreakdown(period);

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
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

  List<Map<String, dynamic>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  ) {
    List<Map<String, dynamic>> uploadedFiles = [];

    for (var file in attachments) {
      final filePath = file['path'];
      if (filePath == null) continue;

      final fileName = file['file_name'] ?? filePath.split('/').last;
      final fileType = file['file_type'] ?? fileName.split('.').last;
      final fileDescription = 'description';
      final fileSize = File(filePath).lengthSync(); // sync file length

      uploadedFiles.add({
        "file_url": filePath,
        "file_name": fileName,
        "file_type": fileType,
        "file_size": fileSize,
        //    "description": fileDescription,
      });
    }

    return uploadedFiles;
  }

  Future<void> vehicleRequest() async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files
      final uploadedFiles = await uploadAttachments(state.attachments);

      final userData = KAppX.globalProvider.read(userProvider);

      // 2️⃣ Build payload
      final payload = {
        "req_user_department_id":
            userData?.department, //userData?.data?.department?.id,
        "req_user_section_id": userData?.section, //userData?.data?.section?.id,
        "service_id": 20,
        "sub_service_id": 13,
        "number_of_passengers": state.numberOfPassengers,
        "purpose_of_travel": state.purposeOfTravel,
        "vehicle_required_location": state.vehicleRequiredLocation,
        "employee_id_passport": employeeIdPassportController.text.trim(),
        "contact_number": contactNumberController.text.trim(),
        "request_type": state.requestType,
        "origin_city": originCityController.text.trim(),
        "destination_city": destinationCityController.text.trim(),
        "arrival_departure_datetime": state.arrivalDepartureDateISO,
        "special_instructions": specialInstructionsController.text.trim(),

        // 👇 FIXED: map each passenger to a Map instead of String
        "passengers": state.passengers
            .map((ui) => ui.nameController.text.trim())
            .where((name) => name.isNotEmpty)
            .map((name) => {"passenger_name": name})
            .toList(),

        // attachments already in correct format
        "attachments": uploadedFiles,
      };

      debugPrint("✅ Final Payload: $payload");
      print("✅ Final Payload=============: $payload");

      // 3️⃣ Send request
      await instance.sendForeignRequest(payload);
      state = state.copyWith(isLoading: true);
      await fetchForeignMyRequests();
      await fetchKpiForeigner();
      await fetchTrendBreakDown('2025');
      await fetchStatusBreakDown('weekly');
      Future.delayed(const Duration(milliseconds: 300), () {
        KAppX.router.pop();
      });
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<String> sendChat(int id, String message, String type) async {
    try {
      state = state.copyWith(isLoading: true);

      List<dynamic> uploadedFiles = [];

      // 🧩 1️⃣ Upload only if not a text message
      if (type != 'text') {
        debugPrint('📎 Attachment Message: $message');
        uploadedFiles = await logisticsDashboardinstance.uploadAttachments(
          state.attachments,
        );

        // ✅ Safety check: ensure upload success
        if (uploadedFiles.isEmpty || uploadedFiles[0]["file_url"] == null) {
          throw Exception('File upload failed or returned empty response.');
        }
      }

      // 🧩 2️⃣ Detect image types (png, jpg, jpeg, gif, etc.)

      if (type != 'text') {
        final uploadedFileType = (uploadedFiles.first["file_type"] ?? '')
            .toLowerCase();
        if (uploadedFileType.contains('png') ||
            uploadedFileType.contains('jpg') ||
            uploadedFileType.contains('jpeg') ||
            uploadedFileType.contains('gif') ||
            uploadedFileType.contains('bmp') ||
            uploadedFileType.contains('webp') ||
            uploadedFileType.contains('tiff')) {
          type = 'image';
        } else {
          type = uploadedFileType;
        }
      }

      // 🧩 3️⃣ Build payload safely
      final payload = {
        "request_id": id,
        "service_id": 20,
        "sub_service_id": 13,
        "message": type == 'text'
            ? message
            : uploadedFiles.first["file_url"], // safe access
        "messageType": type,
        "file_name": type != 'text' ? uploadedFiles.first["file_name"] : null,
        "file_type": type != 'text' ? type : null,
        "file_size": type != 'text' ? uploadedFiles.first["file_size"] : null,
      };

      debugPrint("✅ Final Payload: $payload");

      // 🧩 4️⃣ Send request
      final resMessage = await logisticsDashboardinstance.sendChat(
        payload,
        id,
        type,
      );

      // 🧩 5️⃣ Refresh UI state
      await fetchRequestsById(id);

      foreignChatController.clear();

      state = state.copyWith(attachments: []);
      // 🧩 6️⃣ Close chat modal or pop page
      // KAppX.router.pop();

      return resMessage;
    } catch (e, stack) {
      debugPrint('❌ Error submitting chat: $e');
      debugPrint('Stacktrace: $stack');
      return 'Not sent';
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // Validation check before submission
  bool validatePassengers(BuildContext context) {
    for (var i = 0; i < state.passengers.length; i++) {
      if (state.passengers[i].nameController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter name for Passenger ${i + 1}')),
        );
        return false;
      }
    }
    return true;
  }

  List<String> getPassengerNames() {
    return state.passengers
        .map((ui) => ui.nameController.text.trim())
        .where((name) => name.isNotEmpty)
        .toList();
  }

  @override
  void dispose() {
    for (var p in state.passengers) {
      p.dispose();
    }
    super.dispose();
  }
}
