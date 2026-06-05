part of '../view.dart';

class AssignUser extends ConsumerStatefulWidget {
  const AssignUser({
    super.key,
    required this.service,
    required this.subService,
    required this.onSuccess,
  });

  final Service service;
  final SubService subService;
  final VoidCallback onSuccess;

  @override
  ConsumerState<AssignUser> createState() => _AssignUserState();
}

class _AssignUserState extends ConsumerState<AssignUser> {
  late _VSControllerParams _providerArgs;

  /// LOCAL STATE
  int? selectedDepartmentId;
  int? selectedRoleId;
  int? selectedUserId;

  @override
  void initState() {
    super.initState();
    selectedDepartmentId = null;
    selectedRoleId = null;
    selectedUserId = null;

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    Future.microtask(() async {
      final controller = ref.read(_vsProvider(_providerArgs).notifier);

      final userInfo = KAppX.globalProvider.read(userInfoProvider);
      await controller.resetAllocateDialog();

      /// LOGGED IN USER IDS
      final departmentId =
          int.tryParse(userInfo?.data?.department?.id ?? '') ?? 0;

      final sectionId = int.tryParse(userInfo?.data?.section?.id ?? '') ?? 0;

      /// RESET
      await controller.resetAllocateDialog();

      /// FETCH SECTIONS
      // await controller.fetchSections(departmentId);

      final updatedState = ref.read(_vsProvider(_providerArgs));

      /// CHECK IF USER SECTION EXISTS
      // final isSectionExists = updatedState.sections.any(
      //   (e) => e.id == sectionId,
      // );

      // /// AUTO SELECT USER SECTION
      // if (isSectionExists) {
      //   await controller.onSectionChanged(sectionId);
      // }
      // /// FALLBACK FIRST SECTION
      // else if (updatedState.sections.isNotEmpty) {
      //   await controller.onSectionChanged(updatedState.sections.first.id ?? 0);
      // }
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
              /// DEPARTMENT
              SizedBox(
                width: 280,
                child: DropdownButtonFormField<int>(
                  value:
                      state.departments.any((e) => e.id == selectedDepartmentId)
                      ? selectedDepartmentId
                      : null,
                  isExpanded: true,

                  decoration: InputDecoration(
                    labelText: "Department",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),

                  items: state.departments.map((e) {
                    return DropdownMenuItem<int>(
                      value: e.id,
                      child: Text(
                        e.departmentName ?? '',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),

                  onChanged: (value) async {
                    if (value != null) {
                      setState(() {
                        selectedDepartmentId = value;

                        /// CLEAR DEPENDENT VALUES
                        selectedRoleId = null;
                        selectedUserId = null;
                      });

                      /// RESET SECTION + FETCH NEW SECTIONS
                      controller.clearSelectedSection();
                      await controller.fetchSections(value);
                    }
                  },
                ),
              ),

              /// SECTION
              SizedBox(
                width: 280,
                child: DropdownButtonFormField<int>(
                  value:
                      state.sections.any((e) => e.id == state.selectedSectionId)
                      ? state.selectedSectionId
                      : null,
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

                      await controller.onSectionChanged(
                        sectionId: value,
                        departmentId: selectedDepartmentId ?? 0,
                      );
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

                  items: roles.map((RoleItem e) {
                    return DropdownMenuItem<int>(
                      value: e.roleId,
                      child: Text(
                        e.roleName ?? '',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),

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
                              departmentId: selectedDepartmentId ?? 0,
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
                          selectedDepartmentId ?? 0,
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
