part of '../view.dart';

class RequestsPage extends ConsumerWidget {
  final _VSControllerParams providerArgs;

  const RequestsPage({super.key, required this.providerArgs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider(providerArgs));
    final controller = ref.read(_vsProvider(providerArgs).notifier);

    final isActionTab = state.tabIndex == 1;

    final items = isActionTab
        ? state.requiredNewResourceActionItems
        : state.requiredNewResourceRequestData;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return const Center(child: Text("No Data Found"));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return RequestCard(
          data: controller.buildRequestCardData(item),
          onTap: () async {
            controller.openRequestDetails(
              item.base.id ?? 0,
              fromActionItems: isActionTab,
            );
            controller.updateTabIndex(0);
          },
        );
      },
    );
  }
}
