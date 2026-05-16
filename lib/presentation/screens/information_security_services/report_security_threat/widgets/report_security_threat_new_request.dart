part of '../view.dart';

@RoutePage()
class SecurityThreatNewRequestScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const SecurityThreatNewRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<SecurityThreatNewRequestScreen> createState() =>
      _SecurityThreatNewRequestScreenState();
}

class _SecurityThreatNewRequestScreenState
    extends ConsumerState<SecurityThreatNewRequestScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);

    return KScaffold(
      backgroundColor: Colors.white,
      body: ProviderScope(
        overrides: [
          dynamicFormProvider.overrideWith((ref) => DynamicFormNotifier(ref)),
        ],
        child: DynamicForm(
          title: l10n.newRequest,
          stepTitles: const [''],
          steps: [controller.buildSecurityThreatRequestFields(l10n)],
          onSubmit: (values) async {
            final success = await controller.submitSecurityThreatRequest(
              widget.serviceId,
              widget.subServiceId,
              values,
            );

            if (context.mounted) {
              // Future.delayed(const Duration(seconds: 1), () {
              KAppX.router.pop();
              // });
            }
          },
        ),
      ),
    );
  }
}
