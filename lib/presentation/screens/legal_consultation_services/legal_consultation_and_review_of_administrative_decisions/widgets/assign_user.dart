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

  int? selectedDepartmentId;
  int? selectedSectionId;
  int? selectedRoleId;
  int? selectedUserId;

  @override
  void initState() {
    super.initState();
    selectedDepartmentId = null;
    selectedSectionId = null;
    selectedRoleId = null;
    selectedUserId = null;

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    Future.microtask(() async {
      final controller = ref.read(_vsProvider(_providerArgs).notifier);
      await controller.resetAllocateDialog();
    });
  }

  @override
  void dispose() {
    debugPrint('AssignUser disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);

    final state = ref.watch(_vsProvider(_providerArgs));
    final l10n = DashboardL10n.of(context);
    final isArabic = l10n.isArabic;

    final roles = state.rolesData?.data?.roles ?? [];
    final users = state.usersData?.data?.users ?? [];
    final isSubmitting = state.isActionSubmitting;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: 280,
                  child: DropdownButtonFormField<int>(
                    value:
                        state.departments.any((e) => e.id == selectedDepartmentId)
                        ? selectedDepartmentId
                        : null,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: l10n.department,
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
                          e.displayName(isArabic: isArabic),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) async {
                      if (value != null) {
                        setState(() {
                          selectedDepartmentId = value;
                          selectedSectionId = null;
                          selectedRoleId = null;
                          selectedUserId = null;
                        });

                        controller.clearSelectedSection();
                        await controller.fetchSections(value);
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 280,
                  child: DropdownButtonFormField<int>(
                    value:
                        state.sections.any((e) => e.id == selectedSectionId)
                        ? selectedSectionId
                        : null,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: l10n.sections,
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
                          e.displayName(isArabic: isArabic),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) async {
                      if (value != null) {
                        setState(() {
                          selectedSectionId = value;
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
                SizedBox(
                  width: 280,
                  child: DropdownButtonFormField<int>(
                    value: selectedRoleId,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: l10n.profileRoleLabel,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                    hint: Text(l10n.selectRole),
                    items: roles.map((RoleItem e) {
                      return DropdownMenuItem<int>(
                        value: e.roleId,
                        child: Text(
                          e.displayName(isArabic: isArabic),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: roles.isEmpty
                        ? null
                        : (value) async {
                            setState(() {
                              selectedRoleId = value;
                              selectedUserId = null;
                            });

                            if (value != null) {
                              await controller.fetchUsers(
                                sectionId: selectedSectionId ?? 0,
                                departmentId: selectedDepartmentId ?? 0,
                                roleId: value,
                              );
                            }
                          },
                  ),
                ),
                SizedBox(
                  width: 280,
                  child: DropdownButtonFormField<int>(
                    value: selectedUserId,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: l10n.userLabel,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                    hint: Text(l10n.selectUser),
                    items: users.map((e) {
                      return DropdownMenuItem<int>(
                        value: e.userId,
                        child: Text(
                          e.displayName(isArabic: isArabic),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: isSubmitting ? null : () => KAppX.router.pop(),
                  child: Text(l10n.cancelButton),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: selectedUserId == null || isSubmitting
                      ? null
                      : () async {
                          await controller.onAssign(
                            selectedRoleId ?? 0,
                            selectedSectionId ?? 0,
                            selectedUserId ?? 0,
                            selectedDepartmentId ?? 0,
                          );
                        },
                  child: isSubmitting
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.dynamicFormSubmit),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
