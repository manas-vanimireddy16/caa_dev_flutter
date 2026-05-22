part of '../view.dart';

class RequestsPage extends ConsumerWidget {
  final _VSControllerParams providerArgs;
  final DashboardL10n l10n;
  // final bool isActionItem;

  const RequestsPage({
    super.key,
    required this.providerArgs,
    required this.l10n,
    // required this.isActionItem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider(providerArgs));
    final controller = ref.read(_vsProvider(providerArgs).notifier);
    final isActionItem = state.tabIndex == 1;

    final items = isActionItem ? state.actionItems : state.requestData;

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
          fieldLabelBuilder: l10n.fieldLabel,
          statusLabelBuilder: l10n.statusLabel,
          requestIdLabelBuilder: l10n.requestIdLabel,
          onTap: () async {
            await controller.openRequestDetails(
              item.id ?? 0,
              fromActionItems: isActionItem,
            );
            controller.updateTabIndex(0);
          },
        );
      },
    );
  }
}
