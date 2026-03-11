part of '../view.dart';

class VPNRemarksSend extends ConsumerWidget {
  final String from;
  final String? title;
  final String? subtitle;
  final List<VPNApprovalDetail> approvals;
  final int id;

  const VPNRemarksSend({
    super.key,
    this.from = '',
    this.title,
    this.subtitle,
    required this.id,
    required this.approvals,
  });

  // ✔ Your role detection with role + id
  bool _shouldShowAssignButtons(
    List<VPNApprovalDetail> approvals,
    Map<String, dynamic> outRole,
  ) {
    final rolesData = KAppX.globalProvider.read(rolesProvider);
    final userData = KAppX.globalProvider.read(userInfoProvider);

    if (rolesData == null) return false;

    final userId = userData?.data?.id ?? 0;
    final roleDetail = rolesData.roleName;
    final roleDetails = [].add(roleDetail);

    for (final approval in approvals) {
      if (approval.approvalStatus?.toLowerCase() == 'in progress') {
        final roleId = rolesData.roleId;

        if (approval.approverUserId == userId &&
            approval.approverRoleId == roleId &&
            approval.isManager == true) {
          outRole['role'] = approval.approverRole?.name ?? '';
          outRole['id'] = approval.id ?? 0;
          outRole['requestId'] = approval.requestId ?? 0;

          return true;
        }
      }
    }
    return false;
  }

  bool _shouldShowApprovalButtons(
    List<VPNApprovalDetail> approvals,
    Map<String, dynamic> outRole,
  ) {
    final rolesData = KAppX.globalProvider.read(rolesProvider);
    final userData = KAppX.globalProvider.read(userInfoProvider);
    if (rolesData == null) return false;

    final userId = userData?.data?.id ?? 0;
    ;

    for (final approval in approvals) {
      if (approval.approvalStatus?.toLowerCase() == 'assigned') {
        final roleId = rolesData.roleId;

        if (approval.approverUserId == userId &&
            approval.approverRoleId == roleId &&
            approval.isManager == true) {
          outRole['role'] = approval.approverRole?.name ?? '';
          outRole['id'] = approval.id ?? 0;
          outRole['requestId'] = approval.requestId ?? 0;

          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final state = ref.watch(_vsProvider);
    final controller = ref.read(_vsProvider.notifier);
    final roleData = KAppX.globalProvider.read(rolesProvider);

    // Capture roleName + roleId
    final roleHolder = {'role': '', 'id': 0, 'requestId': 0};
    final assignShowButtons = _shouldShowAssignButtons(approvals, roleHolder);
    final approveShowButtons = _shouldShowApprovalButtons(
      approvals,
      roleHolder,
    );

    final approvalRole = roleHolder['role'].toString();
    final int approvalId = (roleHolder['id'] ?? 0) as int;
    final int requestId = (roleHolder['requestId'] ?? 0) as int;

    final isChatNotEmpty = controller.chatController.text.trim().isNotEmpty;
    final hasAttachment = (state.attachments.isNotEmpty);

    final isSendEnabled = isChatNotEmpty || hasAttachment;
    final isAttachmentEnable = !isChatNotEmpty && !hasAttachment;
    final isChatEnabled = !hasAttachment;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title!,
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s14,
                  fontWeight: currentTheme.fontWeights.wBold,
                ),
              ),

            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
                child: Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: currentTheme.fontSizes.s13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

            // CHAT + ATTACH + SEND
            Row(
              children: [
                IconButton(
                  onPressed: isAttachmentEnable
                      ? () async {
                          await controller.pickFile();
                        }
                      : null,
                  icon: const Icon(Icons.attach_file),
                  color: isAttachmentEnable
                      ? Colors.blueGrey
                      : Colors.grey.shade400,
                ),

                Expanded(
                  child: KTextField(
                    controller: controller.chatController,
                    enabled: isChatEnabled,
                    hintText: 'Add your comments',

                    // onChanged: (_) => controller.refreshUI(),
                  ),
                ),

                const SizedBox(width: 8),

                ElevatedButton.icon(
                  onPressed: isSendEnabled
                      ? () {
                          if (isChatEnabled) {
                            controller.sendChat(id, requestId);
                          } else {
                            controller.sendAttachment(requestId, id);
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSendEnabled
                        ? Colors.blue
                        : Colors.grey.shade400,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                  ),
                  icon: const Icon(Icons.send, color: Colors.white),
                  label: const Text("Send"),
                ),
              ],
            ),

            if (hasAttachment)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.insert_drive_file, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          state.attachments.first["file_name"] ?? "Attachment",
                          style: const TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.removeFile(state.attachments!.first);
                        },
                        icon: const Icon(Icons.close, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 12),

            // APPROVE / REJECT BUTTONS
            if (assignShowButtons)
              Row(
                children: [
                  // -------- ASSIGN BUTTON ----------
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        // STEP 1 — Get dept & section
                        final ids = controller.getDeptAndSectionIfHeadOfSection(
                          roleData,
                          approvalRole,
                        );

                        final deptId = ids['departmentId'] ?? 0;
                        final sectionId = ids['sectionId'] ?? 0;

                        // STEP 2 — Fetch technicians
                        await controller.fetchTechnicianDetails(
                          deptId,
                          sectionId,
                        );

                        // STEP 3 — Read updated data
                        var techList =
                            ref.read(_vsProvider).technicianDetails.data ?? [];

                        // STEP 4 — Small wait if rebuild not done yet
                        if (techList.isEmpty) {
                          await Future.delayed(
                            const Duration(milliseconds: 50),
                          );
                          techList =
                              ref.read(_vsProvider).technicianDetails.data ??
                              [];
                        }

                        if (techList.isEmpty) {
                          print("No technicians found.");
                          return;
                        }

                        // STEP 5 — Show dialog with full data + id
                        KAppX.extendedRouter.dialog.showKDialog(
                          builder: (context) => AssignRequestWidget(
                            id: approvalId,
                            data: techList,
                          ),
                        );
                      },
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      label: const Text("Assign"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // -------- REJECT BUTTON ----------
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await controller.assignorApproveReject(
                          approvalId,
                          requestId,
                          'Rejected',
                        );
                      },
                      icon: const Icon(Icons.cancel, color: Colors.white),
                      label: const Text("Reject"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            if (approveShowButtons)
              Row(
                children: [
                  // -------- ASSIGN BUTTON ----------
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await controller.assignorApproveReject(
                          approvalId,
                          requestId,
                          'Approved',
                        );
                      },
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      label: const Text("Clear"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // -------- REJECT BUTTON ----------
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await controller.assignorApproveReject(
                          approvalId,
                          requestId,
                          'Rejected',
                        );
                      },
                      icon: const Icon(Icons.cancel, color: Colors.white),
                      label: const Text("Reject"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
