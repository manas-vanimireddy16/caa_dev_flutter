part of '../view.dart';

@RoutePage()
class TransferFromOneJobtoAnotherJobNatureNewRequestScreen
    extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const TransferFromOneJobtoAnotherJobNatureNewRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<TransferFromOneJobtoAnotherJobNatureNewRequestScreen>
  createState() => _TransferFromOneJobtoAnotherJobNatureNewRequestScreenState();
}

class _TransferFromOneJobtoAnotherJobNatureNewRequestScreenState
    extends
        ConsumerState<TransferFromOneJobtoAnotherJobNatureNewRequestScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    Future.microtask(() {
      final controller = ref.read(_vsProvider(_providerArgs).notifier);
      controller.fetchUsers();
      controller.fetchpositionsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);
    final code = widget.subService.code ?? '';
    final title = l10n.isArabic
        ? (widget.subService.arabicsubServiceName ??
              widget.subService.subServiceName ??
              '')
        : (widget.subService.subServiceName ?? '');

    return KScaffold(
      backgroundColor: Colors.white,
      body: ProviderScope(
        overrides: [
          dynamicFormProvider.overrideWith((ref) => DynamicFormNotifier(ref)),
        ],
        child: DynamicForm(
          title: code.isNotEmpty ? '$title - $code' : title,
          stepTitles: [
            l10n.isArabic
                ? 'قدّم تفاصيل النقل من وظيفة إلى طبيعة وظيفة أخرى'
                : 'Provide details about your Transfer From One Job To Another Job Nature',
          ],
          steps: [controller.buildJobTransferForm(l10n)],
          onSubmit: (values) async {
            await controller.submitJobTransferRequest(
              widget.serviceId,
              widget.subServiceId,
              values,
            );

            if (context.mounted) {
              context.router.pop();
            }
          },
        ),
      ),
    );
  }
}
