part of '../view.dart';

@RoutePage()
class RequestforCoverageRequestScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const RequestforCoverageRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<RequestforCoverageRequestScreen> createState() =>
      _RequestforCoverageRequestScreenState();
}

class _RequestforCoverageRequestScreenState
    extends ConsumerState<RequestforCoverageRequestScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    /// ✅ Create provider params ONCE
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_vsProvider(_providerArgs).notifier).fetchDepartments();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Watch state only if needed
    final controller = ref.read(_vsProvider(_providerArgs).notifier);

    return KScaffold(
      backgroundColor: Colors.white,
      // appBar: KAppBar(title: Text('Mission Transfer Request')),

      /// ✅ DynamicForm MUST be root-level in a screen
      body: ProviderScope(
        overrides: [
          dynamicFormProvider.overrideWith((ref) => DynamicFormNotifier(ref)),
        ],
        child: DynamicForm(
          title: 'New Request',
          stepTitles: const [''],
          steps: [controller.requestMediaCoverageFields],

          onSubmit: (values) async {
            final success = await controller.submitRequestForCoverageRequest(
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
    );
  }
}
