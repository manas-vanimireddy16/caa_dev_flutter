part of 'view.dart';

// Updated monthly dataset for 2025

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

// final requestDeatilsTabSelectedProvider = StateProvider.autoDispose<int>(
//   (ref) => 0,
// );

final _vsProvider =
    StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
      final stateController = _VSController();
      stateController.initState();
      return stateController;
    });

class _ViewState {
  final bool isLoading;
  final List<Map<String, dynamic>> attachments;
  final KPIResponse kpiData;
  final List<VpnRequestData> myRequests;
  final List<VpnRequestData> myActionItems;
  final VpnRequestByIdModel requestById;
  final StatusBreakdownModel statusBreakdown;
  final TrendBreakdownModel trendData;
  final String searchText;
  final String status;
  final List<String> reasonForRequest;
  final List<String> acknowledgement;
  final String requestFor;
  final List<String> systemsToAccess;
  final String startDate;
  final String endDate;
  final List<String> systemsOrApplications;
  final List<String> devices;
  final String timePeriod;
  final TechniciansResponse technicianDetails;
  final int selectedRequestTab;
  final int selectedVpnTab;

  _ViewState({
    required this.isLoading,
    required this.attachments,
    required this.kpiData,
    required this.myRequests,
    required this.myActionItems,
    required this.requestById,
    required this.statusBreakdown,
    required this.trendData,
    required this.searchText,
    required this.status,
    required this.reasonForRequest,
    required this.acknowledgement,
    required this.requestFor,
    required this.systemsToAccess,
    required this.endDate,
    required this.startDate,
    required this.systemsOrApplications,
    required this.devices,
    required this.timePeriod,
    required this.technicianDetails,
    required this.selectedRequestTab,
    required this.selectedVpnTab,
  });

  /// ✅ Initial State
  _ViewState.init()
    : this(
        isLoading: false,
        attachments: [],
        kpiData: KPIResponse(),
        myRequests: [],
        myActionItems: [],
        requestById: VpnRequestByIdModel(),
        statusBreakdown: StatusBreakdownModel(),
        trendData: TrendBreakdownModel(),
        searchText: '',
        status: '',
        reasonForRequest: [],
        acknowledgement: [],
        requestFor: '',
        systemsToAccess: [],
        startDate: '',
        endDate: '',
        systemsOrApplications: [],
        timePeriod: '',
        devices: [],
        technicianDetails: TechniciansResponse(),
        selectedRequestTab: 0,
        selectedVpnTab: 0,
      );

