enum ActionButtonsType {
  none,
  assign,
  assignReject,
  closeReject,
  reassignCloseReject,
  approveReject,
  approve,
  replace,
  inProgress,
  complete,
}

enum ApprovalDialogType { approve, reject }

enum FileCategory { image, video, audio, pdf, document, unknown }

enum AllowanceFormMode { add, edit }

enum ApprovalStatus { approved, rejected }

extension ApprovalStatusX on ApprovalStatus {
  String get apiValue {
    switch (this) {
      case ApprovalStatus.approved:
        return "Approved";
      case ApprovalStatus.rejected:
        return "Rejected";
    }
  }
}
