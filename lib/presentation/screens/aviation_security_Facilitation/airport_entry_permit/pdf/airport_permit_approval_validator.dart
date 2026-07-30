import 'package:code_setup/presentation/models/details_models.dart';

/// Mirrors the React `isPrintEnabled` gate for Airport Entry Permit.
abstract final class AirportPermitApprovalValidator {
  AirportPermitApprovalValidator._();

  /// Show Download PDF only when every valid approval is completed as Approved
  /// and the request status is Approved or Closed.
  static bool shouldShowDownloadButton(RequestDetailData response) {
    return isPrintEnabled(response);
  }

  static bool isPrintEnabled(RequestDetailData response) {
    final requestStatus =
        (response.request?.status ?? response.status ?? '').toLowerCase().trim();

    if (requestStatus != 'approved' && requestStatus != 'closed') {
      return false;
    }

    final approvalDetails = response.approvalDetails ?? const [];
    final validApprovalDetails = approvalDetails.where((approval) {
      return approval.approverRoleId != null;
    }).toList();

    if (validApprovalDetails.isEmpty) {
      return false;
    }

    final sortedApprovals = [...validApprovalDetails]
      ..sort((a, b) => (a.level ?? 0).compareTo(b.level ?? 0));

    final hasPendingApprovals = sortedApprovals.any((approval) {
      final status = (approval.approvalStatus ?? '').toLowerCase().trim();
      return status == 'pending' || status == 'in progress';
    });
    if (hasPendingApprovals) return false;

    final hasRejectedApprovals = sortedApprovals.any((approval) {
      final status = (approval.approvalStatus ?? '').toLowerCase().trim();
      return status == 'rejected';
    });
    if (hasRejectedApprovals) return false;

    final allApproved = sortedApprovals.every((approval) {
      final status = (approval.approvalStatus ?? '').toLowerCase().trim();
      return status == 'approved';
    });

    final sortedByLevel = [...sortedApprovals]
      ..sort((a, b) => _approvalLevel(b).compareTo(_approvalLevel(a)));

    final lastLevelApproval = sortedByLevel.isNotEmpty
        ? sortedByLevel.first
        : null;
    final lastLevelStatus =
        (lastLevelApproval?.approvalStatus ?? '').toLowerCase().trim();

    return allApproved && lastLevelStatus == 'approved';
  }

  static int _approvalLevel(ApprovalDetailModel approval) {
    return approval.level ?? 0;
  }
}
