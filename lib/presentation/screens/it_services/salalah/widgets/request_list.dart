part of '../view.dart';

class RequestsPage extends ConsumerWidget {
  final _VSControllerParams providerArgs;

  const RequestsPage({super.key, required this.providerArgs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider(providerArgs));

    final controller = ref.read(_vsProvider(providerArgs).notifier);

    final isActionItem = state.tabIndex == 1;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    /// ===================================================
    /// ACTION ITEMS
    /// ===================================================

    if (isActionItem) {
      final items = state.actionItems ?? [];

      if (items.isEmpty) {
        return const Center(child: Text("No Data Found"));
      }

      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return RequestCard(
            data: controller.buildActionItemCardData(item),

            onTap: () async {
              await controller.openRequestDetails(
                item.request?.id ?? 0,
                fromActionItems: true,
              );

              controller.updateTabIndex(0);
            },
          );
        },
      );
    }

    /// ===================================================
    /// REQUESTS
    /// ===================================================

    final items = state.requestData ?? [];

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
            await controller.openRequestDetails(
              item.base?.id ?? 0,
              fromActionItems: false,
            );

            controller.updateTabIndex(0);
          },
        );
      },
    );
  }
}
