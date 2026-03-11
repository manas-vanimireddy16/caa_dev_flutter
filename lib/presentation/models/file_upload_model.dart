class FileUploadDataModel {
  String? status;
  String? message;
  FileUploadData? data;

  FileUploadDataModel({this.status, this.message, this.data});

  factory FileUploadDataModel.fromJson(Map<String, dynamic> json) {
    return FileUploadDataModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? FileUploadData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }
}

class FileUploadData {
  List<FileUploadItem>? files;

  FileUploadData({this.files});

  factory FileUploadData.fromJson(Map<String, dynamic> json) {
    return FileUploadData(
      files: json['files'] != null
          ? (json['files'] as List)
                .map((e) => FileUploadItem.fromJson(e))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'files': files?.map((e) => e.toJson()).toList()};
  }
}

class FileUploadItem {
  String? documentId;
  String? filename;
  String? originalName;
  int? size;
  String? downloadUrl;

  FileUploadItem({
    this.documentId,
    this.filename,
    this.originalName,
    this.size,
    this.downloadUrl,
  });

  /// Backend → Dart Model
  factory FileUploadItem.fromJson(Map<String, dynamic> json) {
    return FileUploadItem(
      documentId: json['documentId'],
      filename: json['filename'],
      originalName: json['originalName'],
      size: json['size'],
      downloadUrl: json['downloadUrl'],
    );
  }

  /// Dart Model → API Request Format YOU need
  Map<String, dynamic> toJson() {
    final ext = (originalName != null && originalName!.contains('.'))
        ? originalName!.split('.').last.toLowerCase()
        : null;

    return {
      'file_name': originalName,
      'file_url': documentId, // Use download link → correct for API
      'file_type': ext, // Extract file extension
      // Use real file name
      'file_size': size, // Forward size
    };
  }
}
