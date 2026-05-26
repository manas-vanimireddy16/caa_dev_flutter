// import 'package:code_setup/presentation/models/details_models.dart';
// import 'package:code_setup/utils/helper/helper.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';

// enum WorkflowStepStatus {
//   submitted,
//   approved,
//   pending,
//   validating,
//   sent,
//   inactive,
// }

// class RequestWorkflowTimeline extends StatelessWidget {
//   final RequestDetailData details;

//   const RequestWorkflowTimeline({super.key, required this.details});

//   // ------------------ MAP STATUS ------------------
//   WorkflowStepStatus mapStatus(String? s) {
//     if (s == null) return WorkflowStepStatus.inactive;

//     switch (s.toLowerCase()) {
//       case "completed":
//         return WorkflowStepStatus.approved;
//       case "pending":
//         return WorkflowStepStatus.pending;
//       default:
//         return WorkflowStepStatus.inactive;
//     }
//   }

//   // ------------------ MAP ACTOR ------------------
//   Map<String, String> getActor(int index) {
//     // STEP 0 → Created By
//     if (index == 0) {
//       final user = details.request?.createdByUser;

//       return {
//         "label": "Action Taken By:",
//         "name": user?.employeeName ?? "-",
//         "empId": user?.employeeId ?? "-",
//         "role": "Requester",
//         "department": user?.department?.departmentName ?? "",
//       };
//     }

//     // Approval Steps → map to approvalDetails list
//     final approvals = details.approvalDetails ?? [];

//     if (index - 1 < approvals.length) {
//       final ap = approvals[index - 1];
//       final user = ap.approverUser;

//       return {
//         "label": "Action Taken By:",
//         "name": user?.employeeName ?? "-",
//         "empId": user?.employeeId ?? "-",
//         "role": ap.approverRole?.name ?? "Approver",
//         "department": "",
//       };
//     }

//     // FALLBACK
//     return {
//       "label": "Action Taken By:",
//       "name": "-",
//       "empId": "-",
//       "role": "",
//       "department": "",
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     // -----------------------------------------
//     // FIX: SORT WORKFLOW ORDER
//     // -----------------------------------------
//     final workflows = [...(details.workflowDetails ?? [])];

//     workflows.sort((a, b) {
//       final da =
//           DateTime.tryParse(a.updatedAt ?? a.createdAt ?? "") ??
//           DateTime.fromMillisecondsSinceEpoch(0);

//       final db =
//           DateTime.tryParse(b.updatedAt ?? b.createdAt ?? "") ??
//           DateTime.fromMillisecondsSinceEpoch(0);

//       return da.compareTo(db);
//     });

//     return Card(
//       margin: const EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: const BorderSide(color: Color(0xFFE0E0E0)),
//       ),
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Request Workflow",
//               style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
//             ),
//             const Divider(height: 24),

//             // -----------------------------------------
//             // BUILD WORKFLOW STEPS
//             // -----------------------------------------
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: workflows.length,
//               itemBuilder: (context, index) {
//                 final wf = workflows[index];
//                 final status = mapStatus(wf.status);
//                 final actor = getActor(index);

//                 return _buildStep(
//                   index: index,
//                   total: workflows.length,
//                   status: status,
//                   title: index == 0
//                       ? "Request Submitted"
//                       : wf.content?.trim() ?? "Workflow Step",
//                   actor: actor["name"]!,
//                   empId: actor["empId"]!,
//                   role: actor["role"]!,
//                   label: actor["label"]!,
//                   department: actor["department"]!,
//                   date: formatDate(wf.createdAt),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ------------------------ UI STEP ------------------------
//   Widget _buildStep({
//     required int index,
//     required int total,
//     required WorkflowStepStatus status,
//     required String title,
//     required String date,
//     required String actor,
//     required String empId,
//     required String role,
//     required String label,
//     required String department,
//   }) {
//     final showLine = index < total - 1;

//     return IntrinsicHeight(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             children: [
//               _statusIndicator(status, index == 0),
//               if (showLine)
//                 Expanded(
//                   child: Container(width: 3, color: const Color(0xFFDFDFDF)),
//                 ),
//             ],
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 22),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // TITLE
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),

//                   if (index == 0 && department.isNotEmpty) ...[
//                     const SizedBox(height: 6),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF2F3FD),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         department,
//                         style: const TextStyle(
//                           color: Color(0xFF4C4F90),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],

//                   const SizedBox(height: 8),

//                   // ACTOR DETAILS
//                   Text(
//                     label,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     actor,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   if (role.isNotEmpty)
//                     Text(
//                       role,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         color: Color(0xFF4C4F90),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                   Text(
//                     "Employee ID: $empId",
//                     style: const TextStyle(fontSize: 13, color: Colors.black54),
//                   ),

//                   const SizedBox(height: 4),

