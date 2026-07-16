import 'package:code_setup/presentation/common_widgets/request_details/scrollable_request_details_tab_bar.dart';
import 'package:code_setup/presentation/screens/request_details/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestTabs extends ConsumerWidget {
  final int selectedTab;

  const RequestTabs({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labels = [
      "Request Details",
      "Request History",
      "Attachments",
      "Work Flow",
    ];

    return ScrollableRequestDetailsTabBar(
      labels: labels,
      selectedIndex: selectedTab,
      onTap: (index) =>
          ref.read(requestDeatilsTabSelectedProvider.notifier).state = index,
    );
  }
}
