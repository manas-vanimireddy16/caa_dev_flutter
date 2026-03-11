import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigatorVSControllerParams extends Equatable {
  final BuildContext context;
  BottomNavigatorVSControllerParams({required this.context});

  @override
  List<Object> get props => [];
}

final bottomNavigatorVsProvider =
    StateNotifierProvider.family<
      _VSController,
      _ViewState,
      BottomNavigatorVSControllerParams
    >((ref, params) {
      final stateController = _VSController(params);
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
  final BottomNavigatorVSControllerParams params;
  _VSController(this.params) : super(_ViewState.init());

  void initState() {
    print('hello');
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

    // if (index == 2) {
    //   final profileStateController = KAppX.globalProvider.read(
    //     patientProfileVSProvider.notifier,
    //   );
    //   profileStateController.initState();
    // }
  }
}

final bottomNavBarProvider =
    StateNotifierProvider<_BottomNavBarController, int>((ref) {
      return _BottomNavBarController();
    });

class _BottomNavBarController extends StateNotifier<int> {
  _BottomNavBarController() : super(0); // Initialize with the default index

  void setActiveIndex(int index) {
    state = index;
  }
}
