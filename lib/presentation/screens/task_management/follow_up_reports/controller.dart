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
  final bool isRequestLoading;

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
  final List<FollowUpReportRequestModel> requestData;
  final List<FollowUpReportRequestModel> actionItems;
  final String myRequestsStatusFilter;
  final String actionItemsStatusFilter;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final int approvalId;

  final bool isButtonDisabled;
  final List<ChatMessageModel> chatById;
  final List<AttachmentModel> attachmentsById;
  final List<HallData> availableHalls;
  final List<RelevantDepartmentModel> relevantDepartments;
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
    required this.isRequestLoading,
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
    required this.myRequestsStatusFilter,
    required this.actionItemsStatusFilter,
    required this.requestDetails,
    required this.requestDetailTab,
    required this.approvalId,
    required this.isButtonDisabled,
    required this.chatById,
    required this.attachmentsById,
    required this.availableHalls,
    required this.relevantDepartments,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        isRequestLoading: false,
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
        myRequestsStatusFilter: '',
        actionItemsStatusFilter: '',
        requestDetails: RequestDetailData(),
        requestDetailTab: 0,
        approvalId: 0,
        isButtonDisabled: false,
        chatById: [],

        attachmentsById: [],
        availableHalls: [],
        relevantDepartments: [],
      );

  _ViewState copyWith({
    bool? isLoading,
    bool? isRequestLoading,
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
    List<FollowUpReportRequestModel>? requestData,
    List<FollowUpReportRequestModel>? actionItems,
    String? myRequestsStatusFilter,
    String? actionItemsStatusFilter,
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
    List<HallData>? availableHalls,
    List<RelevantDepartmentModel>? relevantDepartments,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      isRequestLoading: isRequestLoading ?? this.isRequestLoading,
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
      myRequestsStatusFilter:
          myRequestsStatusFilter ?? this.myRequestsStatusFilter,
      actionItemsStatusFilter:
          actionItemsStatusFilter ?? this.actionItemsStatusFilter,
      requestDetails: requestDetails ?? this.requestDetails,
      requestDetailTab: requestDetailTab ?? this.requestDetailTab,
      approvalId: approvalId ?? this.approvalId,
      isButtonDisabled: isButtonDisabled ?? this.isButtonDisabled,
      chatById: chatById ?? this.chatById,
      attachmentsById: attachmentsById ?? this.attachmentsById,
      availableHalls: availableHalls ?? this.availableHalls,
      relevantDepartments: relevantDepartments ?? this.relevantDepartments,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  static const List<String> requestListStatusFilters = [
    '',
    'Approved',
    'Pending',
    'Rejected',
  ];

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

  VoidCallback? onMyRequestsListRefresh;
  VoidCallback? onActionItemsListRefresh;

  void refreshMyRequestsList() => onMyRequestsListRefresh?.call();
  void refreshActionItemsList() => onActionItemsListRefresh?.call();

  void refreshRequestLists() {
    refreshMyRequestsList();
    refreshActionItemsList();
  }

  void refreshActiveRequestList() {
    if (state.tabIndex == 0) {
      refreshMyRequestsList();
    } else {
      refreshActionItemsList();
    }
  }

  String get currentStatusFilter => state.tabIndex == 0
      ? state.myRequestsStatusFilter
      : state.actionItemsStatusFilter;

  String requestListStatusFilterLabel(String status, DashboardL10n l10n) {
    if (status.isEmpty) {
      return l10n.isArabic ? 'الكل' : 'All';
    }
    return l10n.statusLabel(status);
  }

  void onRequestStatusFilterChanged(String status) {
    if (state.tabIndex == 0) {
      state = state.copyWith(myRequestsStatusFilter: status);
      refreshMyRequestsList();
    } else {
      state = state.copyWith(actionItemsStatusFilter: status);
      refreshActionItemsList();
    }
  }

  void initState() {
    chatController = TextEditingController();
    titleController = TextEditingController();
    searchController = TextEditingController();
    fetchKpi();
    fetchApprovalKpi();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalStatusBreakdown('weekly');
    fetchApprovalTrendBreakDown(DateTime.now().year.toString());
    fetchRelevantDepartments();
    // fetchbyCycleGoals(cycle: 'Jan-Jun');
  }

  /// Loads the departments under the logged-in user's DG department for the
  /// "Relevant Department" dropdown.
  Future<void> fetchRelevantDepartments() async {
    final selectedRole = KAppX.globalProvider.read(rolesProvider);
    final departmentId = selectedRole?.departmentId;

    if (departmentId == null) return;

    try {
      final departments = await followupReportInstance.getRelevantDepartments(
        departmentId: departmentId,
      );
      state = state.copyWith(relevantDepartments: departments);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      debugPrint('Error fetching relevant departments: $e');
    }
  }

  void onSearchChanged(String value) {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      refreshActiveRequestList();
    });
  }

  int get currentYear => DateTime.now().year;

  List<String> get filterLabelList =>
      List.generate(6, (index) => (currentYear - index).toString());
  List<StatSummaryData> currentStats(String Function(String key) titleForKey) =>
      state.tabIndex == 0
      ? StatSummaryHelper.buildStatList(
          state.kpiData.data?.toJson(),
          titleForKey: titleForKey,
        )
      : StatSummaryHelper.buildStatList(
          state.approvalKpiData.data?.toJson(),
          titleForKey: titleForKey,
        );
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

  Map<String, String> buildRequestCardData(FollowUpReportRequestModel item) {
    final approverMap = resolveApproverMap(item.base?.approvalDetails ?? []);

    return {
      'Request Id': item.base?.id?.toString() ?? '-',
      'status': item.base?.status ?? '-',
      'Request By': item.base?.createdByUser?.employeeName ?? '-',
      'Request Submission Date': item.base?.createdAt.toString() ?? '-',
      // 'Type of Project': item.titleOfProject ?? 'NA',

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
    final data = request?.rawJson ?? const <String, dynamic>{};

    return {
      'Topic': data['topic']?.toString() ?? 'N/A',
      'Concerned Department': data['concerned_department']?.toString() ?? 'N/A',
      'Relevant Department': data['relevant_department']?.toString() ?? 'N/A',
      'Date From': data['date_from']?.toString() ?? 'N/A',
      'Date To': data['date_to']?.toString() ?? 'N/A',
    };
  }

  List<Map<String, dynamic>> buildFollowUpReportItems() {
    final detailsData = state.requestDetails.rawJson;
    final requestData =
        state.requestDetails.request?.rawJson ?? const <String, dynamic>{};
    final rawItems =
        detailsData['report_items'] ??
        detailsData['follow_up_reports'] ??
        requestData['report_items'];

    if (rawItems is List) {
      return rawItems
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }

    // Some API versions return the single report item on the request itself.
    if (requestData['sent_by'] != null ||
        requestData['reference_type'] != null) {
      return [Map<String, dynamic>.from(requestData)];
    }

    return const [];
  }

  Map<String, String> buildStatusInformation() {
    final request = state.requestDetails.request;
    final approvals = state.requestDetails.approvalDetails;
    final nextApprover = resolveApproverMap(approvals);
    return {
      "Approval Status": request?.status ?? 'N/A',
      "Requested Date": formatDate(request?.createdAt.toString()),
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
    int initialTabIndex = RequestDetailsTabIndex.requestDetails,
  }) async {
    updateRequestTab(initialTabIndex);

    await KAppX.router.push(
      FollowUpReportDetailsRoute(
        id: id,
        from: fromActionItems ? 'action items' : '',
        service: service,
        subService: subService,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      ),
    );

    returnToMyRequestsTab();
    await refreshAfterReturn();
  }

  void returnToMyRequestsTab() {
    MyRequestsTabPageSyncRegistry.syncToTab(
      serviceId: service.id,
      subServiceId: subService.id,
      index: 0,
    );
    updateTabIndex(0);
    MyRequestsTabPageSyncRegistry.syncToTab(
      serviceId: service.id,
      subServiceId: subService.id,
      index: 0,
    );
  }

  Future<void> refreshAfterReturn() async {
    await Future.wait([
      fetchKpi(),
      fetchApprovalKpi(),
      fetchStatusBreakdown('weekly'),
      fetchTrendBreakDown(DateTime.now().year.toString()),
      fetchApprovalStatusBreakdown('weekly'),
      fetchApprovalTrendBreakDown(DateTime.now().year.toString()),
    ]);
    refreshActiveRequestList();
  }

  void openNewRequestForm() {
    // fetchbyCycleGoals(cycle: 'Jan-Jun');
    // state = state.copyWith(selectedUsersList: []);
    KAppX.router.push(
      FollowUpReportNewRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
  }

  final followupReportInstance = FollowUpReportRepository();

  List<DynamicField> buildFollowUpReportFields(
    DashboardL10n l10n, {
    bool isEditMode = false,
  }) => [
    /// ================= TOPIC =================
    DynamicField(
      name: 'topic',
      label: l10n.requestDetailsLabel('Topic'),
      type: FieldType.text,
      required: true,
      placeholder: l10n.followUpEnterTopic,

      validator: (value, values) {
        final text = value?.toString().trim() ?? '';

        if (text.isEmpty) {
          return l10n.followUpTopicRequired;
        }

        return null;
      },
    ),

    /// ================= CONCERNED DEPARTMENT =================
    DynamicField(
      name: 'concerned_department',
      label: l10n.requestDetailsLabel('Concerned Department'),
      type: FieldType.select,
      required: true,
      placeholder: l10n.followUpSelectConcernedDepartment,

      options: [
        DropdownOption(label: l10n.followUpDepartmentIt, value: 'IT'),
        DropdownOption(label: l10n.followUpDepartmentHr, value: 'HR'),
        DropdownOption(
          label: l10n.followUpDepartmentTraining,
          value: 'Training',
        ),
        DropdownOption(label: l10n.followUpDepartmentFinance, value: 'Finance'),
        DropdownOption(
          label: l10n.followUpDepartmentProjectsMaintenance,
          value: 'Projects & Maintenance',
        ),
      ],

      validator: (value, values) {
        if (value == null || value.toString().isEmpty) {
          return l10n.followUpConcernedDepartmentRequired;
        }

        return null;
      },
    ),

    /// ================= RELEVANT DEPARTMENT =================
    DynamicField(
      name: 'relevant_department',
      label: l10n.followUpRelevantDepartmentLabel,
      type: FieldType.select,
      required: false,
      placeholder: l10n.followUpSelectRelevantDepartment,

      optionsBuilder: (ref) {
        final formL10n = DashboardL10n.of(ref.context);
        final formState = ref.watch(_vsProvider(params));

        return formState.relevantDepartments
            .map(
              (department) => DropdownOption(
                value: department.id,
                label: department.displayName(isArabic: formL10n.isArabic),
              ),
            )
            .toList();
      },
    ),

    /// ================= DATE FROM =================
    DynamicField(
      name: 'date_from',
      label: l10n.requestDetailsLabel('Date From'),
      type: FieldType.date,
      required: true,
      placeholder: 'MM/DD/YYYY',

      validator: (value, values) {
        if (value == null || value.toString().isEmpty) {
          return l10n.followUpDateFromRequired;
        }

        return null;
      },
    ),

    /// ================= DATE TO =================
    DynamicField(
      name: 'date_to',
      label: l10n.requestDetailsLabel('Date To'),
      type: FieldType.date,
      required: true,
      placeholder: 'MM/DD/YYYY',

      validator: (value, values) {
        if (value == null || value.toString().isEmpty) {
          return l10n.followUpDateToRequired;
        }

        return null;
      },
    ),

    /// ================= ATTACHMENTS =================
    if (!isEditMode)
      DynamicField(
        name: 'attachments',
        label: l10n.requestDetailsLabel('Attachments'),
        type: FieldType.file,
        required: true,

        validator: (value, values) {
          if (value == null) {
            return l10n.followUpAttachmentRequired;
          }

          if (value is List && value.isEmpty) {
            return l10n.followUpUploadAttachmentRequired;
          }

          return null;
        },
      ),
  ];

  /// ================= ACTION CARDS (STEP 2) =================
  List<DynamicField> buildFollowUpActionFields(
    DashboardL10n l10n, {
    bool isEditMode = false,
  }) => [
    DynamicField(
      name: kFollowUpActionsKey,
      label: l10n.followUpActionsStepTitle,
      type: FieldType.custom,
      required: true,
      builder: (context, ref) =>
          FollowUpActionCards(showAttachment: !isEditMode),
      validator: (value, values) {
        final list = value is List ? value : const [];

        if (list.isEmpty) {
          return l10n.followUpActionsRequired;
        }

        const requiredKeys = [
          'sent_by',
          'letter_date',
          'subject',
          'subject_classification',
          'general_manager_comment',
          'response_date',
          'action_status',
          'action_taken',
        ];

        for (final item in list) {
          if (item is! Map) {
            return l10n.followUpActionsRequired;
          }
          for (final key in requiredKeys) {
            final fieldValue = item[key];
            if (fieldValue == null || fieldValue.toString().trim().isEmpty) {
              return l10n.followUpActionsRequired;
            }
          }
        }

        return null;
      },
    ),
  ];

  /// ========================= API CALLS =========================

  Future<void> fetchRequestDetailsById(
    int id, {
    bool showLoading = true,
  }) async {
    if (showLoading) {
      state = state.copyWith(isLoading: true);
    }
    try {
      final requests = await followupReportInstance.getRequestsById(
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
      state = state.copyWith(isLoading: false);
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      debugPrint(e.toString());
    }
  }

  Future<void> fetchChatById(int id) async {
    try {
      final requests = await followupReportInstance.getchatById(id);
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
      final attachments = await followupReportInstance.getAttachmentsById(id);
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

  Future<void> deleteAttachment(int attachmentId, {int? requestId}) async {
    if (attachmentId == 0) {
      Fluttertoast.showToast(msg: 'Attachment ID missing');
      return;
    }

    try {
      state = state.copyWith(isLoading: true);
      final effectiveRequestId = requestId ?? state.requestDetails.request?.id;
      await followupReportInstance.deleteAttachment(
        attachmentId,
        requestId: effectiveRequestId,
      );

      final updatedAttachments = state.attachmentsById
          .where((attachment) => attachment.id != attachmentId)
          .toList();
      state = state.copyWith(attachmentsById: updatedAttachments);

      if (effectiveRequestId != null && effectiveRequestId != 0) {
        await fetchAttachmentsById(effectiveRequestId);
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
    state = state.copyWith(isLoading: true);
    try {
      final kpis = await followupReportInstance.getKpiData(
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
      final data = await followupReportInstance.getApprovalTrendBreakdownData(
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
      final statusBreakdown = await followupReportInstance
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
      final statusBreakdown = await followupReportInstance
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
      final data = await followupReportInstance.getTrendBreakdownData(
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
      final kpis = await followupReportInstance.getApprovalKpiData(
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

  Future<List<FollowUpReportRequestModel>> loadMyRequestsPage(
    int pageKey, {
    String searchText = '',
    String status = '',
  }) async {
    if (!mounted) return [];

    try {
      return await followupReportInstance.getRequests(
        offset: ListPagination.offsetForPage(pageKey),
        limit: ListPagination.pageSize,
        searchText: searchText,
        status: status,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: e.toString());
      }
      rethrow;
    }
  }

  Future<List<FollowUpReportRequestModel>> loadActionItemsPage(
    int pageKey, {
    String searchText = '',
    String status = '',
  }) async {
    if (!mounted) return [];

    try {
      return await followupReportInstance.getActionItems(
        offset: ListPagination.offsetForPage(pageKey),
        limit: ListPagination.pageSize,
        searchText: searchText,
        status: status,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: e.toString());
      }
      rethrow;
    }
  }

  String formatTime(String? time) {
    if (time == null || time.isEmpty) return '';

    final parts = time.split(':');

    if (parts.length >= 2) {
      return '${parts[0]}:${parts[1]}';
    }

    return time;
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

          await onApprove(
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

        final uploadedFiles = await followupReportInstance.uploadAttachments(
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

        await followupReportInstance.sendAttachment(payload, requestId);
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

        await followupReportInstance.sendChat(payload, requestId);
      }

      await fetchRequestDetailsById(requestId, showLoading: false);

      /// 3️⃣ Clear UI state
      chatController.clear();
      state.attachments.clear();
    } catch (e, st) {
      debugPrint('❌ Failed to send chat: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  Future<void> onApprove(
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
      await followupReportInstance.onApprove(payload);
      await Future.delayed(Duration(seconds: 2));
      KAppX.router.pop();
      KAppX.router.pop();
      returnToMyRequestsTab();
      await fetchApprovalKpi();
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
      // await followupReportInstance.onSendInProgress(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      returnToMyRequestsTab();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  bool canUserActOnLevel({required ApprovalDetailModel approval}) {
    final selectedRole = KAppX.globalProvider.read(rolesProvider);
    final user = KAppX.globalProvider.read(userInfoProvider);

    final int userId = int.tryParse(user?.data?.id ?? '') ?? 0;

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

  String buildAssignedToLabel(List<ApprovalDetailModel>? approvals) {
    final approverMap = resolveApproverMap(approvals);
    if (approverMap.containsKey('name')) {
      return approverMap['name'] ?? '';
    }
    if (approverMap.containsKey('role')) {
      return approverMap['role'] ?? '';
    }
    if (approverMap.containsKey('department')) {
      return _buildDepartmentSection(approverMap);
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

    if (selectedRole == null) return ActionButtonsType.none;

    final requestStatus = (request?.request?.status ?? request?.status ?? '')
        .toLowerCase()
        .trim()
        .replaceAll('_', ' ');
    final canEdit = selectedRole.roleId == 39;
    final isEditableStatus =
        requestStatus == 'completed' ||
        requestStatus == 'approved' ||
        requestStatus == 'in progress' ||
        requestStatus == 'inprogress' ||
        requestStatus == 'pending';

    // Get active approval level
    final level = getActiveApprovalLevel(approvals);
    final canAct =
        level != null && canUserActOnLevel(approval: level);

    if (canAct) {
      final bool? isManager = level.isManager;
      if (isManager == true) {
        return canEdit
            ? ActionButtonsType.approveRejectUpdate
            : ActionButtonsType.assignReject;
      }
      return canEdit
          ? ActionButtonsType.approveRejectUpdate
          : ActionButtonsType.approveReject;
    }

    // Role 39 can still Edit while In Progress / Completed / Approved
    // even when there is no active approval action.
    if (canEdit && isEditableStatus) {
      return ActionButtonsType.update;
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

  void updateRequestTab(int index, {bool refreshDetails = false}) {
    state = state.copyWith(requestDetailTab: index);
    if (!refreshDetails) return;

    final requestId = state.requestDetails.request?.id;
    if (requestId != null && requestId != 0) {
      fetchRequestDetailsById(requestId, showLoading: false);
    }
  }

  void updateTabIndex(int index) {
    state = state.copyWith(
      tabIndex: index,
      myRequestsStatusFilter: index == 0 ? '' : state.myRequestsStatusFilter,
      actionItemsStatusFilter: index == 1 ? '' : state.actionItemsStatusFilter,
    );
    if (index == 0) {
      refreshMyRequestsList();
      fetchKpi();
      fetchStatusBreakdown('weekly');
      fetchTrendBreakDown(DateTime.now().year.toString());
      searchController.text = '';
    } else {
      refreshActionItemsList();
      fetchApprovalKpi();
      fetchApprovalStatusBreakdown('weekly');
      fetchApprovalTrendBreakDown(DateTime.now().year.toString());
      searchController.text = '';
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

  /// Maps a single action card (as serialized by [FollowUpActionCards]) into
  /// a `report_items` entry expected by the backend.
  Map<String, dynamic> _buildReportItem(Map<dynamic, dynamic> card) {
    return {
      "reference_type": card['sent_by'] ?? "",
      "letter_date": card['letter_date'] ?? "",
      "subject": card['subject'] ?? "",
      "subject_classification": card['subject_classification'] ?? "",
      "general_manager_comment": card['general_manager_comment'] ?? "",
      "response_date_target": card['response_date'] ?? "",
      "action_status": card['action_status'] ?? "",
      "action_taken": card['action_taken'] ?? "",
      "delay_period": (card['delay_period'] ?? "0").toString(),
      "attachment": card['attachment'],
    };
  }

  Map<String, dynamic> _buildPayload(
    int serviceId,
    int subServiceId,
    Map<String, dynamic> values,
  ) {
    /// ACTION CARDS → report_items
    final actionCards = values[kFollowUpActionsKey] is List
        ? List<Map<dynamic, dynamic>>.from(
            (values[kFollowUpActionsKey] as List).whereType<Map>(),
          )
        : <Map<dynamic, dynamic>>[];

    final reportItems = actionCards.map(_buildReportItem).toList();

    /// The first card's values are also flattened at the top level.
    final firstCard = actionCards.isNotEmpty
        ? actionCards.first
        : <dynamic, dynamic>{};

    return {
      /// SERVICE
      "service_id": serviceId,
      "sub_service_id": subServiceId,

      /// USER DETAILS
      "req_user_department_id": values['req_user_department_id'],

      "req_user_section_id": values['req_user_section_id'],

      /// REQUEST DETAILS
      "topic": values['topic'] ?? "",

      "concerned_department": values['concerned_department'] ?? "",

      "relevant_department": values['relevant_department'] ?? "",

      /// DATE RANGE
      "date_from": values['date_from'] ?? "",

      "date_to": values['date_to'] ?? "",

      /// ATTACHMENTS
      "attachments": _buildAttachments(values),

      /// LETTER DETAILS (flattened first report item)
      "sent_by": firstCard['sent_by'] ?? "",

      "letter_date": firstCard['letter_date'] ?? "",

      "subject": firstCard['subject'] ?? "",

      "subject_classification": firstCard['subject_classification'] ?? "",

      "general_manager_comment": firstCard['general_manager_comment'] ?? "",

      "response_date_target": firstCard['response_date'] ?? "",

      "action_status": firstCard['action_status'] ?? "",

      "action_taken": firstCard['action_taken'] ?? "",

      "delay_period": (firstCard['delay_period'] ?? "0").toString(),

      /// ACTION CARDS
      "report_items": reportItems,
    };
  }

  Future<bool> submitProjectApprovalRequest(
    int serviceId,
    int subServiceId,
    Map<String, dynamic> values, {
    bool isEditMode = false,
    int? requestId,
  }) async {
    try {
      state = state.copyWith(isLoading: true);

      final Map<String, dynamic> payload;
      if (isEditMode) {
        payload = _buildUpdatePayload(values);
      } else {
        payload = _buildPayload(serviceId, subServiceId, values);
      }

      debugPrint("✅ Final Payload: $payload");

      final Map<String, dynamic> response;
      if (isEditMode && requestId != null) {
        response = await followupReportInstance.followUpReportUpdateRequest(
          requestId,
          payload,
        );
      } else {
        response = await followupReportInstance.followUpReportCreateRequest(
          payload,
        );
      }

      if (response['status'] == 'success') {
        await Future.delayed(Duration(seconds: 2));
        _refreshDashboard();
        return true;
      }
      return false;
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> openEditRequestForm(int requestId) async {
    await fetchRelevantDepartments();
    final result = await KAppX.router.push<bool>(
      FollowUpReportNewRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
        isEditMode: true,
        requestId: requestId,
      ),
    );

    if (result == true) {
      await fetchRequestDetailsById(requestId, showLoading: false);
    }
  }

  String _normalizeDateForForm(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '';
    final trimmed = raw.trim();
    try {
      final dt = DateTime.parse(trimmed);
      final y = dt.year.toString().padLeft(4, '0');
      final m = dt.month.toString().padLeft(2, '0');
      final d = dt.day.toString().padLeft(2, '0');
      return '$y-$m-$d';
    } catch (_) {
      if (trimmed.length >= 10) return trimmed.substring(0, 10);
      return trimmed;
    }
  }

  int? _resolveRelevantDepartmentId(dynamic raw) {
    if (raw == null) return null;
    if (raw is int) return raw;
    final asInt = int.tryParse(raw.toString());
    if (asInt != null) return asInt;

    final name = raw.toString().trim().toLowerCase();
    if (name.isEmpty) return null;

    for (final department in state.relevantDepartments) {
      final en = (department.departmentName ?? '').trim().toLowerCase();
      final ar = (department.departmentArabicName ?? '').trim().toLowerCase();
      if (en == name || ar == name) {
        return department.id;
      }
    }
    return null;
  }

  String _resolveRelevantDepartmentName(dynamic raw) {
    if (raw == null) return '';
    if (raw is String && int.tryParse(raw) == null) {
      return raw.trim();
    }

    final id = raw is int ? raw : int.tryParse(raw.toString());
    if (id == null) return raw.toString();

    for (final department in state.relevantDepartments) {
      if (department.id == id) {
        return department.departmentName ?? '';
      }
    }
    return raw.toString();
  }

  Map<String, dynamic> _mapReportItemToActionCard(Map<dynamic, dynamic> item) {
    return {
      'sent_by': item['reference_type'] ?? item['sent_by'] ?? '',
      'letter_date': _normalizeDateForForm(item['letter_date']?.toString()),
      'subject': item['subject'] ?? '',
      'subject_classification': item['subject_classification'] ?? '',
      'general_manager_comment': item['general_manager_comment'] ?? '',
      'response_date':
          item['response_date_target'] ?? item['response_date'] ?? '',
      'action_status': item['action_status'] ?? '',
      'action_taken': item['action_taken'] ?? '',
      'delay_period': (item['delay_period'] ?? '0').toString(),
      'attachment': item['attachment'],
    };
  }

  Future<Map<String, dynamic>?> loadFormValuesForEdit(int requestId) async {
    final raw = await followupReportInstance.getRequestRawById(requestId);
    if (raw == null) return null;

    await fetchRelevantDepartments();

    final reportItemsRaw = raw['report_items'];
    final List<Map<String, dynamic>> actionCards = [];

    if (reportItemsRaw is List && reportItemsRaw.isNotEmpty) {
      for (final item in reportItemsRaw) {
        if (item is Map) {
          actionCards.add(_mapReportItemToActionCard(item));
        }
      }
    }

    if (actionCards.isEmpty) {
      actionCards.add(
        _mapReportItemToActionCard({
          'reference_type': raw['sent_by'],
          'letter_date': raw['letter_date'],
          'subject': raw['subject'],
          'subject_classification': raw['subject_classification'],
          'general_manager_comment': raw['general_manager_comment'],
          'response_date_target': raw['response_date_target'],
          'action_status': raw['action_status'],
          'action_taken': raw['action_taken'],
          'delay_period': raw['delay_period'],
          'attachment': null,
        }),
      );
    }

    return {
      'topic': raw['topic'] ?? '',
      'concerned_department': raw['concerned_department'] ?? '',
      'relevant_department': _resolveRelevantDepartmentId(
        raw['relevant_department'],
      ),
      'date_from': _normalizeDateForForm(raw['date_from']?.toString()),
      'date_to': _normalizeDateForForm(raw['date_to']?.toString()),
      kFollowUpActionsKey: actionCards,
    };
  }

  Map<String, dynamic> _buildUpdatePayload(Map<String, dynamic> values) {
    final actionCards = values[kFollowUpActionsKey] is List
        ? List<Map<dynamic, dynamic>>.from(
            (values[kFollowUpActionsKey] as List).whereType<Map>(),
          )
        : <Map<dynamic, dynamic>>[];

    final reportItems = actionCards.map((card) {
      final item = _buildReportItem(card);
      item.remove('attachment');
      return item;
    }).toList();
    final firstCard = actionCards.isNotEmpty
        ? actionCards.first
        : <dynamic, dynamic>{};

    return {
      'topic': values['topic'] ?? '',
      'concerned_department': values['concerned_department'] ?? '',
      'relevant_department': _resolveRelevantDepartmentName(
        values['relevant_department'],
      ),
      'date_from': values['date_from'] ?? '',
      'date_to': values['date_to'] ?? '',
      'sent_by': firstCard['sent_by'] ?? '',
      'letter_date': firstCard['letter_date'] ?? '',
      'subject': firstCard['subject'] ?? '',
      'subject_classification': firstCard['subject_classification'] ?? '',
      'general_manager_comment': firstCard['general_manager_comment'] ?? '',
      'response_date_target': firstCard['response_date'] ?? '',
      'action_status': firstCard['action_status'] ?? '',
      'action_taken': firstCard['action_taken'] ?? '',
      'delay_period': (firstCard['delay_period'] ?? '0').toString(),
      'report_items': reportItems,
    };
  }

  Future<void> _refreshDashboard() async {
    state = state.copyWith(isRequestLoading: true);

    fetchKpi();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalStatusBreakdown('weekly');
    fetchApprovalTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalKpi();
    refreshRequestLists();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
