part of 'view.dart';

@RoutePage()
class RequestPortalScreen extends ConsumerStatefulWidget {
  const RequestPortalScreen({super.key});

  @override
  ConsumerState<RequestPortalScreen> createState() => _RequestPortalState();
}

class _RequestPortalState extends ConsumerState<RequestPortalScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController searchController;
  late FocusNode _focusNode;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(
      text: ref.read(searchQueryProvider),
    );
    _focusNode = FocusNode();

    searchController.addListener(() {
      setState(() {}); // rebuild suffixIcon
    });

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        ref.read(selectedrequesteventTabProvider.notifier).state =
            _tabController.index;
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final tickets = ref.watch(ticketProvider);
    final selectedTab = ref.watch(selectedrequesteventTabProvider);
    final data = ref.watch(filteredDataProvider);
    final selectedService = ref.watch(bottomNavIndexProvider);

    // Keep TabController in sync with provider
    if (_tabController.index != selectedTab) {
      _tabController.index = selectedTab;
    }

    return KScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Request Event Support')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // KPI Cards
          //StatSummaryRow(stats: tickets),
          16.toHorizontalSizedBox,

          // RequestStatusBreakdownCard(
          //   data: requestStatusData,
          //   title: "Requests Status Breakdown",
          //   //  filterLabel: "Monthly",
          //   onFilterTap: () => debugPrint("Filter tapped!"),
          // ),
          16.toHorizontalSizedBox,

          // Trend breakdown
          RequestTrendBreakdownCard(
            monthlyData: monthlyRequestData2025,
            monthLabels: monthLabels,
            metric: "Total Tickets",
            // selectedYear: '2025',
            barColor: Colors.blue,
            // onYearTap: () => debugPrint("Year dropdown tapped"),
            onChanged: (String? p1) {},
            filterLabelList: [],
          ),
          16.toHorizontalSizedBox,

          // Ticket Requests Section
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ticket Requests",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          KAppX.router.push(NewRequestRequestSupportRoute());
                        },
                        child: const Text('New Request'),
                      ),
                    ],
                  ),
                  12.toHorizontalSizedBox,

                  // Search box
                  KTextField(
                    focusNode: _focusNode,
                    hintText: "Search by ID or Name",
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      ref.read(searchQueryProvider.notifier).state = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                searchController.clear();
                                ref.read(searchQueryProvider.notifier).state =
                                    "";
                                Future.microtask(() {
                                  if (!_focusNode.hasFocus) {
                                    _focusNode.requestFocus();
                                  }
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  12.toHorizontalSizedBox,

                  // Tabs below the search bar
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.blue,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: "My Requests"),
                      Tab(text: "Action Items"),
                    ],
                  ),

                  // Tab content
                  SizedBox(
                    height: 400, // adjust height as needed
                    child: TabBarView(
                      controller: _tabController,
                      // physics:   const NeverScrollableScrollPhysics(), // ❌ disables swipe
                      children: [
                        // Tab 0
                        Consumer(
                          builder: (context, ref, _) {
                            //final data = ref.watch(filteredDataProvider);
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return RequestCard(
                                  data: item,
                                  onTap: () {
                                    // KAppX.router.push(
                                    //   ReuseRequestDetailsTabRoute(
                                    //     taskData: tasksData1,
                                    //     comments: comments1,
                                    //     attachments: attachments1,
                                    //   ),
                                    // );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        // Tab 1
                        Consumer(
                          builder: (context, ref, _) {
                            // final data = ref.watch(filteredDataProvider);
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return RequestCard(
                                  data: item,
                                  onTap: () {
                                    // KAppX.router.push(
                                    //   ReuseRequestDetailsTabRoute(
                                    //     taskData: tasksData1,
                                    //     comments: comments1,
                                    //     attachments: attachments1,
                                    //   ),
                                    // );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
