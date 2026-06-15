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

    final items = isActionItem
        ? state.promotionsActionItems
        : state.promotionsRequestData;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return Center(child: Text(l10n.noDataFound));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return RequestCard(
          data: controller.buildRequestCardData(item),
          fieldLabelBuilder: l10n.requestDetailsLabel,
          requestIdLabelBuilder: l10n.requestIdLabel,
          statusLabelBuilder: l10n.statusLabel,
          onTap: () async {
            await controller.openRequestDetails(
              item.base.id ?? 0,
              fromActionItems: isActionItem,
            );
            controller.updateTabIndex(0);
          },
        );
      },
    );
  }
}