//                   Text(
//                     date,
//                     style: const TextStyle(fontSize: 12, color: Colors.black54),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ------------------ STATUS ICON ------------------
//   Widget _statusIndicator(WorkflowStepStatus status, bool isFirst) {
//     Color color;
//     IconData icon;

//     if (isFirst) {
//       color = const Color(0xFF232B74);
//       icon = Icons.check;
//     } else {
//       switch (status) {
//         case WorkflowStepStatus.approved:
//           color = const Color(0xFF31B480);
//           icon = Icons.check;
//           break;
//         case WorkflowStepStatus.pending:
//           color = const Color(0xFFFFA713);
//           icon = Icons.access_time;
//           break;
//         default:
//           color = const Color(0xFFCCCCCC);
//           icon = Icons.circle;
//       }
//     }

//     return Container(
//       width: 34,
//       height: 34,
//       decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//       child: Icon(icon, color: Colors.white, size: 20),
//     );
//   }
// }

import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/utils/assets/icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// ---------------------------------------------------------------------------
/// STATUS ENUM
/// ---------------------------------------------------------------------------
enum WorkflowStepStatus {
  submitted,
  approved,
  pending,
  validating,
  sent,
  inactive,
  assigned,
  rejected,
}

/// ---------------------------------------------------------------------------
/// INTERNAL VIEW MODEL FOR ONE STEP
/// ---------------------------------------------------------------------------
class WorkflowStepView {
  final String title;
  final String? department;
  final String? actor;
  final String? empId;
  final String? role;
  final String? rawDate;
  final WorkflowStepStatus status;
  final bool isFirst;

  const WorkflowStepView({
    required this.title,
    required this.status,
    this.department,
    this.actor,
    this.empId,
    this.role,
    this.rawDate,
    this.isFirst = false,
  });
}

/// ---------------------------------------------------------------------------
/// MAIN WIDGET
/// ---------------------------------------------------------------------------
class ITServicesRequestWorkflowTimeline extends StatelessWidget {
  final RequestDetailData details;

  const ITServicesRequestWorkflowTimeline({super.key, required this.details});

  // ------------------ MAP STATUS ------------------
  WorkflowStepStatus mapStatus(String? s) {
    if (s == null) return WorkflowStepStatus.inactive;

    switch (s.toLowerCase()) {
      case "completed":
      case "approved":
        return WorkflowStepStatus.approved;
      case "pending":
      case "in progress":
        return WorkflowStepStatus.pending;
      case "submitted":
        return WorkflowStepStatus.submitted;
      case "validating":
        return WorkflowStepStatus.validating;
      case "sent":
        return WorkflowStepStatus.sent;
      default:
        return WorkflowStepStatus.inactive;
    }
  }

  // ------------------ FORMAT DATE ------------------
  String formatDateTime(String? dt) {
    if (dt == null || dt.isEmpty) return "-";
    try {
      final local = DateTime.parse(dt).toUtc().toLocal();
      return DateFormat("dd MMM yyyy, hh:mm a").format(local);
    } catch (_) {
      return "-";
    }
  }

  // ------------------ FIND APPROVAL ------------------
  ApprovalDetailModel? _findApprovalByUserId(int? userId) {
    if (userId == null) return null;

    for (final a in details.approvalDetails ?? []) {
      if (a.approverUserId == userId || a.approvedBy == userId) {
        return a;
      }
    }
    return null;
  }

  // ------------------ NORMALIZE MODELS ------------------
  UserModel? _mapApproverUserToUser(ApproverUserModel? u) {
    if (u == null) return null;

    return UserModel(
      id: u.id,
      employeeId: u.employeeId,
      employeeName: u.employeeName,
      email: u.email,
      mobile: u.mobile,
      // departmentId: u.department,
      // sectionId: u.section,
      // positionId: u.position,
    );
  }

  RoleModel? _mapApproverRoleToRole(ApproverRoleModel? r) {
    if (r == null) return null;
    return RoleModel(id: r.id, name: r.name);
  }

  // ------------------ RESOLVE ACTOR + ROLE ------------------
  ({UserModel? user, RoleModel? role}) _resolveActorAndRole(
    WorkflowDetailModel wf,
  ) {
    // 1️⃣ NEW workflow fields
    if (wf.approvedByUser != null || wf.approverRole != null) {
      return (user: wf.approvedByUser, role: wf.approverRole);
    }

    // 2️⃣ OLD workflow fields
    if (wf.user != null || wf.role != null) {
      return (user: wf.user, role: wf.role);
    }

    // 3️⃣ FINAL FALLBACK → approvalDetails
    final approval = _findApprovalByUserId(wf.approverUserId);
    if (approval != null) {
      return (
        user: _mapApproverUserToUser(
          approval.approvedByUser ?? approval.approverUser,
        ),
        role: _mapApproverRoleToRole(approval.approverRole),
      );
    }

    return (user: null, role: null);
  }

