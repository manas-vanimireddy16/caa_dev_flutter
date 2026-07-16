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
class LegalServicesRequestWorkflowTimeline extends StatelessWidget {
  final RequestDetailData details;
  final DashboardL10n? l10n;

  const LegalServicesRequestWorkflowTimeline({
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
      if (a.approverUserId == userId ||
          a.approvedBy == userId ||
          a.approverUser?.id == userId ||
          a.approvedByUser?.id == userId) {
        return a;
      }
    }
    return null;
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
      return (a.stepOrder ?? 0).compareTo(b.stepOrder ?? 0);
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
