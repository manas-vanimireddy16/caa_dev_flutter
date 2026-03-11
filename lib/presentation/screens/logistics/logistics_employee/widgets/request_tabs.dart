// import 'package:code_setup/presentation/screens/approvals/widgets/buildChangewidget.dart';
// import 'package:code_setup/presentation/screens/logistics/view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
part of '../view.dart';

class RequestTabs extends ConsumerWidget {
  final int selectedTab;

  const RequestTabs({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (index) {
          final labels = [
            "Request Details",
            "Request History",
            "Attachments",
            "Work Flow",
          ];
          return TabItem(
            text: labels[index],
            index: index,
            selectedIndex: selectedTab,
            onTap: () =>
                ref.read(requestDeatilsTabSelectedProvider.notifier).state =
                    index,
          );
        }),
      ),
    );
  }
}
