part of 'view.dart';

final List<ActivityItem> activityList = [
  const ActivityItem(
    title: 'Internet Error Request',
    subtitle: 'Event Request',
    timeAgo: '10 Min',
    isCompleted: false,
  ),
  const ActivityItem(
    title: 'Sent to Network Team',
    subtitle: 'Event Request',
    timeAgo: '3 Days ago',
    isCompleted: false,
  ),
  const ActivityItem(
    title: 'Infrastructure Team Review',
    subtitle: 'Event Request',
    timeAgo: '1 Week Ago',
    isCompleted: true,
  ),
  const ActivityItem(
    title: 'Verification in progress.',
    subtitle: 'Event Request',
    timeAgo: '1 Week Ago',
    isCompleted: false,
  ),
  const ActivityItem(
    title: 'Sent to Network Team',
    subtitle: 'Event Request',
    timeAgo: '3 Days ago',
    isCompleted: false,
  ),
  const ActivityItem(
    title: 'Infrastructure Team Review',
    subtitle: 'Event Request',
    timeAgo: '1 Week Ago',
    isCompleted: true,
  ),
  const ActivityItem(
    title: 'Verification in progress.',
    subtitle: 'Event Request',
    timeAgo: '1 Week Ago',
    isCompleted: false,
  ),
];

final selectedrequesteventTabProvider = StateProvider<int>((ref) => 0);

// Stores search text
final searchQueryProvider = StateProvider<String>((ref) => "");

// Filters data based on searchQuery + selected tab
final filteredDataProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final selectedTab = ref.watch(selectedrequesteventTabProvider);

  // Pick correct dataset
  final data = selectedTab == 1 ? requestData : actionItems;

  // No search → return all
  if (query.isEmpty) return data;

  // Filter by ID or Name
  return data.where((item) {
    final idMatch = item["requestId"]?.toString().contains(query) ?? false;
    final nameMatch = (item["requestName"] ?? "")
        .toString()
        .toLowerCase()
        .contains(query);
    return idMatch || nameMatch;
  }).toList();
});

final selectedRolerequesteventProvider = StateProvider<String>((ref) {
  return '';
});

/// Holds all the controllers for the NewRequest form
class NewRequestControllers {
  final personNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final departmentController = TextEditingController();
  final problemController = TextEditingController();
  final descriptionController = TextEditingController();
  final extensionNumberController = TextEditingController();
  final emailController = TextEditingController();
}

/// AutoDispose so controllers are disposed when screen is popped
final newRequestControllerProvider =
    Provider.autoDispose<NewRequestControllers>((ref) {
      final controllers = NewRequestControllers();
      ref.onDispose(() {
        controllers.personNameController.dispose();
        controllers.contactNumberController.dispose();
        controllers.departmentController.dispose();
        controllers.problemController.dispose();
        controllers.descriptionController.dispose();
        controllers.extensionNumberController.dispose();
        controllers.emailController.dispose();
      });
      return controllers;
    });

final Map<String, ChartData> requestStatusData = {
  'open': ChartData(label: 'Open', value: 40, color: Colors.blue),
  'in_progress': ChartData(
    label: 'In Progress',
    value: 25,
    color: Colors.orange,
  ),
  'closed': ChartData(label: 'Closed', value: 60, color: Colors.green),
  'rejected': ChartData(label: 'Rejected', value: 15, color: Colors.red),
};

// Example static dataset for 2025
final List<int> monthlyRequestData2025 = [
  30,
  40,
  20,
  50,
  60,
  45,
  70,
  90,
  55,
  65,
  35,
  80,
];

final List<String> monthLabels = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];

final List<Map<String, dynamic>> requestData = [
  {
    "requestId": "REQ-1001",
    "date": "2025-09-20",
    "serviceType": "Maintenance",
    "requestName": "Air Conditioner Repair",
    "status": "Pending",
    "assignedTo": "John Doe",
  },
  {
    "requestId": "REQ-1002",
    "date": "2025-09-21",
    "serviceType": "Cleaning",
    "requestName": "Office Cleaning",
    "status": "Approved",
    "assignedTo": "Jane Smith",
  },
  {
    "requestId": "REQ-1003",
    "date": "2025-09-22",
    "serviceType": "IT Support",
    "requestName": "Laptop Setup",
    "status": "Rejected",
    "assignedTo": "Michael Johnson",
  },
];

