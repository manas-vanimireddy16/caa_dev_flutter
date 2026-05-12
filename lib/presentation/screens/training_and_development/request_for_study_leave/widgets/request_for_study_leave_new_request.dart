part of '../view.dart';

@RoutePage()
class RequestForStudyLeaveNewRequestScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const RequestForStudyLeaveNewRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<RequestForStudyLeaveNewRequestScreen> createState() =>
      _RequestForStudyLeaveNewRequestScreenState();
}

class _RequestForStudyLeaveNewRequestScreenState
    extends ConsumerState<RequestForStudyLeaveNewRequestScreen> {
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
    /// Watch state only if needed
    final state = ref.watch(_vsProvider(_providerArgs));
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
          steps: [controller.requestStudyLeaveFields],

          /// ⭐ VERY IMPORTANT
          // enableSubmitWhen: (values) {
          //   return state.hrTasks.isNotEmpty;
          // },
          onSubmit: (values) async {
            await controller.submitStudyLeaveRequest(
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
