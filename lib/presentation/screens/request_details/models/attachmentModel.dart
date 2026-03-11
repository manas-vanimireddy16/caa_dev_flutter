class AttachmentsmodelRD {
  final String documentName;
  final String fileType;
  final String uploadedDate;
  final String downloadUrl; // could be a link or file path
  final String action; // e.g., "Edit", "Delete"

  AttachmentsmodelRD({
    required this.documentName,
    required this.fileType,
    required this.uploadedDate,
    required this.downloadUrl,
    required this.action,
  });
}