  // ------------------ SORT WORKFLOW ------------------
  List<WorkflowDetailModel> _sortWorkflows(List<WorkflowDetailModel> list) {
    final workflows = [...list];
    workflows.sort((a, b) {
      if (a.order != null && b.order != null) {
        return a.order!.compareTo(b.order!);
      }
      if (a.order != null) return -1;
      if (b.order != null) return 1;
      return (a.id ?? 0).compareTo(b.id ?? 0);
    });
    return workflows;
  }

  // ------------------ GENERATE STEPS ------------------
  List<WorkflowStepView> generateWorkflowStepsForITServices() {
    final workflows = _sortWorkflows(details.workflowDetails ?? []);
    final List<WorkflowStepView> steps = [];

    for (int i = 0; i < workflows.length; i++) {
      final wf = workflows[i];

      final user = wf.user;
      final role = wf.role;

      steps.add(
        WorkflowStepView(
          title: _formatTitle(wf.content),
          department: i == 0
              ? details.request?.createdByUser?.department?.departmentName
              : role?.name,
          actor: user?.employeeName,
          empId: user?.employeeId ?? user?.id?.toString(),
          role: role?.name,
          rawDate: wf.updatedAt ?? wf.createdAt,
          status: mapStatus(wf.status),
          isFirst: i == 0,
        ),
      );
    }

    return steps;
  }

  // ------------------ BUILD UI ------------------
  @override
  Widget build(BuildContext context) {
    final steps = generateWorkflowStepsForITServices();

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Request Workflow",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const Divider(height: 24),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: steps.length,
              itemBuilder: (context, index) {
                final s = steps[index];

                return _buildStep(
                  index: index,
                  total: steps.length,
                  status: s.status,
                  title: s.title,
                  actor: s.actor ?? "-",
                  empId: s.empId ?? "-",
                  role: s.role ?? "",
                  department: s.department ?? "",
                  date: formatDateTime(s.rawDate),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ------------------ STEP UI ------------------
  // ------------------ STEP UI ------------------
  Widget _buildStep({
    required int index,
    required int total,
    required WorkflowStepStatus status,
    required String title,
    required String date,
    required String actor,
    required String empId,
    required String role,
    required String department,
  }) {
    final showLine = index < total - 1;

    final showActor = actor != "-" && actor.isNotEmpty;

    final showDetails =
        index == 0 ||
        status == WorkflowStepStatus.approved ||
        status == WorkflowStepStatus.submitted;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          /// =====================================================
          /// LEFT TIMELINE
          /// =====================================================
          Column(
            children: [
              _statusIndicator(status, index == 0),

              if (showLine)
                Expanded(
                  child: Container(width: 2, color: const Color(0xFFE0E0E0)),
                ),
            ],
          ),

          const SizedBox(width: 12),

          /// =====================================================
          /// RIGHT CONTENT
          /// =====================================================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  /// =====================================================
                  /// TITLE
                  /// =====================================================
                  SizedBox(
                    width: double.infinity,

                    child: Text(
                      title,

                      softWrap: true,

                      overflow: TextOverflow.visible,

                      maxLines: 4,

                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                  ),

                  if (showDetails) ...[
                    const SizedBox(height: 8),

                    /// =====================================================
                    /// DEPARTMENT TAG
                    /// =====================================================
                    if (department.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),

                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F1F5),

                          borderRadius: BorderRadius.circular(8),

                          border: Border.all(color: Colors.grey.shade300),
                        ),

                        child: Text(
                          department,

                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    if (showActor) ...[
                      const SizedBox(height: 10),

                      const Text(
                        "Action Taken By:",

                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(actor, style: const TextStyle(fontSize: 12)),
                    ],

                    if (empId.isNotEmpty && empId != "-") ...[
                      const SizedBox(height: 2),

                      Text(
                        "Employee ID: $empId",

                        style: const TextStyle(fontSize: 12),
                      ),
                    ],

                    const SizedBox(height: 6),

                    Text(
                      date,

                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------ STATUS ICON ------------------
  Widget _statusIndicator(WorkflowStepStatus status, bool isFirst) {
    String icon = KIcons.workflowPending;

    Color color = const Color(0xFFC77700);

    if (isFirst || status == WorkflowStepStatus.approved) {
      icon = KIcons.workflowCompleted;

      color = const Color(0xFF26285F);
    }

    const double size = 24;

    const double iconSize = 12;

    return Container(
      width: size,
      height: size,

      decoration: BoxDecoration(color: color, shape: BoxShape.circle),

      child: Center(
        child: KImageProvider(width: iconSize, height: iconSize, image: icon),
      ),
    );
  }
}

String _formatTitle(String? content) {
  if (content == null) return "Workflow Step";

  final text = content.toLowerCase();

  if (text.contains("submitted")) return "Request Submitted";
  if (text.contains("assignment")) return "Request Assigned";
  if (text.contains("progress")) return "Request Processed";
  if (text.contains("approval")) return "Awaiting Approval";
  // if (text.contains("notification")) return "Notification Sent";

  return content;
}
