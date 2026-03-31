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
    fetchUserRoles(1018); //0); //(40);(1017);(userData?.userId ?? 0);
    fetchBookmarks();
  }

  final dashboardinstance = DashboardRepository();

  Future<void> fetchUserRoles(int id) async {
    state = state.copyWith(isLoading: true);

    try {
      final repo = RolesRepo();
      final userRoles = await repo.getUserRoles(id); //(40);

      // Save full response
      state = state.copyWith(userRoles: userRoles);

      // Load saved role (DO NOT overwrite)
      final storage = KAuthCred();
      final saved = await storage.getSelectedRole();

      List<Service> filteredServices = [];

      if (saved != null) {
        // 1. Find matching RoleDetail whose role.id == saved.roleId
        final matchedRole = userRoles.data?.roleDetails?.firstWhere(
          (detail) => detail.role?.id == saved.roleId,
          orElse: () => RoleDetail(services: []),
        );

        // 2. Extract services of that role
        filteredServices = matchedRole?.services ?? [];
      }

      // Update state with filtered services only
      state = state.copyWith(services: filteredServices, isLoading: false);
    } catch (e) {
      debugPrint("fetchUserRoles error: $e");
      state = state.copyWith(isLoading: false);
    }
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
      case 'IT Services':
        KAppX.router.push(ITServicesHomeRoute());
        break;
      case 'Logistics Services':
        KAppX.router.push(LogisticsHomeRoute());
        break;
      case 'Security and Access':
        KAppX.router.push(RequestForAccessHomeRoute());
        break;
      case 'Request Transportation for Foreign Employee':
        KAppX.router.push(LogisticsForeignersRequestPortalRoute());
        break;
      case 'Request a Vehicle: Daily/Emergency':
        KAppX.router.push(LogisticsRequestPortalRoute());
        break;
      case 'Request for Access Card':
        KAppX.router.push(AccessCardRequestRoute());
        break;
      case 'Request for Hotel Reservation':
        KAppX.router.push(
          HotelReservationRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Report Security Threat':
        KAppX.router.push(
          SecurityThreatRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;

      case 'Request to Organize Security Awareness':
        KAppX.router.push(
          OrganizeSecurityAwarenessRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Request for Project Approval':
        KAppX.router.push(
          RequestForProjectApprovalRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Airport Entry Permit Request':
        KAppX.router.push(
          AirportEntryPermitRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Assignment Decision':
        KAppX.router.push(
          AssignmentDecisionRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Secondment Decision':
        KAppX.router.push(
          SecondmentDecisionRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Temporary Decision':
        KAppX.router.push(
          TemporaryAssignmentDecisionRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
      case 'Service Transfer Decision':
        KAppX.router.push(
          ServiceTransferRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Assign a task':
        KAppX.router.push(
          AssignaTasktoEmployeeRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Duty Mission':
        KAppX.router.push(
          RequestforDutyMissionPlannedRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Request For Coverage':
        KAppX.router.push(
          RequestforCoverageRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Training Room Booking':
        KAppX.router.push(
          RequestforTrainingRoomBookingRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Annual Training Plan':
        KAppX.router.push(
          AnnualTrainingPlanRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Request Training':
        KAppX.router.push(
          RequestTrainingRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Request Study Leave':
        KAppX.router.push(
          RequestForStudyLeaveRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Transfer from One Job to Another Job Nature':
        KAppX.router.push(
          TransferFromOneJobtoAnotherJobNatureRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Payment of Shift Allowance':
        KAppX.router.push(
          PaymentofShiftAllowanceRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Payment of Cash Allowance for Leave':
        KAppX.router.push(
          PaymentofCashAllowanceForLeaveRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Required New Resource':
        KAppX.router.push(
          RequiredNewResourceRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Promotions':
        KAppX.router.push(
          PromotionsRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );

        break;
      case 'Annual Increment':
        KAppX.router.push(
          AnnualIncrementRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Skill Enhancement':
        KAppX.router.push(
          SkillsEnhancementRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Performance Management':
        KAppX.router.push(
          PerformanceManagementRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Human Resource Annual Planning':
        KAppX.router.push(
          RequestForHumanResourceAnnualPlanningRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Help Desk Muscat':
        KAppX.router.push(
          MuscatDashboard(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Help Desk Salalah':
        KAppX.router.push(
          SalalahDashboard(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Request for Accommodation in Muscat Governorate':
        KAppX.router.push(
          RequestForAccommodationInMuscatGovernorateRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Residential Unit Rental':
        KAppX.router.push(
          ResidentalUnitRentalRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Request to Renew a Housing Contract':
        KAppX.router.push(
          RequestToRenewalHousingContractRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Cancel a Housing Contract':
        KAppX.router.push(
          CancelHousingContractRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'Request for VAPT and Infrastructure Review':
        KAppX.router.push(
          RequestForVAPTAndInfrastructureReviewRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
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
