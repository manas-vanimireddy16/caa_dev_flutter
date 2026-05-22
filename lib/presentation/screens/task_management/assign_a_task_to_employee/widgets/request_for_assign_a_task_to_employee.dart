part of '../view.dart';

@RoutePage()
class AssignaTasktoEmployeeDetailsRequestScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const AssignaTasktoEmployeeDetailsRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<AssignaTasktoEmployeeDetailsRequestScreen> createState() =>
      _AssignaTasktoEmployeeDetailsRequestScreenState();
}

class _AssignaTasktoEmployeeDetailsRequestScreenState
    extends ConsumerState<AssignaTasktoEmployeeDetailsRequestScreen> {
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
    /// Watch state only if needed
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);

    return KScaffold(
      backgroundColor: Colors.white,
      // appBar: KAppBar(title: Text('Mission Transfer Request')),

      /// ✅ DynamicForm MUST be root-level in a screen
      body: ProviderScope(
        overrides: [
          dynamicFormProvider.overrideWith((ref) => DynamicFormNotifier(ref)),
        ],
        child: DynamicForm(
          title: l10n.assignTaskToEmployeeNewRequest,
          stepTitles: [l10n.assignTaskFormStepDetails],
          steps: [controller.buildAssignTaskFields(l10n)],

          onSubmit: (values) async {
            await controller.submitAssignaTasktoEmployeeRequest(
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
