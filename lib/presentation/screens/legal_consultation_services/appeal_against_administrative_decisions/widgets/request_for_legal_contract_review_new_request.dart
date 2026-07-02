part of '../view.dart';

@RoutePage()
class AppealAgainstAdministrativeDecisionsNewRequestScreen
    extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const AppealAgainstAdministrativeDecisionsNewRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<AppealAgainstAdministrativeDecisionsNewRequestScreen>
  createState() => _AppealAgainstAdministrativeDecisionsNewRequestScreenState();
}

class _AppealAgainstAdministrativeDecisionsNewRequestScreenState
    extends
        ConsumerState<AppealAgainstAdministrativeDecisionsNewRequestScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    /// ✅ Create provider params ONCE
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
    // Future.microtask(() {
    //   ref.read(_vsProvider(_providerArgs).notifier).initialize();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);

    return KScaffold(
      backgroundColor: Colors.white,

      /// ✅ DynamicForm MUST be root-level in a screen
      body: ProviderScope(
        overrides: [
          dynamicFormProvider.overrideWith((ref) => DynamicFormNotifier(ref)),
        ],
        child: DynamicForm(
          title: l10n.appealAgainstAdministrativeDecisionsTitle,
          stepTitles: [
            l10n.appealAgainstAdministrativeDecisionsTitle,
            l10n.appealStepDecisionBeingGrieved,
            l10n.appealStepGrievantInformation,
          ],
          steps: [
            controller.buildAppealStepOneFields(l10n),
            controller.buildAppealStepTwoFields(l10n),
            controller.buildAppealStepThreeFields(l10n),
          ],

          /// ⭐ VERY IMPORTANT
          // enableSubmitWhen: (values) {
          //   return state.hrTasks.isNotEmpty;
          // },
          onSubmit: (values) async {
            await controller.submitAppealAgainstAdministrativeDecisionsRequest(
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
