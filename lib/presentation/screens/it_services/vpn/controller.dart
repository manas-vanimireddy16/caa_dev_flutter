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
  final List<AccessRequestModel> requestData;
  final List<AccessRequestModel> actionItems;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final int approvalId;

  final bool isButtonDisabled;
  final List<ChatMessageModel> chatById;
  final List<AttachmentModel> attachmentsById;
  final List<TechnicianData> techniciansList;

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
    required this.requestDetails,
    required this.requestDetailTab,
    required this.approvalId,
    required this.isButtonDisabled,
    required this.chatById,
    required this.attachmentsById,
    required this.techniciansList,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        selectedFileUrl: [],
        attachments: [],
        kpiData: KPIResponse(),
        approvalKpiData: KPIResponse(),
        statusBreakdown: StatusBreakdownModel(),
        trendData: TrendBreakdownModel(),
        requestDataById: RequestDetailModel(),
        tabIndex: 1,
        selectedTab: 0,
        approvalStatusBreakdown: StatusBreakdownModel(),
        approvalTrendData: TrendBreakdownModel(),
        requestData: [],
        actionItems: [],
        requestDetails: RequestDetailData(),
        requestDetailTab: 0,
        approvalId: 0,
        isButtonDisabled: false,
        chatById: [],

        attachmentsById: [],
        techniciansList: [],
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
    int? selectedTab,
    List<AccessRequestModel>? requestData,
    List<AccessRequestModel>? actionItems,
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
    List<TechnicianData>? techniciansList,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
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
      requestDetails: requestDetails ?? this.requestDetails,
      requestDetailTab: requestDetailTab ?? this.requestDetailTab,
      approvalId: approvalId ?? this.approvalId,
      isButtonDisabled: isButtonDisabled ?? this.isButtonDisabled,
      chatById: chatById ?? this.chatById,
      attachmentsById: attachmentsById ?? this.attachmentsById,
      techniciansList: techniciansList ?? this.techniciansList,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
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

  void initState() {
    chatController = TextEditingController();
    titleController = TextEditingController();
    searchController = TextEditingController();
    fetchKpi();
    fetchRequests();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    // fetchbyCycleGoals(cycle: 'Jan-Jun');
  }

  int _searchVersion = 0;

  void onSearchChanged(String value) {
    _searchDebounce?.cancel();
    final int currentVersion = ++_searchVersion;

    _searchDebounce = Timer(const Duration(milliseconds: 400), () async {
      if (state.tabIndex == 1) {
        await fetchRequests(isRefresh: true, searchText: value);
      } else {
        await fetchactionItems(isRefresh: true, searchText: value);
      }

      if (currentVersion != _searchVersion) return; // ignore old response
    });
  }

  int get currentYear => DateTime.now().year;

  List<String> get filterLabelList =>
      List.generate(6, (index) => (currentYear - index).toString());
  List<StatSummaryData> requestStatsList(
    String Function(String key) titleForKey,
  ) => StatSummaryHelper.buildStatList(
    state.kpiData.data?.toJson(),
    isSecurityThreat: true,
    titleForKey: titleForKey,
  );

  List<StatSummaryData> approverStatsList(
    String Function(String key) titleForKey,
  ) => StatSummaryHelper.buildStatList(
    state.approvalKpiData.data?.toJson(),
    isSecurityThreat: true,
    titleForKey: titleForKey,
  );

  List<StatSummaryData> currentStats(String Function(String key) titleForKey) =>
      state.tabIndex == 1
      ? requestStatsList(titleForKey)
      : approverStatsList(titleForKey);
  void onStatusFilterChanged(String? value) {
    if (state.tabIndex == 1) {
      fetchStatusBreakdown(value ?? '');
    } else {
      fetchApprovalStatusBreakdown(value ?? '');
    }
  }

  void onTrendFilterChanged(String? value) {
    if (value == null) return;

    if (state.tabIndex == 1) {
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

  Map<String, String> buildRequestCardData(AccessRequestModel item) {
    final approverMap = resolveApproverMap(item.base?.approvalDetails ?? []);

    return {
      'Request Id': item.id?.toString() ?? '-',
      'status': item.status ?? '-',
      'Request Type': item.base?.subService?.subServiceName ?? '-',
      'Request For': item.requestFor ?? '-',
      'Start Date': formatDate(item.startDate ?? '-'),
      'End Date': formatDate(item.endDate ?? '-'),

      // 'Vehicle Number': item.vehicleNumber ?? 'N/A',
      // 'Maintenance Type': item.typeOfMaintenanceRequired ?? 'N/A',
      // 'Preferred Maintenance Date': formatDate(
      //   item.preferredMaintenanceDate ?? 'N/A',
      // ),

      /// ================= EMPLOYEE INFO =================

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
      "Service Type": request?.service?.name ?? 'N/A',
      "Sub Service Type": request?.subService?.subServiceName ?? 'N/A',
      'Request For': request?.requestFor ?? 'N/A',
      'Employee ID': request?.employeeId ?? 'N/A',
      'Employee Mail': request?.email ?? 'N/A',
      'Contact Number': request?.phoneNumber ?? request?.contactNum ?? 'N/A',
      'Reasons For Request': request?.reasonForRequest?.join(', ') ?? 'N/A',
      'Start Date': formatDate(request?.startDate ?? 'N/A'),
      'End Date': formatDate(request?.endDate ?? 'N/A'),
      'Description': request?.description ?? 'N/A',
    };
  }

  Map<String, String> buildStatusInformation() {
    final request = state.requestDetails.request;
    final approvals = state.requestDetails.approvalDetails;
    final nextApprover = resolveApproverMap(approvals);
    return {
      "Approval Status": request?.status ?? 'N/A',
      "Requested Date": formatDate(request?.createdAt ?? 'N/A'),
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
      'Job Title':
          request?.jobTitle ?? request?.createdByUser?.directorate ?? 'N/A',
      'Country': request?.countryName ?? 'N/A',
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
    await fetchTechnicianList();

    updateRequestTab(0);

    await KAppX.router.push(
      VPNRequestDetailsTabRoute(
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
      fetchRequests(),
      fetchKpi(),
      fetchStatusBreakdown('weekly'),
      fetchTrendBreakDown(DateTime.now().year.toString()),
    ]);
  }

  Future<void> openNewRequestForm() async {
    KAppX.router.push(
      VpnNewRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
  }

  final userInfo = KAppX.globalProvider.read(userInfoProvider);

  final vpnInstance = VpnRepository();
  final residentalUnitRentalInstance = ResidentalUnitRentalRepository();
  List<DynamicField> buildVpnFields(DashboardL10n l10n) => [
    /// ================= JOB TITLE =================
    DynamicField(
      name: 'job_title',
      label: l10n.jobTitle,
      type: FieldType.text,
      required: true,
      initialValue: userInfo?.data?.category ?? '',
      disabled: true,
    ),

    /// ================= DEPARTMENT =================
    DynamicField(
      name: 'department',
      label: l10n.requestDetailsLabel('Department'),
      type: FieldType.text,
      required: true,
      initialValue: userInfo?.data?.department?.departmentName ?? '',
      disabled: true,
    ),

    /// ================= REQUEST FOR =================
    DynamicField(
      name: 'request_for',
      label: l10n.requestFor,
      type: FieldType.radio,
      required: true,
      initialValue: 'CAA Staff',

      options: [
        DropdownOption(value: 'CAA_STAFF', label: l10n.caaStaff),
        DropdownOption(value: 'CONTRACTOR', label: l10n.contractor),
      ],

      onChanged: (value, ref) {
        final notifier = ref.read(dynamicFormProvider.notifier);

        /// ✅ STAFF
        if (value == 'CAA_STAFF') {
          notifier.autoPopulate({
            'person_name': userInfo?.data?.employeeName ?? '',
            'contact_number': userInfo?.data?.mobile ?? '',
            'emp_id': userInfo?.data?.employeeId ?? '',
            'email': userInfo?.data?.email ?? '',
            'country': 'Oman',
          });
        }
        /// ✅ CONTRACTOR
        else {
          notifier.autoPopulate({
            'person_name': '',
            'contact_number': '',
            'emp_id': '',
            'email': '',
            'country': '',
          });
        }
      },
    ),

    /// ================= PERSON NAME =================
    DynamicField(
      name: 'person_name',
      label: l10n.personName,
      type: FieldType.text,
      required: true,
      initialValue: userInfo?.data?.employeeName ?? '',

      disabledWhen: (values) =>
          (values['request_for'] ?? 'CAA_STAFF') == 'CAA_STAFF',

      placeholder: l10n.enterPersonName,
    ),

    /// ================= CONTACT NUMBER =================
    DynamicField(
      name: 'contact_number',
      label: l10n.transportContactNumber,
      type: FieldType.number,
      required: true,
      initialValue: userInfo?.data?.mobile ?? '',

      disabledWhen: (values) =>
          (values['request_for'] ?? 'CAA_STAFF') == 'CAA_STAFF',

      placeholder: l10n.enterContactNumber,

      validator: (value, values) {
        final phone = value?.toString().trim() ?? '';

        if (phone.isEmpty) {
          return l10n.contactNumberRequired;
        }

        if (phone.length != 8) {
          return l10n.contactNumberEightDigits;
        }

        return null;
      },
    ),

    /// ================= EMPLOYEE ID =================
    DynamicField(
      name: 'emp_id',
      label: l10n.employeeId,
      type: FieldType.text,
      required: true,
      initialValue: userInfo?.data?.employeeId ?? '',

      disabledWhen: (values) =>
          (values['request_for'] ?? 'CAA_STAFF') == 'CAA_STAFF',

      placeholder: l10n.enterEmployeeId,
    ),

    /// ================= EMAIL =================
    DynamicField(
      name: 'email',
      label: l10n.employeeMail,
      type: FieldType.email,
      required: true,
      initialValue: userInfo?.data?.email ?? '',

      disabledWhen: (values) =>
          (values['request_for'] ?? 'CAA_STAFF') == 'CAA_STAFF',

      placeholder: l10n.enterEmail,
    ),

    /// ================= COUNTRY =================
    DynamicField(
      name: 'country',
      label: l10n.country,
      type: FieldType.text,
      required: true,
      initialValue: 'Oman',

      disabled: true,

      placeholder: l10n.enterCountry,
    ),

    /// ================= REASONS FOR REQUEST =================
    DynamicField(
      name: 'reasons_for_request',
      label: l10n.reasonsForRequest,
      type: FieldType.checkbox,
      required: true,

      options: [
        DropdownOption(value: 'Remote Work', label: l10n.remoteWork),
        DropdownOption(
          value: 'Third Party/Vendor Access',
          label: l10n.thirdPartyVendorAccess,
        ),
        DropdownOption(
          value: 'Access to Internal System/Applications',
          label: l10n.accessToInternalSystemApplications,
        ),
        DropdownOption(
          value: 'Project-specific Requirement',
          label: l10n.projectSpecificRequirement,
        ),
      ],
    ),

    /// ================= SYSTEMS / APPLICATIONS =================
    DynamicField(
      name: 'systems_access',
      label: l10n.sysAppToAccess,
      type: FieldType.checkbox,
      required: true,

      options: [
        DropdownOption(
          value: 'Internal Databases',
          label: l10n.internalDataBase,
        ),
        DropdownOption(value: 'File Servers', label: l10n.fileServers),
        DropdownOption(value: 'Shared Servers', label: l10n.sharedServers),
        DropdownOption(value: 'UFUQ', label: l10n.ufuq),
        DropdownOption(value: 'ERP', label: l10n.erp),
        DropdownOption(value: 'Other', label: l10n.other),
      ],
    ),

    /// ================= REQUEST TIME PERIOD =================
    DynamicField(
      name: 'request_time_period',
      label: l10n.requestForTimePeriod,
      type: FieldType.radio,
      required: true,

      options: [
        DropdownOption(value: 'ONE_TIME', label: l10n.oneTime),
        DropdownOption(value: 'Permanent', label: l10n.permanent),
      ],
    ),

    /// ================= START DATE =================
    DynamicField(
      name: 'start_date',
      label: l10n.startDate,
      type: FieldType.date,
      required: true,
      placeholder: l10n.select,
      disabledWhen: (values) => values['request_time_period'] == 'Permanent',
    ),

    /// ================= END DATE =================
    DynamicField(
      name: 'end_date',
      label: l10n.endDate,
      type: FieldType.date,
      required: false,
      placeholder: l10n.select,

      disabledWhen: (values) => values['request_time_period'] == 'Permanent',
    ),

    /// ================= DEVICE TYPE =================
    DynamicField(
      name: 'device_type',
      label: l10n.deviceType,
      type: FieldType.checkbox,
      required: true,

      options: [
        DropdownOption(value: 'CAA_LAPTOP', label: l10n.caaLaptop),
        DropdownOption(
          value: 'PERSONAL_DEVICE_COMPLIES_WITH_SECURITY_POLICIES',
          label: l10n.personalDeviceCompliesWithSecurityPolicies,
        ),
        DropdownOption(value: 'MOBILE_DEVICE', label: l10n.mobileDevice),
      ],
    ),

    /// ================= DESCRIPTION =================
    DynamicField(
      name: 'description',
      label: l10n.requestDetailsLabel('Description'),
      type: FieldType.textarea,
      required: false,
      placeholder: l10n.enterDescription,
    ),

    /// ================= ACKNOWLEDGEMENT 1 =================
    DynamicField(
      name: 'acknowledgement',
      label: l10n.declaration,
      type: FieldType.acknowledgement,
      required: true,
      acknowledgements: [
        AcknowledgementItem(
          id: 'privacy_policy',
          text: l10n.securityPrivacyPolicyAccepted,
          hasAction: true,
          onTap: (context) async {
            return await KAppX.extendedRouter.dialog.showKDialog<bool>(
              context: context,
              builder: (_) => const CommonPolicyDialog(
                title: 'Security Policies',
                content: '''


1. Purpose
This policy establishes the requirements for Virtual Private Network (VPN) access to CAA's internal systems and resources. All users must comply with these security guidelines to ensure the protection of organizational data and infrastructure.

2. Acceptable Use
VPN access is granted solely for legitimate business purposes. Users must:
• Use VPN connections only for authorized work-related activities
• Not share VPN credentials with any other person
• Not use VPN access to bypass security controls
• Immediately report any suspected security incidents or unauthorized access

3. Device Security Requirements
All devices connecting via VPN must:
• Have up-to-date antivirus and anti-malware software installed
• Be protected with strong passwords or biometric authentication
• Have automatic screen lock enabled after 5 minutes of inactivity
• Have the latest operating system and security patches installed
• Not be jailbroken or rooted

4. Data Protection
Users must:
• Encrypt all sensitive data transmitted over VPN connections
• Not store organizational data on personal devices without authorization
• Use secure file transfer protocols when moving data
• Comply with data classification and handling policies

5. Access Control
• VPN access will be granted based on the principle of least privilege
• Access rights will be reviewed periodically and revoked when no longer needed
• Multi-factor authentication (MFA) is required for all VPN connections
• Session timeouts will be enforced after 30 minutes of inactivity

6. Monitoring and Logging
CAA reserves the right to:
• Monitor VPN connections for security and compliance purposes
• Log all VPN access attempts and activities
• Investigate any suspicious or unauthorized activities
• Audit VPN usage as part of security assessments

7. Consequences of Non-Compliance
Violation of this policy may result in:
• Immediate suspension or termination of VPN access
• Disciplinary action up to and including termination of employment
• Legal action in cases of data breach or malicious activity
• Reporting to relevant authorities as required by law
            ''',
                acceptText: 'Accept',
                cancelText: 'Close',
              ),
            );
          },
        ),
      ],
    ),

    /// ================= ACKNOWLEDGEMENT 2 =================
    DynamicField(
      name: 'acknowledgement2',
      label: l10n.declaration,
      type: FieldType.acknowledgement,
      required: true,
      acknowledgements: [
        AcknowledgementItem(
          id: 'Declaration Acknowledged',
          text: l10n.misuseMayResultDisciplinaryAction,
        ),
      ],
    ),
  ];

  /// ========================= API CALLS =========================

  Future<void> fetchRequestDetailsById(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      final requests = await vpnInstance.getRequestsById(
        id: id,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      if (requests != null) {
        state = state.copyWith(
          requestDetails: requests,
          isLoading: false,
          chatById: requests.chatMessages ?? [],
          attachmentsById: requests.attachments ?? [],
        );

        // fetchAssignEmployeesList();

        // fetchChatById(id);
        // fetchAttachmentsById(id);
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
      debugPrint('API ERROR: ${apiError.message}');
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      debugPrint(e.toString());
    }
  }

  // Future<void> fetchChatById(int id) async {
  //   try {
  //     final requests = await vpnInstance.getchatById(
  //       id: id,
  //       serviceId: service.id ?? 0,
  //       subServiceId: subService.id ?? 0,
  //     );
  //     if (requests != null) {
  //       final chats = requests.reversed.toList();
  //       state = state.copyWith(chatById: chats);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {
  //     // optionally handle other errors
  //     debugPrint(e.toString());
  //   }
  // }

  // Future<void> fetchAttachmentsById(int id) async {
  //   try {
  //     final attachments = await vpnInstance.getAttachmentsById(
  //       id: id,
  //       serviceId: service.id ?? 0,
  //       subServiceId: subService.id ?? 0,
  //     );
  //     if (attachments != null) {
  //       state = state.copyWith(attachmentsById: attachments);
  //     }
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //   } catch (e) {
  //     // optionally handle other errors
  //     debugPrint(e.toString());
  //   }
  // }

  Future<void> fetchKpi() async {
    state = state.copyWith(isLoading: true);
    try {
      final kpis = await vpnInstance.getKpiData(
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
      final data = await vpnInstance.getApprovalTrendBreakdownData(
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
      final statusBreakdown = await vpnInstance.getApprovalStatusBreakdownData(
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
      final statusBreakdown = await vpnInstance.getStatusBreakdownData(
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
      final data = await vpnInstance.getTrendBreakdownData(
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
      final kpis = await vpnInstance.getApprovalKpiData(
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

  Future<void> fetchTechnicianList({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    /// ✅ SHOW LOADER + CLEAR OLD LIST
    // state = state.copyWith(isLoading: true, requestData: []);

    try {
      final userInfo = KAppX.globalProvider.read(userInfoProvider);
      final departmentId = userInfo?.data?.department?.id;
      final sectionId = userInfo?.data?.section?.id;
      final requests = await vpnInstance.getAssignUsersList(
        departmentId: departmentId,
        sectionId: sectionId,
      );

      /// ✅ UPDATE NEW DATA
      state = state.copyWith(techniciansList: requests);
    } catch (e) {
      /// ✅ STOP LOADER ON ERROR
      // state = state.copyWith(isLoading: false);

      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> fetchRequests({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    /// ✅ SHOW LOADER + CLEAR OLD LIST
    state = state.copyWith(isLoading: true, requestData: []);

    try {
      final requests = await vpnInstance.getRequests(
        offset: 1,
        limit: 8,
        searchText: searchText,
        status: status,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      /// ✅ UPDATE NEW DATA
      state = state.copyWith(requestData: requests, isLoading: false);
    } catch (e) {
      /// ✅ STOP LOADER ON ERROR
      state = state.copyWith(isLoading: false);

      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> fetchactionItems({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final items = await vpnInstance.getActionItems(
        offset: 1,
        limit: 8,
        searchText: searchText,
        status: status,

        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      // No merging needed
      state = state.copyWith(actionItems: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
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

          await onApproveReject(
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

  void showAssignTechnicianDialog(
    BuildContext context, {
    required int approvalId,
  }) {
    final searchController = TextEditingController();

    List<TechnicianData> filteredList = List.from(state.techniciansList);

    KAppX.extendedRouter.dialog.showKDialog(
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),

              child: Container(
                width: 700,
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
                          const Expanded(
                            child: Text(
                              "Assign Request",
                              style: TextStyle(
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
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            /// SEARCH
                            TextField(
                              controller: searchController,
                              onChanged: (value) {
                                setState(() {
                                  filteredList = state.techniciansList.where((
                                    e,
                                  ) {
                                    final name =
                                        e.employeeName?.toLowerCase() ?? '';

                                    return name.contains(value.toLowerCase());
                                  }).toList();
                                });
                              },

                              decoration: InputDecoration(
                                hintText: "Search by Technician Name",
                                prefixIcon: const Icon(Icons.search),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),

                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            /// TABLE HEADER
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),

                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "TECHNICIAN NAME",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      "TASKS",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),

                            /// LIST
                            Expanded(
                              child: filteredList.isEmpty
                                  ? const Center(
                                      child: Text("No technicians found"),
                                    )
                                  : ListView.separated(
                                      itemCount: filteredList.length,

                                      separatorBuilder: (_, __) =>
                                          const Divider(height: 1),

                                      itemBuilder: (context, index) {
                                        final technician = filteredList[index];

                                        return InkWell(
                                          onTap: () async {
                                            await onAssign(
                                              approveralId: approvalId,
                                              technicianUserId:
                                                  technician.userId ?? 0,
                                              comment: "",
                                            );

                                            KAppX.router.pop();
                                          },

                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 18,
                                            ),

                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    technician.employeeName ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  width: 80,
                                                  child: Text(
                                                    '${technician.inProgressCount ?? 0}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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

        final uploadedFiles = await vpnInstance.uploadAttachments(
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

        await vpnInstance.sendAttachment(payload, requestId);
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

        await vpnInstance.sendChat(payload, requestId);
      }
      fetchRequestDetailsById(requestId);

      /// 3️⃣ Clear UI state
      // chatController.clear();
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
      await vpnInstance.onApprove(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      fetchactionItems();
      fetchRequests();
      fetchApprovalKpi();
      fetchApprovalStatusBreakdown('weekly');
      fetchApprovalTrendBreakDown(DateTime.now().year.toString());
      fetchStatusBreakdown('weekly');
      fetchTrendBreakDown(DateTime.now().year.toString());
      fetchKpi();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
    return;
  }

  Future<void> onApproveReject(
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
      await vpnInstance.onApprove(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      // if (decisionNo != null) {
      KAppX.router.pop();
      // }
      await fetchactionItems();
      await fetchRequests();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> onAssign({
    required int approveralId,
    required String comment,
    required int technicianUserId,
  }) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload
      final payload = {
        "technician_user_id": technicianUserId,
        "comment": comment,
        "approval_id": approveralId,
      };

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await vpnInstance.onAssign(payload);
      await Future.delayed(Duration(seconds: 3));
      // KAppX.router.pop();
      // if (decisionNo != null) {
      KAppX.router.pop();
      // }
      await fetchactionItems();
      await fetchRequests();
    } catch (e) {
      debugPrint('❌ Error submitting request: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> onVehicleAllocate(Map<String, dynamic> payload) async {
    try {
      state = state.copyWith(isLoading: true);

      // 1️⃣ Upload files

      // 2️⃣ Build payload

      debugPrint("✅ Final Payload: $payload");

      // 3️⃣ Send request
      await vpnInstance.onAllocateVehicle(
        payload,
        state.requestDetails.request?.id ?? 0,
      );
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      // if (decisionNo != null) {
      // }
      await fetchactionItems();
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
      // await vpnInstance.onSendInProgress(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      await fetchactionItems();
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
      return ActionButtonsType.assignCloseReject;
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
    state = state.copyWith(tabIndex: index);
    if (index == 1) {
      fetchRequests();
      fetchKpi();
      fetchStatusBreakdown('weekly');
      fetchTrendBreakDown('2026');
    } else {
      fetchactionItems();
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
    final userInfo = KAppX.globalProvider.read(userInfoProvider);
    final ack1 = (values['acknowledgement'] as List?)?.isNotEmpty ?? false;

    final ack2 = (values['acknowledgement2'] as List?)?.isNotEmpty ?? false;

    return {
      /// ⭐ USER INFO
      "service_id": serviceId,
      "sub_service_id": subServiceId,

      /// REQUEST FOR
      "request_for": values['request_for'],

      /// STAFF / CONTRACTOR
      "employee_identifier": values['emp_id'],
      "employee_email": values['email'],

      "contractor_user_id": values['request_for'] == 'CONTRACTOR'
          ? values['contractor_user_id']
          : null,

      "contractor_email": values['request_for'] == 'CONTRACTOR'
          ? values['email']
          : null,

      /// BASIC DETAILS
      "job_title": values['job_title'],
      "phone_number": values['contact_number'],

      /// MULTI SELECT
      "reason_for_request": List<String>.from(
        values['reasons_for_request'] ?? [],
      ),

      "systems_to_access": List<String>.from(values['systems_access'] ?? []),

      /// COUNTRY
      "country": values['country'],

      /// DATES
      "start_date": values['start_date'],

      "end_date": values['request_time_period'] == 'Permanent'
          ? null
          : values['end_date'],

      /// ACCESS TYPE
      "access_type": values['request_time_period'],

      /// DEVICE TYPE
      "device_type": List<String>.from(values['device_type'] ?? []),

      /// ACKNOWLEDGEMENT
      "acknowledgement": ack1 && ack2,

      /// DESCRIPTION
      "description": values['description'] ?? '',

      /// FILES
      "attachments": [],

      /// CHATS
      "chats": [],
    };
  }

  Future<void> submitVpnRequest(
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

      final response = await vpnInstance.vpnCreateRequest(payload);

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
    await Future.delayed(Duration(milliseconds: 2000));
    fetchKpi();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalStatusBreakdown('weekly');
    fetchApprovalTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalKpi();
    fetchRequests(isRefresh: true);
    fetchactionItems();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
