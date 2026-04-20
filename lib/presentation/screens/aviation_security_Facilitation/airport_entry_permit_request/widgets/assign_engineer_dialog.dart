part of '../view.dart';

class AssignEngineerDialog extends ConsumerStatefulWidget {
  final int requestId;
  final int approverRoleId;
  final Service service;
  final SubService subService;
  // final int? departmentId;
  // final int? sectionId;

  AssignEngineerDialog({
    super.key,
    required this.requestId,
    required this.approverRoleId,
    required this.service,
    required this.subService,
    // required this.departmentId,
    // required this.sectionId,
  });

  @override
  ConsumerState<AssignEngineerDialog> createState() =>
      _AssignEngineerDialogState();
}

class _AssignEngineerDialogState extends ConsumerState<AssignEngineerDialog> {
  late _VSControllerParams _providerArgs;
  @override
  void initState() {
    super.initState();
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
    // ref.read(_vsProvider.notifier).fetchEngineersList();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final state = ref.watch(_vsProvider(_providerArgs));

    final engineers = state.engineersList;

    return SizedBox(
      // width: 420,
      // height: 540,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Assign to Engineer",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            if (engineers.isEmpty)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: engineers.length,
                  itemBuilder: (_, index) {
                    final eng = engineers[index];

                    return ListTile(
                      title: Text(eng.employeeName ?? ''),
                      subtitle: Text(eng.email ?? "-"),
                      onTap: () async {
                        await controller.assignEngineer(
                          engineerUserId: eng.userId ?? 0,
                          approverRoleId: widget.approverRoleId,
                        );

                        KAppX.router.pop();
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
