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
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
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
class RequestWorkflowTimeline extends StatelessWidget {
  final RequestDetailData details;
  final DashboardL10n? l10n;

  const RequestWorkflowTimeline({
    super.key,
    required this.details,
    this.l10n,
  });

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
  List<WorkflowStepView> generateWorkflowSteps() {
    final workflows = _sortWorkflows(details.workflowDetails ?? []);
    final List<WorkflowStepView> steps = [];

    for (int i = 0; i < workflows.length; i++) {
      final wf = workflows[i];
      final resolved = _resolveActorAndRole(wf);

      steps.add(
        WorkflowStepView(
          title: wf.content ?? "Workflow Step",
          department: i == 0
              ? details.request?.createdByUser?.department?.departmentName
              : resolved.role?.name,
          actor: resolved.user?.employeeName,
          empId: i == 0
              ? resolved.user?.employeeId
              : resolved.user?.id.toString(),
          role: resolved.role?.name,
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
    final steps = generateWorkflowSteps();

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
            Text(
              l10n?.requestWorkflowSectionTitle ?? 'Request Workflow',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const Divider(height: 24),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                final s = steps[index];
                return _buildStep(
                  l10n: l10n,
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
  Widget _buildStep({
    DashboardL10n? l10n,
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
    final showDetails = status == WorkflowStepStatus.approved;
    final actionLabel = l10n?.workflowActionTakenBy ?? 'Action taken by';
    String employeeLineFor(String id) =>
        l10n?.workflowEmployeeIdLine(id) ?? 'Employee ID: $id';

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _statusIndicator(status, index == 0),
              if (showLine)
                Expanded(
                  child: Container(width: 3, color: const Color(0xFFDFDFDF)),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (showDetails) ...[
                    if (department.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Chip(label: Text(department)),
                      ),
                    if (showActor) ...[
                      const SizedBox(height: 6),
                      Text(
                        '$actionLabel:',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(actor),
                    ],
                    if (empId.isNotEmpty && empId != "-")
                      Text(employeeLineFor(empId)),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
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

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(child: KImageProvider(width: 22, height: 22, image: icon)),
    );
  }
}
