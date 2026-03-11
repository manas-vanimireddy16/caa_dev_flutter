class Attachmentsmodel {
  final String documentName;
  final String fileType;
  final String uploadedDate;
  final String downloadUrl; // could be a link or file path
  final String action; // e.g., "Edit", "Delete"

  Attachmentsmodel({
    required this.documentName,
    required this.fileType,
    required this.uploadedDate,
    required this.downloadUrl,
    required this.action,
  });

  // /// Convert to Map<String, String> if you want to reuse CustomCard
  // Map<String, String> toMap() {
  //   return {
  //     "Document Name": documentName,
  //     "File Type": fileType,
  //     "Uploaded Date": uploadedDate,
  //     "Download": downloadUrl,
  //     "Action": action,
  //   };
  // }
}
