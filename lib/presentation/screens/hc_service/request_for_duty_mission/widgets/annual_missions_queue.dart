part of '../view.dart';

class _AnnualMissionsQueueWidget extends ConsumerWidget {
  final Service service;
  final SubService subService;

  const _AnnualMissionsQueueWidget({
    required this.service,
    required this.subService,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerArgs = _VSControllerParams(
      service: service,
      subService: subService,
    );
    final controller = ref.read(_vsProvider(providerArgs).notifier);
    final missions = ref.watch(
      _vsProvider(providerArgs).select((s) => s.pendingAnnualMissions),
    );
    final form = ref.watch(dynamicFormProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (missions.isNotEmpty) ...[
          Text(
            'Added Missions (${missions.length})',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
          const SizedBox(height: 8),
          ...List.generate(missions.length, (index) {
            final m = missions[index];
            final purpose = m['mission_purpose']?.toString() ?? '';
            final month = m['month']?.toString() ?? '';
            final total = m['total']?.toString() ?? '';
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(
                  purpose.isEmpty ? 'Mission ${index + 1}' : purpose,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  [
                    if (month.isNotEmpty) 'Month: $month',
                    if (total.isNotEmpty) 'Total: $total',
                  ].join(' · '),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => controller.removePendingAnnualMission(index),
                ),
              ),
            );
          }),
        ],
        OutlinedButton.icon(
          onPressed: () {
            final values = Map<String, dynamic>.from(form.values);
            final ok = controller.addCurrentFormAsAnnualMission(values);
            if (!ok) {
              ShowFlutterToast().showFlutterToastFailure(
                'Fill required mission fields before adding another',
              );
              return;
            }
            // Clear mission-specific fields for the next block.
            final formNotifier = ref.read(dynamicFormProvider.notifier);
            for (final key in const [
              'month',
              'missionPurpose',
              'missionNumber',
              'missionStartDate',
              'missionEndDate',
              'missionDays',
              'noOfEmployees',
              'placeOfMission',
              'allowancePercentage',
              'allowanceFeesOmr',
              'ticketFee',
              'missionTotal',
              'notes',
            ]) {
              formNotifier.updateValue(key, null);
            }
            formNotifier.updateValue('missionTotal', '0.000');
          },
          icon: const Icon(Icons.add),
          label: Text(
            missions.length >= 49
                ? 'Maximum 50 missions'
                : 'Add Mission',
          ),
        ),
        if (missions.length >= 49)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'You can submit up to 50 missions.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
      ],
    );
  }
}
