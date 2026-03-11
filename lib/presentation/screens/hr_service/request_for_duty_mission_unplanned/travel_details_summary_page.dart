part of 'view.dart';

class TravelDetailsSectionWidget extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;

  const TravelDetailsSectionWidget({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<TravelDetailsSectionWidget> createState() =>
      _TravelDetailsSectionWidgetState();
}

class _TravelDetailsSectionWidgetState
    extends ConsumerState<TravelDetailsSectionWidget> {
  late final _VSControllerParams providerArgs;

  @override
  void initState() {
    super.initState();

    providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(providerArgs));
    final controller = ref.read(_vsProvider(providerArgs).notifier);

    final formState = ref.watch(dynamicFormProvider);

    final String departureDate =
        formState.values['travelStartDate']?.toString() ?? '0';
    final String returnDate =
        formState.values['travelReturnDate']?.toString() ?? '0';
    final String missionId = formState.values['missionId']?.toString() ?? '0';

    return Column(
      children: [
        if (state.showForm)
          TravelDetailsForm(
            key: ValueKey(state.formVersion),
            initialValues: {
              'departureDate': departureDate,
              'returnDate': returnDate,
              'missionId': missionId,
            },
            onSubmit: controller.saveTravelDetailsEntry,
            onCancel: controller.closeForm,
          ),

        ...state.entries.map(
          (e) => TravelDetailsCard(
            entry: e,
            isExpanded: state.expandedId == e.id,
            onTap: () => controller.toggleExpand(e.id),
            onEdit: () => controller.openEditForm(entry: e),
          ),
        ),

        if (!controller.allCompleted)
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Please complete travel details for all employees',
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
