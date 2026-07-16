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

    final items = isActionItem ? state.actionItems : state.requestData;

    if (state.isLoading || state.isRequestLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return Center(child: Text(l10n.noDataFound));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final base = item.base;
        final service =
            item.service ??
            Service(
              id: base?.serviceId,
              code: base?.service?.code,
              name: base?.service?.name,
            );
        final subService =
            item.subService ??
            SubService(
              id: base?.subServiceId,
              code: base?.subService?.code,
              subServiceName: base?.subService?.subServiceName,
            );

        return RequestCard(
          data: controller.buildRequestCardData(item),
          fieldLabelBuilder: l10n.fieldLabel,
          requestIdLabelBuilder: l10n.requestIdLabel,
          onTap: () {
            controller.navigateToRoute(
              name: item.subServiceCode ?? subService.code ?? '',
              requestId:
                  int.tryParse(item.requestId ?? '') ??
                  base?.id ??
                  item.id ??
                  0,
              service: service,
              subService: subService,
              fromActionItems: isActionItem,
            );
          },
          onWorkflowTap: () {
            controller.navigateToRoute(
              name: item.subServiceCode ?? subService.code ?? '',
              requestId:
                  int.tryParse(item.requestId ?? '') ??
                  base?.id ??
                  item.id ??
                  0,
              service: service,
              subService: subService,
              fromActionItems: isActionItem,
              initialTabIndex: RequestDetailsTabIndex.workflow,
            );
          },
        );
      },
    );
  }
}
