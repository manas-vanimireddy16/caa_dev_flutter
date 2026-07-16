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

    final labels = [
      "Request Details",
      "Request History",
      "Attachments",
      "Work Flow",
    ];

    return ScrollableRequestDetailsTabBar(
      labels: labels,
      selectedIndex: selectedTab,
      onTap: controller.updateRequestTab,
    );
  }
}
