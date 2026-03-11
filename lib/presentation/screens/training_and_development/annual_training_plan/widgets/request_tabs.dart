part of '../view.dart';

class RequestTabs extends ConsumerWidget {
  final int selectedTab;
  final Service service;
  final SubService subService;

  RequestTabs({
    super.key,
    required this.selectedTab,
    required this.service,
    required this.subService,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerArgs = _VSControllerParams(
      service: service,
      subService: subService,
    );

    // ✅ Correct provider family usage
    final controller = ref.read(_vsProvider(providerArgs).notifier);

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
            onTap: () => controller.updateRequestTab(index),
          );
        }),
      ),
    );
  }
}
