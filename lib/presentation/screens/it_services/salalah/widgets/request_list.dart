part of '../view.dart';

class RequestsPage extends ConsumerWidget {
  final _VSControllerParams providerArgs;
  final DashboardL10n l10n;

  const RequestsPage({
    super.key,
    required this.providerArgs,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider(providerArgs));
    final controller = ref.read(_vsProvider(providerArgs).notifier);
    final isActionItem = state.tabIndex == 1;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isActionItem) {
      final items = state.actionItems ?? [];

      if (items.isEmpty) {
        return Center(child: Text(l10n.noDataFound));
      }

      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return RequestCard(
            data: controller.buildActionItemCardData(item),
            fieldLabelBuilder: l10n.fieldLabel,
            requestIdLabelBuilder: l10n.requestIdLabel,
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

    final items = state.requestData ?? [];

    if (items.isEmpty) {
      return Center(child: Text(l10n.noDataFound));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return RequestCard(
          data: controller.buildRequestCardData(item),
          fieldLabelBuilder: l10n.fieldLabel,
          requestIdLabelBuilder: l10n.requestIdLabel,
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
