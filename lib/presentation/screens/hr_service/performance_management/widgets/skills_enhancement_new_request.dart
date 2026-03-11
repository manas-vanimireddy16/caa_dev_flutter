part of '../view.dart';

@RoutePage()
class PerformanceManagementNewRequestScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;

  const PerformanceManagementNewRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<PerformanceManagementNewRequestScreen> createState() =>
      _PerformanceManagementNewRequestScreenState();
}

class _PerformanceManagementNewRequestScreenState
    extends ConsumerState<PerformanceManagementNewRequestScreen> {
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
      ref.read(_vsProvider(_providerArgs).notifier).fetchbyCycleGoals();
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
          dynamicFormProvider.overrideWith((ref) => DynamicFormNotifier()),
        ],
        child: DynamicForm(
          title: 'Required New Resource Request',
          stepTitles: const [''],
          steps: [controller.skillsEnhancementForm],

          onSubmit: (values) async {
            await controller.submitSkillsEnhancementRequest(
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
