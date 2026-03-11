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
  final List<HotelReservationRequestModel> hotelReservationRequestData;
  final List<HotelReservationRequestModel> hotelReservationActionItemsData;
  final RequestDetailData requestDetails;
  final int requestDetailTab;

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
    required this.hotelReservationRequestData,
    required this.hotelReservationActionItemsData,
    required this.requestDetails,
    required this.requestDetailTab,
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
        hotelReservationRequestData: [],
        hotelReservationActionItemsData: [],
        requestDetails: RequestDetailData(),
        requestDetailTab: 0,
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
    List<HotelReservationRequestModel>? hotelReservationRequestData,
    List<HotelReservationRequestModel>? hotelReservationActionItemsData,
    RequestDetailData? requestDetails,
    int? requestDetailTab,
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
      hotelReservationRequestData:
          hotelReservationRequestData ?? this.hotelReservationRequestData,
      hotelReservationActionItemsData:
          hotelReservationActionItemsData ??
          this.hotelReservationActionItemsData,
      requestDetails: requestDetails ?? this.requestDetails,
      requestDetailTab: requestDetailTab ?? this.requestDetailTab,
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

  ApprovalDetailModel? getActiveApprovalLevel(List<ApprovalDetailModel> list) {
    if (list.isEmpty) return null;

    // 1️⃣ First try to get lowest level with status "In Progress"
    final inProgress = list
        .where((e) => e.approvalStatus?.toLowerCase() == "in progress")
        .toList();

    if (inProgress.isNotEmpty) {
      inProgress.sort((a, b) => (a.level ?? 999).compareTo(b.level ?? 999));
      return inProgress.first;
    }

    // 2️⃣ If no "In Progress", get lowest "Assigned"
    // final assigned = list
    //     .where((e) => e.approvalStatus?.toLowerCase() == "assigned")
    //     .toList();

    // if (assigned.isNotEmpty) {
    //   assigned.sort((a, b) => (a.level ?? 999).compareTo(b.level ?? 999));
    //   return assigned.first;
    // }

    return null;
  }

  bool canUserActOnLevel({
    required ApprovalDetailModel approval,
    required int userId,
    required SelectedUserRole selectedRole,
  }) {
    // Must be the assigned approver
    if (approval.approverUserId != userId) return false;

    // Must match approver role
    if (approval.approverRoleId != selectedRole.roleId) return false;

    if (approval.departmentId != selectedRole.departmentId) return false;

    if (approval.sectionId != selectedRole.sectionId) return false;

    return true;
  }

  bool shouldShowApprovalButtons(List<ApprovalDetailModel> approvals) {
    final selectedRole = KAppX.globalProvider.read(rolesProvider);
    final user = KAppX.globalProvider.read(userInfoProvider);

    if (selectedRole == null) return false;

    final int userId = int.parse(user?.data?.id ?? '0');

    // Get active level (lowest active)
    final level = getActiveApprovalLevel(approvals);
    if (level == null) return false;

    // Only show approval button for "assigned" status
    // if (level.approvalStatus?.toLowerCase() != "assigned") return false;

    // Check user permissions
    if (!canUserActOnLevel(
      approval: level,
      userId: userId,
      selectedRole: selectedRole,
    )) {
      return false;
    }

    return true;
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
