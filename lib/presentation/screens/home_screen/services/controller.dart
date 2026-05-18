part of 'view.dart';

final servicesProvider =
    StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
      final stateController = _VSController();
      stateController.initState();
      return stateController;
    });

class _ViewState {
  final bool isLoading;
  final String fromDate;
  final String toDate;
  final String selectedRole;
  final List<Service>? services;
  final List<Bookmarksmodel>? bookmarks;
  final UserRoleResponse userRoles;

  _ViewState({
    required this.isLoading,
    required this.fromDate,
    required this.toDate,
    required this.selectedRole,
    required this.services,
    required this.userRoles,
    required this.bookmarks,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        fromDate: '',
        toDate: '',
        selectedRole: '',
        services: [],
        bookmarks: [],
        userRoles: UserRoleResponse(),
      );

  _ViewState copyWith({
    bool? isLoading,
    String? fromDate,
    String? toDate,
    String? selectedRole,
    List<Service>? services,
    List<Bookmarksmodel>? bookmarks,
    UserRoleResponse? userRoles,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      selectedRole: selectedRole ?? this.selectedRole,
      services: services ?? this.services,
      bookmarks: bookmarks ?? this.bookmarks,
      userRoles: userRoles ?? this.userRoles,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());
  // late TextEditingController fromDateController;

  void initState() {
    // fromDateController = TextEditingController();
    final userData = KAppX.globalProvider.read(userProvider);
    fetchUserRoles(
      userData?.userId ?? 0,
    ); //0); //(40);(1017);(userData?.userId ?? 0);
    fetchBookmarks();
  }

  final dashboardinstance = DashboardRepository();

  Future<void> fetchUserRoles(int id) async {
    state = state.copyWith(isLoading: true);

    try {
      final storage = KAuthCred();
      final saved = await storage.getSelectedRole();
      final roleId = saved?.roleId;

      UserRoleResponse? roles = state.userRoles;

      // ✅ STEP 1: Decide whether to call API
      // if (roleId == null || roleId == 0 || roles == null) {
      roles = await _fetchAndStoreRoles(id);
      // }

      // ✅ STEP 2: Ensure role is selected
      final effectiveRoleId = await _ensureRoleSelected(roles);

      // ✅ STEP 3: Filter services (single reusable method)
      final services = _filterServicesByRole(roles, effectiveRoleId);

      // ✅ STEP 4: Update state
      state = state.copyWith(services: services, isLoading: false);
    } catch (e) {
      debugPrint("fetchUserRoles error: $e");
      state = state.copyWith(isLoading: false);
    }
  }

  List<Service> _filterServicesByRole(UserRoleResponse roles, int roleId) {
    final matched = state.userRoles.data?.roleDetails?.firstWhere(
      (d) => d.role?.id == roleId,
      orElse: () => RoleDetail(services: []),
    );

    return matched?.services ?? [];
  }

  Future<int> _ensureRoleSelected(UserRoleResponse roles) async {
    final storage = KAuthCred();
    final saved = await storage.getSelectedRole();

    if (saved?.roleId != null && saved!.roleId != 0) {
      return saved.roleId!;
    }

    // fallback (should rarely happen)
    final firstRole = roles.data?.roleDetails?.firstOrNull?.role?.id ?? 0;
    return firstRole;
  }

  Future<UserRoleResponse> _fetchAndStoreRoles(int id) async {
    final repo = RolesRepo();
    final storage = KAuthCred();

    final saved = await storage.getSelectedRole();
    final roleId = saved?.roleId;
    final roles = await repo.getUserRoles(id);

    state = state.copyWith(userRoles: roles);

    if (roleId == null || roleId == 0 || roles == null) {
      await selectOrStoreRole(roles);
    }
    return roles;
  }

  Future<void> selectOrStoreRole(UserRoleResponse userRoles) async {
    final storage = KAuthCred();
    final saved = await storage.getSelectedRole();

    // First role from summary
    final first = userRoles.data!.rolesSummary!.first;

    // Match it inside role_details
    final detail = userRoles.data!.roleDetails!.firstWhere(
      (e) => e.role?.id == first.roleId,
      orElse: () => userRoles.data!.roleDetails!.first,
    );

    final selected = SelectedUserRole(
      roleId: first.roleId!,
      roleName: first.roleName!,
      departmentId: detail.department?.id ?? 0,
      sectionId: detail.section?.id ?? 0,
      services: detail.services ?? [],
    );

    await storage.storeSelectedRole(selected);

    // state = state.copyWith(userRoles: _wrapSelectedRole(saved!));

    print("🎯 Selected Role: ${selected.services}");
  }

  Future<void> fetchBookmarks() async {
    state = state.copyWith(isLoading: true);
    final Bookmarksmodel = await dashboardinstance.getBookmarks();
    final bookmarks = Bookmarksmodel;
    print(bookmarks);
    state = state.copyWith(isLoading: false, bookmarks: bookmarks);
    print(bookmarks);
  }

  // Future<void> fetchUser() async {
  //   final userData = KAppX.globalProvider.read(userProvider);
  //   state = state.copyWith(isLoading: true);
  //   final userModel = await dashboardinstance.getUser(userData?.userId ?? 0);
  //   final user = userModel;
  //   state = state.copyWith(isLoading: false);
  // }

  Future<void> updateBookmark({
    required int userId,
    required int serviceId,
  }) async {
    try {
      // Optional: show loading if needed
      state = state.copyWith(isLoading: true);

      await dashboardinstance.updateBookmark(
        userId: userId,
        serviceId: serviceId,
      );

      // Optional: refresh services/bookmarks
      fetchBookmarks();

      state = state.copyWith(isLoading: false);
    } catch (e) {
      print('❌ Error updating bookmark: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  void navigateToRoute({
    required String name,
    Service? service,
    SubService? subService,
  }) {
    switch (name.trim()) {
      // 🔹 Main Services
      // case 'IT Services':
      //   KAppX.router.push(ITServicesHomeRoute());
      //   break;
      // case 'Logistics Services':
      //   KAppX.router.push(LogisticsHomeRoute());
      //   break;
      // case 'Security and Access':
      //   KAppX.router.push(RequestForAccessHomeRoute());
      //   break;
      case 'CAA032':
        KAppX.router.push(
          LogisticsForeignersRequestPortalRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA031':
        KAppX.router.push(
          LogisticsRequestPortalRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      // case 'CAA033':
      //   KAppX.router.push(
      //     RequestForVehicleMaintenanceRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Request for Access Card':
      //   KAppX.router.push(
      //     AccessCardRequestRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      case 'CAA046':
        KAppX.router.push(
          HotelReservationRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA006':
        KAppX.router.push(
          SecurityThreatRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
      //   break;

      // case 'Request to Organize Security Awareness':
      //   KAppX.router.push(
      //     OrganizeSecurityAwarenessRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Request for Project Approval':
      //   KAppX.router.push(
      //     RequestForProjectApprovalRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Airport Entry Permit Request':
      //   KAppX.router.push(
      //     AirportEntryPermitRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Assignment Decision':
      //   KAppX.router.push(
      //     AssignmentDecisionRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Secondment Decision':
      //   KAppX.router.push(
      //     SecondmentDecisionRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Temporary Decision':
      //   KAppX.router.push(
      //     TemporaryAssignmentDecisionRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      // case 'Service Transfer Decision':
      //   KAppX.router.push(
      //     ServiceTransferRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Assign a task':
      //   KAppX.router.push(
      //     AssignaTasktoEmployeeRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Duty Mission':
      //   KAppX.router.push(
      //     RequestforDutyMissionPlannedRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Request For Coverage':
      //   KAppX.router.push(
      //     RequestforCoverageRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Training Room Booking':
      //   KAppX.router.push(
      //     RequestforTrainingRoomBookingRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Annual Training Plan':
      //   KAppX.router.push(
      //     AnnualTrainingPlanRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'CAA015':
      //   KAppX.router.push(
      //     RequestTrainingRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'CAA016':
      //   KAppX.router.push(
      //     RequestForStudyLeaveRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Transfer from One Job to Another Job Nature':
      //   KAppX.router.push(
      //     TransferFromOneJobtoAnotherJobNatureRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Payment of Shift Allowance':
      //   KAppX.router.push(
      //     PaymentofShiftAllowanceRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Payment of Cash Allowance for Leave':
      //   KAppX.router.push(
      //     PaymentofCashAllowanceForLeaveRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Required New Resource':
      //   KAppX.router.push(
      //     RequiredNewResourceRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Promotions':
      //   KAppX.router.push(
      //     PromotionsRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );

      //   break;
      // case 'Annual Increment':
      //   KAppX.router.push(
      //     AnnualIncrementRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Skill Enhancement':
      //   KAppX.router.push(
      //     SkillsEnhancementRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Performance Management':
      //   KAppX.router.push(
      //     PerformanceManagementRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Human Resource Annual Planning':
      //   KAppX.router.push(
      //     RequestForHumanResourceAnnualPlanningRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Help Desk Muscat':
      //   KAppX.router.push(
      //     MuscatDashboard(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      case 'CAA003':
        KAppX.router.push(
          SalalahDashboard(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      // case 'Request for Hospitality Use in Muscat':
      //   KAppX.router.push(
      //     RequestForAccommodationInMuscatGovernorateRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Residential Unit Rental':
      //   KAppX.router.push(
      //     ResidentalUnitRentalRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Request to Renew a Housing Contract':
      //   KAppX.router.push(
      //     RequestToRenewalHousingContractRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Cancel a Housing Contract':
      //   KAppX.router.push(
      //     CancelHousingContractRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Request for VAPT and Infrastructure Review':
      //   KAppX.router.push(
      //     RequestForVAPTAndInfrastructureReviewRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      // case 'Request for Internal Audit (Cyber Security Audit)':
      //   KAppX.router.push(
      //     RequestForInternalAuditRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Cyber Security Risk Management':
      //   KAppX.router.push(
      //     CyberSecurityRiskManagementRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Request for Legal Contract Review':
      //   KAppX.router.push(
      //     RequestForLegalContractReviewRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Appeal Against Administrative Decisions':
      //   KAppX.router.push(
      //     AppealAgainstAdministrativeDecisionsRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Legal Consultation and Review of Administrative Decisions':
      //   KAppX.router.push(
      //     LegalConsultationandReviewofAdministrativeDecisionsRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Request Event Support':
      //   KAppX.router.push(
      //     RequestEventSupportRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Request For Cancellation':
      //   KAppX.router.push(
      //     RequestForCancellationRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Request a Tender Service':
      //   KAppX.router.push(
      //     RequestTenderServiceRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Request a Service to Respond to Enquiries':
      //   KAppX.router.push(
      //     RequestAServiceToRespondToEnquiriesRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Request Tender Ananlysis Service':
      //   KAppX.router.push(
      //     RequestTenderAnalysisServiceRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Contract Service Request':
      //   KAppX.router.push(
      //     ContractServiceRequestRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Request to Book CAA Halls':
      //   KAppX.router.push(
      //     RequestToBookCAAHallsRoute(
      //       service: service ?? Service(),
      //       subService: subService ?? SubService(),
      //     ),
      //   );
      //   break;
      // case 'Services':
      //   KAppX.router.push(const Services());
      //   break;

      // // 🔹 Sub-services (example)
      // case 'Leave Request':
      //   KAppX.router.push(const LeaveRequestRoute());
      //   break;
      // case 'Travel Request':
      //   KAppX.router.push(const TravelRequestRoute());
      //   break;
      // case 'IT Support':
      //   KAppX.router.push(const ITSupportRoute());
      //   break;

      default:
        debugPrint('⚠️ No route found for $name');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
