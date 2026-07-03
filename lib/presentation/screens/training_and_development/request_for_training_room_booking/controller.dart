part of 'view.dart';

final selectedrequesteventTabProvider = StateProvider<int>((ref) => 0);

// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");

final requestDeatilsTabSelectedProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);

// final _vsProvider = StateNotifierProvider.autoDispose
//     .family<
//       _VSController,
//       _ViewState,
//       ({Service service, SubService subService})
//     >((ref, params) {
//       final controller = _VSController(
//         service: params.service,
//         subService: params.subService,
//       );
//       controller.initState();
//       return controller;
//     });
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
  final String selectedPriority;

  final List<FileUploadItem> selectedFileUrl;
  final List<Map<String, dynamic>> attachments;

  final KPIResponse kpiData;
  final KPIResponse approvalKpiData;

  final StatusBreakdownModel statusBreakdown;
  final TrendBreakdownModel trendData;
  final RequestDetailModel requestDataById;

  final int tabIndex;

  final StatusBreakdownModel approvalStatusBreakdown;
  final TrendBreakdownModel approvalTrendData;
  final List<TrainingandDevelopmentRequestModel>
  requestForTrainingRoomBookingRequestData;
  final List<TrainingandDevelopmentRequestModel>
  requestForTrainingRoomBookingActionItemsData;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final List<PendingApprovalUser> engineersList;
  final int approvalId;

  final bool isFormValid;
  final bool isButtonDisabled;
  final List<ChatMessageModel> chatById;
  final List<Position> positionsList;
  final List<EmployeeList> usersList;
  final String selectedPositionName;
  final EmployeeList? selectedUser;
  final String selectedUserName;
  final String selectedSalaryDetails;

  final int? selectedUserId;
  final List<EmployeeSummary> employeeList;
  final bool isStartDateSelected;

  final String selectedRequestType;
  final List<AllowanceEmployee> allowanceEmployees;
  final List<DepartmentModel> departments;
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

  /// FORM KEY
  final formKey = GlobalKey<FormState>();

  _ViewState({
    required this.isLoading,
    required this.selectedPriority,
    required this.selectedFileUrl,
    required this.attachments,
    required this.kpiData,
    required this.approvalKpiData,
    required this.statusBreakdown,
    required this.trendData,
    required this.requestDataById,
    required this.tabIndex,
    required this.approvalStatusBreakdown,
    required this.approvalTrendData,
    required this.requestForTrainingRoomBookingRequestData,
    required this.requestForTrainingRoomBookingActionItemsData,
    required this.requestDetails,
    required this.requestDetailTab,
    required this.engineersList,
    required this.approvalId,
    required this.isFormValid,
    required this.isButtonDisabled,
    required this.chatById,
    required this.positionsList,
    required this.selectedPositionName,
    this.selectedUserId,
    required this.usersList,
    required this.selectedUserName,
    this.selectedUser,
    required this.employeeList,
    required this.isStartDateSelected,
    required this.selectedSalaryDetails,
    required this.selectedRequestType,
    required this.allowanceEmployees,
    required this.departments,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        selectedPriority: '',
        selectedFileUrl: [],
        attachments: [],
        kpiData: KPIResponse(),
        approvalKpiData: KPIResponse(),
        statusBreakdown: StatusBreakdownModel(),
        trendData: TrendBreakdownModel(),
        requestDataById: RequestDetailModel(),
        tabIndex: 0,
        approvalStatusBreakdown: StatusBreakdownModel(),
        approvalTrendData: TrendBreakdownModel(),
        requestForTrainingRoomBookingRequestData: [],
        requestForTrainingRoomBookingActionItemsData: [],
        requestDetails: RequestDetailData(),
        requestDetailTab: 0,
        engineersList: [],
        approvalId: 0,
        isFormValid: false,
        isButtonDisabled: false,
        chatById: [],
        positionsList: [],
        selectedPositionName: '',
        selectedUserId: null,
        usersList: [],
        selectedUserName: '',
        selectedUser: null,
        employeeList: [],
        isStartDateSelected: false,
        selectedSalaryDetails: '',
        selectedRequestType: '',
        allowanceEmployees: [],
        departments: [],
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
    List<TrainingandDevelopmentRequestModel>?
    requestForTrainingRoomBookingRequestData,
    List<TrainingandDevelopmentRequestModel>?
    requestForTrainingRoomBookingActionItemsData,
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
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedFileUrl: selectedFileUrl ?? this.selectedFileUrl,
      attachments: attachments ?? this.attachments,
      kpiData: kpiData ?? this.kpiData,
      approvalKpiData: approvalKpiData ?? this.approvalKpiData,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      trendData: trendData ?? this.trendData,
      requestDataById: requestDataById ?? this.requestDataById,
      tabIndex: tabIndex ?? this.tabIndex,
      approvalStatusBreakdown:
          approvalStatusBreakdown ?? this.approvalStatusBreakdown,
      approvalTrendData: approvalTrendData ?? this.approvalTrendData,
      requestForTrainingRoomBookingRequestData:
          requestForTrainingRoomBookingRequestData ??
          this.requestForTrainingRoomBookingRequestData,
      requestForTrainingRoomBookingActionItemsData:
          requestForTrainingRoomBookingActionItemsData ??
          this.requestForTrainingRoomBookingActionItemsData,
      requestDetails: requestDetails ?? this.requestDetails,
      requestDetailTab: requestDetailTab ?? this.requestDetailTab,
      engineersList: engineersList ?? this.engineersList,
      approvalId: approvalId ?? this.approvalId,
      isFormValid: isFormValid ?? this.isFormValid,
      isButtonDisabled: isButtonDisabled ?? this.isButtonDisabled,
      chatById: chatById ?? this.chatById,
      positionsList: positionsList ?? this.positionsList,
      selectedPositionName: selectedPositionName ?? this.selectedPositionName,
      selectedUserId: selectedUserId ?? this.selectedUserId,
      usersList: usersList ?? this.usersList,
      selectedUserName: selectedUserName ?? this.selectedUserName,
      selectedUser: selectedUser ?? this.selectedUser,
      employeeList: employeeList ?? this.employeeList,
      isStartDateSelected: isStartDateSelected ?? this.isStartDateSelected,
      selectedSalaryDetails:
          selectedSalaryDetails ?? this.selectedSalaryDetails,
      selectedRequestType: selectedRequestType ?? this.selectedRequestType,
      allowanceEmployees: allowanceEmployees ?? this.allowanceEmployees,
      departments: departments ?? this.departments,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final Service service;
  final SubService subService;

  _VSController({required this.service, required this.subService})
    : super(_ViewState.init());
  Timer? _searchDebounce;

  late TextEditingController chatController;
  late TextEditingController titleController;
  late TextEditingController searchController;

  void initState() {
    chatController = TextEditingController();
    titleController = TextEditingController();
    searchController = TextEditingController();
    // fetchDepartmentName();
    fetchKpi();
    fetchApprovalKpi();
    // fetchUsers();
    fetchRequests();
    fetchActionItems();
    fetchStatusBreakdown('monthly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalStatusBreakdown('monthly');
    fetchApprovalTrendBreakDown(DateTime.now().year.toString());
    fetchDepartments();
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

  Map<String, String> buildRequestCardData(
    TrainingandDevelopmentRequestModel item,
  ) {
    final approvers = resolveApproverDisplayList(item.base?.approvalDetails);

    return {
      'Request Id': item.base?.id?.toString() ?? '-',
      'status': item.status ?? '-',
      // 'Purpose of Training': item.purposeOfTraining ?? '-',
      // 'Event Date': item.dateOfEvent ?? '-',
      // 'Number of Attendees': item.numberOfAttendees?.toString() ?? '-',
      if (approvers.length == 2) ...{
        'Department': approvers[0],
        'Section': approvers[1],
      } else if (approvers.length == 1)
        'Approver': approvers[0],
    };
  }

  Future<void> openRequestDetails(int id, {bool fromActionItems = false}) async {
    updateRequestTab(0);

    await KAppX.router.push(
      RequestforTrainingRoomBookingDetailsRoute(
        id: id,
        from: fromActionItems ? 'action items' : '',
        service: service,
        subService: subService,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      ),
    );

    if (fromActionItems) {
      returnToMyRequestsTab();
    }

    await refreshAfterReturn();
  }

  void returnToMyRequestsTab() {
    updateTabIndex(0);
  }

  Future<void> refreshAfterReturn() async {
    await Future.wait([
      fetchKpi(),
      fetchApprovalKpi(),
      fetchStatusBreakdown('monthly'),
      fetchTrendBreakDown(DateTime.now().year.toString()),
      fetchApprovalStatusBreakdown('monthly'),
      fetchApprovalTrendBreakDown(DateTime.now().year.toString()),
    ]);
    await fetchRequests(isRefresh: true);
    await fetchActionItems(isRefresh: true);
  }

  void openNewRequestForm(BuildContext context) {
    KAppX.router.push(
      RequestforTrainingRoomBookingRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
    FocusScope.of(context).unfocus();
  }

  final requestForTrainingRoomBookingInstance =
      RequestForTrainingRoomBookingRepository();
  final securityAccessInstance = SecurityAccessRepoistory();
  List<DynamicField> get trainingRoomBookingForm => [
    /// -------- PURPOSE OF TRAINING --------
    DynamicField(
      name: 'purposeOfTraining',
      label: 'Purpose of Training',
      type: FieldType.textarea,
      required: true,
      placeholder: 'Write Here...',
    ),

    /// -------- DATE OF EVENT --------
    DynamicField(
      name: 'eventDate',
      label: 'Date of Event',
      type: FieldType.date,
      required: true,
    ),

    /// -------- START TIME --------
    DynamicField(
      name: 'startTime',
      label: 'Start Time',
      type: FieldType.time,
      required: true,
    ),

    /// -------- END TIME --------
    DynamicField(
      name: 'endTime',
      label: 'End Time',
      type: FieldType.time,
      required: true,
    ),

    /// -------- CLASSROOM / TRAINING HALL --------
    DynamicField(
      name: 'trainingHallId',
      label: 'Select Classroom / Training Hall',
      type: FieldType.select,
      required: true,
      placeholder: 'Select Classroom / Training Hall',
      options: const [
        // Replace with API-driven options later
        DropdownOption(
          value: 'Classroom 1',
          label: 'Classroom 1 (Capacity: 40 Persons)',
        ),
        DropdownOption(
          value: 'Classroom 2',
          label: 'Classroom 2 (Capacity: 40 Persons)',
        ),
        DropdownOption(
          value: 'Classroom 3',
          label: 'Classroom 3 (Capacity: 40 Persons)',
        ),
        DropdownOption(
          value: 'Classroom 4',
          label: 'Classroom 4 (Capacity: 40 Persons)',
        ),
        DropdownOption(
          value: 'Training Centre Hall',
          label: 'Training Centre Hall (Capacity: 100 Persons)',
        ),
      ],
    ),

    /// -------- NETWORK SUPPORT REQUIRED --------
    DynamicField(
      name: 'networkSupportRequired',
      label: 'Network Support Required',
      type: FieldType.radio,
      required: false,
      options: const ['Yes', 'No'],
    ),

    /// -------- MEALS REQUIRED --------
    DynamicField(
      name: 'mealsRequired',
      label: 'Meals Required',
      type: FieldType.radio,
      required: false,
      options: const ['Yes', 'No'],
    ),

    /// -------- NUMBER OF ATTENDEES --------
    DynamicField(
      name: 'numberOfAttendees',
      label: 'Number of Attendees',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter',
    ),

    /// -------- REMARKS --------
    DynamicField(
      name: 'remarks',
      label: 'Remarks',
      type: FieldType.textarea,
      required: false,
      placeholder: 'Write Here...',
    ),

    /// -------- ATTACHMENTS --------
    DynamicField(
      name: 'attachments',
      label: 'Attachments',
      type: FieldType.file,
      required: false,
    ),
  ];

  Future<void> fetchRequestDetailsById(int id) async {
    try {
      final requests = await requestForTrainingRoomBookingInstance
          .getRequestsById(
            id: id,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );
      if (requests != null) {
        state = state.copyWith(requestDetails: requests);
        fetchChatById(id);
        updateButtonDisabledFromApprovals(requests.approvalDetails ?? []);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      // optionally handle other errors
      debugPrint(e.toString());
    }
  }

  Future<void> fetchDepartments() async {
    try {
      final departments = await securityAccessInstance.getDepartments();

      if (departments != null) {
        state = state.copyWith(departments: departments);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchChatById(int id) async {
    try {
      final requests = await requestForTrainingRoomBookingInstance.getchatById(
        id,
      );
      if (requests != null) {
        state = state.copyWith(chatById: requests);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      // optionally handle other errors
      debugPrint(e.toString());
    }
  }

  Future<void> deleteAttachment(int attachmentId, {int? requestId}) async {
    if (attachmentId == 0) {
      Fluttertoast.showToast(msg: 'Attachment ID missing');
      return;
    }

    try {
      state = state.copyWith(isLoading: true);
      final effectiveRequestId = requestId ?? state.requestDetails.request?.id;
      await requestForTrainingRoomBookingInstance.deleteAttachment(
        attachmentId,
        requestId: effectiveRequestId,
      );

      if (effectiveRequestId != null && effectiveRequestId != 0) {
        await fetchRequestDetailsById(effectiveRequestId);
      }
    } catch (e, st) {
      debugPrint('Failed to delete attachment: $e');
      debugPrintStack(stackTrace: st);
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchKpi() async {
    try {
      final kpis = await requestForTrainingRoomBookingInstance.getKpiData(
        service.id ?? 0,
        subService.id ?? 0,
      );

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalTrendBreakDown(String period) async {
    try {
      final data = await requestForTrainingRoomBookingInstance
          .getApprovalTrendBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );

      if (data != null) {
        state = state.copyWith(approvalTrendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await requestForTrainingRoomBookingInstance
          .getApprovalStatusBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );
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

  Future<void> fetchStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await requestForTrainingRoomBookingInstance
          .getStatusBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );
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
      final data = await requestForTrainingRoomBookingInstance
          .getTrendBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalKpi() async {
    try {
      final kpis = await requestForTrainingRoomBookingInstance
          .getApprovalKpiData(
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );

      if (kpis != null) {
        state = state.copyWith(approvalKpiData: kpis);
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
        state = state.copyWith(requestForTrainingRoomBookingRequestData: []);
      }

      final requests = await requestForTrainingRoomBookingInstance.getRequests(
        offset: 0,
        limit: 8,
        searchText: searchText,
        status: status,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      // No merging needed
      state = state.copyWith(
        requestForTrainingRoomBookingRequestData: requests,
      );
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
        state = state.copyWith(
          requestForTrainingRoomBookingActionItemsData: [],
        );
      }

      final items = await requestForTrainingRoomBookingInstance.getActionItems(
        offset: 0,
        limit: 8,
        searchText: searchText,
        status: status,

        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      // No merging needed
      state = state.copyWith(
        requestForTrainingRoomBookingActionItemsData: items,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void showApprovalCommentDialog({
    required ApprovalDialogType type,
    required int approverId,
    required int requestId,
  }) {
    KAppX.extendedRouter.dialog.showKDialog(
      builder: (_) => ApprovalCommentDialog(
        type: type,
        onSubmit: (comment, decisionNo) async {
          final status = type == ApprovalDialogType.approve
              ? ApprovalStatus.approved
              : ApprovalStatus.rejected;

          await onApprove(
            approverId,
            requestId,
            comment.trim(), // always safe
            status.apiValue, // ✅ backend-safe string
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

        final uploadedFiles = await requestForTrainingRoomBookingInstance
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

        // await requestForTrainingRoomBookingInstance.sendAttachment(payload, requestId);
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

        await requestForTrainingRoomBookingInstance.sendChat(
          payload,
          requestId,
        );
      }
      fetchChatById(requestId);

      /// 3️⃣ Clear UI state
      chatController.clear();
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
      await requestForTrainingRoomBookingInstance.onApprove(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      fetchActionItems();
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

  Future<void> onApprove(
    int approverId,
    int requestId,
    String comment,
    String status,
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

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await requestForTrainingRoomBookingInstance.onApprove(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      KAppX.router.pop();
      await fetchActionItems();
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
      // await requestForTrainingRoomBookingInstance.onSendInProgress(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      await fetchActionItems();
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

    /// 1️⃣ Delegate always allowed
    if (approval.delegateUserId == userId) return true;

    /// 2️⃣ Approver user rule
    /// null → open approval
    /// not null → must match logged-in user
    if (approval.approverUserId != null && approval.approverUserId != userId) {
      return false;
    }

    /// 3️⃣ Role must match (if defined)
    if (approval.approverRoleId != null &&
        approval.approverRoleId != selectedRole?.roleId) {
      return false;
    }

    /// 4️⃣ Department must match (if defined)
    if (approval.departmentId != null &&
        approval.departmentId != selectedRole?.departmentId) {
      return false;
    }

    /// 5️⃣ Section must match (if defined)
    if (approval.sectionId != null &&
        approval.sectionId != selectedRole?.sectionId) {
      return false;
    }

    return true;
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
    final next = getNextApprovalDetails(approvals ?? []);
    if (next == null) return 'N/A';

    final name = next.approverUser?.employeeName;
    if ((name ?? '').isNotEmpty) return name!;

    final role = next.approverRole?.name;
    if ((role ?? '').isNotEmpty) return role!;

    final department = next.department?.departmentName;
    final section = next.section?.sectionName;
    if ((department ?? '').isNotEmpty) {
      return _buildDepartmentSection({
        'department': department!,
        if ((section ?? '').isNotEmpty) 'section': section!,
      });
    }
    return 'N/A';
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

    if (level != null) {
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
    if (active.isAllowed != true) {
      state = state.copyWith(isButtonDisabled: true);
      return;
    }

    final status = active.approvalStatus?.toLowerCase();

    // ✅ Disable ONLY if ACTIVE is approved
    final shouldDisable = status == 'approved';

    state = state.copyWith(isButtonDisabled: shouldDisable);
  }

  bool _isPendingOrInProgress(String? status) {
    final s = status?.toLowerCase();
    return s == 'pending' || s == 'in progress';
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

  List<String> resolveApproverDisplayList(
    List<ApprovalDetailModel>? approvals,
  ) {
    if (approvals == null || approvals.isEmpty) {
      return [];
    }

    /// 1️⃣ Pending / In-progress
    final pending = approvals.firstWhere(
      (a) => _isPendingOrInProgress(a.approvalStatus),
      orElse: () => ApprovalDetailModel(),
    );

    if (pending.approvalStatus != null) {
      /// 🔹 CASE 1: approverRoleId is NULL → Department + Section
      if (pending.approverRoleId == null) {
        final department = pending.department?.departmentName;
        final section = pending.section?.sectionName;

        if ((department ?? '').isNotEmpty && (section ?? '').isNotEmpty) {
          return [department ?? '', section ?? ''];
        }

        if ((department ?? '').isNotEmpty) {
          return [department ?? ''];
        }

        return [];
      }

      /// 🔹 CASE 2: approverRoleId NOT NULL → Role Name
      final roleName = pending.approverRole?.name;
      if ((roleName ?? '').isNotEmpty) {
        return [roleName ?? ''];
      }

      return [];
    }

    /// 2️⃣ All completed → pick LAST approved
    final completed = approvals
        .where((a) => _isCompleted(a.approvalStatus))
        .toList();

    if (completed.isEmpty) {
      return [];
    }

    completed.sort((a, b) {
      final levelCompare = (a.level ?? 0).compareTo(b.level ?? 0);
      if (levelCompare != 0) return levelCompare;

      return _parseDate(a.updatedAt).compareTo(_parseDate(b.updatedAt));
    });

    final lastApproved = completed.last;

    final userName =
        lastApproved.approvedByUser?.employeeName ??
        lastApproved.approverUser?.employeeName;
    final roleName = lastApproved.approverRole?.name;

    if ((userName ?? '').isNotEmpty) {
      return [userName ?? '', roleName ?? ''];
    }

    return [];
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
  }

  void onRemoveFile(int index) {
    final urls = List<FileUploadItem>.from(state.selectedFileUrl);
    urls.removeAt(index);
    state = state.copyWith(selectedFileUrl: urls);
  }

  void refreshUI() {
    // triggers rebuild in UI
    state = state.copyWith();
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

  Future<void> submitRequestForCoverageRequest(
    int serviceId,
    int subServiceId,
    Map<String, dynamic> values,
  ) async {
    try {
      state = state.copyWith(isLoading: true);

      final userData = KAppX.globalProvider.read(rolesProvider);
      final userInfo = KAppX.globalProvider.read(userInfoProvider);

      // Build attachments list
      final List<Map<String, dynamic>> attachments =
          (values['attachment'] as List<FileUploadItem>? ?? [])
              .map((file) => file.toJson())
              .toList();

      /// -------- FINAL PAYLOAD (TRAINING ROOM BOOKING) --------
      final payload = {
        // ================= USER / REQUEST INFO =================
        "req_user_department_id": userData?.departmentId ?? 0,
        "req_user_section_id": userData?.sectionId ?? 0,
        "req_user_position_id": userInfo?.data?.position?.id ?? 0,

        // ================= SERVICE INFO =================
        "service_id": serviceId,
        "sub_service_id": subServiceId,

        // ================= TRAINING DETAILS =================
        "purpose_of_training": values['purposeOfTraining'],
        "date_of_event": values['eventDate'], // yyyy-MM-dd

        "start_time": values['startTime'], // HH:mm:ss
        "end_time": values['endTime'], // HH:mm:ss
        // Derived / helper field (API expects this)
        "timing_of_event": "${values['startTime']} - ${values['endTime']}",

        // ================= ROOM DETAILS =================
        "room_type": values['trainingHallId'],
        // or values['trainingHallName'] if backend expects label

        // ================= REQUIREMENTS =================
        "network_support_required": values['networkSupportRequired'] == 'Yes',

        "meals_required": values['mealsRequired'] == 'Yes',

        // ================= ATTENDEES =================
        "number_of_attendees":
            int.tryParse(values['numberOfAttendees']?.toString() ?? '0') ?? 0,

        // ================= OPTIONAL =================
        "remarks": values['remarks'] ?? "",

        // ================= ATTACHMENTS =================
        "attachments": attachments,
      };

      debugPrint("✅ Final Payload: $payload");

      // API CALL
      await requestForTrainingRoomBookingInstance
          .sendRequestForTrainingRoomBookingRequest(payload);

      // KAppX.router.pop();

      // Refresh dashboards
      fetchKpi();
      // fetchStatusBreakdown('monthly');
      // fetchTrendBreakDown(DateTime.now().year.toString());
      // fetchApprovalStatusBreakdown('monthly');
      // fetchApprovalTrendBreakDown(DateTime.now().year.toString());
      fetchApprovalKpi();
      fetchRequests();
      fetchActionItems();
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
