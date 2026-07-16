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
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/localized_display_name.dart';
import 'package:code_setup/utils/helper/org_directory_cache.dart';
import 'package:code_setup/utils/helper/workflow_step_helpers.dart';
import 'dart:ui' as ui;
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
  final String? workflowType;
  final String? actor;
  final String? empId;
  final String? department;
  final String? section;
  final String? role;
  final String? rawDate;
  final WorkflowStepStatus status;
  final bool isFirst;
  final bool showDetails;

  const WorkflowStepView({
    required this.title,
    required this.status,
    this.workflowType,
    this.actor,
    this.empId,
    this.department,
    this.section,
    this.role,
    this.rawDate,
    this.isFirst = false,
    this.showDetails = true,
  });
}

/// ---------------------------------------------------------------------------
/// MAIN WIDGET
/// ---------------------------------------------------------------------------
class RequestWorkflowTimeline extends StatelessWidget {
  final RequestDetailData details;
  final DashboardL10n? l10n;

  const RequestWorkflowTimeline({super.key, required this.details, this.l10n});

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
      case "assigned":
        return WorkflowStepStatus.assigned;
      default:
        return WorkflowStepStatus.inactive;
    }
  }

  bool _shouldShowStepDetails(WorkflowStepStatus status, WorkflowDetailModel wf) {
    if (isNotificationWorkflowStep(
      content: wf.content,
      contentAr: wf.contentAr,
      status: wf.status,
      statusAr: wf.statusAr,
    )) {
      return false;
    }

    return status == WorkflowStepStatus.approved ||
        status == WorkflowStepStatus.submitted ||
        status == WorkflowStepStatus.assigned;
  }

  // ------------------ FORMAT DATE ------------------
  String formatDateTime(String? dt) {
    if (dt == null || dt.isEmpty) return '-';
    try {
      final local = DateTime.parse(dt).toUtc().toLocal();
      return DateFormat('MMM dd, yyyy | hh:mm a').format(local);
    } catch (_) {
      return '-';
    }
  }

  /// Returns null when value is missing so the UI can hide the row.
  String? _nullableText(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null ||
        trimmed.isEmpty ||
        trimmed == '-' ||
        trimmed.toLowerCase() == 'null' ||
        trimmed.toLowerCase() == 'n/a') {
      return null;
    }
    return trimmed;
  }

  String _localizedText({
    required bool isArabic,
    String? english,
    String? arabic,
    String fallback = '-',
  }) {
    final value = localizedDisplayName(
      isArabic: isArabic,
      english: english,
      arabic: arabic,
    );
    return value.isEmpty ? fallback : value;
  }

  String _stepTitle(WorkflowDetailModel wf, bool isArabic) {
    final title = _localizedText(
      isArabic: isArabic,
      english: wf.content,
      arabic: wf.contentAr,
      fallback: '',
    );
    if (title.isNotEmpty) return title;

    final statusTitle = _localizedText(
      isArabic: isArabic,
      english: wf.status,
      arabic: wf.statusAr,
      fallback: '',
    );
    return statusTitle.isNotEmpty ? statusTitle : 'Workflow Step';
  }

  String _workflowTypeLabel(bool isArabic) {
    final service = details.service;
    if (service != null) {
      final label = service.displayName(isArabic: isArabic);
      if (label.isNotEmpty) return label;
    }
    return _localizedText(
      isArabic: isArabic,
      english: details.subService?.subServiceName,
      arabic: null,
      fallback: '',
    );
  }

  String _employeeName(UserModel? user, bool isArabic) {
    final name = _localizedText(
      isArabic: isArabic,
      english: user?.employeeName,
      arabic: user?.employeeArabicName,
      fallback: '',
    );
    return name;
  }

  String _roleName(RoleModel? role, bool isArabic) {
    final name = _localizedText(
      isArabic: isArabic,
      english: role?.name,
      arabic: role?.arabicName,
      fallback: '',
    );
    return name;
  }

  // ------------------ FIND APPROVAL ------------------
  ApprovalDetailModel? _findApprovalByUserId(int? userId) {
    if (userId == null) return null;

    for (final a in details.approvalDetails ?? []) {
      if (a.approverUserId == userId ||
          a.approvedBy == userId ||
          a.approverUser?.id == userId ||
          a.approvedByUser?.id == userId) {
        return a;
      }
    }
    return null;
  }

  ApprovalDetailModel? _findApprovalForWorkflow(
    WorkflowDetailModel wf,
    int index,
  ) {
    final approvals = details.approvalDetails ?? [];
    final userIds = <int>{
      ?wf.approverUserId,
      ?wf.approvedBy,
      ?wf.approvedByUser?.id,
      ?wf.updatedBy,
      ?wf.user?.id,
      ?wf.userId,
    };

    for (final approval in approvals) {
      if (userIds.contains(approval.approverUserId) ||
          userIds.contains(approval.approvedBy) ||
          userIds.contains(approval.approverUser?.id) ||
          userIds.contains(approval.approvedByUser?.id)) {
        return approval;
      }
    }

    if (index > 0 && index - 1 < approvals.length) {
      return approvals[index - 1];
    }

    return null;
  }

  ({DepartmentModel? department, SectionModel? section})
  _resolveDepartmentAndSection({
    required WorkflowDetailModel wf,
    required UserModel? user,
    required int index,
  }) {
    DepartmentModel? department;
    SectionModel? section;

    void useDepartment(DepartmentModel? value) {
      if (department != null || value == null) return;
      department = value;
    }

    void useSection(SectionModel? value) {
      if (section != null || value == null) return;
      section = value;
    }

    useDepartment(user?.department);
    useSection(user?.section);
    useDepartment(wf.department);
    useSection(wf.section);

    final approval = _findApprovalForWorkflow(wf, index);
    if (approval != null) {
      useDepartment(approval.department);
      useSection(approval.section);
    }

    if (index == 0) {
      final creator = details.request?.createdByUser;
      useDepartment(creator?.department);
      useSection(creator?.section);
    }

    if (department == null &&
        wf.departmentId != null &&
        wf.departmentId! > 0) {
      department = _findDepartmentById(wf.departmentId);
    }
    if (section == null && wf.sectionId != null && wf.sectionId! > 0) {
      section = _findSectionById(wf.sectionId);
    }

    if (department != null &&
        department!.displayName(isArabic: false).trim().isEmpty &&
        department!.id != null) {
      department = _findDepartmentById(department!.id);
    }
    if (section != null &&
        section!.displayName(isArabic: false).trim().isEmpty &&
        section!.id != null) {
      section = _findSectionById(section!.id);
    }

    return (department: department, section: section);
  }

  DepartmentModel? _findDepartmentById(int? id) {
    if (id == null || id <= 0) return null;

    DepartmentModel? pick(DepartmentModel? model) {
      if (model?.id != id) return null;
      if (model!.displayName(isArabic: false).trim().isEmpty) return null;
      return model;
    }

    final creator = details.request?.createdByUser?.department;
    final fromCreator = pick(creator);
    if (fromCreator != null) return fromCreator;

    for (final wf in details.workflowDetails ?? []) {
      for (final candidate in [
        wf.department,
        wf.approvedByUser?.department,
        wf.user?.department,
      ]) {
        final match = pick(candidate);
        if (match != null) return match;
      }
    }

    for (final approval in details.approvalDetails ?? []) {
      final match = pick(approval.department);
      if (match != null) return match;
    }

    final fromCatalog = OrgDirectoryCache.departmentById(id);
    if (fromCatalog != null) return fromCatalog;

    return DepartmentModel(id: id);
  }

  SectionModel? _findSectionById(int? id) {
    if (id == null || id <= 0) return null;

    SectionModel? pick(SectionModel? model) {
      if (model?.id != id) return null;
      if (model!.displayName(isArabic: false).trim().isEmpty) return null;
      return model;
    }

    final creator = details.request?.createdByUser?.section;
    final fromCreator = pick(creator);
    if (fromCreator != null) return fromCreator;

    for (final wf in details.workflowDetails ?? []) {
      for (final candidate in [
        wf.section,
        wf.approvedByUser?.section,
        wf.user?.section,
      ]) {
        final match = pick(candidate);
        if (match != null) return match;
      }
    }

    for (final approval in details.approvalDetails ?? []) {
      final match = pick(approval.section);
      if (match != null) return match;
    }

    final fromCatalog = OrgDirectoryCache.sectionById(id);
    if (fromCatalog != null) return fromCatalog;

    return SectionModel(id: id);
  }

  bool _needsOrgDirectoryLookup() {
    bool needsName(DepartmentModel? department, SectionModel? section) {
      final deptNeeds =
          department?.id != null &&
          department!.id! > 0 &&
          department.displayName(isArabic: false).trim().isEmpty;
      final sectionNeeds =
          section?.id != null &&
          section!.id! > 0 &&
          section.displayName(isArabic: false).trim().isEmpty;
      return deptNeeds || sectionNeeds;
    }

    for (final wf in details.workflowDetails ?? []) {
      if ((wf.departmentId != null && wf.departmentId! > 0) ||
          (wf.sectionId != null && wf.sectionId! > 0) ||
          needsName(wf.department, wf.section) ||
          needsName(
            wf.approvedByUser?.department,
            wf.approvedByUser?.section,
          ) ||
          needsName(wf.user?.department, wf.user?.section)) {
        return true;
      }
    }

    for (final approval in details.approvalDetails ?? []) {
      if ((approval.departmentId != null && approval.departmentId! > 0) ||
          (approval.sectionId != null && approval.sectionId! > 0) ||
          needsName(approval.department, approval.section)) {
        return true;
      }
    }

    final creator = details.request?.createdByUser;
    if (needsName(creator?.department, creator?.section)) {
      return true;
    }

    return false;
  }

  Future<void> _ensureOrgDirectoryLoaded() async {
    if (!_needsOrgDirectoryLookup()) return;
    await OrgDirectoryCache.ensureLoaded();
  }

  // ------------------ NORMALIZE MODELS ------------------
  UserModel? _mapApproverUserToUser(
    ApproverUserModel? u, {
    DepartmentModel? department,
    SectionModel? section,
  }) {
    if (u == null) return null;

    return UserModel(
      id: u.id,
      employeeId: u.employeeId,
      employeeName: u.employeeName,
      employeeArabicName: u.employeeArabicName,
      email: u.email,
      mobile: u.mobile,
      department:
          department ??
          (u.department != null ? DepartmentModel(id: u.department) : null),
      section:
          section ?? (u.section != null ? SectionModel(id: u.section) : null),
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
    RoleModel? role = wf.approverRole ?? wf.role;
    UserModel? user = wf.approvedByUser ?? wf.user;

    // When approved_by / approved_by_user is null, resolve the actor from
    // approval_details / approver_details using approver_user_id.
    if (user == null) {
      final approval = _findApprovalByUserId(
        wf.approverUserId ?? wf.approvedBy ?? wf.updatedBy ?? wf.userId,
      );
      if (approval != null) {
        user = _mapApproverUserToUser(
          approval.approvedByUser ?? approval.approverUser,
          department: approval.department,
          section: approval.section,
        );
        role ??= _mapApproverRoleToRole(approval.approverRole);
      }
    }

    return (user: user, role: role);
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
  List<WorkflowStepView> generateWorkflowSteps({required bool isArabic}) {
    final workflows = _sortWorkflows(details.workflowDetails ?? []);
    final workflowType = _workflowTypeLabel(isArabic);
    final List<WorkflowStepView> steps = [];

    for (int i = 0; i < workflows.length; i++) {
      final wf = workflows[i];
      final resolved = _resolveActorAndRole(wf);
      final user =
          resolved.user ??
          (i == 0 ? details.request?.createdByUser : null) ??
          wf.user;
      final role = resolved.role ?? wf.role;
      final org = _resolveDepartmentAndSection(
        wf: wf,
        user: user,
        index: i,
      );

      steps.add(
        WorkflowStepView(
          title: _stepTitle(wf, isArabic),
          workflowType: i == 0 && workflowType.isNotEmpty ? workflowType : null,
          actor: _nullableText(_employeeName(user, isArabic)),
          empId: _nullableText(user?.employeeId ?? user?.id?.toString()),
          department: _nullableText(
            org.department?.displayName(isArabic: isArabic),
          ),
          section: _nullableText(
            org.section?.displayName(isArabic: isArabic),
          ),
          role: _nullableText(_roleName(role, isArabic)),
          rawDate: wf.updatedAt ?? wf.createdAt,
          status: mapStatus(wf.status),
          isFirst: i == 0,
          showDetails: _shouldShowStepDetails(mapStatus(wf.status), wf),
        ),
      );
    }
    return steps;
  }

  // ------------------ BUILD UI ------------------
  @override
  Widget build(BuildContext context) {
    final labels = l10n ?? DashboardL10n.of(context);
    final isArabic = labels.isArabic;
    final textDirection = isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr;

    return FutureBuilder<void>(
      future: _ensureOrgDirectoryLoaded(),
      builder: (context, snapshot) {
        final steps = generateWorkflowSteps(isArabic: isArabic);

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
                  labels.requestWorkflowSectionTitle,
                  style: AppTextStyles.requestDetailsSectionHeading(),
                ),
                const Divider(height: 24),
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !OrgDirectoryCache.isLoaded)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    final step = steps[index];
                    return _buildStep(
                      labels: labels,
                      textDirection: textDirection,
                      index: index,
                      total: steps.length,
                      step: step,
                      date: formatDateTime(step.rawDate),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ------------------ STEP UI ------------------
  Widget _buildStep({
    required DashboardL10n labels,
    required ui.TextDirection textDirection,
    required int index,
    required int total,
    required WorkflowStepView step,
    required String date,
  }) {
    final showLine = index < total - 1;
    final showDetails = step.showDetails;

    return IntrinsicHeight(
      child: Row(
        textDirection: textDirection,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimelineRail(
            status: step.status,
            isFirst: step.isFirst,
            showLine: showLine,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: AppTextStyles.requestDetailsSectionHeading().copyWith(
                      fontSize: 15,
                    ),
                  ),
                  if (step.workflowType != null &&
                      step.workflowType!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _WorkflowTypeChip(label: step.workflowType!),
                  ],
                  if (showDetails) ...[
                    ..._buildOptionalDetailRows(
                      labels: labels,
                      textDirection: textDirection,
                      step: step,
                    ),
                    if (_nullableText(date) != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        date,
                        style: AppTextStyles.requestDetailsFieldHeading()
                            .copyWith(color: const Color(0xFF9E9E9E)),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOptionalDetailRows({
    required DashboardL10n labels,
    required ui.TextDirection textDirection,
    required WorkflowStepView step,
  }) {
    final rows = <({String label, String? value})>[
      (label: '${labels.workflowActionTakenBy}:', value: step.actor),
      (label: '${labels.employeeId}:', value: step.empId),
      (label: '${labels.workflowDepartmentName}:', value: step.department),
      (label: '${labels.workflowSectionName}:', value: step.section),
      (label: '${labels.workflowRoleName}:', value: step.role),
    ];

    final visible = rows
        .where((row) => _nullableText(row.value) != null)
        .toList();
    if (visible.isEmpty) return const [];

    return [
      const SizedBox(height: 12),
      for (var i = 0; i < visible.length; i++) ...[
        if (i > 0) const SizedBox(height: 8),
        _WorkflowDetailRow(
          label: visible[i].label,
          value: visible[i].value!,
          textDirection: textDirection,
        ),
      ],
    ];
  }

  Widget _buildTimelineRail({
    required WorkflowStepStatus status,
    required bool isFirst,
    required bool showLine,
  }) {
    return Column(
      children: [
        _statusIndicator(status, isFirst),
        if (showLine)
          Expanded(
            child: Container(width: 2, color: const Color(0xFFDFDFDF)),
          ),
      ],
    );
  }

  // ------------------ STATUS ICON ------------------
  Widget _statusIndicator(WorkflowStepStatus status, bool isFirst) {
    String icon = KIcons.workflowPending;
    Color color = const Color(0xFFC77700);

    if (isFirst) {
      icon = KIcons.workflowCompleted;
      color = const Color(0xFF26285F);
    } else if (status == WorkflowStepStatus.approved ||
        status == WorkflowStepStatus.submitted) {
      icon = KIcons.workflowCompleted;
      color = const Color(0xFF31B480);
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(child: KImageProvider(width: 22, height: 22, image: icon)),
    );
  }
}

class _WorkflowTypeChip extends StatelessWidget {
  final String label;

  const _WorkflowTypeChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Text(
        label,
        style: AppTextStyles.requestDetailsFieldContent().copyWith(
          color: const Color(0xFF676767),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _WorkflowDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final ui.TextDirection textDirection;

  const _WorkflowDetailRow({
    required this.label,
    required this.value,
    required this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: textDirection,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: AppTextStyles.requestDetailsFieldHeading(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.requestDetailsFieldContent(),
          ),
        ),
      ],
    );
  }
}
