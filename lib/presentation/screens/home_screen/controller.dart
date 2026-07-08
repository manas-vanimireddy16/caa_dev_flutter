part of 'view.dart';

final bottomNavigatorVsProvider =
    StateNotifierProvider<_VSController, _ViewState>((ref) {
      final stateController = _VSController();

      stateController.initState();

      return stateController;
    });

class _ViewState {
  final int currentTabIndex;

  _ViewState({required this.currentTabIndex});

  _ViewState.init() : this(currentTabIndex: 0);

  _ViewState copyWith({int? currentTabIndex}) {
    return _ViewState(currentTabIndex: currentTabIndex ?? this.currentTabIndex);
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());

  void initState() {
    _hydrateSession();
  }

  Future<void> _hydrateSession() async {
    await KAuthCred().hydrateProvidersFromStorage();
  }

  int get currentTabIndex {
    return state.currentTabIndex;
  }

  // AutoTabsRouter.of(params.context).activeIndex;

  void onTabChanged(int index) {
    // getting context
    // final tabsRouter = AutoTabsRouter.of(context);
    //
    // tabsRouter.setActiveIndex(index);
    state = state.copyWith(currentTabIndex: index); //
    // final services = KAppX.globalProvider.read(servicesProvider.notifier);
    // final userData = KAppX.globalProvider.read(userProvider);

    // if (index == 2) {
    //   // services.fetchUserRoles(userData?.userId ?? 0);
    // }
  }
}

final homeNavBarProvider = StateNotifierProvider<_BottomNavBarController, int>((
  ref,
) {
  return _BottomNavBarController();
});

class _BottomNavBarController extends StateNotifier<int> {
  _BottomNavBarController() : super(0); // Initialize with the default index

  void setActiveIndex(int index) {
    state = index;
  }
}
