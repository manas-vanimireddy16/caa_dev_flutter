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

  /// Only the newest roles request is allowed to write [_ViewState.services],
  /// so a slower earlier response can never overwrite a fresher list.
  int _rolesFetchToken = 0;
  Future<void>? _inFlightRolesFetch;
  int? _inFlightUserId;

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

  Future<void> fetchUserRoles(int id, {bool force = false}) {
    if (id <= 0) {
      debugPrint('fetchUserRoles skipped: invalid user id ($id)');
      return Future<void>.value();
    }

    // The tab bar, the route observer and pull-to-refresh can all ask for the
    // same data at once. Share a single request instead of racing them.
    final inFlight = _inFlightRolesFetch;
    if (!force && inFlight != null && _inFlightUserId == id) {
      return inFlight;
    }

    final token = ++_rolesFetchToken;
    final request = _runFetchUserRoles(id, token);
    _inFlightRolesFetch = request;
    _inFlightUserId = id;
    request.whenComplete(() {
      if (_rolesFetchToken == token) {
        _inFlightRolesFetch = null;
        _inFlightUserId = null;
      }
    });
    return request;
  }

  Future<void> _runFetchUserRoles(int id, int token) async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);

    try {
      final roles = await _fetchAndStoreRoles(id);
      if (!mounted || token != _rolesFetchToken) return;

      final effectiveRoleId = await _ensureRoleSelected(roles);
      if (!mounted || token != _rolesFetchToken) return;

      final detail = _findRoleDetail(roles, effectiveRoleId);
      if (detail == null) {
        // The response carries no usable role. Keep whatever is on screen
        // rather than replacing a good list with an empty one.
        debugPrint('fetchUserRoles: role $effectiveRoleId not in response');
        state = state.copyWith(isLoading: false);
        return;
      }

      final services = MobileServiceScope.filterServices(
        detail.services ?? const [],
      );
      await _storeSelectedRole(effectiveRoleId, detail);
      if (!mounted || token != _rolesFetchToken) return;

      state = state.copyWith(
        services: services,
        selectedRole: detail.role?.name ?? state.selectedRole,
        isLoading: false,
      );
    } catch (e) {
      debugPrint('fetchUserRoles error: $e');
      if (mounted && token == _rolesFetchToken) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  RoleDetail? _findRoleDetail(UserRoleResponse roles, int roleId) {
    final details = roles.data?.roleDetails;
    if (details == null || roleId == 0) return null;

    for (final detail in details) {
      if (detail.role?.id == roleId) return detail;
    }
    return null;
  }

  Future<void> _storeSelectedRole(int roleId, RoleDetail detail) async {
    await KAuthCred().storeSelectedRole(
      SelectedUserRole(
        roleId: roleId,
        roleName: detail.role?.name ?? '',
        departmentId: detail.department?.id ?? 0,
        sectionId: detail.section?.id ?? 0,
        services: MobileServiceScope.filterServices(
          detail.services ?? const [],
        ),
      ),
    );
  }

  /// Updates the services list for the active role. Applies cached role
  /// services immediately, then optionally refreshes from the API.
  Future<void> syncWithSelectedRole({
    required RoleDetail role,
    int? userId,
  }) async {
    if (!mounted) return;

    final roleName = role.role?.name ?? '';
    final immediateServices = MobileServiceScope.filterServices(
      role.services ?? const [],
    );

    state = state.copyWith(
      services: immediateServices,
      selectedRole: roleName,
      isLoading: userId != null && userId != 0,
    );

    if (userId == null || userId == 0) return;
    await fetchUserRoles(userId, force: true);
  }

  Future<int> _ensureRoleSelected(UserRoleResponse roles) async {
    final storage = KAuthCred();
    final saved = await storage.getSelectedRole();
    final savedRoleId = saved?.roleId ?? 0;

    // A stored role that no longer exists on the account would resolve to an
    // empty service list, so fall back to the first role the API returned.
    if (savedRoleId != 0 && _findRoleDetail(roles, savedRoleId) != null) {
      return savedRoleId;
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
    final details = userRoles.data?.roleDetails;
    if (details == null || details.isEmpty) {
      debugPrint('selectOrStoreRole skipped: response carries no role details');
      return;
    }

    final first = userRoles.data?.rolesSummary?.firstOrNull;
    final detail =
        _findRoleDetail(userRoles, first?.roleId ?? 0) ?? details.first;

    final roleId = detail.role?.id ?? first?.roleId ?? 0;
    if (roleId == 0) {
      debugPrint('selectOrStoreRole skipped: no usable role id');
      return;
    }

    final selected = SelectedUserRole(
      roleId: roleId,
      roleName: detail.role?.name ?? first?.roleName ?? '',
      departmentId: detail.department?.id ?? 0,
      sectionId: detail.section?.id ?? 0,
      services: MobileServiceScope.filterServices(detail.services ?? const []),
    );

    await KAuthCred().storeSelectedRole(selected);
    debugPrint('Selected Role: ${selected.roleName} (${selected.roleId})');
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
    List<SubService>? subServices,
  }) {
    if (service != null && !MobileServiceScope.isApprovedService(service)) {
      return;
    }
    if (subService != null &&
        !MobileServiceScope.isApprovedSubService(subService)) {
      return;
    }

    if (subService != null) {
      final targetService = service ?? Service();
      final shellRoute = SubServiceRouteResolver.serviceShellRouteFor(
        targetService,
      );
      if (shellRoute != null) {
        KAppX.globalProvider
            .read(selectedServiceProvider.notifier)
            .state = SelectedServiceState(
          service: targetService,
          subService: subService,
        );
        KAppX.router.push(shellRoute);
        return;
      }

      final destination = SubServiceRouteResolver.resolve(
        service: targetService,
        subService: subService,
      );
      if (destination.route != null) {
        KAppX.router.push(destination.route!);
        return;
      }
    }

    if (subService == null && service != null) {
      KAppX.globalProvider.read(selectedServiceProvider.notifier).state =
          SelectedServiceState(service: service, subService: SubService());

      switch ((service.code ?? name).trim()) {
        case 'CAAS01':
          KAppX.router.push(const ITServicesHomeRoute());
          return;
        case 'CAAS014':
          KAppX.router.push(const HotelReservationHomeRoute());
          return;
        case 'CAAS013':
          KAppX.router.push(const AviationSecurityFacilitationHomeRoute());
          return;
        case 'CAAS03':
          KAppX.router.push(const RequestForAccessHomeRoute());
          return;
        case 'CAAS016':
          KAppX.router.push(const MaintenanceHomeRoute());
          return;
        case 'CAAS02':
          KAppX.router.push(const TrainingandDevelopmentHomeRoute());
          return;
        case 'HSS':
          KAppX.router.push(const HallServicesHomeRoute());
          return;
        case 'CAAS05':
          KAppX.router.push(const LegalConsultationServicesHomeRoute());
          return;
        case 'CAAS08':
          KAppX.router.push(const HRServiceHomeRoute());
          return;
        case 'CAAS09':
          KAppX.router.push(const MediaCoverageHomeRoute());
          return;
        case 'CAAS011':
          KAppX.router.push(const SecuritySelfHomeRoute());
          return;
        case 'CAAS012':
          KAppX.router.push(const TenderServiceHomeRoute());
          return;
        case 'CAAS015':
          KAppX.router.push(const TrainingsandDevelopmentHomeRoute());
          return;
      }

      final serviceSubServices = subServices ?? service.subservices ?? [];
      final codes = serviceSubServices
          .map((item) => (item.code ?? '').trim())
          .toSet();

      if (codes.any({'CAA003', 'CAA004', 'CAA005', 'CAA059'}.contains)) {
        KAppX.router.push(const ITServicesHomeRoute());
        return;
      }
      if (codes.any({'CAA031', 'CAA032', 'CAA033'}.contains)) {
        KAppX.router.push(const LogisticsHomeRoute());
        return;
      }
      if (codes.any({'CAA027', 'CAA028', 'CAA029', 'CAA030'}.contains)) {
        KAppX.router.push(const LegalConsultationServicesHomeRoute());
        return;
      }
      if (codes.any({'CAA011', 'CAA012', 'CAA013', 'CAA014'}.contains)) {
        KAppX.router.push(const TenderServiceHomeRoute());
        return;
      }
      if (codes.any({'CAA035', 'CAA045'}.contains)) {
        KAppX.router.push(const MaintenanceHomeRoute());
        return;
      }
      if (codes.contains('CAA010')) {
        KAppX.router.push(const AviationSecurityFacilitationHomeRoute());
        return;
      }
      if (codes.contains('CAA050')) {
        KAppX.router.push(const HallServicesHomeRoute());
        return;
      }
      if (codes.contains('CAA046')) {
        KAppX.router.push(const HotelReservationHomeRoute());
        return;
      }
      if (codes.contains('CAA006')) {
        KAppX.router.push(const SecuritySelfHomeRoute());
        return;
      }
      if (codes.any({'CAA021', 'CAA023', 'CAA025'}.contains)) {
        KAppX.router.push(const RequestForAccessHomeRoute());
        return;
      }
      if (codes.any(
        {'CAA015', 'CAA016', 'CAA018', 'CAA019', 'CAA049'}.contains,
      )) {
        KAppX.router.push(const TrainingandDevelopmentHomeRoute());
        return;
      }
      if (codes.any({'CAA034', 'CAA065'}.contains)) {
        KAppX.router.push(const TrainingsandDevelopmentHomeRoute());
        return;
      }

      return;
    }

    switch (name.trim()) {
      case 'CAAS014':
        KAppX.router.push(const HotelReservationHomeRoute());
        break;

      case 'CAAS016':
        KAppX.router.push(const MaintenanceHomeRoute());
        break;
      case 'CAAS02':
        KAppX.router.push(const TrainingandDevelopmentHomeRoute());
        break;
      case 'HSS':
        KAppX.router.push(const HallServicesHomeRoute());
        break;
      case 'CAAS05':
        KAppX.router.push(const LegalConsultationServicesHomeRoute());
        break;
      case 'CAAS08':
        KAppX.router.push(const HRServiceHomeRoute());
        break;
      case 'CAAS09':
        KAppX.router.push(const MediaCoverageHomeRoute());
        break;
      case 'CAAS011':
        KAppX.router.push(const SecuritySelfHomeRoute());
        break;
      case 'CAAS012':
        KAppX.router.push(const TenderServiceHomeRoute());
        break;
      case 'CAAS015':
        KAppX.router.push(const TrainingsandDevelopmentHomeRoute());
        break;
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
      case 'CAA028':
        KAppX.router.push(
          RaiseLegalComplaintRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;
      case 'CAA030':
        KAppX.router.push(
          RequestForLegalContractReviewRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );
        break;

      /// Tender Services
      case 'CAA011':
        KAppX.router.push(
          RequestTenderServiceRoute(
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
      case 'CAA045':
        SubServiceRouteResolver.navigateToSubService(
          service: service ?? Service(),
          subService: subService ?? SubService(code: name),
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
      case 'CAA023':
        KAppX.router.push(
          ImportExportMaterialPermissionRoute(
            service: service ?? Service(),
            subService: subService ?? SubService(),
          ),
        );

        break;

      default:
        debugPrint('No route found for-- $name');
    }
  }
}
