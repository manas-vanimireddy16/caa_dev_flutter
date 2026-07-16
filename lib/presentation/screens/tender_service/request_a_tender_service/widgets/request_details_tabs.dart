part of '../view.dart';

class RequestDetailsTabs extends ConsumerWidget {
  final int selectedTab;
  final Service service;
  final SubService subService;

  RequestDetailsTabs({
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

    final state = ref.watch(_vsProvider(providerArgs));
    final controller = ref.read(_vsProvider(providerArgs).notifier);

    final labels = [
      "Request Details",
      "Request History",
      "Attachments",
      "Work Flow",
    ];

    return ScrollableRequestDetailsTabBar(
      labels: labels,
      selectedIndex: state.requestDetailTab,
      onTap: controller.updateRequestTab,
    );
  }
}
