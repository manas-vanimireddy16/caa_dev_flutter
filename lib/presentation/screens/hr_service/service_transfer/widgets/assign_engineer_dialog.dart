part of '../view.dart';

class AssignEngineerDialog extends ConsumerStatefulWidget {
  final int requestId;
  final int approverRoleId;
  final Service service;
  final SubService subService;

  const AssignEngineerDialog({
    super.key,
    required this.requestId,
    required this.approverRoleId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<AssignEngineerDialog> createState() =>
      _AssignEngineerDialogState();
}

class _AssignEngineerDialogState extends ConsumerState<AssignEngineerDialog> {
  late final ({Service service, SubService subService}) _providerArgs;

  @override
  void initState() {
    super.initState();
    _providerArgs = (service: widget.service, subService: widget.subService);

    // Optional: trigger fetch if not already done
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(_vsProvider(_providerArgs).notifier).fetchEngineersList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final state = ref.watch(_vsProvider(_providerArgs));

    final engineers = state.employeeList;

    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      child: SizedBox(
        width: 420,
        height: 520,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ───────── HEADER WITH CLOSE BUTTON ─────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Assign to Engineer",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: "Close",
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),

              const Divider(height: 20),

              // ───────── BODY ─────────
              if (engineers.isEmpty)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: engineers.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, index) {
                      final eng = engineers[index];

                      return ListTile(
                        title: Text(
                          eng.employeeName ?? '',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(eng.email ?? '-'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () async {
                          await controller.assignEngineer(
                            engineerUserId: eng.userId ?? 0,
                            approverRoleId: widget.approverRoleId,
                          );

                          if (mounted) {
                            KAppX.router.pop();
                          }
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
