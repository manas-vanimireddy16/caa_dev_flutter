part of 'view.dart';

// Holds the index of the selected bottom nav tab
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

final _vsProvider =
    StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
      final stateController = _VSController();

      stateController.fetchUser();
      stateController.fetchAnnouncements();
      stateController.initState();

      return stateController;
    });

class _ViewState {
  final bool isLoading;
  final String fromDate;
  final String toDate;
  final String selectedRole;
  final UserModel? user;
  final List<AnnouncementModel> announcements;
  final List<DashboardRequestModel> requestData;
  final List<DashboardRequestModel> actionItems;
  final List<int> serviceIds;
  final List<int> subServiceIds;
  final bool isRequestLoading;
  final bool isActionItemLoading;
  final String requestError;
  final String actionItemError;

  _ViewState({
    required this.isLoading,
    required this.fromDate,
    required this.toDate,
    required this.selectedRole,
    required this.user,
    required this.announcements,
    required this.requestData,
    required this.actionItems,
    required this.serviceIds,
    required this.subServiceIds,
    required this.isRequestLoading,
    required this.isActionItemLoading,
    required this.requestError,
    required this.actionItemError,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        fromDate: '',
        toDate: '',
        selectedRole: '',
        user: null,
        announcements: [],
        requestData: [],
        actionItems: [],
        serviceIds: [],
        subServiceIds: [],
        isRequestLoading: false,
        isActionItemLoading: false,
        requestError: '',
        actionItemError: '',
      );

  _ViewState copyWith({
    bool? isLoading,
    String? fromDate,
    String? toDate,
    String? selectedRole,
    UserModel? user,
    List<AnnouncementModel>? announcements,
    List<DashboardRequestModel>? requestData,
    List<DashboardRequestModel>? actionItems,
    List<int>? serviceIds,
    List<int>? subServiceIds,
    bool? isRequestLoading,
    bool? isActionItemLoading,
    String? requestError,
    String? actionItemError,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      selectedRole: selectedRole ?? this.selectedRole,
      user: user ?? this.user,
      announcements: announcements ?? this.announcements,
      requestData: requestData ?? this.requestData,
      actionItems: actionItems ?? this.actionItems,
      serviceIds: serviceIds ?? this.serviceIds,
      subServiceIds: subServiceIds ?? this.subServiceIds,
      isActionItemLoading: isActionItemLoading ?? this.isActionItemLoading,
      isRequestLoading: isRequestLoading ?? this.isRequestLoading,
      requestError: requestError ?? this.requestError,
      actionItemError: actionItemError ?? this.actionItemError,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());
  // late TextEditingController fromDateController;

  Future<void> initState() async {
    final savedRole = await KAuthCred().getSelectedRole();
    if (savedRole != null) {
      // await Future.wait([fetchRequests(), fetchActionItems()]);
      return;
    }

    final userInfo = KAppX.globalProvider.read(userInfoProvider);
    final user = KAppX.globalProvider.read(userProvider);
    final id = int.tryParse(userInfo?.data?.id ?? '') ?? user?.userId ?? 0;
    await fetchUserRoles(id);
  }

  final dashboardInstance = DashboardRepository();
  final repo = RolesRepo();

  Future<void> fetchUser() async {
    final userData = KAppX.globalProvider.read(userProvider);
    final userInfo = KAppX.globalProvider.read(userInfoProvider);
    final userId =
        userData?.userId ?? int.tryParse(userInfo?.data?.id ?? '') ?? 0;

    if (userId == 0) return;

    state = state.copyWith(isLoading: true);
    final userModel = await dashboardInstance.getUser(userId);
    final user = userModel;
    print(user.data?.employeeName);
    print(user.data?.department?.id);

    state = state.copyWith(isLoading: false, user: user);
  }

  Future<void> fetchAnnouncements() async {
    state = state.copyWith(isLoading: true);
    final announcements = await dashboardInstance.getModels();
    final anns = announcements;

    state = state.copyWith(isLoading: false, announcements: anns);
  }

  Future<void> selectOrStoreRole(UserRoleResponse userRoles) async {
    final storage = KAuthCred();
    final saved = await storage.getSelectedRole();

    if (saved != null) {
      print("🔵 Using saved role ${saved.roleName}");
      // state = state.copyWith(selectedRoleName: saved.roleName);
      return;
    }

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

    print("🎯 Selected Role: ${selected.roleName}");
  }

  Future<void> fetchUserRoles(int id) async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);

    try {
      final userRoles = await repo.getUserRoles(id);
      if (!mounted) return;

      await selectOrStoreRole(userRoles);
      await Future.wait([fetchRequests(), fetchActionItems()]);

      // state = state.copyWith(userRoles: userRoles);
      // await loadSavedRole(userRoles);
      if (!mounted) return;

      state = state.copyWith(isLoading: false);
    } catch (e) {
      debugPrint("fetchUserRoles error: $e");
      if (mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> fetchRequests({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    state = state.copyWith(isRequestLoading: true, requestError: '');

    try {
      final role = KAppX.globalProvider.read(rolesProvider);

      final ids = MobileServiceScope.idsForServices(role?.services ?? const []);
      final serviceIds = ids.serviceIds;
      final subServiceIds = ids.subServiceIds;

      final requests = await dashboardInstance.getRequestsData(
        offset: 1,
        limit: 10,
        searchText: searchText,
        serviceIds: serviceIds,
        subServiceIds: subServiceIds,
      );

      state = state.copyWith(
        requestData: requests,
        serviceIds: serviceIds,
        subServiceIds: subServiceIds,
        isRequestLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isRequestLoading: false,
        requestError: e.toString(),
      );
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> fetchActionItems({
    bool isRefresh = false,
    String searchText = '',
    String status = '',
  }) async {
    state = state.copyWith(isActionItemLoading: true, actionItemError: '');

    try {
      if (isRefresh || status.isNotEmpty) {
        state = state.copyWith(actionItems: []);
      }

      final role = KAppX.globalProvider.read(rolesProvider);

      final ids = MobileServiceScope.idsForServices(role?.services ?? const []);
      final serviceIds = ids.serviceIds;
      final subServiceIds = ids.subServiceIds;

      final items = await dashboardInstance.getActionItems(
        offset: 1,
        limit: 10,
        searchText: searchText,
        serviceIds: serviceIds,
        subServiceIds: subServiceIds,
      );

      state = state.copyWith(
        actionItems: items,
        serviceIds: serviceIds,
        subServiceIds: subServiceIds,
        isActionItemLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isActionItemLoading: false,
        actionItemError: e.toString(),
      );
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
