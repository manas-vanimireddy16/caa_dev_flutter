part of '../view.dart';

@RoutePage()
class ResidentalUnitRentalNewRequestScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const ResidentalUnitRentalNewRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<ResidentalUnitRentalNewRequestScreen> createState() =>
      _ResidentalUnitRentalNewRequestScreenState();
}

class _ResidentalUnitRentalNewRequestScreenState
    extends ConsumerState<ResidentalUnitRentalNewRequestScreen> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    /// ✅ Create provider params ONCE
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
    Future.microtask(() {
      ref.read(_vsProvider(_providerArgs).notifier).fetchUsers();
    });
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
          title: 'Performance Management',
          stepTitles: const ['step 1', 'step 2'],
          steps: [
            controller.requestForAccommodationFormStep1,
            controller.requestforAccommodationFormStep2,
          ],

          /// ⭐ VERY IMPORTANT
          // enableSubmitWhen: (values) {
          //   return state.hrTasks.isNotEmpty;
          // },
          onSubmit: (values) async {
            await controller.submitPerformanceManagementRequest(
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