  /// ✅ CopyWith method for immutability
  _ViewState copyWith({
    bool? isLoading,
    List<Map<String, dynamic>>? attachments,
    KPIResponse? kpiData,
    List<VpnRequestData>? myRequests,
    List<VpnRequestData>? myActionItems,
    VpnRequestByIdModel? requestById,
    StatusBreakdownModel? statusBreakdown,
    TrendBreakdownModel? trendData,
    String? searchText,
    String? status,
    List<String>? reasonForRequest,
    List<String>? acknowledgement,
    String? requestFor,
    List<String>? systemsOrApplications,
    List<String>? systemsToAccess,
    String? startDate,
    String? endDate,
    List<String>? devices,
    String? timePeriod,
    TechniciansResponse? technicianDetails,
    int? selectedRequestTab,
    int? selectedVpnTab,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      attachments: attachments ?? this.attachments,
      kpiData: kpiData ?? this.kpiData,
      myRequests: myRequests ?? this.myRequests,
      requestById: requestById ?? this.requestById,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      trendData: trendData ?? this.trendData,
      searchText: searchText ?? this.searchText,
      status: status ?? this.status,
      endDate: endDate ?? this.endDate,
      systemsOrApplications:
          systemsOrApplications ?? this.systemsOrApplications,
      reasonForRequest: reasonForRequest ?? this.reasonForRequest,
      acknowledgement: acknowledgement ?? this.acknowledgement,
      requestFor: requestFor ?? this.requestFor,
      systemsToAccess: systemsToAccess ?? this.systemsToAccess,
      startDate: startDate ?? this.startDate,
      devices: devices ?? this.devices,
      timePeriod: timePeriod ?? this.timePeriod,
      myActionItems: myActionItems ?? this.myActionItems,
      technicianDetails: technicianDetails ?? this.technicianDetails,
      selectedRequestTab: selectedRequestTab ?? this.selectedRequestTab,
      selectedVpnTab: selectedVpnTab ?? this.selectedVpnTab,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());

  late TextEditingController searchController;
  late TextEditingController personNameController;
  late TextEditingController departmentController;
  late TextEditingController contactNumberController;
  late TextEditingController reasonController;
  late TextEditingController descriptionController;
  late TextEditingController employeeIdController;
  late TextEditingController emailController;
  late TextEditingController jobTitleController;
  late TextEditingController chatController;
  late TextEditingController countryController;
  late TextEditingController startDate;
  late TextEditingController endDate;

  void initState() async {
    startDate = TextEditingController();
    endDate = TextEditingController();
    personNameController = TextEditingController();
    searchController = TextEditingController();
    departmentController = TextEditingController();
    contactNumberController = TextEditingController();
    reasonController = TextEditingController();
    employeeIdController = TextEditingController();
    descriptionController = TextEditingController();
    chatController = TextEditingController();
    jobTitleController = TextEditingController();
    emailController = TextEditingController();
    countryController = TextEditingController();
    chatController.addListener(() {});

    fetchKpiData();
    fetchStatusBreakDown('weekly');
    fetchTrendBreakDown('2025');
    await fetchMyRequests();
    fetchMyActionItems();
  }

  final vpninstance = VPNRepository();

  Future<void> fetchMyRequests({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    try {
      // Clear list only on refresh or search
      if (isRefresh || searchText.isNotEmpty) {
        state = state.copyWith(myRequests: []);
      }

      final response = await vpninstance.getVpnRequests(
        offset: 1,
        limit: 10,
        // sortBy: 'created_at',
        // sortOrder: 'DESC',
        status: status,
        searchText: searchText,
      );

      if (response.isNotEmpty) {
        // final updatedList = (isRefresh || searchText.isNotEmpty)
        //     ? response
        //     : [...state.myRequests, ...response];

        // Remove duplicates by ID (if any)
        // final uniqueList = {
        //   for (var item in updatedList) item.id: item,
        // }.values.toList();

        state = state.copyWith(myRequests: response);
      } else {
        if (isRefresh || searchText.isNotEmpty) {
          state = state.copyWith(myRequests: []);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> fetchMyActionItems({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    try {
      // Clear list only on refresh or search
      if (isRefresh || searchText.isNotEmpty) {
        state = state.copyWith(myActionItems: []);
      }

      final response = await vpninstance.getVpnActionItems(
        offset: 1,
        limit: 10,
        // sortBy: 'created_at',
        // sortOrder: 'DESC',
        status: status,
        searchText: searchText,
      );

      if (response.isNotEmpty) {
        // final updatedList = (isRefresh || searchText.isNotEmpty)
        //     ? response
        //     : [...state.myActionItems, ...response];

        // // Remove duplicates by ID (if any)
        // final uniqueList = {
        //   for (var item in updatedList) item.id: item,
        // }.values.toList();

        state = state.copyWith(myActionItems: response);
      } else {
        if (isRefresh || searchText.isNotEmpty) {
          state = state.copyWith(myActionItems: []);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> fetchRequestById(int id) async {
    try {
      state = state.copyWith(isLoading: true);
      final data = await vpninstance.getVpnRequestById(id: id);

      if (data != null) {
        state = state.copyWith(requestById: data);
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchKpiData() async {
    try {
      state = state.copyWith(isLoading: true);
      final data = await vpninstance.getKpiData();

      if (data != null) {
        state = state.copyWith(kpiData: data);
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchStatusBreakDown(String period) async {
    try {
      final data = await vpninstance.getStatusBreakdownData(period);

      if (data != null) {
        state = state.copyWith(statusBreakdown: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchTrendBreakDown(String period) async {
    try {
      final data = await vpninstance.getTrendBreakdownData(period);

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchTechnicianDetails(int id, int sectionId) async {
    try {
      final data = await vpninstance.getTechnicianData(
        id: id,
        sectionId: sectionId,
      );

      if (data != null) {
        state = state.copyWith(technicianDetails: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  void onSelectedRequestFor(String value) =>
      state = state.copyWith(requestFor: value);

  void onSelectedStartDate(String value) =>
      state = state.copyWith(startDate: value);

  void onSelectedEndDate(String value) =>
      state = state.copyWith(endDate: value);

  void onSelectedReasonForRequest(List<String> value) =>
      state = state.copyWith(reasonForRequest: value);

  void onSelectedTimePeriod(String value) =>
      state = state.copyWith(timePeriod: value);

  void onSelectedDevice(List<String> value) =>
      state = state.copyWith(devices: value);

  void onSelectedAcknowledgements(List<String> value) =>
      state = state.copyWith(acknowledgement: value);
  void onSelectedSystem(List<String> value) =>
      state = state.copyWith(systemsToAccess: value);

  void updateRequestTab(int index) {
    state = state.copyWith(selectedRequestTab: index);
  }

  void updateVpnTab(int index) {
    state = state.copyWith(selectedVpnTab: index);
  }

  // 🧩 Shared helpers for Start and End Dates

  /// Handles manual date input for both start and end fields.
  void handleManualDateInput({
    required String input,
    required bool isStartDate,
  }) {
    try {
      // Expect MM/DD/YYYY format
      final parts = input.split('/');
      if (parts.length == 3) {
        final month = int.parse(parts[0]);
        final day = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        final parsedDate = DateTime(year, month, day);

        // ✅ Update respective controller text (for UI)
        if (isStartDate) {
          startDate.text = _formatDateForDisplay(parsedDate);
        } else {
          endDate.text = _formatDateForDisplay(parsedDate);
        }

        // ✅ Save in API format (YYYY-MM-DD)
        final formattedForApi = _formatDateForApi(parsedDate);
        state = state.copyWith(
          startDate: isStartDate ? formattedForApi : state.startDate,
          endDate: !isStartDate ? formattedForApi : state.endDate,
        );
      }
    } catch (e) {
      debugPrint(
        "❌ Invalid manual ${isStartDate ? 'start' : 'end'} date input: $e",
      );
    }
  }

  Map<String, int> getDeptAndSectionIfHeadOfSection(
    SelectedUserRole? roleData,
    String targetRoleName,
  ) {
    if (roleData == null) {
      return {'departmentId': 0, 'sectionId': 0};
    }

    final roleName = roleData.roleName.toLowerCase();
    final target = targetRoleName.toLowerCase();

    // Check if this selected role matches "Head of Section"
    final isMatch = roleName == target || roleName.contains(target);

    if (!isMatch) {
      return {'departmentId': 0, 'sectionId': 0};
    }

    return {
      'departmentId': roleData.departmentId,
      'sectionId': roleData.sectionId,
    };
  }

  /// Handles date picker selection for both start and end fields.
  Future<void> pickDate({required bool isStartDate}) async {
    final picked = await KAppX.extendedRouter.showKDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formattedDisplay = _formatDateForDisplay(picked);
      final formattedApi = _formatDateForApi(picked);

      if (isStartDate) {
        startDate.text = formattedDisplay;
        state = state.copyWith(startDate: formattedApi);
      } else {
        endDate.text = formattedDisplay;
        state = state.copyWith(endDate: formattedApi);
      }
    }
  }

  /// Helper: display format MM/DD/YYYY
  String _formatDateForDisplay(DateTime date) {
    return "${date.month.toString().padLeft(2, '0')}/"
        "${date.day.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  /// Helper: API format YYYY-MM-DD
  String _formatDateForApi(DateTime date) {
    return "${date.year}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> sendAttachment(int id, int requestId) async {
    try {
      state = state.copyWith(isLoading: true);

      final uploadedFiles = await vpninstance.uploadAttachments(
        state.attachments,
      );
      // final uploadedFileType = (uploadedFiles.first["file_type"] ?? '')
      //     .toLowerCase();
      // if (uploadedFileType.contains('png') ||
      //     uploadedFileType.contains('jpg') ||
      //     uploadedFileType.contains('jpeg') ||
      //     uploadedFileType.contains('gif') ||
      //     uploadedFileType.contains('bmp') ||
      //     uploadedFileType.contains('webp') ||
      //     uploadedFileType.contains('tiff')) {
      //   type = 'image';
      // } else {
      //   type = uploadedFileType;
      // }

      // ✅ Safety check: ensure upload success
      if (uploadedFiles.isEmpty || uploadedFiles[0]["file_url"] == null) {
        throw Exception('File upload failed or returned empty response.');
      }

      // 2️⃣ Build payload
      final payload = {
        "request_id": requestId,
        "file_url": uploadedFiles.first["file_url"],
        "file_name": uploadedFiles.first["file_name"],
        "file_type": uploadedFiles.first["file_type"],
        "file_size": uploadedFiles.first["file_size"],
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      final resMessage = await vpninstance.sendAttachment(payload, id);
      state = state.copyWith(attachments: []);

      state = state.copyWith(isLoading: false);

      await fetchRequestById(id);
      // return resMessage;
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> sendChat(int id, int requestId) async {
    try {
      state = state.copyWith(isLoading: true);

      // 🧩 3️⃣ Build payload safely
      final payload = {
        "request_id": requestId,
        "message": chatController.text,
        "messageType": "text",
        "is_internal": false,
      };

      debugPrint("✅ Final Payload: $payload");

      // 🧩 4️⃣ Send request
      final resMessage = await vpninstance.sendChat(payload, id);
      state = state.copyWith(isLoading: false);

      // 🧩 5️⃣ Refresh UI state
      await fetchRequestById(id);

      chatController.clear();

      state = state.copyWith(attachments: []);
      // 🧩 6️⃣ Close chat modal or pop page
      // KAppX.router.pop();
    } catch (e, stack) {
      debugPrint('❌ Error submitting chat: $e');
      debugPrint('Stacktrace: $stack');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> sendVPNRequest() async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files
      // final uploadedFiles = await vpninstance.uploadAttachments(
      //   state.attachments,
      // );

      final userData = KAppX.globalProvider.read(userProvider);

      // 2️⃣ Build payload (updated according to new VPN request schema)
      final payload = {
        "service_id": 1,
        "sub_service_id": 3,
        "request_for": state.requestFor,
        "employee_identifier": employeeIdController.text,
        "employee_email": emailController.text,
        "job_title": jobTitleController.text,
        "phone_number": contactNumberController.text,
        "reason_for_request": state.reasonForRequest, // e.g. "REMOTE_WORK"
        "systems_to_access":
            state.systemsToAccess, // e.g. ["INTERNAL_DATABASES"]
        "country": countryController.text,
        "start_date": state.startDate, // e.g. "2025-01-01"
        "end_date": state.endDate, // e.g. "2025-01-07"
        "access_type": state.timePeriod, // e.g. "ONE_TIME"
        "device_type": state.devices, // e.g. "CAA_LAPTOP"
        "acknowledgement": state.acknowledgement.length == 2 ? true : false,
        "description": descriptionController.text,
        "attachments": [],
        "chats": [],
      };

      debugPrint("✅ Final VPN Payload: $payload");

      // 3️⃣ Send request
      await vpninstance.sendVPNTicket(payload);

      // 4️⃣ Reset attachments and close the screen
      state = state.copyWith(attachments: []);
      await fetchKpiData();
      await fetchMyRequests();
      await fetchStatusBreakDown('weekly');
      await fetchTrendBreakDown('2025');
      refreshUI();
      state = state.copyWith(isLoading: false);
      KAppX.router.pop();
    } catch (e) {
      debugPrint('❌ Error submitting VPN request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> assignVPNRequest(int approvalId, techcianId) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files
      // final uploadedFiles = await vpninstance.uploadAttachments(
      //   state.attachments,
      // );

      final userData = KAppX.globalProvider.read(userProvider);

      // 2️⃣ Build payload (updated according to new VPN request schema)
      final payload = {
        "approval_id": approvalId,
        "technician_user_id": techcianId,
        "comment": chatController.text,
      };

      debugPrint("✅ Final Assign VPN Payload: $payload");

      // 3️⃣ Send request
      await vpninstance.sendAssign(payload);

      // 4️⃣ Reset attachments and close the screen
      state = state.copyWith(attachments: []);
      state = state.copyWith(isLoading: false);
      fetchKpiData();

      fetchMyRequests();
      fetchMyActionItems();

      fetchStatusBreakDown('weekly');
      fetchTrendBreakDown('2025');
      refreshUI();
      KAppX.router.pop();
    } catch (e) {
      debugPrint('❌ Error submitting VPN request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> assignorApproveReject(
    int approvalId,
    int requestId,
    String status,
  ) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files
      // final uploadedFiles = await vpninstance.uploadAttachments(
      //   state.attachments,
      // );

      final userData = KAppX.globalProvider.read(userProvider);

      // 2️⃣ Build payload (updated according to new VPN request schema)
      final payload = {
        "approval_id": approvalId,
        "request_id": requestId,
        "status": status,
        "comment": chatController.text,
      };

      debugPrint("✅ Final Assign VPN Payload: $payload");

      // 3️⃣ Send request
      await vpninstance.approveorReject(payload);
      state = state.copyWith(isLoading: false);

      // 4️⃣ Reset attachments and close the screen
      state = state.copyWith(attachments: []);

      fetchKpiData();

      fetchMyRequests();
      fetchMyActionItems();

      fetchStatusBreakDown('weekly');
      fetchTrendBreakDown('2025');
      refreshUI();
      KAppX.router.pop();
    } catch (e) {
      debugPrint('❌ Error submitting VPN request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // await fetchKpi();
  // await fetchKpiEmployee();
  // await fetchKpiForeigner();
  // await fetchActivityFeed();
  // await fetchAllMyRequests();
  // await fetchStatusBreakDown('weekly');
  // await fetchTrendBreakDown('2025');
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

  void refreshUI() {
    // triggers rebuild in UI
    state = state.copyWith();
  }

  @override
  void dispose() {
    // searchController.dispose();
    personNameController.dispose();
    departmentController.dispose();
    contactNumberController.dispose();
    reasonController.dispose();
    descriptionController.dispose();
    employeeIdController.dispose();
    emailController.dispose();
    jobTitleController.dispose();
    chatController.dispose();
    countryController.dispose();
    startDate.dispose();
    endDate.dispose();

    super.dispose();
  }
}
