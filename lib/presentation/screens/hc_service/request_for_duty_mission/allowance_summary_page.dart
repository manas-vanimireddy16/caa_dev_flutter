part of 'view.dart';

class AllowanceSectionWidget extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;

  const AllowanceSectionWidget({
    super.key,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<AllowanceSectionWidget> createState() =>
      _AllowanceSectionWidgetState();
}

class _AllowanceSectionWidgetState
    extends ConsumerState<AllowanceSectionWidget> {
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

    final int missionDays =
        int.tryParse(formState.values['missionDays']?.toString() ?? '0') ?? 0;

    final int maxEmployees =
        int.tryParse(formState.values['noOfEmployees']?.toString() ?? '0') ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),

        /// -------- HEADER ----------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Allowance Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.green),
              onPressed: state.entries.length >= maxEmployees
                  ? null
                  : () => controller.openAddForm(),
            ),
          ],
        ),

        /// -------- FORM ----------
        if (state.showForm)
          AllowanceForm(
            key: ValueKey(state.formVersion),
            service: widget.service,
            subService: widget.subService,
            users: state.usersList,

            /// 👇 PASS INITIAL VALUES ONLY FOR EDIT
            initialValues: state.formMode == AllowanceFormMode.edit
                ? {...state.editingEntry!.values, 'missionDays': missionDays}
                : {'missionDays': missionDays},

            maxEmployees: maxEmployees,
            onSubmit: controller.saveEntry,
            onCancel: controller.closeForm,
          ),

        /// -------- CARDS ----------
        ...state.entries.map(
          (entry) => AllowanceCard(
            entry: entry,
            isExpanded: state.expandedId == entry.id,
            onTap: () => controller.toggleExpand(entry.id),
            onEdit: () => controller.openEditForm(entry: entry),
            onDelete: () => controller.deleteEntry(entry.id),
          ),
        ),

        /// -------- NET AMOUNT ----------
        if (state.entries.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Net Amount: ${controller.netAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}
