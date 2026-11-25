part of '../view.dart';

@RoutePage()
class RequestforDutyMissionRequestScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;
  final bool isEditMode;
  final int? requestId;

  const RequestforDutyMissionRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
    this.isEditMode = false,
    this.requestId,
  });

  @override
  ConsumerState<RequestforDutyMissionRequestScreen> createState() =>
      _RequestforDutyMissionRequestScreenState();
}

class _RequestforDutyMissionRequestScreenState
    extends ConsumerState<RequestforDutyMissionRequestScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
      isEditMode: widget.isEditMode,
      requestId: widget.requestId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final state = ref.watch(_vsProvider(_providerArgs));

    if (widget.isEditMode &&
        (state.isLoading ||
            state.formInitialValues == null ||
            state.formInitialValues!.isEmpty)) {
      return const KScaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return KScaffold(
      backgroundColor: Colors.white,
      body: ProviderScope(
        overrides: [
          dynamicFormProvider.overrideWith((ref) => DynamicFormNotifier(ref)),
        ],
        child: DynamicForm(
          key: ValueKey(
            widget.isEditMode
                ? 'edit-${widget.requestId}-${state.formInitialValues!.length}'
                : 'create',
          ),
          title: widget.isEditMode
              ? 'Edit Annual Duty Mission Plan'
              : 'Annual Duty Mission Plan',
          stepTitles: widget.isEditMode
              ? const ['1']
              : const ['1', '2', '3', '4'],
          steps: widget.isEditMode
              ? [controller.plannedForm1]
              : [
                  controller.plannedForm1,
                  controller.step2Fields(_providerArgs),
                  controller.travelDetailsForm,
                  controller.step4Fields(_providerArgs),
                ],
          apiValues: widget.isEditMode ? state.formInitialValues : null,
          onSubmit: (values) async {
            await controller.submitAnnualBulkRequest(
              serviceId: widget.serviceId,
              subServiceId: widget.subServiceId,
              values: values,
            );
          },
        ),
      ),
    );
  }
}
