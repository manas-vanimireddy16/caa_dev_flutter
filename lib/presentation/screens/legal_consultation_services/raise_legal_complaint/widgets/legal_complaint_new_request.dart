part of '../view.dart';

@RoutePage()
class RaiseLegalComplaintNewRequestScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const RaiseLegalComplaintNewRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<RaiseLegalComplaintNewRequestScreen> createState() =>
      _RaiseLegalComplaintNewRequestScreenState();
}

class _RaiseLegalComplaintNewRequestScreenState
    extends ConsumerState<RaiseLegalComplaintNewRequestScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(_vsProvider(_providerArgs).notifier);
      controller.fetchDepartments();
      controller.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);

    return Stack(
      children: [
        KScaffold(
          backgroundColor: Colors.white,
          body: ProviderScope(
            overrides: [
              dynamicFormProvider.overrideWith(
                (ref) => DynamicFormNotifier(ref),
              ),
            ],
            child: DynamicForm(
              title: l10n.raiseLegalComplaintTitle,
              stepTitles: [
                l10n.legalComplaintStepRequestDetails,
                l10n.legalComplaintStepComplaintIncident,
                // l10n.legalComplaintComplainantDetails,
                l10n.legalComplaintComplainedEmployeeDetails,
              ],
              steps: [
                controller.buildLegalComplaintStepOneFields(l10n),
                controller.buildLegalComplaintStepTwoFields(l10n),
                // controller.buildLegalComplaintStepThreeFields(l10n),
                controller.buildLegalComplaintStepFourFields(l10n),
              ],
              onSubmit: (values) async {
                await controller.submitRaiseLegalComplaintRequest(
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
        ),
        if (state.isLoading)
          const ColoredBox(
            color: Color(0x55000000),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