final List<Map<String, dynamic>> actionItems = [
  {
    "requestId": "ACT-2001",
    "date": "2025-09-20",
    "serviceType": "Maintenance",
    "requestName": "Fix Projector",
    "status": "Pending",
    "assignedTo": "Alice Brown",
  },
  {
    "requestId": "ACT-2002",
    "date": "2025-09-21",
    "serviceType": "IT Support",
    "requestName": "Install Antivirus",
    "status": "In Progress",
    "assignedTo": "David Wilson",
  },
  {
    "requestId": "ACT-2003",
    "date": "2025-09-22",
    "serviceType": "HR",
    "requestName": "Update Employee Records",
    "status": "Completed",
    "assignedTo": "Emma Davis",
  },
];

final List<CommentItemRD> comments1 = [
  CommentItemRD(
    userName: "Evelyn Parker",
    initials: "EP",
    message: "Shared the updated budget file for your review.",
    status: "Submitted",
    dateTime: DateTime.now().subtract(const Duration(hours: 1, minutes: 15)),
  ),
  CommentItemRD(
    userName: "Frank Miller",
    initials: "FM",
    message: "The technical feasibility looks fine. Proceeding ahead.",
    status: "Approved",
    dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
  ),
  CommentItemRD(
    userName: "Grace Thompson",
    initials: "GT",
    message: "Need more clarity on vendor selection process.",
    status: "Pending",
    dateTime: DateTime.now().subtract(const Duration(days: 2, hours: 6)),
  ),
  CommentItemRD(
    userName: "Henry Wilson",
    initials: "HW",
    message: "Declined due to incomplete compliance documents.",
    status: "Rejected",
    dateTime: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
  ),
];

List<TaskRD> tasksData1 = [
  TaskRD(
    taskName: "Initial Request Logged",
    status: "completed",
    approvedBy: "Sophia Ali",
    date: "05 Sep, 2025",
  ),
  TaskRD(
    taskName: "Reviewed by Department Head",
    status: "completed",
    approvedBy: "Omar Hassan",
    date: "06 Sep, 2025",
  ),
  TaskRD(
    taskName: "Awaiting Finance Team Approval",
    status: "pending",
    approvedBy: "NA",
  ),
  TaskRD(
    taskName: "Final Notification Dispatch",
    status: "not_started",
    approvedBy: "",
  ),
];

final List<AttachmentsmodelRD> attachments1 = [
  AttachmentsmodelRD(
    documentName: "Updated Budget Sheet",
    fileType: "budget.xlsx",
    uploadedDate: "10 Sep 2025",
    downloadUrl: "https://example.com/budget.xlsx",
    action: "Edit/Delete",
  ),
  AttachmentsmodelRD(
    documentName: "Technical Proposal",
    fileType: "proposal.docx",
    uploadedDate: "11 Sep 2025",
    downloadUrl: "https://example.com/proposal.docx",
    action: "Edit/Delete",
  ),
  AttachmentsmodelRD(
    documentName: "Compliance Report",
    fileType: "compliance.pdf",
    uploadedDate: "13 Sep 2025",
    downloadUrl: "https://example.com/compliance.pdf",
    action: "Edit/Delete",
  ),
  AttachmentsmodelRD(
    documentName: "Vendor Quotation",
    fileType: "quotation.pdf",
    uploadedDate: "14 Sep 2025",
    downloadUrl: "https://example.com/quotation.pdf",
    action: "Edit/Delete",
  ),
];

final _vsProvider =
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

  _ViewState({
    required this.isLoading,
    required this.fromDate,
    required this.toDate,
    required this.selectedRole,
  });

  _ViewState.init()
    : this(isLoading: false, fromDate: '', toDate: '', selectedRole: '');

  _ViewState copyWith({
    bool? isLoading,
    String? fromDate,
    String? toDate,
    String? selectedRole,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      selectedRole: selectedRole ?? this.selectedRole,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());
  late TextEditingController eventTypeController;
  late TextEditingController departmentController;
  late TextEditingController contactNumberController;
  late TextEditingController reasonController;
  void initState() {
    eventTypeController = TextEditingController();
    departmentController = TextEditingController();
    contactNumberController = TextEditingController();
    reasonController = TextEditingController();
  }

  final dashboardinstance = DashboardRepository();

  // Future<void> fetchServices() async {
  //   state = state.copyWith(isLoading: true);
  //   final servicesModel = await dashboardinstance.getServices();
  //   final services = servicesModel.data ?? [];
  //   // print(services);
  //   state = state.copyWith(isLoading: false, services: services);
  // }

  void onSelectFromDate(String date) {
    state = state.copyWith(fromDate: date);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
