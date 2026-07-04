part of '../view.dart';

@RoutePage()
class RequestforTrainingRoomBookingRequestScreen
    extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const RequestforTrainingRoomBookingRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<RequestforTrainingRoomBookingRequestScreen> createState() =>
      _RequestforTrainingRoomBookingRequestScreenState();
}

class _RequestforTrainingRoomBookingRequestScreenState
    extends ConsumerState<RequestforTrainingRoomBookingRequestScreen> {
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
      ref.read(_vsProvider(_providerArgs).notifier).clearAttendeeNames();
    });
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
          title: l10n.isArabic
              ? (widget.subService.arabicsubServiceName ??
                    widget.subService.subServiceName ??
                    '')
              : (widget.subService.subServiceName ?? ''),
          stepTitles: const [''],
          steps: [controller.buildTrainingRoomBookingForm(l10n)],
          enableSubmitWhen: (values) {
            final count =
                int.tryParse(values['numberOfAttendees']?.toString() ?? '0') ??
                0;

            if (count <= 0) return false;

            final sig = values['_training_attendees_sig']?.toString() ?? '';
            if (sig.isEmpty) return false;

            final names = sig
                .split('\x1e')
                .map((name) => name.trim())
                .where((name) => name.isNotEmpty)
                .toList();

            if (names.length != count) return false;

            for (final name in names) {
              if (name.length <= 2) return false;
            }

            return true;
          },
          onSubmit: (values) async {
            await controller.submitRequestForCoverageRequest(
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
