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
  assignApproveReject,
  approveRejectAllocateVehicle,
  assignCloseReject,
}

enum ApprovalDialogType { approve, reject, close }

enum FileCategory { image, video, audio, pdf, document, unknown }

enum AllowanceFormMode { add, edit }

enum ApprovalStatus { approved, rejected }

enum RequestServiceType { allowance, goals, hrPlanning }

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
