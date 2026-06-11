part of 'view.dart';

final servicesProvider = StateNotifierProvider<_VSController, _ViewState>((
  ref,
) {
  return _VSController();
});

class _ViewState {
  final bool isLoading;
  final bool isBookmarksLoading;
  final String fromDate;
  final String toDate;
  final String selectedRole;
  final List<Service>? services;
  final Set<int> bookmarkedServiceIds;
  final UserRoleResponse userRoles;
  final ServicesListFilter listFilter;
  final String searchQuery;

  _ViewState({
    required this.isLoading,
    required this.isBookmarksLoading,
    required this.fromDate,
    required this.toDate,
    required this.selectedRole,
    required this.services,
    required this.bookmarkedServiceIds,
    required this.userRoles,
    required this.listFilter,
    required this.searchQuery,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        isBookmarksLoading: false,
        fromDate: '',
        toDate: '',
        selectedRole: '',
        services: [],
        bookmarkedServiceIds: {},
        userRoles: UserRoleResponse(),
        listFilter: ServicesListFilter.all,
        searchQuery: '',
      );

  _ViewState copyWith({
    bool? isLoading,
    bool? isBookmarksLoading,
    String? fromDate,
    String? toDate,
    String? selectedRole,
    List<Service>? services,
    Set<int>? bookmarkedServiceIds,
    UserRoleResponse? userRoles,
    ServicesListFilter? listFilter,
    String? searchQuery,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      isBookmarksLoading: isBookmarksLoading ?? this.isBookmarksLoading,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      selectedRole: selectedRole ?? this.selectedRole,
      services: services ?? this.services,
      bookmarkedServiceIds: bookmarkedServiceIds ?? this.bookmarkedServiceIds,
      userRoles: userRoles ?? this.userRoles,
      listFilter: listFilter ?? this.listFilter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());

  final dashboardinstance = DashboardRepository();
  final Set<int> _pendingBookmarkToggles = {};
  bool _isFetchingBookmarks = false;

  bool isBookmarked(int serviceId) =>
      serviceId != 0 && state.bookmarkedServiceIds.contains(serviceId);

  void setListFilter(ServicesListFilter filter) {
    if (state.listFilter == filter) return;
    state = state.copyWith(listFilter: filter);
  }

  void setSearchQuery(String query) {
    if (state.searchQuery == query) return;
    state = state.copyWith(searchQuery: query);
  }

  List<Service> filteredServices({required bool isArabic}) {
    var list = List<Service>.from(state.services ?? []);

    if (state.listFilter == ServicesListFilter.myServices) {
      list = list.where((s) => isBookmarked(s.id ?? 0)).toList(growable: false);
    }

    final query = state.searchQuery.trim().toLowerCase();
    if (query.isEmpty) return list;

    return list
        .where((s) {
          final en = (s.name ?? '').toLowerCase();
          final ar = (s.arabicName ?? '').toLowerCase();
          return en.contains(query) || ar.contains(query);
        })
        .toList(growable: false);
  }

  static int? _bookmarkServiceId(Bookmarksmodel bookmark) {
    final tableId = bookmark.serviceTableId;
    if (tableId != null && tableId != 0) return tableId;
    return int.tryParse(bookmark.serviceId ?? '');
  }

  static Set<int> _bookmarkIdsFrom(List<Bookmarksmodel> bookmarks) {
    return bookmarks
        .map(_bookmarkServiceId)
        .whereType<int>()
        .where((id) => id != 0)
        .toSet();
  }

  Future<void> fetchUserRoles(int id) async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);

    try {
      final roles = await _fetchAndStoreRoles(id);
      if (!mounted) return;

      final effectiveRoleId = await _ensureRoleSelected(roles);
      if (!mounted) return;

      final services = _filterServicesByRole(roles, effectiveRoleId);
      state = state.copyWith(services: services, isLoading: false);
    } catch (e) {
      debugPrint('fetchUserRoles error: $e');
      if (mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  List<Service> _filterServicesByRole(UserRoleResponse roles, int roleId) {
    final matched = roles.data?.roleDetails?.firstWhere(
      (d) => d.role?.id == roleId,
      orElse: () => RoleDetail(services: []),
    );

    return matched?.services ?? [];
  }

  /// Updates the services list for the active role. Applies cached role
  /// services immediately, then optionally refreshes from the API.
  Future<void> syncWithSelectedRole({
    required RoleDetail role,
    int? userId,
  }) async {
    if (!mounted) return;

    final roleId = role.role?.id ?? 0;
    final roleName = role.role?.name ?? '';
    final immediateServices = role.services ?? [];

    state = state.copyWith(
      services: immediateServices,
      selectedRole: roleName,
      isLoading: userId != null && userId != 0,
    );

    if (userId == null || userId == 0) return;
    await fetchUserRoles(userId);
  }

  Future<int> _ensureRoleSelected(UserRoleResponse roles) async {
    final storage = KAuthCred();
    final saved = await storage.getSelectedRole();

    if (saved?.roleId != null && saved!.roleId != 0) {
      return saved.roleId;
    }

    final firstRole = roles.data?.roleDetails?.firstOrNull?.role?.id ?? 0;
    return firstRole;
  }

  Future<UserRoleResponse> _fetchAndStoreRoles(int id) async {
    final repo = RolesRepo();
    final storage = KAuthCred();

    final saved = await storage.getSelectedRole();
    final roleId = saved?.roleId;
    final roles = await repo.getUserRoles(id);

    if (!mounted) return roles;
    state = state.copyWith(userRoles: roles);

    if (roleId == null || roleId == 0) {
      await selectOrStoreRole(roles);
    }
    return roles;
  }

  Future<void> selectOrStoreRole(UserRoleResponse userRoles) async {
    final storage = KAuthCred();
    final first = userRoles.data!.rolesSummary!.first;

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
    debugPrint('Selected Role: ${selected.services}');
  }

  Future<void> fetchBookmarks() async {
    if (_isFetchingBookmarks || !mounted) return;
    _isFetchingBookmarks = true;

    final showLoading = state.bookmarkedServiceIds.isEmpty;
    if (showLoading && mounted) {
      state = state.copyWith(isBookmarksLoading: true);
    }

    try {
      final bookmarks = await dashboardinstance.getBookmarks();
      if (!mounted) return;

      state = state.copyWith(
        bookmarkedServiceIds: _bookmarkIdsFrom(bookmarks),
        isBookmarksLoading: false,
      );
    } catch (e) {
      debugPrint('fetchBookmarks error: $e');
      if (mounted) {
        state = state.copyWith(isBookmarksLoading: false);
      }
    } finally {
      _isFetchingBookmarks = false;
    }
  }

  Future<void> toggleBookmark(int serviceId) async {
    if (serviceId == 0 || _pendingBookmarkToggles.contains(serviceId)) {
      return;
    }

    final wasBookmarked = isBookmarked(serviceId);
    final optimistic = Set<int>.from(state.bookmarkedServiceIds);
    if (wasBookmarked) {
      optimistic.remove(serviceId);
    } else {
      optimistic.add(serviceId);
    }

    state = state.copyWith(bookmarkedServiceIds: optimistic);
    _pendingBookmarkToggles.add(serviceId);

    try {
      await dashboardinstance.updateBookmark(serviceId: serviceId);
    } catch (e) {
      debugPrint('Error updating bookmark: $e');
      final reverted = Set<int>.from(state.bookmarkedServiceIds);
      if (wasBookmarked) {
        reverted.add(serviceId);
      } else {
        reverted.remove(serviceId);
      }
      state = state.copyWith(bookmarkedServiceIds: reverted);
      ShowFlutterToast().showFlutterToastFailure(
        'Could not update bookmark. Please try again.',
      );
    } finally {
      _pendingBookmarkToggles.remove(serviceId);
    }
  }

  void navigateToRoute({
    required String name,
    Service? service,
    SubService? subService,
  }) {
    switch (name.trim()) {
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
      case 'CAA033':
        KAppX.router.push(
          RequestForVehicleMaintenanceRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA021':
        KAppX.router.push(
          AccessCardRequestRoute(
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
        break;
      case 'CAA010':
        KAppX.router.push(
          AirportEntryPermitRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA060':
        KAppX.router.push(
          AssignmentDecisionRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA061':
        KAppX.router.push(
          SecondmentDecisionRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA062':
        KAppX.router.push(
          TemporaryAssignmentDecisionRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA063':
        KAppX.router.push(
          ServiceTransferRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA034':
        KAppX.router.push(
          AssignaTasktoEmployeeRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA065':
        KAppX.router.push(
          FollowUpReportRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA004':
        KAppX.router.push(
          MuscatDashboard(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA005':
        KAppX.router.push(
          VpnDashboard(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA003':
        KAppX.router.push(
          SalalahDashboard(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA059':
        KAppX.router.push(
          RequestEventSupportRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA066':
        KAppX.router.push(
          PaymentofShiftAllowanceRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA067':
        KAppX.router.push(
          PaymentofCashAllowanceForLeaveRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA069':
        KAppX.router.push(
          AnnualIncrementRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;

      /// Legal Services
      case 'CAA029':
        KAppX.router.push(
          AppealAgainstAdministrativeDecisionsRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA027':
        KAppX.router.push(
          LegalConsultationandReviewofAdministrativeDecisionsRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;

      case 'CAA012':
        KAppX.router.push(
          RequestAServiceToRespondToEnquiriesRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;

      case 'CAA013':
        KAppX.router.push(
          RequestTenderAnalysisServiceRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA014':
        KAppX.router.push(
          ContractServiceRequestRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA050':
        KAppX.router.push(
          RequestToBookCAAHallsRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );

        break;
      case 'CAA035':
        KAppX.router.push(
          RequestMaintenanceRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );

        break;

      /// complaint a Lost Item
      case 'CAA025':
        KAppX.router.push(
          ComplaintLostPropertyReportRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );

        break;

      default:
        debugPrint('No route found for $name');
    }
  }
}
