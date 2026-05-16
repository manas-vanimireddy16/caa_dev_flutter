part of '../view.dart';

@RoutePage()
class LogisticsPassengersVehicleRequestScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const LogisticsPassengersVehicleRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<LogisticsPassengersVehicleRequestScreen> createState() =>
      _LogisticsPassengersVehicleRequestScreenState();
}

class _LogisticsPassengersVehicleRequestScreenState
    extends ConsumerState<LogisticsPassengersVehicleRequestScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(_vsProvider(_providerArgs).notifier).clearPassengerNames();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final isSubmitting = ref.watch(
      _vsProvider(_providerArgs).select((s) => s.isLoading),
    );
    final l10n = DashboardL10n.of(context);

    return KScaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [
          ProviderScope(
            overrides: [
              dynamicFormProvider.overrideWith(
                (ref) => DynamicFormNotifier(ref),
              ),
            ],
            child: DynamicForm(
              title: l10n.transportForeignEmployeeNewRequest,
              stepTitles: [
                l10n.transportFormStepPassengers,
                l10n.transportFormStepTripDetails,
              ],
              steps: [
                controller.buildTransportationRequestFields2(l10n),
                controller.buildTransportationRequestFields(l10n),
              ],
              canProceedFromStep: (ref, step, values) {
                if (step != 0) return true;

                ref.watch(
                  _vsProvider(_providerArgs).select((s) => s.passengerNames),
                );

                final count = int.tryParse(
                      values['no_of_passengers']?.toString() ?? '0',
                    ) ??
                    0;
                if (count <= 0) return false;

                final contact =
                    values['contact_number']?.toString().trim() ?? '';
                if (contact.length != 8) return false;

                final vsState = ref.read(_vsProvider(_providerArgs));
                final names = vsState.passengerNames;
                if (names.length != count) return false;

                for (final n in names) {
                  final trimmed = n.trim();
                  if (trimmed.isEmpty || trimmed.length <= 2) return false;
                }
                return true;
              },
              onSubmit: (values) async {
                final success = await controller.submitProjectApprovalRequest(
                  widget.serviceId,
                  widget.subServiceId,
                  values,
                );

                if (context.mounted && success) {
                  context.router.pop();
                }
              },
            ),
          ),
          if (isSubmitting)
            Container(
              color: Colors.black.withOpacity(0.25),
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(l10n.submittingRequest),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
