part of 'dashboard.dart';

// Holds the index of the selected bottom nav tab
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

final _vsProvider =
    StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
      final stateController = _VSController();

      stateController.fetchUser();
      stateController.fetchAnnouncements();

      return stateController;
    });

class _ViewState {
  final bool isLoading;
  final String fromDate;
  final String toDate;
  final String selectedRole;
  final UserModel? user;
  final List<AnnouncementModel> announcements;

  _ViewState({
    required this.isLoading,
    required this.fromDate,
    required this.toDate,
    required this.selectedRole,
    required this.user,
    required this.announcements,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        fromDate: '',
        toDate: '',
        selectedRole: '',
        user: null,
        announcements: [],
      );

  _ViewState copyWith({
    bool? isLoading,
    String? fromDate,
    String? toDate,
    String? selectedRole,
    UserModel? user,
    List<AnnouncementModel>? announcements,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      selectedRole: selectedRole ?? this.selectedRole,
      user: user ?? this.user,
      announcements: announcements ?? this.announcements,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());
  // late TextEditingController fromDateController;

  void initState() {
    // fromDateController = TextEditingController();
  }

  final dashboardinstance = DashboardRepository();

  Future<void> fetchUser() async {
    final userData = KAppX.globalProvider.read(userProvider);
    state = state.copyWith(isLoading: true);
    final userModel = await dashboardinstance.getUser(userData?.userId ?? 0);
    final user = userModel;
    print(user.data?.employeeName);

    state = state.copyWith(isLoading: false, user: user);
  }

  Future<void> fetchAnnouncements() async {
    state = state.copyWith(isLoading: true);
    final announcements = await dashboardinstance.getModels();
    final anns = announcements;

    state = state.copyWith(isLoading: false, announcements: anns);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
