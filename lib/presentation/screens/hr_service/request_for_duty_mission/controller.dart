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
  final List<DutyMissionModel> assignaTasktoEmployeeRequestDataRequestData;
  final List<DutyMissionModel> assignaTasktoEmployeeActionItemsData;
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
  final bool showForm;
  final List<AllowanceEntry> entries;
  final String? expandedId;
  final AllowanceEntry? editingEntry;
  final int formVersion;
  final Map<String, dynamic>? formInitialValues;

  final AllowanceFormMode formMode;
  final List<Map<String, dynamic>> missionIdDropDownOptions;

  final bool isEdit;
  final List<DutyMissionModel> missionIdDropDownValues;

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
    required this.assignaTasktoEmployeeRequestDataRequestData,
    required this.assignaTasktoEmployeeActionItemsData,
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

    required this.showForm,
    required this.entries,
    required this.expandedId,
    required this.editingEntry,
    required this.formVersion,
    required this.formMode,
    required this.missionIdDropDownValues,
    required this.missionIdDropDownOptions,

    required this.isEdit,
    required this.formInitialValues,
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
        assignaTasktoEmployeeRequestDataRequestData: [],
        assignaTasktoEmployeeActionItemsData: [],
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

        showForm: false,
        entries: [],
        expandedId: null,
        editingEntry: null,
        formVersion: 0,
        formMode: AllowanceFormMode.add,
        missionIdDropDownValues: [],
        missionIdDropDownOptions: [],
        isEdit: true,
        formInitialValues: {},
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
    List<DutyMissionModel>? assignaTasktoEmployeeRequestDataRequestData,
    List<DutyMissionModel>? assignaTasktoEmployeeActionItemsData,
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
    bool? showForm,
    List<AllowanceEntry>? entries,
    String? expandedId,
    AllowanceEntry? editingEntry,
    int? formVersion,
    AllowanceFormMode? formMode,
    List<Map<String, dynamic>>? missionIdDropDownOptions,
    List<DutyMissionModel>? missionIdDropDownValues,

    bool? isEdit,
    Map<String, dynamic>? formInitialValues,
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
      assignaTasktoEmployeeRequestDataRequestData:
          assignaTasktoEmployeeRequestDataRequestData ??
          this.assignaTasktoEmployeeRequestDataRequestData,
      assignaTasktoEmployeeActionItemsData:
          assignaTasktoEmployeeActionItemsData ??
          this.assignaTasktoEmployeeActionItemsData,
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
      showForm: showForm ?? this.showForm,
      entries: entries ?? this.entries,
      expandedId: expandedId ?? this.expandedId,
      editingEntry: editingEntry ?? this.editingEntry,
      formVersion: formVersion ?? this.formVersion,
      formMode: formMode ?? this.formMode,
      missionIdDropDownValues:
          missionIdDropDownValues ?? this.missionIdDropDownValues,
      missionIdDropDownOptions:
          missionIdDropDownOptions ?? this.missionIdDropDownOptions,

      isEdit: isEdit ?? this.isEdit,
      formInitialValues: formInitialValues ?? this.formInitialValues,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final Service service;
  final SubService subService;

  _VSController({required this.service, required this.subService})
    : super(_ViewState.init());

  late TextEditingController chatController;
  late TextEditingController titleController;
  late TextEditingController fromEntityController;
  late TextEditingController toEntityController;
  late TextEditingController startDateController;
  late TextEditingController empIdController;
  late TextEditingController eventTimeController;
  late TextEditingController occupationController;
  late TextEditingController detailsController;
  late TextEditingController assignmentAllowanceController;
  late TextEditingController completionController;
  late TextEditingController endTimeController;
  late TextEditingController phoneController;
  late TextEditingController dateSubmitController;
  late TextEditingController civilIdCardNumberController;
  late TextEditingController currentJobPositionController;
  late TextEditingController taskDescriptionController;
  late TextEditingController taskTitleController;
  late TextEditingController allowancePercentageController;
  late TextEditingController socialServiceFundContribution;

  void initState() {
    chatController = TextEditingController();
    titleController = TextEditingController();
    fromEntityController = TextEditingController();
    toEntityController = TextEditingController();
    startDateController = TextEditingController();
    empIdController = TextEditingController();
    eventTimeController = TextEditingController();
    occupationController = TextEditingController();
    detailsController = TextEditingController();
    assignmentAllowanceController = TextEditingController();
    completionController = TextEditingController();
    phoneController = TextEditingController();
    dateSubmitController = TextEditingController();
    civilIdCardNumberController = TextEditingController();
    currentJobPositionController = TextEditingController();
    taskDescriptionController = TextEditingController();
    endTimeController = TextEditingController();
    taskTitleController = TextEditingController();
    allowancePercentageController = TextEditingController();
    socialServiceFundContribution = TextEditingController();

    phoneController.addListener(_validateForm);
    completionController.addListener(_validateForm);
    phoneController.addListener(_validateForm);
    fromEntityController.addListener(_validateForm);
    currentJobPositionController.addListener(_validateForm);
    civilIdCardNumberController.addListener(_validateForm);
    taskDescriptionController.addListener(_validateForm);
    empIdController.addListener(_validateForm);
    endTimeController.addListener(_validateForm);
    taskTitleController.addListener(_validateForm);
    toEntityController.addListener(_validateForm);
    allowancePercentageController.addListener(_validateForm);
    socialServiceFundContribution.addListener(_validateForm);
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
  }

  void _validateForm() {
    final valid = isFormValid();

    if (state.isFormValid != valid) {
      state = state.copyWith(isFormValid: valid);
    }
  }

  bool isFormValid() {
    return taskDescriptionController.text.isNotEmpty &&
        civilIdCardNumberController.text.isNotEmpty &&
        empIdController.text.isNotEmpty &&
        currentJobPositionController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        assignmentAllowanceController.text.isNotEmpty &&
        fromEntityController.text.isNotEmpty &&
        state.selectedUserId != null &&
        state.selectedPositionName.isNotEmpty &&
        completionController.text.isNotEmpty &&
        endTimeController.text.isNotEmpty &&
        taskTitleController.text.isNotEmpty &&
        toEntityController.text.isNotEmpty &&
        allowancePercentageController.text.isNotEmpty &&
        socialServiceFundContribution.text.isNotEmpty;
  }

  bool get isFormFilled {
    return taskDescriptionController.text.isNotEmpty &&
        civilIdCardNumberController.text.isNotEmpty &&
        empIdController.text.isNotEmpty &&
        currentJobPositionController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        state.selectedUserId != null &&
        state.selectedPositionName.isNotEmpty &&
        completionController.text.isNotEmpty &&
        endTimeController.text.isNotEmpty &&
        toEntityController.text.isNotEmpty &&
        socialServiceFundContribution.text.isNotEmpty &&
        fromEntityController.text.isNotEmpty &&
        state.selectedRequestType.isNotEmpty;
  }

  void updateFormValidity() {
    final formState = state.formKey.currentState;
    if (formState == null) return;

    final valid = formState.validate();
    if (state.isFormValid != valid) {
      state = state.copyWith(isFormValid: valid);
    }
  }

  List<DropdownOption<dynamic>> get bankNameOptions {
    return state.usersList
        .map(
          (e) => DropdownOption(
            value: e.id, // ✅ store id (or full object)
            label: e.employeeName,
          ),
        )
        .toList();
  }

  final dutyMissionAnnualInstance = AnnualDutyMissionRepoistry();
  final tripType = 'Annual';

  List<DynamicField> get plannedForm1 => [
    /// -------- TRIP TYPE --------
    DynamicField(
      name: 'tripType',
      label: 'Trip Type',
      type: FieldType.text,
      required: false,
      initialValue: 'Planned',
    ),

    /// -------- CHOOSE TYPE --------
    DynamicField(
      name: 'chooseType',
      label: 'Choose Type',
      type: FieldType.select,
      required: true,
      options: const [
        DropdownOption(value: 'Inside', label: 'Inside'),
        DropdownOption(value: 'Outside', label: 'Outside'),
      ],
    ),

    /// -------- MISSION ID --------
    DynamicField(
      name: 'missionId',
      label: 'Mission ID',
      type: FieldType.select,
      required: false,
      options: state.missionIdDropDownOptions
          .map(
            (e) => DropdownOption<String>(value: e['value'], label: e['label']),
          )
          .toList(),
    ),

    /// -------- MISSION SPONSORED BY --------
    DynamicField(
      name: 'missionSponsoredBy',
      label: 'Mission Sponsored by',
      type: FieldType.select,
      required: false,
      options: const [
        DropdownOption(value: 'CAA', label: 'CAA'),
        DropdownOption(value: 'Listed Companies', label: 'Listed Companies'),
        DropdownOption(
          value: 'Non-listed Companies',
          label: 'Non-listed Companies',
        ),
      ],
    ),

    DynamicField(
      name: 'sponsoredCompanyName',
      label: 'Sponsored Company',
      type: FieldType.custom,
      visibleWhen: (values) => values['missionSponsoredBy'] != null,
      builder: (context, ref) {
        final state = ref.watch(dynamicFormProvider);
        final sponsor = state.values['missionSponsoredBy'];

        // 🔹 CAA → readonly text
        if (sponsor == 'CAA') {
          return TextFieldWidget(
            field: DynamicField(
              name: 'sponsoredCompanyName',
              label: 'Sponsored Company',
              type: FieldType.text,
              disabled: true,
            ),
          );
        }

        // 🔹 Listed Companies → dropdown
        if (sponsor == 'Listed Companies') {
          return SelectFieldWidget(
            field: DynamicField(
              name: 'sponsoredCompanyName',
              label: 'Sponsored Company',
              type: FieldType.select,
              options: const [
                DropdownOption(value: 'Oman Airports', label: 'Oman Airports'),
                DropdownOption(value: 'Occidental', label: 'Occidental'),
                DropdownOption(value: 'PDO', label: 'PDO'),
              ],
            ),
          );
        }

        // 🔹 Non-listed → free text
        return TextFieldWidget(
          field: DynamicField(
            name: 'sponsoredCompanyName',
            label: 'Sponsored Company',
            type: FieldType.text,
            placeholder: 'Enter company name',
          ),
        );
      },
    ),

    /// -------- MISSION PURPOSE --------
    DynamicField(
      name: 'missionPurpose',
      label: 'Mission Purpose',
      type: FieldType.textarea,
      required: true,
      placeholder: 'Enter mission purpose',
    ),

    /// -------- MISSION NUMBER --------
    DynamicField(
      name: 'missionNumber',
      label: 'Mission Number',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter mission number',
    ),

    /// -------- MISSION START DATE --------
    DynamicField(
      name: 'missionStartDate',
      label: 'Mission Start Date',
      type: FieldType.date,
      required: true,
    ),

    /// -------- MISSION END DATE --------
    DynamicField(
      name: 'missionEndDate',
      label: 'Mission End Date',
      type: FieldType.date,
      required: true,
    ),

    /// -------- MISSION DAYS (AUTO / READ ONLY) --------
    DynamicField(
      name: 'missionDays',
      label: 'Mission Days',
      type: FieldType.text,
      disabled: true,
      // visibleWhen: (values) =>
      //     values['missionStartDate'] != null &&
      //     values['missionEndDate'] != null,
    ),

    /// -------- NO. OF EMPLOYEES --------
    DynamicField(
      name: 'noOfEmployees',
      label: 'No. of Employees',
      type: FieldType.select,
      required: true,
      options: List.generate(
        50,
        (index) => DropdownOption(
          value: (index + 1).toString(),
          label: (index + 1).toString(),
        ),
      ),
    ),
  ];

  List<DynamicField> step2Fields(_VSControllerParams providerArgs) => [
    DynamicField(
      name: 'allowance_section',
      type: FieldType.custom,
      builder: (context, ref) {
        return AllowanceSectionWidget(service: service, subService: subService);
      },
      label: 'allowanceSection',
    ),
  ];
  List<DynamicField> step4Fields(_VSControllerParams providerArgs) => [
    DynamicField(
      name: 'allowance_section',
      type: FieldType.custom,
      builder: (context, ref) {
        return TravelDetailsSectionWidget(
          service: service,
          subService: subService,
        );
      },
      label: 'allowanceSection',
    ),
  ];

  List<DynamicField> get travelDetailsForm => [
    /// -------- TRAVELLING AREA FROM --------
    DynamicField(
      name: 'travellingAreaFrom',
      label: 'Travelling Area From',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter',
    ),

    /// -------- TRAVELLING AREA TO --------
    DynamicField(
      name: 'travellingAreaTo',
      label: 'Travelling Area To',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter',
    ),

    /// -------- DISTANCE --------
    DynamicField(
      name: 'distance',
      label: 'Distance',
      type: FieldType.text,
      required: false,
      placeholder: 'Enter',
    ),

    /// -------- TRAVEL PLACE --------
    DynamicField(
      name: 'travelPlace',
      label: 'Travel Place',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter',
    ),

    /// -------- FROM COUNTRY --------
    DynamicField(
      name: 'fromCountry',
      label: 'From Country',
      type: FieldType.text,
      required: true,
      initialValue: 'Oman',
    ),

    /// -------- TO COUNTRY --------
    DynamicField(
      name: 'toCountry',
      label: 'To Country',
      type: FieldType.text,
      required: true,
      initialValue: 'Oman',
    ),

    /// -------- TRAVEL START DATE --------
    DynamicField(
      name: 'travelStartDate',
      label: 'Travel Start Date',
      type: FieldType.date,
      required: true,
    ),

    /// -------- TRAVEL RETURN DATE --------
    DynamicField(
      name: 'travelReturnDate',
      label: 'Travel Return Date',
      type: FieldType.date,
      required: true,
    ),

    /// -------- AIR TICKET REQUIRED --------
    DynamicField(
      name: 'airTicketRequired',
      label: 'Air Ticket Required',
      type: FieldType.radio,
      required: true,
      options: const ['Yes', 'No', 'Cash Component'],
    ),

    /// -------- VEHICLE REQUIRED --------
    DynamicField(
      name: 'vehicleRequired',
      label: 'Vehicle Required',
      type: FieldType.radio,
      required: true,
      options: const ['Yes', 'No'],
    ),
    DynamicField(
      name: 'remarks',
      label: 'Remarks (Optional)',
      type: FieldType.text,
      placeholder: 'Enter',
    ),
    DynamicField(
      name: 'attachments',
      label: 'Attachments (Optional)',
      type: FieldType.file,
    ),
  ];

  get assignTaskFields => [
    /// -------- TASK TITLE --------
    DynamicField(
      name: 'taskTitle',
      label: 'Task Title',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter task title',
      // minLength: 5,
    ),

    /// -------- ASSIGNED TO --------
    DynamicField(
      name: 'assignedUserId',
      label: 'Assigned To (Employee Name / ID)',
      type: FieldType.select,
      required: true,
      options: state.usersList
          .map(
            (e) => DropdownOption<String>(
              value: e.id.toString(),
              label: e.employeeName ?? '',
            ),
          )
          .toList(),
    ),

    /// -------- PRIORITY --------
    DynamicField(
      name: 'priority',
      label: 'Priority',
      type: FieldType.select,
      required: true,
      options: const [
        DropdownOption(value: 'High', label: 'High'),
        DropdownOption(value: 'Medium', label: 'Medium'),
        DropdownOption(value: 'Low', label: 'Low'),
      ],
    ),

    /// -------- COMPLETION DATE --------
    DynamicField(
      name: 'completionDate',
      label: 'Completion Date',
      type: FieldType.date,
      required: false,
      placeholder: 'Select completion date',
    ),

    /// -------- TASK DESCRIPTION --------
    DynamicField(
      name: 'taskDescription',
      label: 'Task Description',
      type: FieldType.textarea, // or FieldType.text with maxLines
      required: true,
      placeholder: 'Enter task description',
    ),

    /// -------- ATTACHMENTS --------
    DynamicField(
      name: 'attachments',
      label: 'Attachments (Optional)',
      type: FieldType.file,
      required: false,
    ),
  ];

  void fetchDepartmentName() {
    final selectedRole = KAppX.globalProvider.read(userInfoProvider);
    if (selectedRole != null) {
      state = state.copyWith(
        departmentName: selectedRole.data?.department?.departmentName ?? '',
      );
    }
  }

  Future<void> fetchRequestDetailsById(int id) async {
    try {
      final requests = await dutyMissionAnnualInstance.getRequestsById(id);

      // ✅ Declare first
      List<AllowanceEmployee> allowanceEmployees = [];

      // ✅ Map ONLY if data exists
      final rawEmployees = requests?.request?.employeesDetails ?? [];

      allowanceEmployees = rawEmployees
          .map((e) => AllowanceEmployee.fromEmployee(e))
          .toList();

      if (requests != null) {
        state = state.copyWith(
          requestDetails: requests,
          allowanceEmployees: allowanceEmployees,
        );

        fetchChatById(id);
        updateButtonDisabledFromApprovals(requests.approvalDetails ?? []);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> fetchChatById(int id) async {
    try {
      final requests = await dutyMissionAnnualInstance.getchatById(id);
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

  // Future<void> getRoleDetails() async {
  //   final storage = KAuthCred();
  //   final saved = await storage.getSelectedRole();
  //   if (saved != null) {
  //     state = state.copyWith(currentRoleName: saved.roleName);
  //   }
  // }

  Future<void> fetchKpi() async {
    try {
      final kpis = await dutyMissionAnnualInstance.getKpiData(
        service.id ?? 0,
        subService.id ?? 0,
        tripType,
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
      final data = await dutyMissionAnnualInstance
          .getApprovalTrendBreakdownData(period, tripType);

      if (data != null) {
        state = state.copyWith(approvalTrendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchApprovalStatusBreakdown(String period) async {
    try {
      final statusBreakdown = await dutyMissionAnnualInstance
          .getApprovalStatusBreakdownData(period, tripType);
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
      final statusBreakdown = await dutyMissionAnnualInstance
          .getStatusBreakdownData(period, tripType);
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
      final data = await dutyMissionAnnualInstance.getTrendBreakdownData(
        period,
        tripType,
      );

      if (data != null) {
        state = state.copyWith(trendData: data);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  // Future<void> fetchUsers() async {
  //   try {
  //     final userInfo = KAppX.globalProvider.read(rolesProvider);
  //     final departmentId = userInfo?.departmentId ?? 0;
  //     final users = await dutyMissionAnnualInstance.getUsers(departmentId);

  //     state = state.copyWith(usersList: users);
  //     print('✅ Users fetched: ${users.length}');
  //   } on ApiException catch (apiError) {
  //     Fluttertoast.showToast(msg: apiError.message);
  //     print('❌ API ERROR: ${apiError.message}');
  //   } catch (e, stack) {
  //     print('❌ UNKNOWN ERROR: $e');
  //     print(stack);
  //   }
  // }

  Future<void> fetchApprovalKpi() async {
    try {
      final kpis = await dutyMissionAnnualInstance.getApprovalKpiData(
        service.id ?? 0,
        subService.id ?? 0,
        tripType,
      );

      if (kpis != null) {
        state = state.copyWith(approvalKpiData: kpis);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  // Future<void> fetchEngineersList() async {
  //   try {
  //     // Clear list only if explicitly refreshing or searching

  //     final engineersList = await dutyMissionAnnualInstance
  //         .getEngineersList();

  //     // No merging needed
  //     state = state.copyWith(engineersList: engineersList);
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  Future<void> fetchRequests({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    try {
      // Clear list only if explicitly refreshing or searching
      if (isRefresh || searchText.isNotEmpty || status.isNotEmpty) {
        state = state.copyWith(assignaTasktoEmployeeRequestDataRequestData: []);
      }

      final requests = await dutyMissionAnnualInstance.getRequests(
        offset: 0,
        limit: 8,
        searchText: searchText,
        status: status,
        tripType: tripType,
      );

      // No merging needed
      state = state.copyWith(
        assignaTasktoEmployeeRequestDataRequestData: requests,
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
        state = state.copyWith(assignaTasktoEmployeeActionItemsData: []);
      }

      final items = await dutyMissionAnnualInstance.getActionItems(
        offset: 0,
        limit: 8,
        searchText: searchText,
        status: status,
        tripType: tripType,
      );

      // No merging needed
      state = state.copyWith(
        assignaTasktoEmployeeActionItemsData: items,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Dialog for approve and reject request
  void showApprovalCommentDialog({
    required ApprovalDialogType type,
    required int approverId,
    required int requestId,
  }) {
    KAppX.extendedRouter.dialog.showKDialog(
      builder: (_) => ApprovalCommentDialog(
        type: type,
        onSubmit: (comment, decisionNo) async {
          if (type == ApprovalDialogType.approve) {
            await onApprove(
              approverId,
              requestId,
              comment,
              "Approved", // optional
            );
          } else {
            await onApprove(
              approverId,
              requestId,
              comment,
              'Rejected', // mandatory
            );
          }
        },
      ),
    );
  }

  // void showAssignEngineerDialog({
  //   required int requestId,
  //   required int approverRoleId,
  //   // required int? departmentId,
  //   // required int? sectionId,
  // }) {
  //   KAppX.extendedRouter.dialog.showKDialog(
  //     builder: (_) => AssignEngineerDialog(
  //       requestId: requestId,
  //       approverRoleId: approverRoleId,
  //       service: service,
  //       subService: subService,
  //       // departmentId: departmentId,
  //       // sectionId: sectionId,
  //     ),
  //   );
  // }

  // String _resolveMessageType() {
  //   // No attachment → text
  //   if (state.attachments.isEmpty) {
  //     return 'text';
  //   }

  //   // Attachment exists → detect file type
  //   final file = state.attachments.first;
  //   final category = getFileTypeFromPath(file.);

  //   return mapCategoryToMessageType(category); // image | file
  // }
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

        final uploadedFiles = await dutyMissionAnnualInstance.uploadAttachments(
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

        // await dutyMissionAnnualInstance.sendAttachment(payload, requestId);
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

        await dutyMissionAnnualInstance.sendChat(payload, requestId);
      }

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
      await dutyMissionAnnualInstance.onApprove(payload);
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
      await dutyMissionAnnualInstance.onApprove(payload);
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
      // await dutyMissionAnnualInstance.onSendInProgress(payload);
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

  void onPositionChange(String position) =>
      state = state.copyWith(selectedPositionName: position);
  void onSelectedSalaryDetailsChange(String salaryDetails) =>
      state = state.copyWith(selectedSalaryDetails: salaryDetails);

  void onselectedRequestTypeChange(String requestDetails) =>
      state = state.copyWith(selectedRequestType: requestDetails);
  void onUserChange(int userId) {
    final user = state.usersList.firstWhere((e) => e.id == userId);

    state = state.copyWith(
      selectedUserId: user.id,
      selectedUserName: user.employeeName,
    );

    // Auto-fill text field
    // taskDescriptionController.text = user.employeeName ?? '';
  }

  /// End Date enabled/disabled handler
  void updateStartDateSelected(bool value) {
    state = state.copyWith(isStartDateSelected: value);
  }

  void onLocationChange(String value) =>
      state = state.copyWith(location: value);
  void onAreaPermissionChange(List<AreaPermission> list) {
    final List<String> permissionAreas = list.map((e) => e.name).toList();
    state = state.copyWith(selectedpermissionAreas: permissionAreas);
    _validateForm();
  }

  void onPermitChange(String value) =>
      state = state.copyWith(permitType: value);
  void onSelectedServicePreference(List<String> value) =>
      state = state.copyWith(servicePreference: value);

  void onUploadFileSuccess(FileUploadItem url) {
    final urls = List<FileUploadItem>.from(state.selectedFileUrl);
    urls.add(url);
    state = state.copyWith(selectedFileUrl: urls);
  }

  void onVisitorCheckChange(String value) {
    state = state.copyWith(visitorChecks: value);
  }

  void onMediaCoverageChange(String value) =>
      state = state.copyWith(mediaCoverageRequired: value);

  void onSelectedApprovalId(int value) =>
      state = state.copyWith(approvalId: value);

  void updateRequestTab(int index) {
    state = state.copyWith(requestDetailTab: index);
  }

  void updateTabIndex(int index) {
    state = state.copyWith(tabIndex: index);
  }

  void onPriorityChange(String value) =>
      state = state.copyWith(selectedPriority: value);

  void onSelectedAcknowledgements(List<String> value) =>
      state = state.copyWith(acknowledgement: value);
  void onRemoveFile(int index) {
    final urls = List<FileUploadItem>.from(state.selectedFileUrl);
    urls.removeAt(index);
    state = state.copyWith(selectedFileUrl: urls);
  }

  bool submitSecurityAwarenessRequest() {
    // 1. Validate all text fields inside the Form
    if (!state.formKey.currentState!.validate()) {
      return false;
    }

    // 2. Accommodation Type
    if (titleController.text.isEmpty) {
      return false;
    }

    // 5. Meal Preference (optional but recommended)
    if (startDateController.text.isEmpty) {
      return false;
    }

    // 6. Services (optional)
    // if (contactNumberController.text.isEmpty) {
    //   return false;
    // }

    // 7. Guests Count Validation (controller-based)
    // if (eventDateController.text.isEmpty) {
    //   return false;
    // }

    // 8. Description
    // if (descriptionController.text.isEmpty) {
    //   return false;
    // }

    // 9. File Upload (optional)
    if (eventTimeController.text.isEmpty) {
      return false;
    }

    return true;
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

  void onThreatTypeChange(int value, String threat) =>
      state = state.copyWith(threatType: value, threatOption: threat);

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
  //       uploadedFiles = await dutyMissionAnnualInstance.uploadAttachments(
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
  //     final resMessage = await dutyMissionAnnualInstance.sendChat(payload, id, type);

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

  Future<void> submitAssignaTasktoEmployeeRequest(
    int serviceId,
    int subServiceId,
  ) async {
    try {
      state = state.copyWith(isLoading: true);

      final userData = KAppX.globalProvider.read(rolesProvider);
      final userInfo = KAppX.globalProvider.read(userInfoProvider);

      // Build attachments list
      final List<Map<String, dynamic>> attachments = state.selectedFileUrl
          .map((file) => file.toJson())
          .toList();

      // BUILD FINAL PAYLOAD
      final payload = {
        "req_user_department_id": userData?.departmentId ?? 0,
        "req_user_section_id": userData?.sectionId ?? 0,
        "service_id": serviceId,
        "sub_service_id": subServiceId,
        "user_id": userInfo?.data?.id != null
            ? int.parse(userInfo!.data!.id!)
            : 0,
        "task_title": taskTitleController.text,
        "task_description": taskDescriptionController.text,
        "priority": state.selectedPriority,
        "completion_date": completionController.text,
        "attachments": attachments,
      };

      debugPrint("✅ Final Payload: $payload");
      print("=====================================");
      print("FINAL PAYLOAD: $payload");
      print("=====================================");

      // SEND REQUEST
      await dutyMissionAnnualInstance.sendAnnualDutyMissionRequest(payload);
      KAppX.router.pop();

      fetchKpi();
      fetchStatusBreakdown('monthly');
      fetchTrendBreakDown(DateTime.now().year.toString());

      fetchApprovalStatusBreakdown('monthly');
      fetchApprovalTrendBreakDown(DateTime.now().year.toString());
      fetchApprovalKpi();
      fetchRequests();
      fetchActionItems();
    } catch (e, st) {
      debugPrint('❌ Error submitting request: $e\n$st');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /* ---------------- FORM ---------------- */

  void openAddForm() {
    state = state.copyWith(
      showForm: true,
      editingEntry: null,
      formMode: AllowanceFormMode.add,
      formVersion: state.formVersion + 1,
    );
  }

  void openEditForm({required AllowanceEntry entry}) {
    state = state.copyWith(
      showForm: true,
      editingEntry: entry,
      formMode: AllowanceFormMode.edit,
      formVersion: state.formVersion + 1,
    );
  }

  void closeForm() {
    state = state.copyWith(
      showForm: false,
      editingEntry: null,
      formMode: AllowanceFormMode.add,
    );
  }

  void saveEntry(Map<String, dynamic> values) {
    final normalizedValues = {
      ...values,
      'allowancePerDay': values['allowancePerDay'] is num
          ? (values['allowancePerDay'] as num).toDouble()
          : double.tryParse(values['allowancePerDay']?.toString() ?? '0') ?? 0,
    };

    if (state.formMode == AllowanceFormMode.edit) {
      final editingId = state.editingEntry!.id;

      final updated = state.entries.map((e) {
        return e.id == editingId
            ? AllowanceEntry(id: e.id, values: normalizedValues)
            : e;
      }).toList();

      state = state.copyWith(
        entries: updated,
        expandedId: editingId,
        showForm: false,
        editingEntry: null,
        formMode: AllowanceFormMode.add,
        formVersion: state.formVersion + 1,
      );
    } else {
      final entry = AllowanceEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        values: normalizedValues,
      );

      state = state.copyWith(
        entries: [...state.entries, entry],
        expandedId: entry.id,
        showForm: false,
        formMode: AllowanceFormMode.add,
        formVersion: state.formVersion + 1,
      );
    }
  }

  /* -------- EXPAND / COLLAPSE ----------- */

  void toggleExpand(String id) {
    state = state.copyWith(expandedId: state.expandedId == id ? null : id);
  }

  /* -------------- DELETE --------------- */

  void deleteEntry(String id) {
    final updated = state.entries.where((e) => e.id != id).toList();

    state = state.copyWith(
      entries: updated,
      expandedId: state.expandedId == id ? null : state.expandedId,
    );
  }

  /* -------------- REORDER -------------- */

  void reorder(int oldIndex, int newIndex) {
    final list = [...state.entries];
    if (newIndex > oldIndex) newIndex--;

    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);

    state = state.copyWith(entries: list);
  }

  /* -------- NET AMOUNT SUMMARY ---------- */

  double get netAmount {
    return state.entries.fold<double>(
      0,
      (sum, e) => sum + (e.values['allowancePerDay'] as double),
    );
  }

  void saveTravelDetailsEntry(Map<String, dynamic> newValues) {
    final updated = state.entries.map((e) {
      if (e.id != state.editingEntry!.id) return e;

      return AllowanceEntry(
        id: e.id,
        values: {
          ...e.values, // 🔥 keep old
          ...newValues, // 🔥 merge new
        },
      );
    }).toList();

    state = state.copyWith(
      entries: updated,
      editingEntry: null,
      showForm: false,
      formVersion: state.formVersion + 1,
    );
  }

  bool get allCompleted {
    return state.entries.every((e) {
      final v = e.values;
      return v['passportNo'] != null &&
          v['passportIssueDate'] != null &&
          v['passportExpiryDate'] != null &&
          v['decisionDate'] != null;
    });
  }

  @override
  void dispose() {
    // // 🔥 Dispose ALL controllers
    // titleController.dispose();
    // startDateController.dispose();
    // eventTimeController.dispose();

    // Optional
    // eventDateController.dispose();

    super.dispose();
  }
}
