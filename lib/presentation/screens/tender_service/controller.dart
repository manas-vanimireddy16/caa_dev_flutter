part of 'view.dart';

// class BottomNavigatorVSControllerParams extends Equatable {
//   final BuildContext context;
//   BottomNavigatorVSControllerParams({required this.context});

//   @override
//   List<Object> get props => [];
// }

final bottomNavigatorVsProvider =
    StateNotifierProvider<_VSController, _ViewState>((ref) {
      final stateController = _VSController();

      // stateController.initState();

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
    printUserData();
  }

  Future<void> printUserData() async {
    final userData = await KAuthCred().getProfileData();
    log(userData!.toJson().toString());
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
    state = state.copyWith(currentTabIndex: index);

    if (index == 2) {
      // final profileStateController = KAppX.globalProvider.read(patientProfileVSProvider.notifier);
      // profileStateController.initState();
    }
  }

  String titleForIndex(int index) {
    switch (index) {
      case 0:
        return 'Request a Tender Service';
      case 1:
        return 'Request A Service To Respond To Enquiries';
      case 2:
        return 'Request Tender Analysis Service';
      case 3:
        return 'Request Contract Service';

      default:
        return '  Home';
    }
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
