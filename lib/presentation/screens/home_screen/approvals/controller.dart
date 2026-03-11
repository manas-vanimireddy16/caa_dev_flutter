part of 'view.dart';

final selectedTabProvider = StateProvider<int>((ref) => 0);

// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");

// Filters data based on searchQuery + selected tab
final filteredDataProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final selectedTab = ref.watch(selectedTabProvider);

  // Pick correct dataset
  final data = selectedTab == 0 ? myRequests : actionItems;

  // No search → return all
  if (query.isEmpty) return data;

  // Filter by ID or Name
  return data.where((item) {
    final idMatch = item["id"]?.toString().contains(query) ?? false;
    final nameMatch = (item["name"] ?? "").toString().toLowerCase().contains(
      query,
    );
    return idMatch || nameMatch;
  }).toList();
});

final _vsProvider =
    StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
      final stateController = _VSController();

      stateController.fetchActionItems(userId: 12);

      return stateController;
    });

class _ViewState {
  final bool isLoading;
  final List<ActionItemData> actionItems;

  _ViewState({required this.isLoading, required this.actionItems});

  _ViewState.init() : this(isLoading: false, actionItems: []);

  _ViewState copyWith({bool? isLoading, List<ActionItemData>? actionItems}) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      actionItems: actionItems ?? this.actionItems,
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

  Future<void> fetchActionItems({required int userId}) async {
    state = state.copyWith(isLoading: true);

    try {
      final items = await dashboardinstance.getActionItems(userId: userId);
      state = state.copyWith(isLoading: false, actionItems: items);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print("Error fetching Action Items: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
