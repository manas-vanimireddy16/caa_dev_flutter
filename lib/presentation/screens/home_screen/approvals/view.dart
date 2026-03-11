import 'package:auto_route/auto_route.dart';
import 'package:code_setup/l10n/app_localizations.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/model/actionItems.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/staticdata.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/widgets/buildChangewidget.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/widgets/newRequest.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/repository/dashboard/domain/dashboard.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/statusWidget.dart';
part 'controller.dart';

@RoutePage()
class ApprovalsList extends ConsumerStatefulWidget {
  const ApprovalsList({super.key});

  @override
  ConsumerState<ApprovalsList> createState() => _ApprovalsListState();
}

class _ApprovalsListState extends ConsumerState<ApprovalsList> {
  late TextEditingController searchController;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(
      text: ref.read(searchQueryProvider),
    );

    _focusNode = FocusNode();

    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final selectedTab = ref.watch(selectedTabProvider);
    final state = ref.watch(_vsProvider);
    final controller = ref.read(_vsProvider.notifier);
    final data = state.actionItems;

    return GestureDetector(
      behavior: HitTestBehavior.opaque, // 👈 detects taps
      onTap: () {
        FocusScope.of(context).unfocus(); // 👈 dismiss keyboard & remove cursor
      },
      child: KScaffold(
        appBar: AppBar(
          leading: const Icon(Icons.approval),
          title: Text(loc.approvals),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  KAppX.extendedRouter.bottomSheet.showConstraintBottomSheet(
                    showDragger: false,
                    context: context,
                    builder: (_) => const NewRequestForm(),
                  );
                },
                child: Row(
                  children: const [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 4),
                    Text("New Request", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Tabs
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  TabItem(
                    text: "My Requests",
                    index: 0,
                    selectedIndex: selectedTab,
                    onTap: () =>
                        ref.read(selectedTabProvider.notifier).state = 0,
                  ),
                  TabItem(
                    text: "Action Items",
                    index: 1,
                    selectedIndex: selectedTab,
                    onTap: () =>
                        ref.read(selectedTabProvider.notifier).state = 1,
                  ),
                ],
              ),
            ),

            // ✅ Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: KTextField(
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
                          icon: const Icon(Icons.clear, color: Colors.black),
                          onPressed: () {
                            searchController.clear();
                            ref.read(searchQueryProvider.notifier).state = "";
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
            ),

            // ✅ Card layout
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  return GestureDetector(
                    onTap: () {
                      KAppX.router.push(RequestDetailRoute());
                    },
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Request ID and Status at top row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Request ID: ${item.id}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                StatusChip(status: item.status ?? ""),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Request Name
                            Text(
                              "Request Name: ${item.problem}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Date
                            Text(
                              "Date: ${item.requestDate ?? "-"}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Approver
                            Text(
                              "Approver: ${item.reportingManager?.employeeName ?? "-"}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Service Type
                            if (item.serviceType != null) ...[
                              Text(
                                "Service Type: ${item.serviceType}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],

                            // Assigned To
                            if (item.assignedTo != null) ...[
                              Text(
                                "Assigned To: ${item.assignedTo}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],

                            // Start Date & End Date Row
                            if (item.createdBy != null ||
                                item.updatedBy != null) ...[
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Start Date: ${item.createdBy ?? "-"}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "End Date: ${item.updatedBy ?? "-"}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
