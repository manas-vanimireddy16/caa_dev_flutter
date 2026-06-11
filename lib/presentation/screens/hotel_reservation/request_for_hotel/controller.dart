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
  final List<HotelReservationRequestModel> requestData;
  final List<HotelReservationRequestModel> actionItems;
  final String myRequestsStatusFilter;
  final String actionItemsStatusFilter;
  final RequestDetailData requestDetails;
  final int requestDetailTab;
  final bool isButtonDisabled;

  final List<ChatMessageModel> chatById;
  final List<AttachmentModel> attachmentsById;
  final List<String> months = const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

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
    required this.requestData,
    required this.actionItems,
    required this.myRequestsStatusFilter,
    required this.actionItemsStatusFilter,
    required this.requestDetails,
    required this.requestDetailTab,
    required this.isButtonDisabled,
    required this.chatById,
    required this.attachmentsById,
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
        requestData: [],
        actionItems: [],
        myRequestsStatusFilter: '',
        actionItemsStatusFilter: '',
        requestDetails: RequestDetailData(),
        requestDetailTab: 0,
        isButtonDisabled: false,
        chatById: [],
        attachmentsById: [],
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
    List<HotelReservationRequestModel>? requestData,
    List<HotelReservationRequestModel>? actionItems,
    String? myRequestsStatusFilter,
    String? actionItemsStatusFilter,
    RequestDetailData? requestDetails,
    int? requestDetailTab,
    bool? isButtonDisabled,
    List<ChatMessageModel>? chatById,
    List<AttachmentModel>? attachmentsById,
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
      requestData: requestData ?? this.requestData,
      actionItems: actionItems ?? this.actionItems,
      myRequestsStatusFilter:
          myRequestsStatusFilter ?? this.myRequestsStatusFilter,
      actionItemsStatusFilter:
          actionItemsStatusFilter ?? this.actionItemsStatusFilter,
      requestDetails: requestDetails ?? this.requestDetails,
      requestDetailTab: requestDetailTab ?? this.requestDetailTab,
      isButtonDisabled: isButtonDisabled ?? this.isButtonDisabled,
      chatById: chatById ?? this.chatById,
      attachmentsById: attachmentsById ?? this.attachmentsById,
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
    final searchText = searchController.text.trim();

    if (state.tabIndex == 0) {
      state = state.copyWith(myRequestsStatusFilter: status);
      fetchRequests(isRefresh: true, searchText: searchText, status: status);
      return;
    }

    state = state.copyWith(actionItemsStatusFilter: status);
    fetchActionItems(isRefresh: true, searchText: searchText, status: status);
  }

  void onSearchChanged(String value) {
    _searchDebounce?.cancel();
    final int currentVersion = ++_searchVersion;

    _searchDebounce = Timer(const Duration(milliseconds: 400), () async {
      if (state.tabIndex == 0) {
        await fetchRequests(
          isRefresh: true,
          searchText: value,
          status: state.myRequestsStatusFilter,
        );
      } else {
        await fetchActionItems(
          isRefresh: true,
          searchText: value,
          status: state.actionItemsStatusFilter,
        );
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
    titleForKey: titleForKey,
  );

  List<StatSummaryData> approverStatsList(
    String Function(String key) titleForKey,
  ) => StatSummaryHelper.buildStatList(
    state.approvalKpiData.data?.toJson(),
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

  Map<String, String> buildRequestCardData(HotelReservationRequestModel item) {
    final approverMap = resolveApproverMap(item.approvalDetails ?? []);

    return {
      'Request Id': item.id?.toString() ?? '-',
      'status': item.status ?? '-',
      'Request By': item.createdByUser?.employeeName ?? '-',
      // 'Cycle Period': item.cyclePeriod ?? '-',
      'Request Submission Date': item.createdAt.toString() ?? '-',
      'Date': item.dateOfRequest.toString(),
      'Hotel Name': item.hotelName ?? '',
      'Check-In Date': item.checkInDate ?? '',

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
      /// ───── RIGHT COLUMN ─────
      "Service Type": request?.service?.name ?? 'N/A',

      /// ───── LEFT COLUMN ─────
      "Sub Service Type": request?.subService?.subServiceName ?? 'N/A',

      'Hotel Name': request?.hotelName ?? 'N/A',
      'Accommodation Type': request?.typeOfAccommodation ?? 'N/A',
      'Number of Passengers': request?.numberOfGuests?.toString() ?? 'N/A',
      'Check-In Date': request?.checkInDate?.toString() ?? 'N/A',
      'Check-Out Date': request?.checkOutDate?.toString() ?? 'N/A',
      'Meal': (request?.meal?.isNotEmpty ?? false)
          ? request?.meal?.join(', ') ?? 'N/A'
          : 'N/A',
      'Hotel Price': request?.price?.toString() ?? 'N/A',
      'Service Type': request?.service?.name ?? 'N/A',
      // 'Quarter': request?.quarter ?? 'N/A',
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
      HotelReservationRequestDetailsTabRoute(
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

  void openNewRequestForm() {
    KAppX.router.push(
      HotelReservationNewRequestRoute(
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
        service: service,
        subService: subService,
      ),
    );
  }

  final hotelReservationinstance = HotelReservationRepoistory();
  List<DynamicField> buildHotelReservationFields(DashboardL10n l10n) => [
    DynamicField(
      name: 'accommodationType',
      label: l10n.accommodationType,
      type: FieldType.text,
      required: true,
      placeholder: l10n.select,
    ),
    DynamicField(
      name: 'hotelName',
      label: l10n.hotelName,
      type: FieldType.text,
      required: true,
      placeholder: l10n.enterHotelName,
    ),
    DynamicField(
      name: 'hotelPrice',
      label: l10n.hotelPrice,
      type: FieldType.number,
      required: true,
      placeholder: l10n.enterPrice,
    ),
    DynamicField(
      name: 'meals',
      label: l10n.meals,
      type: FieldType.checkbox,
      required: false,
      options: [
        DropdownOption(value: 'Breakfast', label: l10n.breakfast),
        DropdownOption(value: 'Lunch', label: l10n.lunch),
        DropdownOption(value: 'Dinner', label: l10n.dinner),
      ],
    ),
    DynamicField(
      name: 'services',
      label: l10n.servicesLabel,
      type: FieldType.checkbox,
      required: false,
      options: [
        DropdownOption(value: 'Laundry', label: l10n.laundry),
        DropdownOption(
          value: 'Telephone Service',
          label: l10n.telephoneService,
        ),
      ],
    ),
    DynamicField(
      name: 'needMeetingRoom',
      label: l10n.needMeetingRoom,
      type: FieldType.radio,
      required: true,
      options: [
        DropdownOption(value: 'Yes', label: l10n.yesNoYes),
        DropdownOption(value: 'No', label: l10n.yesNoNo),
      ],
    ),
    DynamicField(
      name: 'requestDate',
      label: l10n.date,
      type: FieldType.date,
      required: true,
      initialValue: formatFormDate(DateTime.now().toString()),
      disabled: true,
    ),
    DynamicField(
      name: 'numberOfGuests',
      label: l10n.numberOfGuests,
      type: FieldType.number,
      required: true,
      placeholder: l10n.enterNumberOfGuests,
    ),
    DynamicField(
      name: 'checkInDate',
      label: l10n.checkInDate,
      type: FieldType.date,
      required: true,
      placeholder: l10n.select,
    ),
    DynamicField(
      name: 'checkInTime',
      label: l10n.checkInTime,
      type: FieldType.time,
      required: true,
      placeholder: l10n.select,
    ),
    DynamicField(
      name: 'checkOutDate',
      label: l10n.checkOutDate,
      type: FieldType.date,
      required: true,
      placeholder: l10n.select,
    ),
    DynamicField(
      name: 'checkOutTime',
      label: l10n.checkOutTime,
      type: FieldType.time,
      required: true,
      placeholder: l10n.select,
    ),
    DynamicField(
      name: 'purposeOfVisit',
      label: l10n.purposeOfVisit,
      type: FieldType.text,
      required: true,
      placeholder: l10n.enterPurposeOfVisit,
    ),
    DynamicField(
      name: 'description',
      label: l10n.descriptionAdditionalNotesOptional,
      type: FieldType.text,
      required: false,
      placeholder: l10n.writeHereAr,
    ),
    DynamicField(
      name: 'passportVisaAttachment',
      label: l10n.attachPassportVisaPhoto,
      type: FieldType.file,
      required: true,
      allowedExtensions: ['doc', 'docx', 'pdf', 'png', 'jpg', 'jpeg'],
      maxFileSizeInMB: 10,
    ),
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


Your Privacy Policy
(Last Update: 26 March 2024)

CAA's Security & Privacy policy addresses CAA's practices related to information collection & usage of your personal information.

Information Collection & Usage

Personal information is not collected unless specified or provided by the user. The IP address, from which you access the Internet, the date and time of your access to our website, and the pages you visited (recorded by the text and graphics files that compose the page) are automatically collected.

This information is used for statistical and monitoring purposes, and to identify website performance.

Third-party consultants are used for statistical analysis, and only aggregated, non-personal information is collected, which does not identify individuals.

Collected information is kept confidential, except when legally required or to protect CAA's rights/properties.

Security of Transactions

CAA has implemented generally accepted standards of technology and operational security.

The site has security measures, including encryption, to protect sensitive information and meet legal requirements.

Links to third-party websites

CAA's website may link to other sites but is not responsible for their content accuracy or information collection mechanisms.

Users are advised to read the Security & Privacy Policy of any third-party site accessed through CAA's website.

Security & Privacy Policy Changes

CAA reserves the right to change the policy at any time, with amended versions always published on CAA's website.

Privacy intrusion

If you suspect privacy compromise:

• Close all tabs and windows you are browsing CAA's website with.

• Inform us through email:
info@caa.gov.om
            ''',
                acceptText: 'Accept',
                cancelText: 'Close',
              ),
            );
          },
        ),
      ],
    ),
  ];

  /// ========================= API CALLS =========================

  Future<void> fetchRequestDetailsById(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      final requests = await hotelReservationinstance.getRequestsById(
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
      final requests = await hotelReservationinstance.getchatById(id);
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
      final attachments = await hotelReservationinstance.getAttachmentsById(id);
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

  Future<void> fetchKpi() async {
    state = state.copyWith(isLoading: true);
    try {
      final kpis = await hotelReservationinstance.getKpiData(
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
      final data = await hotelReservationinstance.getApprovalTrendBreakdownData(
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
      final statusBreakdown = await hotelReservationinstance
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
      final statusBreakdown = await hotelReservationinstance
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
      final data = await hotelReservationinstance.getTrendBreakdownData(
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
      final kpis = await hotelReservationinstance.getApprovalKpiData(
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

  Future<void> fetchRequests({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final requests = await hotelReservationinstance.getRequests(
        offset: 1,
        limit: 8,
        searchText: searchText,
        status: status,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      state = state.copyWith(requestData: requests, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);

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
      final items = await hotelReservationinstance.getActionItems(
        offset: 1,
        limit: 8,
        searchText: searchText,
        status: status,
        serviceId: service.id ?? 0,
        subServiceId: subService.id ?? 0,
      );

      state = state.copyWith(actionItems: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);

      Fluttertoast.showToast(msg: e.toString());
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

        final uploadedFiles = await hotelReservationinstance.uploadAttachments(
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

        await hotelReservationinstance.sendAttachment(payload, requestId);
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

        await hotelReservationinstance.sendChat(payload, requestId);
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
      await hotelReservationinstance.onApprove(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      fetchActionItems();
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
      await hotelReservationinstance.onApprove(payload);
      await Future.delayed(Duration(seconds: 3));
      KAppX.router.pop();
      // if (decisionNo != null) {
      KAppX.router.pop();
      // }
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
      // await hotelReservationinstance.onSendInProgress(payload);
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
        approval.approverRoleId != 0 &&
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
      fetchRequests(status: '');
      fetchKpi();
      fetchStatusBreakdown('weekly');
      fetchTrendBreakDown('2026');
    } else {
      fetchActionItems(status: '');
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
    return (values['passportVisaAttachment'] as List<FileUploadItem>? ?? [])
        .map((file) => file.toJson())
        .toList();
  }

  Map<String, dynamic> _buildPayload(
    int serviceId,
    int subServiceId,
    Map<String, dynamic> values,
  ) {
    final userInfo = KAppX.globalProvider.read(userInfoProvider);
    final selectedRole = KAppX.globalProvider.read(rolesProvider);

    return {
      /// ================= ROLE / DEPARTMENT =================
      "role_id": selectedRole?.roleId,
      "department_id": userInfo?.data?.department?.id,
      "section_id": userInfo?.data?.section?.id,

      /// ================= SERVICE INFO =================
      "service_id": serviceId,
      "sub_service_id": subServiceId,

      /// ================= HOTEL DETAILS =================
      "type_of_accommodation": values['accommodationType'] ?? "",

      "hotel_name": values['hotelName'] ?? "",

      "price": int.tryParse(values['hotelPrice']?.toString() ?? "0") ?? 0,

      /// ================= MEALS =================
      "meal": values['meals'] ?? [],

      /// ================= SERVICES =================
      "service": values['services'] ?? [],

      /// ================= BOOKING DATE =================
      "booking_date": values['requestDate'],

      /// ================= CHECK-IN =================
      "check_in_date": values['checkInDate'],

      "check_in_time": values['checkInTime'] ?? "",

      /// ================= CHECK-OUT =================
      "check_out_date": values['checkOutDate'],

      "check_out_time": values['checkOutTime'] ?? "",

      /// ================= GUEST INFO =================
      "number_of_guests":
          int.tryParse(values['numberOfGuests']?.toString() ?? "0") ?? 0,

      /// ================= PURPOSE =================
      "purpose_of_visit": values['purposeOfVisit'] ?? "",

      /// ================= DESCRIPTION =================
      "description": values['description'] ?? "",

      /// ================= MEETING ROOM =================
      "need_meeting_room": values['needMeetingRoom'] == 'Yes',

      /// ================= ATTACHMENTS =================
      "attachments": _buildAttachments(values),
    };
  }

  int _toInt(dynamic value) {
    return int.tryParse(value?.toString() ?? '0') ?? 0;
  }

  Future<void> sendHotelReservationRequest(
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

      final response = await hotelReservationinstance
          .hotelReservationCreateRequest(payload);

      if (response['status'] == 'success') {
        await Future.delayed(const Duration(seconds: 1));
        _refreshDashboard();
      }
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void _refreshDashboard() {
    fetchKpi();
    fetchStatusBreakdown('weekly');
    fetchTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalStatusBreakdown('weekly');
    fetchApprovalTrendBreakDown(DateTime.now().year.toString());
    fetchApprovalKpi();
    fetchRequests(isRefresh: true);
    fetchActionItems(isRefresh: true);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
