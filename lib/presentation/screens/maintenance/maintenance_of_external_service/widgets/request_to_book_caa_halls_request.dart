part of '../view.dart';

@RoutePage()
class MaintenanceExternalServiceNewRequestScreen
    extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const MaintenanceExternalServiceNewRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<MaintenanceExternalServiceNewRequestScreen> createState() =>
      _MaintenanceExternalServiceNewRequestScreenState();
}

class _MaintenanceExternalServiceNewRequestScreenState
    extends ConsumerState<MaintenanceExternalServiceNewRequestScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    /// ✅ Create provider params ONCE
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);
    final formTitle = l10n.isArabic
        ? (widget.subService.arabicsubServiceName ??
              widget.subService.subServiceName ??
              l10n.createRequest)
        : (widget.subService.subServiceName ?? l10n.createRequest);

    return KScaffold(
      backgroundColor: Colors.white,

      /// ✅ DynamicForm MUST be root-level in a screen
      body: ProviderScope(
        overrides: [
          dynamicFormProvider.overrideWith((ref) => DynamicFormNotifier(ref)),
        ],
        child: DynamicForm(
          title: formTitle,
          stepTitles: const [''],
          steps: [controller.buildFollowUpReportFields(l10n)],

          /// ⭐ VERY IMPORTANT
          // enableSubmitWhen: (values) {
          //   return state.hrTasks.isNotEmpty;
          // },
          onSubmit: (values) async {
            await controller.submitProjectApprovalRequest(
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
