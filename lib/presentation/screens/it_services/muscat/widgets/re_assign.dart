part of '../view.dart';

class ReAssignUser extends ConsumerStatefulWidget {
  const ReAssignUser({
    super.key,
    required this.service,
    required this.subService,
    required this.onSuccess,
  });

  final Service service;
  final SubService subService;
  final VoidCallback onSuccess;

  @override
  ConsumerState<ReAssignUser> createState() => _ReAssignUserState();
}

class _ReAssignUserState extends ConsumerState<ReAssignUser> {
  late _VSControllerParams _providerArgs;

  /// LOCAL STATE
  int? selectedRoleId;
  int? selectedUserId;

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    Future.microtask(() async {
      final controller = ref.read(_vsProvider(_providerArgs).notifier);

      final userInfo = KAppX.globalProvider.read(userInfoProvider);

      /// LOGGED IN USER IDS
      final departmentId =
          int.tryParse(userInfo?.data?.department?.id ?? '') ?? 0;

      final sectionId = int.tryParse(userInfo?.data?.section?.id ?? '') ?? 0;

      /// RESET
      await controller.resetAllocateDialog();

      /// FETCH SECTIONS
      await controller.fetchSections(departmentId);

      final updatedState = ref.read(_vsProvider(_providerArgs));

      /// CHECK IF USER SECTION EXISTS
      final isSectionExists = updatedState.sections.any(
        (e) => e.id == sectionId,
      );

      /// AUTO SELECT USER SECTION
      if (isSectionExists) {
        await controller.onSectionChanged(sectionId);
      }
      /// FALLBACK FIRST SECTION
      else if (updatedState.sections.isNotEmpty) {
        await controller.onSectionChanged(updatedState.sections.first.id ?? 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);

    final state = ref.watch(_vsProvider(_providerArgs));

    final userInfo = KAppX.globalProvider.read(userInfoProvider);

    final departmentName = userInfo?.data?.department?.departmentName ?? '';

    final roles = state.rolesData?.data?.roles ?? [];

    final users = state.usersData?.data?.users ?? [];

    return SingleChildScrollView(
      child: Column(
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              /// DEPARTMENT
              SizedBox(
                width: 280,
                child: TextFormField(
                  enabled: false,
                  initialValue: departmentName,
                  decoration: InputDecoration(
                    labelText: "Department",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                ),
              ),

              /// SECTION
              SizedBox(
                width: 280,
                child: DropdownButtonFormField<int>(
                  value: state.selectedSectionId,

                  isExpanded: true,

                  decoration: InputDecoration(
                    labelText: "Sections",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),

                  items: state.sections.map((e) {
                    return DropdownMenuItem<int>(
                      value: e.id,
                      child: Text(
                        e.sectionName ?? '',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),

                  onChanged: (value) async {
                    if (value != null) {
                      /// CLEAR LOCAL VALUES
                      setState(() {
                        selectedRoleId = null;
                        selectedUserId = null;
                      });

                      await controller.onSectionChanged(value);
                    }
                  },
                ),
              ),

              /// ROLE
              SizedBox(
                width: 280,
                child: DropdownButtonFormField<int>(
                  value: selectedRoleId,
                  isExpanded: true,

                  decoration: InputDecoration(
                    labelText: "Role",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),

                  hint: const Text("Select Role"),

                  items: roles
                      .where((e) => (e.roleId == 2) || (e.roleId == 9))
                      .map((RoleItem e) {
                        return DropdownMenuItem<int>(
                          value: e.roleId,
                          child: Text(
                            e.roleName ?? '',
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      })
                      .toList(),

                  onChanged: roles.isEmpty
                      ? null
                      : (value) async {
                          setState(() {
                            selectedRoleId = value;

                            /// CLEAR USER
                            selectedUserId = null;
                          });

                          if (value != null) {
                            await controller.fetchUsers(
                              sectionId: state.selectedSectionId ?? 0,
                              roleId: value,
                            );
                          }
                        },
                ),
              ),

              /// USER
              SizedBox(
                width: 280,
                child: DropdownButtonFormField<int>(
                  value: selectedUserId,
                  isExpanded: true,

                  decoration: InputDecoration(
                    labelText: "User",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),

                  hint: const Text("Select User"),

                  items: users.map((e) {
                    return DropdownMenuItem<int>(
                      value: e.userId,
                      child: Text(
                        e.employeeName ?? '',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),

                  onChanged: users.isEmpty
                      ? null
                      : (value) {
                          setState(() {
                            selectedUserId = value;
                          });
                        },
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          /// BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              OutlinedButton(
                onPressed: () {
                  KAppX.router.pop();
                },

                child: const Text("Cancel"),
              ),

              const SizedBox(width: 12),

              ElevatedButton(
                onPressed: selectedUserId == null
                    ? null
                    : () async {
                        controller.onAssign(
                          selectedRoleId ?? 0,
                          state.selectedSectionId ?? 0,
                          selectedUserId ?? 0,
                        );
                        print('SectionId: ${state.selectedSectionId}');

                        print('RoleId: $selectedRoleId');

                        print('UserId: $selectedUserId');

                        /// CALL SUBMIT API HERE

                        widget.onSuccess();

                        KAppX.router.pop();
                      },

                child: const Text("Submit"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
