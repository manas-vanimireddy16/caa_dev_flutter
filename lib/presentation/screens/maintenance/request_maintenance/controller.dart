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
      return _VSController(
        service: params.service,
        subService: params.subService,
      );
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
  final List<MaintenanceRequestModel> requestData;
  final List<MaintenanceRequestModel> actionItems;
  final String myRequestsStatusFilter;
  final String actionItemsStatusFilter;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final int approvalId;

  final bool isButtonDisabled;
  final List<ChatMessageModel> chatById;
  final List<AttachmentModel> attachmentsById;
  final List<StationModel> stationsList;
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
    required this.stationsList,
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
        stationsList: [],
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
    List<MaintenanceRequestModel>? requestData,
    List<MaintenanceRequestModel>? actionItems,
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
    List<StationModel>? stationsList,
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
      stationsList: stationsList ?? this.stationsList,
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
    chatController = TextEditingController();
    titleController = TextEditingController();
    searchController = TextEditingController();
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

  void initState() {
    fetchKpi();
    fetchApprovalKpi();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());
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

  Map<String, String> buildRequestCardData(MaintenanceRequestModel item) {
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
    return {
      /// ───── RIGHT COLUMN ─────
      "Service Type": request?.service?.name ?? 'N/A',

      /// ───── LEFT COLUMN ─────
      "Sub Service Type": request?.subService?.subServiceName ?? 'N/A',
      // 'Request Submission Date':
      //     formatDate(request?.createdAt.toString()) ?? '-',
      'Purpose of Event': request?.purposeOfEvent ?? 'NA',
      'Hall Name': request?.typeOfHall ?? 'NA',
      'Expected Number of Attendees':
          request?.noOfAttendees?.toString() ?? 'N/A',
      'Start Date': request?.startDate ?? 'N/A',
      'End Date': request?.endDate ?? 'N/A',
      'Start Time': request?.startTime ?? 'N/A',
      'End Time': request?.endTime ?? 'N/A',
    };
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
  }) async {
    updateRequestTab(0);

    await KAppX.router.push(
      RequestMaintenanceDetailsRoute(
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
      fetchKpi(),
      fetchStatusBreakdown('weekly'),
      fetchTrendBreakDown(DateTime.now().year.toString()),
    ]);
    refreshRequestLists();
  }

  Future<void> openNewRequestForm() async {
    await fetchStations();
    KAppX.router.push(
      RequestMaintenanceNewRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
  }

  final requestMaintenanceInstance = RequestMaintenanceRepository();
  List<DynamicField> buildRequestMaintenanceFields(DashboardL10n l10n) => [
    /// ================= CATEGORY =================
    DynamicField(
      name: 'category',
      label: l10n.requestDetailsLabel('Category'),
      type: FieldType.select,
      required: true,
      placeholder: 'Select Category',

      options: [
        DropdownOption(label: 'Building', value: 'Building'),
        DropdownOption(label: 'Station', value: 'Station'),
        DropdownOption(label: 'Residential', value: 'Residential'),
      ],

      validator: (value, values) {
        if (value == null || value.toString().isEmpty) {
          return 'Category is required';
        }

        return null;
      },
    ),
    DynamicField(
      name: 'station',
      label: l10n.requestDetailsLabel('Station'),
      type: FieldType.select,
      required: true,
      placeholder: 'Select Station',
      visibleWhen: (values) => values['category'] == 'Station',
      options: state.stationsList
          .map(
            (station) => DropdownOption(
              label: '${station.stationName} (${station.stationCode})' ?? 'N/A',
              value: station.id?.toString() ?? '',
            ),
          )
          .toList(),

      validator: (value, values) {
        if (value == null || value.toString().isEmpty) {
          return 'Station is required';
        }

        return null;
      },
    ),

    /// ================= BUILDING SITE CLASSIFICATION =================
    DynamicField(
      name: 'building_site_classification',
      label: l10n.requestDetailsLabel('Building Site Classification'),
      type: FieldType.radio,
      required: true,

      options: [
        DropdownOption(
          label: 'CAA Muscat/outside station',
          value: 'CAA Muscat/outside station',
        ),

        DropdownOption(label: 'Housing', value: 'Housing'),
      ],

      validator: (value, values) {
        if (value == null || value.toString().isEmpty) {
          return 'Building Site Classification is required';
        }

        return null;
      },
    ),

    /// ================= SUB CATEGORY =================
    DynamicField(
      name: 'sub_category',
      label: l10n.requestDetailsLabel('Sub Category'),
      type: FieldType.select,
      required: true,
      placeholder: 'Please select a sub-category',

      options: [
        DropdownOption(label: 'Electrical', value: 'Electrical'),

        DropdownOption(label: 'Plumbing', value: 'Plumbing'),

        DropdownOption(label: 'HVAC', value: 'HVAC'),

        DropdownOption(label: 'Civil', value: 'Civil'),

        DropdownOption(label: 'Cleaning', value: 'Cleaning'),

        DropdownOption(label: 'Other', value: 'Other'),
      ],

      validator: (value, values) {
        if (value == null || value.toString().isEmpty) {
          return 'Sub Category is required';
        }

        return null;
      },
    ),

    /// ================= EMERGENCY MAINTENANCE SUPPORT =================
    DynamicField(
      name: 'emergency_maintenance_support',
      label: l10n.requestDetailsLabel('Emergency Maintenance Support'),
      type: FieldType.radio,
      required: true,

      options: ['Yes', 'No'],

      validator: (value, values) {
        if (value == null) {
          return 'Emergency Maintenance Support is required';
        }

        return null;
      },
    ),

    /// ================= LOCATION =================
    DynamicField(
      name: 'location',
      label: l10n.requestDetailsLabel('Location'),
      type: FieldType.text,
      required: true,
      placeholder: 'Location',

      validator: (value, values) {
        final text = value?.toString().trim() ?? '';

        if (text.isEmpty) {
          return 'Location is required';
        }

        return null;
      },
    ),

    /// ================= REASON FOR MAINTENANCE =================
    DynamicField(
      name: 'reason_for_maintenance',
      label: l10n.requestDetailsLabel('Reason for Maintenance'),
      type: FieldType.textarea,
      required: true,
      placeholder: 'Reason for Maintenance',

      validator: (value, values) {
        final text = value?.toString().trim() ?? '';

        if (text.isEmpty) {
          return 'Reason for Maintenance is required';
        }

        return null;
      },
    ),

    /// ================= DESCRIPTION =================
    DynamicField(
      name: 'description',
      label: l10n.requestDetailsLabel('Description'),
      type: FieldType.textarea,
      // required: true,
      placeholder: 'Enter Description',

      validator: (value, values) {
        final text = value?.toString().trim() ?? '';

        if (text.isEmpty) {
          return 'Description is required';
        }

        return null;
      },
    ),

    /// ================= ATTACHMENTS =================
    DynamicField(
      name: 'attachments',
      label: l10n.requestDetailsLabel('Attachments'),
      type: FieldType.file,

      // required: true,
      validator: (value, values) {
        if (value == null) {
          return 'Attachment is required';
        }

        if (value is List && value.isEmpty) {
          return 'Please upload at least one attachment';
        }

        return null;
      },
    ),
  ];

  /// ========================= API CALLS =========================

  Future<void> fetchRequestDetailsById(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      final requests = await requestMaintenanceInstance.getRequestsById(
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
      final requests = await requestMaintenanceInstance.getchatById(id);
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
      final attachments = await requestMaintenanceInstance.getAttachmentsById(
        id,
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

  Future<void> deleteAttachment(int attachmentId, {int? requestId}) async {
    if (attachmentId == 0) {
      Fluttertoast.showToast(msg: 'Attachment ID missing');
      return;
    }

    try {
      state = state.copyWith(isLoading: true);
      await requestMaintenanceInstance.deleteAttachment(attachmentId);

      final updatedAttachments = state.attachmentsById
          .where((attachment) => attachment.id != attachmentId)
          .toList();
      state = state.copyWith(attachmentsById: updatedAttachments);

      final effectiveRequestId = requestId ?? state.requestDetails.request?.id;
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
    if (!mounted) return;
    state = state.copyWith(isLoading: true);
    try {
      final kpis = await requestMaintenanceInstance.getKpiData(
        service.id ?? 0,
        subService.id ?? 0,
      );

      if (!mounted) return;

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: apiError.message);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchStations() async {
    try {
      final stations = await requestMaintenanceInstance.getStations();

      if (!mounted) return;

      if (stations != null) {
        state = state.copyWith(stationsList: stations);
      }
    } catch (e) {
      // ignore
    }
  }

  Future<void> fetchApprovalTrendBreakDown(String period) async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);
    try {
      final data = await requestMaintenanceInstance
          .getApprovalTrendBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );

      if (!mounted) return;

      if (data != null) {
        state = state.copyWith(approvalTrendData: data, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: apiError.message);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchApprovalStatusBreakdown(String period) async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);
    try {
      final statusBreakdown = await requestMaintenanceInstance
          .getApprovalStatusBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );

      if (!mounted) return;

      if (statusBreakdown != null) {
        state = state.copyWith(
          approvalStatusBreakdown: statusBreakdown,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: apiError.message);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false);
      debugPrint(e.toString());
    }
  }

  Future<void> fetchStatusBreakdown(String period) async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);
    try {
      final statusBreakdown = await requestMaintenanceInstance
          .getStatusBreakdownData(
            period: period,
            serviceId: service.id ?? 0,
            subServiceId: subService.id ?? 0,
          );

      if (!mounted) return;

      if (statusBreakdown != null) {
        state = state.copyWith(
          statusBreakdown: statusBreakdown,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: apiError.message);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false);
      debugPrint(e.toString());
    }
  }

  Future<void> fetchTrendBreakDown(String period) async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);
    try {
      final data = await requestMaintenanceInstance.getTrendBreakdownData(
        period: period,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      if (!mounted) return;

      if (data != null) {
        state = state.copyWith(trendData: data, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: apiError.message);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchApprovalKpi() async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);
    try {
      final kpis = await requestMaintenanceInstance.getApprovalKpiData(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      if (!mounted) return;

      if (kpis != null) {
        state = state.copyWith(approvalKpiData: kpis, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } on ApiException catch (apiError) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: apiError.message);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false);
    }
  }

  Future<List<MaintenanceRequestModel>> loadMyRequestsPage(
    int pageKey, {
    String searchText = '',
    String status = '',
  }) async {
    if (!mounted) return [];

    try {
      return await requestMaintenanceInstance.getRequests(
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

  Future<List<MaintenanceRequestModel>> loadActionItemsPage(
    int pageKey, {
    String searchText = '',
    String status = '',
  }) async {
    if (!mounted) return [];

    try {
      return await requestMaintenanceInstance.getActionItems(
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

  bool shouldShowMaterialToggle(
    List<ApprovalDetailModel> list,
    ApprovalDetailModel? approver,
  ) {
    if (approver == null) return false;

    /// determine final level
    final hasLevel1Dept106 =
        state.requestDetails.approvalDetails?.any(
          (e) => e.departmentId == 106 && e.level == 1,
        ) ??
        false;

    final int finalLevel = hasLevel1Dept106 ? 4 : 3;

    /// current approver must be the final approver
    ///
    if (approver.departmentId == 106 && approver.level == 1) {
      return false;
    }
    if (approver.level != finalLevel) {
      return true;
    }

    /// find that final level record
    ApprovalDetailModel? finalApproval;

    for (final approval in list) {
      if (approval.level == finalLevel) {
        finalApproval = approval;
        break;
      }
    }

    if (finalApproval == null) {
      return false;
    }

    /// hide toggle if final level still in progress
    final status = finalApproval.approvalStatus?.toLowerCase().trim();

    return status != 'in progress';
  }

  void showApprovalCommentDialog({
    required ApprovalDialogType type,
    required int approverId,
    required int requestId,
  }) {
    final approver = getActiveApprovalLevel(
      state.requestDetails.approvalDetails ?? [],
    );

    /// ✅ toggle visibility check
    final showMaterialToggle = shouldShowMaterialToggle(
      state.requestDetails.approvalDetails ?? [],
      approver,
    );

    KAppX.extendedRouter.dialog.showKDialog(
      builder: (_) => ApprovalCommentDialog(
        type: type,

        /// ✅ show toggle only for approve
        /// AND when last level is not in progress
        isToggle:
            type == ApprovalDialogType.approve &&
            showMaterialToggle &&
            (approver?.level != 1 || approver?.departmentId != 106),

        toggleTitle: 'Is material available',

        togglePayloadKey: 'is_material_available',

        // showDecisionNumber: showDecionNumber,
        onSubmit: (comment, decisionNo) async {
          final status = type == ApprovalDialogType.approve
              ? ApprovalStatus.approved
              : ApprovalStatus.rejected;

          await onApprove(
            approverId,
            requestId,
            comment.trim(),
            status.apiValue,
            decisionNo,
          );
        },

        onSubmitWithTogglePayload: (comment, decisionNo, togglePayload) async {
          await onApprove(
            approverId,
            requestId,
            comment.trim(),
            ApprovalStatus.approved.apiValue,
            decisionNo,
            togglePayload: togglePayload,
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

        final uploadedFiles = await requestMaintenanceInstance
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

        await requestMaintenanceInstance.sendAttachment(payload, requestId);
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

        await requestMaintenanceInstance.sendChat(payload, requestId);
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

  Future<void> onApprove(
    int approverId,
    int requestId,
    String comment,
    String status,
    String? decisionNo, {
    Map<String, dynamic>? togglePayload,
  }) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload
      final payload = <String, dynamic>{
        "request_id": requestId,
        "status": status,
        "comment": comment,
        "approval_id": approverId,
      };
      if (decisionNo != null) {
        payload['decision_number'] = decisionNo;
      }
      if (togglePayload != null) {
        payload.addAll(togglePayload);
      }

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await requestMaintenanceInstance.onApprove(payload);
      await Future.delayed(Duration(seconds: 2));
      KAppX.router.pop();
      // if (decisionNo != null) {
      KAppX.router.pop();
      // }
      // await fetchactionItems();
      refreshRequestLists();
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
      // await requestMaintenanceInstance.onSendInProgress(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      refreshRequestLists();
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
      return ActionButtonsType.assignReject;
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
    state = state.copyWith(
      tabIndex: index,
      myRequestsStatusFilter: index == 0 ? '' : state.myRequestsStatusFilter,
      actionItemsStatusFilter: index == 1 ? '' : state.actionItemsStatusFilter,
    );

    if (index == 0) {
      refreshMyRequestsList();
      fetchKpi();
      fetchStatusBreakdown('weekly');
      fetchTrendBreakDown('2026');
    } else {
      refreshActionItemsList();
      fetchApprovalKpi();
      fetchApprovalStatusBreakdown('weekly');
      fetchApprovalTrendBreakDown('2026');
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
    return {
      /// SERVICE
      "service_id": serviceId,
      "sub_service_id": subServiceId,

      /// USER DETAILS
      "req_user_department_id": values['req_user_department_id'],

      "req_user_section_id": values['req_user_section_id'],

      /// MAINTENANCE DETAILS
      "category": values['category'] ?? "",

      "sub_category": values['sub_category'] ?? "",

      "emergency_maintenance_support":
          values['emergency_maintenance_support'] == 'Yes' ? true : false,

      "location": values['location'] ?? "",

      "reason_for_maintenance": values['reason_for_maintenance'] ?? "",

      "description": values['description'] ?? "",

      "building_site_classification":
          values['building_site_classification'] ?? "",

      "if_station_selected": values['if_station_selected'],

      /// ATTACHMENTS
      "attachments": _buildAttachments(values),
    };
  }

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

      final response = await requestMaintenanceInstance
          .requestMaintenanceCreateRequest(payload);

      if (response['status'] == 'success') {
        _refreshDashboard();
      }
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _refreshDashboard() async {
    state = state.copyWith(isRequestLoading: true);
    await Future.delayed(Duration(seconds: 2));
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
    _searchDebounce?.cancel();
    chatController.dispose();
    titleController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
