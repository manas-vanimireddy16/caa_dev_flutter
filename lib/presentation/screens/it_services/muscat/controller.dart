part of 'view.dart';

final selectedSalalahTabProvider = StateProvider<int>((ref) => 0);

// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");

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
  final bool isRequestDetailsLoading;
  final String selectedRequestFor;
  final List<Map<String, dynamic>> attachments;
  final List<ServiceData> serviceDropDown;
  final List<SalalahRequestModel> requestData;
  final RequestDetailData requestDetails;
  final StatusBreakdownModel statusBreakdown;
  final TrendBreakdownModel trendData;
  final int requestDetailTab;
  final List<UserItem> itTechnician;
  final List<DepartmentModel> departments;
  final List<SectionModel> sections;
  final int itTechnicianId;
  final List<ApprovalData> actionItems;

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
  final String myRequestsStatusFilter;
  final String actionItemsStatusFilter;

  final KPIResponse approvalKpiData;

  final RequestDetailModel requestDataById;
  final int selectedTab;

  final StatusBreakdownModel approvalStatusBreakdown;
  final TrendBreakdownModel approvalTrendData;
  final bool isButtonDisabled;

  final List<ChatMessageModel> chatById;
  final List<AttachmentModel> attachmentsById;
  final UsersResponseModel? usersData;
  final RolesResponseModel? rolesData;
  final int? selectedSectionId;
  final int? selectedRoleId;
  final int? selectedUserId;

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
    required this.isRequestLoading,
    required this.isRequestDetailsLoading,
    required this.isLoading,
    required this.selectedRequestFor,
    required this.attachments,
    required this.serviceDropDown,
    required this.requestData,
    required this.serviceId,
    required this.subServiceId,
    required this.serviceTypeId,
    required this.requestDetails,
    required this.kpiData,
    required this.statusBreakdown,
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
    required this.myRequestsStatusFilter,
    required this.actionItemsStatusFilter,
    required this.approvalKpiData,
    required this.requestDataById,
    required this.selectedTab,
    required this.approvalStatusBreakdown,
    required this.approvalTrendData,
    required this.isButtonDisabled,
    required this.chatById,
    required this.attachmentsById,
    required this.usersData,
    required this.rolesData,
    required this.selectedSectionId,
    required this.selectedRoleId,
    required this.selectedUserId,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        isRequestLoading: false,
        isRequestDetailsLoading: false,
        selectedRequestFor: 'Self',
        attachments: [],
        serviceDropDown: [],
        requestData: [],
        serviceId: 0,
        subServiceId: 0,
        serviceTypeId: 0,
        requestDetails: RequestDetailData(),
        kpiData: KPIResponse(),
        statusBreakdown: StatusBreakdownModel(),
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
        myRequestsStatusFilter: '',
        actionItemsStatusFilter: '',
        approvalKpiData: KPIResponse(),
        requestDataById: RequestDetailModel(),
        selectedTab: 0,
        approvalStatusBreakdown: StatusBreakdownModel(),
        approvalTrendData: TrendBreakdownModel(),
        isButtonDisabled: false,
        chatById: [],
        attachmentsById: [],
        usersData: null,
        rolesData: null,
        selectedSectionId: null,
        selectedRoleId: null,
        selectedUserId: null,
      );

  _ViewState copyWith({
    bool? isLoading,
    String? selectedRequestFor,
    List<Map<String, dynamic>>? attachments,
    List<ServiceData>? serviceDropDown,
    List<SalalahRequestModel>? requestData,
    final int? serviceId,
    final int? subServiceId,
    final int? serviceTypeId,
    final int? itTechnicianId,
    RequestDetailData? requestDetails,
    KPIResponse? kpiData,
    StatusBreakdownModel? statusBreakdown,
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
    final List<ApprovalData>? actionItems,
    final int? tabIndex,
    String? myRequestsStatusFilter,
    String? actionItemsStatusFilter,
    final KPIResponse? approvalKpiData,
    final RequestDetailModel? requestDataById,
    final int? selectedTab,
    final StatusBreakdownModel? approvalStatusBreakdown,
    final TrendBreakdownModel? approvalTrendData,
    final bool? isButtonDisabled,
    final List<ChatMessageModel>? chatById,
    final List<AttachmentModel>? attachmentsById,
    final UsersResponseModel? usersData,
    final RolesResponseModel? rolesData,
    final int? selectedSectionId,
    final int? selectedRoleId,
    final int? selectedUserId,
    final bool? isRequestLoading,
    final bool? isRequestDetailsLoading,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      selectedRequestFor: selectedRequestFor ?? this.selectedRequestFor,
      attachments: attachments ?? this.attachments,
      serviceDropDown: serviceDropDown ?? this.serviceDropDown,
      requestData: requestData ?? this.requestData,
      serviceId: serviceId ?? this.serviceId,
      subServiceId: subServiceId ?? this.subServiceId,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      requestDetails: requestDetails ?? this.requestDetails,
      kpiData: kpiData ?? this.kpiData,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
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
      myRequestsStatusFilter:
          myRequestsStatusFilter ?? this.myRequestsStatusFilter,
      actionItemsStatusFilter:
          actionItemsStatusFilter ?? this.actionItemsStatusFilter,
      approvalKpiData: approvalKpiData ?? this.approvalKpiData,
      requestDataById: requestDataById ?? this.requestDataById,
      selectedTab: selectedTab ?? this.selectedTab,
      approvalStatusBreakdown:
          approvalStatusBreakdown ?? this.approvalStatusBreakdown,
      approvalTrendData: approvalTrendData ?? this.approvalTrendData,
      isButtonDisabled: isButtonDisabled ?? this.isButtonDisabled,
      chatById: chatById ?? this.chatById,
      attachmentsById: attachmentsById ?? this.attachmentsById,
      usersData: usersData ?? this.usersData,
      rolesData: rolesData ?? this.rolesData,
      selectedSectionId: selectedSectionId ?? this.selectedSectionId,
      selectedRoleId: selectedRoleId ?? this.selectedRoleId,
      selectedUserId: selectedUserId ?? this.selectedUserId,
      isRequestLoading: isRequestLoading ?? this.isRequestLoading,
      isRequestDetailsLoading:
          isRequestDetailsLoading ?? this.isRequestDetailsLoading,
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
    searchController = TextEditingController();
    chatController = TextEditingController();
  }
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

  Future<void> initState() async {
    personNameController = TextEditingController();
    contactNumberController = TextEditingController();
    departmentController = TextEditingController();
    sectionController = TextEditingController();
    problemController = TextEditingController();
    descriptionController = TextEditingController();
    extensionNumberController = TextEditingController();
    emailController = TextEditingController();
    fetchServices();
    fetchApprovalKpi();

    fetchKpi();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchDepartments();
    // fetchitTechnician();
  }

  int _searchVersion = 0;
  final userInfo = KAppX.globalProvider.read(userInfoProvider);
  final userRoleInfo = KAppX.globalProvider.read(rolesProvider);

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
  List<StatSummaryData> requestStatsList(
    String Function(String key) titleForKey,
  ) => StatSummaryHelper.buildStatList(
    state.kpiData.data?.toJson(),
    isShowApprovalAsClose: true,
    titleForKey: titleForKey,
  );

  List<StatSummaryData> approverStatsList(
    String Function(String key) titleForKey,
  ) => StatSummaryHelper.buildStatList(
    state.approvalKpiData.data?.toJson(),
    // isSecurityThreat: true,
    isShowApprovalAsClose: true,
    titleForKey: titleForKey,
  );

  List<StatSummaryData> currentStats(String Function(String key) titleForKey) =>
      state.tabIndex == 0
      ? requestStatsList(titleForKey)
      : approverStatsList(titleForKey);
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

  Map<String, String> buildRequestCardData(SalalahRequestModel item) {
    final approverMap = resolveApproverMap(item.base?.approvalDetails);

    return {
      'Request Id': item.base?.id?.toString() ?? '-',
      'status': item.base?.status ?? '-',
      'Request By': item.base?.createdByUser?.employeeName ?? '-',

      // / ================= EMPLOYEE INFO =================
      'Problem': item.problem ?? '-',
      'Created By': item.base?.createdByUser?.employeeName ?? '-',
      'Service Type': item.serviceType?.name ?? '-',

      /// ================= CURRENT DETAILS =================
      'Date': item.base?.createdAt.toString().split('T').first ?? '-',

      /// 👇 APPROVER (SINGLE LINE)
      if (approverMap.containsKey('role')) ...{
        'Approver': approverMap['role'] ?? '-',
      } else if (approverMap.containsKey('department')) ...{
        'Approver': _buildDepartmentSection(approverMap),
      },
    };
  }

  Map<String, String> buildActionItemCardData(ApprovalData item) {
    final request = item.request;

    return {
      'Request Id': request?.id?.toString() ?? '-',

      'status': item.approvalStatus ?? '-',

      'Request By': request?.createdByUser?.employeeName ?? '-',

      'Problem': request?.problem ?? '-',

      'Comment': item.comment ?? '-',
      'Service Type': request?.serviceType?.name ?? '-',

      'Date': item.createdAt?.toString().split('T').first ?? '-',
    };
  }

  Map<String, String> buildRequestInformationData() {
    final request = state.requestDetails.request;
    return {
      /// ───── RIGHT COLUMN ─────
      "Service Type": request?.service?.name ?? 'N/A',

      /// ───── LEFT COLUMN ─────
      "Sub Service Type": request?.subService?.subServiceName ?? 'N/A',
      "Request For": request?.requestFor ?? 'N/A',
      "Problem Statement": request?.problem ?? 'N/A',
      "Description": request?.description ?? 'N/A',
    };
  }

  Map<String, String> buildStatusInformation() {
    final request = state.requestDetails.request;
    final approvals = state.requestDetails.approvalDetails;
    final nextApprover = resolveApproverMap(approvals);
    final assignedTo = buildAssignedToLabel(approvals);

    return {
      if (assignedTo.trim().isNotEmpty && assignedTo != 'N/A')
        'Assigned To': assignedTo,
      'Approval Status': request?.status ?? 'N/A',
      'Requested Date': formatDate(request?.createdAt) ?? 'N/A',
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
    return {'Extension Number': request?.extnNum.toString() ?? '0'};
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
    final approverMap = resolveApproverMap(approvals);
    if (approverMap.containsKey('name')) {
      return approverMap['name']!;
    }
    if (approverMap.containsKey('role')) {
      return approverMap['role']!;
    }
    if (approverMap.containsKey('department')) {
      return _buildDepartmentSection(approverMap);
    }
    return 'N/A';
  }

  Future<void> openRequestDetails(
    int id, {
    bool fromActionItems = false,
  }) async {
    updateRequestTab(0);

    await KAppX.router.push(
      MuscatRequestDetailsTabRoute(
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
      fetchApprovalKpi(),
    ]);
    refreshRequestLists();
  }

  Future<void> openNewRequestForm() async {
    await fetchitTechnician();
    KAppX.router.push(
      MuscatEmployeeNewRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
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

  List<DynamicField> buildSalalahFields(DashboardL10n l10n) => [
    /// ================= REQUEST FOR =================
    DynamicField(
      name: 'request_for',
      label: l10n.requestFor,
      type: FieldType.radio,
      required: true,
      initialValue: 'Self',
      options: [
        DropdownOption(value: 'Self', label: l10n.self),
        DropdownOption(value: 'Behalf of', label: l10n.behalfOf),
      ],

      onChanged: (value, ref) {
        final notifier = ref.read(dynamicFormProvider.notifier);

        if (value == 'Self') {
          final selfDepartmentId =
              int.tryParse(userInfo?.data?.department?.id ?? '') ?? 0;

          /// ✅ FETCH SELF SECTIONS
          ref
              .read(_vsProvider(params).notifier)
              .fetchSections(selfDepartmentId);

          /// ✅ RESET TO USER INFO
          notifier.autoPopulate({
            'person_name': userInfo?.data?.employeeName ?? '',
            'contact_number': userInfo?.data?.mobile ?? '',
            'department': userInfo?.data?.department?.id?.toString(),
            'section': userInfo?.data?.section?.id?.toString(),
          });
        } else {
          /// ✅ CLEAR ALL FIELDS FOR BEHALF
          notifier.autoPopulate({
            'person_name': '',
            'contact_number': '',
            'department': '',
            'section': '',
            'email': '',
            'problem': '',
            'description': '',
          });
        }
      },
    ),

    // / ================= PERSON NAME =================
    DynamicField(
      name: 'person_name',
      label: l10n.personName,
      type: FieldType.text,
      required: true,
      initialValue: userInfo?.data?.employeeName ?? '',
      disabledWhen: (values) => (values['request_for'] ?? 'Self') == 'Self',
    ),

    /// ================= CONTACT NUMBER =================
    DynamicField(
      name: 'contact_number',
      label: l10n.phoneNumber,
      type: FieldType.number,
      required: true,
      initialValue: userInfo?.data?.mobile ?? '',
      disabledWhen: (values) => (values['request_for'] ?? 'Self') == 'Self',
    ),

    DynamicField(
      name: 'department',
      label: l10n.requestDetailsLabel('Department'),
      type: FieldType.select,
      required: true,
      initialValue: userInfo?.data?.department?.id?.toString(),
      disabledWhen: (values) => (values['request_for'] ?? 'Self') == 'Self',
      options: (state.departments ?? [])
          .map(
            (d) => DropdownOption(
              value: d.id.toString(),
              label: d.departmentName ?? '',
            ),
          )
          .toList(),

      onChanged: (value, ref) async {
        final notifier = ref.read(dynamicFormProvider.notifier);

        /// ✅ RESET SELECTED SECTION
        notifier.updateValue('section', '');

        final departmentId = int.tryParse(value.toString()) ?? 0;

        /// ✅ FETCH NEW SECTIONS
        await ref
            .read(_vsProvider(params).notifier)
            .fetchSections(departmentId);
      },
    ),
    // /// ================= SECTION =================
    DynamicField(
      name: 'section',
      label: l10n.section,
      type: FieldType.select,
      required: true,

      initialValue: userInfo?.data?.section?.id?.toString(),

      disabledWhen: (values) => (values['request_for'] ?? 'Self') == 'Self',

      optionsBuilder: (ref) {
        final state = ref.watch(_vsProvider(params));

        return (state.sections ?? [])
            .map(
              (s) => DropdownOption(
                value: s.id.toString(),
                label: s.sectionName ?? '',
              ),
            )
            .toList();
      },
    ),

    /// ================= SERVICE TYPE =================
    DynamicField(
      name: 'service_type',
      label: l10n.serviceType,
      type: FieldType.select,
      required: true,
      optionsBuilder: (ref) {
        final currentState = ref.watch(_vsProvider(params));

        return (currentState.serviceDropDown ?? [])
            .map(
              (service) => DropdownOption(
                value: service.id.toString(),
                label: service.displayName(isArabic: l10n.isArabic),
              ),
            )
            .toList();
      },
    ),

    /// ================= PROBLEM =================
    DynamicField(
      name: 'problem',
      label: l10n.problem,
      type: FieldType.text,
      required: true,
      placeholder: l10n.enterProblem,
      validator: (value, values) {
        final problem = value?.toString().trim() ?? '';

        // Required validation
        // if (problem.isEmpty) {
        //   return l10n.enterProblem;
        // }

        // Only digits validation

        // Exact 5 digits validation
        if (problem.isEmpty) {
          return 'Problem is required';
        }

        return null;
      },
    ),

    /// ================= DESCRIPTION =================
    DynamicField(
      name: 'description',
      label: l10n.requestDetailsLabel('Description'),
      type: FieldType.textarea,
      required: false,
      placeholder: l10n.describeIssuePlaceholder,
    ),
    DynamicField(
      name: 'assigned_to',
      label: l10n.assignedTo,
      type: FieldType.select,
      required: true,

      visibleWhen: (values) => userRoleInfo?.roleId == 4,

      requiredWhen: (values) => userRoleInfo?.roleId == 4,
      optionsBuilder: (ref) => (state.itTechnician ?? [])
          .map(
            (user) => DropdownOption(
              value: user.userId.toString(), // ✅ FIX
              label: '\u200E${user.employeeName ?? ''}',
            ),
          )
          .toList(),
    ),

    /// ================= EXTENSION NUMBER =================
    DynamicField(
      name: 'extension_number',
      label: l10n.extensionNumber,
      type: FieldType.number,
      required: true,
      placeholder: l10n.enterExtensionNumber,

      validator: (value, values) {
        final extension = value?.toString().trim() ?? '';

        // Required validation
        if (extension.isEmpty) {
          return l10n.enterExtensionNumber;
        }

        // Only digits validation
        if (!RegExp(r'^\d+$').hasMatch(extension)) {
          return 'Extension Number must contain only digits';
        }

        // Exact 5 digits validation
        if (extension.length != 5) {
          return 'Extension Number must be exactly 5 digits';
        }

        return null;
      },
    ),

    /// ================= EMAIL =================
    DynamicField(
      name: 'email',
      label: l10n.email,
      type: FieldType.email,
      required: true,
      visibleWhen: (values) => values['request_for'] == 'Behalf of',
      requiredWhen: (values) => values['request_for'] == 'Behalf of',
      placeholder: l10n.enterEmail,
    ),

    /// ================= ATTACHMENT =================
    DynamicField(
      name: 'attachments',
      label: l10n.attachFile,
      type: FieldType.file,
      required: false,
      maxFiles: 1,
      maxFileSizeInMB: 10,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    ),
  ];

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
          final status = type == ApprovalDialogType.close
              ? ApprovalStatus.approved
              : ApprovalStatus.rejected;

          await onClose(
            approverId,
            requestId,
            comment.trim(), // always safe
            status.apiValue,
            // decisionNo, // ✅ backend-safe string
          );
        },
      ),
    );
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
        '❌ Denied: Approver User ID mismatch '
        '(${approval.approverUserId} != $userId)',
      );
      return false;
    }

    /// 3️⃣ Role must match
    if (approval.approverRoleId != null &&
        approval.approverRoleId != 30 &&
        approval.approverRoleId != selectedRole?.roleId) {
      debugPrint(
        '❌ Denied: Role mismatch '
        '(${approval.approverRoleId} != ${selectedRole?.roleId})',
      );

      return false;
    }

    /// 4️⃣ Department must match
    if (approval.departmentId != null &&
        approval.departmentId != selectedRole?.departmentId) {
      debugPrint(
        '❌ Denied: Department mismatch '
        '(${approval.departmentId} != ${selectedRole?.departmentId})',
      );
      return false;
    }

    /// 5️⃣ Section must match
    if (approval.sectionId != null &&
        approval.sectionId != selectedRole?.sectionId) {
      debugPrint(
        '❌ Denied: Section mismatch '
        '(${approval.sectionId} != ${selectedRole?.sectionId})',
      );
      return false;
    }

    debugPrint('✅ Allowed: User can act on this approval level');

    return true;
  }

  ApprovalDetailModel? getNextApprovalDetails(List<ApprovalDetailModel> list) {
    /// 1️⃣ Prefer pending / in progress
    for (final a in list) {
      final status = a.approvalStatus?.toLowerCase();

      if (status == 'pending' || status == 'in progress') {
        return a;
      }
    }

    /// 2️⃣ Fallback
    return getActiveApprovalLevel(list);
  }

  ApprovalDetailModel? getActiveApprovalLevel(List<ApprovalDetailModel> list) {
    ApprovalDetailModel? candidate;

    for (final approval in list) {
      if (!canUserActOnLevel(approval: approval)) continue;

      final status = approval.approvalStatus?.toLowerCase();
      final level = approval.level ?? -1;

      /// Pending / In Progress always priority
      if (status == 'pending' || status == 'in progress') {
        return approval;
      }

      /// fallback approved/assigned
      if (status == 'approved' || status == 'assigned') {
        if (candidate == null || level > (candidate.level ?? -1)) {
          candidate = approval;
        }
      }
    }

    return candidate;
  }

  Future<void> showAllocateUserDialog(BuildContext context) async {
    final l10n = DashboardL10n.of(context);

    await resetAllocateDialog();

    KAppX.extendedRouter.dialog.showKDialog(
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),

          child: Container(
            width: 650,

            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),

                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Allocate User",

                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      InkWell(
                        borderRadius: BorderRadius.circular(30),

                        onTap: () => KAppX.router.pop(),

                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                /// BODY
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    ),

                    child: ReAssignUser(
                      service: service,
                      subService: subService,
                      onSuccess: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ActionButtonsType getActionButtonsType(
    RequestDetailData? request,
    List<ApprovalDetailModel> approvals,
  ) {
    final selectedRole = KAppX.globalProvider.read(rolesProvider);

    if (selectedRole == null) {
      return ActionButtonsType.none;
    }

    /// Active approval level
    final level = getActiveApprovalLevel(approvals);

    if (level == null) {
      return ActionButtonsType.none;
    }

    /// Permission check
    final canAct = canUserActOnLevel(approval: level);

    if (!canAct) {
      return ActionButtonsType.none;
    }

    final status = level.approvalStatus?.toLowerCase();

    debugPrint('Current Status => $status');
    debugPrint('Approver User Id => ${level.approverUserId}');

    /// =========================================================
    /// CASE 1
    /// pending + approver_user_id == null
    /// SHOW ASSIGN BUTTON
    /// =========================================================
    // if (status == 'pending' && level.approverUserId == null) {
    //   debugPrint('✅ SHOW ASSIGN BUTTON');

    //   return ActionButtonsType.assign;
    // }

    /// =========================================================
    /// CASE 2
    /// pending + approver_user_id exists
    /// SHOW CLOSE + REJECT
    /// =========================================================
    ///
    if (status == 'pending' && level.approverUserId == 9 ||
        level.approverRoleId == 30 && level.level == 1) {
      debugPrint('✅ SHOW ASSIGN BUTTON');

      return ActionButtonsType.closeReject;
    }
    if (status == 'pending' && level.level == 1) {
      debugPrint('✅ SHOW CLOSE + REJECT');

      return ActionButtonsType.assign;
    } else if (status == 'pending' && level.level == 2) {
      debugPrint('✅ SHOW CLOSE + REJECT');

      return ActionButtonsType.reassignCloseReject;
    } else if (status == 'pending' && level.level == 3) {
      debugPrint('✅ SHOW CLOSE + REJECT');

      return ActionButtonsType.closeReject;
    }

    /// =========================================================
    /// CASE 3
    /// in progress
    /// SHOW APPROVE + REJECT
    /// =========================================================
    if (status == 'in progress') {
      debugPrint('✅ SHOW APPROVE + REJECT');

      return ActionButtonsType.approveReject;
    }

    return ActionButtonsType.none;
  }

  void updateButtonDisabledFromApprovals(List<ApprovalDetailModel> approvals) {
    final active = getActiveApprovalLevel(approvals);

    /// No active approval
    if (active == null) {
      state = state.copyWith(isButtonDisabled: true);
      return;
    }

    /// Permission denied
    if (active.isAllowed != null && active.isAllowed != true) {
      state = state.copyWith(isButtonDisabled: true);
      return;
    }

    final status = active.approvalStatus?.toLowerCase();

    /// Disable only when completed
    final shouldDisable =
        status == 'approved' || status == 'completed' || status == 'rejected';

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

  Map<String, String> resolveApproverMap(List<ApprovalDetailModel>? approvals) {
    if (approvals == null || approvals.isEmpty) {
      return {};
    }

    /// 1️⃣ NEXT PENDING / IN PROGRESS
    final pendingList = approvals
        .where((a) => _isPendingOrInProgress(a.approvalStatus))
        .toList();

    if (pendingList.isNotEmpty) {
      pendingList.sort((a, b) => (a.level ?? 0).compareTo(b.level ?? 0));

      final next = pendingList.first;

      /// approver exists
      if (next.approverUserId != null) {
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

      /// approver not assigned yet
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

    /// 2️⃣ COMPLETED FLOW
    final completedList = approvals
        .where((a) => _isCompleted(a.approvalStatus))
        .toList();

    if (completedList.isEmpty) {
      return {};
    }

    completedList.sort((a, b) {
      final levelCompare = (a.level ?? 0).compareTo(b.level ?? 0);

      if (levelCompare != 0) {
        return levelCompare;
      }

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

  Future<void> fetchServices() async {
    try {
      final services = await dashboardinstance.getServices(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

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
      /// ✅ CLEAR OLD SECTIONS FIRST
      state = state.copyWith(sections: []);

      final sections = await dashboardinstance.getSections(id);

      /// ✅ UPDATE NEW SECTIONS
      state = state.copyWith(sections: sections);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> onSectionChanged(int sectionId) async {
    state = state.copyWith(
      selectedSectionId: sectionId,

      /// RESET
      selectedRoleId: null,
      selectedUserId: null,

      rolesData: null,
      usersData: null,
    );

    await fetchRoles(sectionId: sectionId);
  }

  Future<void> onRoleChanged(int roleId) async {
    state = state.copyWith(
      selectedRoleId: roleId,

      /// RESET
      selectedUserId: null,
      usersData: null,
    );

    await fetchUsers(sectionId: state.selectedSectionId ?? 0, roleId: roleId);
  }

  void updateSelectedUser(int? userId) {
    state = state.copyWith(selectedUserId: userId);
  }

  Future<void> fetchRoles({required int sectionId}) async {
    state = state.copyWith(isLoading: true);
    try {
      final userInfo = KAppX.globalProvider.read(userInfoProvider);
      // Clear list only if explicitly refreshing or searching
      // if (isRefresh || status.isNotEmpty) {
      //   state = state.copyWith(requestData: [], isLoading: false);
      // }

      final users = await dashboardinstance.getRoles(
        // roleId: roleId,
        departmentId: int.tryParse(userInfo?.data?.department?.id ?? '') ?? 0,
        sectionId: sectionId,
      );

      // No merging needed
      state = state.copyWith(rolesData: users, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> fetchUsers({required int sectionId, required int roleId}) async {
    state = state.copyWith(isLoading: true);
    try {
      final userInfo = KAppX.globalProvider.read(userInfoProvider);
      // Clear list only if explicitly refreshing or searching
      // if (isRefresh || status.isNotEmpty) {
      //   state = state.copyWith(requestData: [], isLoading: false);
      // }

      final users = await dashboardinstance.getUsers(
        roleId: roleId,
        departmentId: int.tryParse(userInfo?.data?.department?.id ?? '') ?? 0,
        sectionId: sectionId,
      );

      // No merging needed
      state = state.copyWith(usersData: users, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<List<SalalahRequestModel>> loadMyRequestsPage(
    int pageKey, {
    String searchText = '',
    String status = '',
  }) async {
    if (!mounted) return [];

    try {
      return await dashboardinstance.getRequests(
        offset: ItHelpdeskListPagination.offsetForPage(pageKey),
        limit: ItHelpdeskListPagination.pageSize,
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

  Future<List<ApprovalData>> loadActionItemsPage(
    int pageKey, {
    String searchText = '',
    String status = '',
  }) async {
    if (!mounted) return [];

    try {
      return await dashboardinstance.getActionItems(
        offset: ItHelpdeskListPagination.offsetForPage(pageKey),
        limit: ItHelpdeskListPagination.pageSize,
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

  Future<void> fetchKpi() async {
    try {
      final kpis = await dashboardinstance.getKpiData(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      if (kpis != null) {
        state = state.copyWith(kpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalKpi() async {
    state = state.copyWith(isLoading: true);
    try {
      final kpis = await dashboardinstance.getApprovalKpiData(
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

  Future<void> fetchitTechnician() async {
    try {
      final userInfo = KAppX.globalProvider.read(userInfoProvider);
      final departmentId =
          int.tryParse(userInfo?.data?.department?.id ?? '') ?? 0;
      final sectionId = int.tryParse(userInfo?.data?.section?.id ?? '') ?? 0;
      final itTechnician = await dashboardinstance.getItTechnicianDetails(
        departmentId: departmentId,
        sectionId: sectionId,
      );

      if (itTechnician != null) {
        state = state.copyWith(itTechnician: itTechnician.data);
        for (var user in state.itTechnician ?? []) {
          print(
            "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++",
          );
          print('${user.employeeName} , ${user.userId}');
        }
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchTrendBreakDown(String period) async {
    try {
      final data = await dashboardinstance.getTrendBreakdownData(
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
        updateButtonDisabledFromApprovals(requests.approvalDetails ?? []);

        fetchChatById(id);
        fetchAttachmentsById(id);
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
    state = state.copyWith(isLoading: true);
    try {
      final statusBreakdown = await dashboardinstance.getStatusBreakdownData(
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
      refreshRequestLists();
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

  Future<void> onClose(
    int approverId,
    int requestId,
    String comment,
    String status,
  ) async {
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
      KAppX.router.pop();
      KAppX.router.pop();
      refreshRequestLists();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> onAssign(int roleId, int sectionId, int userId) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      final userData = KAppX.globalProvider.read(userInfoProvider);
      final active = getActiveApprovalLevel(
        state.requestDetails.approvalDetails ?? [],
      );
      final approvalId = active?.id ?? 0;

      // 2️⃣ Build payload
      final payload = {
        "request_id": state.requestDetails.request?.id,
        "approval_id": approvalId,
        "status": "Reassigned",
        "comment": "",
        "assigned_to_user_id": userId,
        "department_id": userData?.data?.department?.id,
        "section_id": sectionId,
        "role_id": roleId,
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await dashboardinstance.muscatAssign(payload);
      KAppX.router.pop();
      // refreshRequestLists();
      // await refreshRequestLists();
      fetchRequestDetailsById(state.requestDetails.request?.id ?? 0);
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
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

        final uploadedFiles = await dashboardinstance.uploadAttachments(
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

        await dashboardinstance.sendAttachment(payload, requestId);
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

        await dashboardinstance.sendChat(payload, requestId);
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

  Future<void> fetchChatById(int id) async {
    try {
      final requests = await dashboardinstance.getchatById(id);
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
      final attachments = await dashboardinstance.getAttachmentsById(id);
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
      await dashboardinstance.deleteAttachment(
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
    final userInfo = KAppX.globalProvider.read(userInfoProvider);
    final roleInfo = KAppX.globalProvider.read(rolesProvider);

    final roleId = roleInfo?.roleId;

    final payload = {
      /// ⭐ ROLE + REQUEST TYPE
      "role_id": roleId,
      "request_type": roleId == 4 ? "internal" : "external",

      /// ⭐ USER INFO
      "department_id": userInfo?.data?.department?.id,
      "section_id": userInfo?.data?.section?.id,

      /// ⭐ SERVICE INFO
      "service_id": serviceId,
      "sub_service_id": subServiceId,
      "service_type_id": values['service_type'],

      /// ⭐ FORM DATA
      "request_for": values['request_for'] ?? "Self",
      "problem": values['problem'],
      "description": values['description'] ?? "",

      /// ⭐ CONTACT INFO
      "contact_num": values['contact_number'],
      "extn_num": values['extension_number'] ?? "",

      /// ⭐ ATTACHMENTS
      "attachments": _buildAttachments(values),
    };

    /// ✅ ADD ONLY FOR ROLE 4
    if (roleId == 4) {
      payload["approval_user_id"] = state.itTechnicianId;
    }

    return payload;
  }

  Future<void> sumbitSalalahRequest(
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

      final response = await dashboardinstance.sendRequest(payload);

      if (response['status'] == 'success') {
        state = state.copyWith(isRequestLoading: true);
        _refreshDashboard();
      }
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _refreshDashboard() async {
    await Future.delayed(const Duration(milliseconds: 2000));

    fetchKpi();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalStatusBreakdown('weekly');
    fetchApprovalTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalKpi();
    refreshRequestLists();
    // fetchactionItems();
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
      refreshRequestLists();
      KAppX.router.pop();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> resetAllocateDialog() async {
    state = state.copyWith(
      rolesData: null,

      sections: [],

      usersData: null,

      selectedSectionId: null,
      selectedRoleId: null,
      selectedUserId: null,
    );

    print('✅ Allocate Dialog Reset');
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    searchController.dispose();
    chatController.dispose();
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
