part of '../view.dart';

class AssignEngineerDialog extends ConsumerStatefulWidget {
  final int requestId;
  final int approverId;
  final Service service;
  final SubService subService;

  const AssignEngineerDialog({
    super.key,
    required this.requestId,
    required this.approverId,
    required this.service,
    required this.subService,
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
    // Optional: trigger fetch if not already done
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(_vsProvider(_providerArgs).notifier).fetchEngineersList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final state = ref.watch(_vsProvider(_providerArgs));

    final searchController = TextEditingController();

    List<EmployeeSummary> filteredEngineers = List.from(state.employeeList);

    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),

          child: Container(
            width: 700,

            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              children: [
                /// HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),

                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Assign Engineer",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              "${filteredEngineers.length} Engineers Available",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      InkWell(
                        borderRadius: BorderRadius.circular(30),

                        onTap: () {
                          Navigator.of(context).pop();
                        },

                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                /// BODY
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),

                    child: Column(
                      children: [
                        /// SEARCH
                        TextField(
                          controller: searchController,

                          onChanged: (value) {
                            setState(() {
                              filteredEngineers = state.employeeList.where((e) {
                                final name =
                                    e.employeeName?.toLowerCase() ?? '';

                                return name.contains(value.toLowerCase());
                              }).toList();
                            });
                          },

                          decoration: InputDecoration(
                            hintText: "Search by Engineer Name",

                            prefixIcon: const Icon(Icons.search),

                            filled: true,
                            fillColor: Colors.grey.shade50,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),

                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),

                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// TABLE HEADER
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "ENGINEER NAME",

                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,

                                    color: Colors.grey,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 80,

                                child: Text(
                                  "TASKS",

                                  textAlign: TextAlign.center,

                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,

                                    color: Colors.grey,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// ENGINEERS LIST
                        Expanded(
                          child: filteredEngineers.isEmpty
                              ? const Center(child: Text("No engineers found"))
                              : ListView.separated(
                                  itemCount: filteredEngineers.length,

                                  separatorBuilder: (_, __) =>
                                      const Divider(height: 1),

                                  itemBuilder: (context, index) {
                                    final eng = filteredEngineers[index];

                                    return InkWell(
                                      borderRadius: BorderRadius.circular(12),

                                      onTap: () async {
                                        await controller.assignEngineer(
                                          engineerUserId: eng.userId ?? 0,

                                          approverId: widget.approverId,
                                        );

                                        if (mounted) {
                                          KAppX.router.pop();
                                        }
                                      },

                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 18,
                                        ),

                                        child: Row(
                                          children: [
                                            /// NAME + EMAIL
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,

                                                children: [
                                                  Text(
                                                    eng.employeeName ?? '',

                                                    style: const TextStyle(
                                                      fontSize: 16,

                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),

                                                  const SizedBox(height: 4),

                                                  Text(
                                                    eng.email ?? '-',

                                                    style: TextStyle(
                                                      fontSize: 13,

                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            /// TASK COUNT
                                            SizedBox(
                                              width: 80,

                                              child: Text(
                                                '${eng.inProgressCount ?? 0}',

                                                textAlign: TextAlign.center,

                                                style: const TextStyle(
                                                  fontSize: 16,

                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
