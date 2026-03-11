import 'package:code_setup/presentation/models/details_models.dart';

class ChatByIdResponseModel {
  final String? status;
  final int? totalCount;
  final List<ChatMessageModel> data;

  ChatByIdResponseModel({this.status, this.totalCount, required this.data});

  factory ChatByIdResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatByIdResponseModel(
      status: json['status'],
      totalCount: json['total_count'],
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => ChatMessageModel.fromJson(e))
          .toList(),
    );
  }
}

class AttachmentByIdResponseModel {
  final String? status;
  final int? totalCount;
  final List<AttachmentModel> data;

  AttachmentByIdResponseModel({
    this.status,
    this.totalCount,
    required this.data,
  });

  factory AttachmentByIdResponseModel.fromJson(Map<String, dynamic> json) {
    return AttachmentByIdResponseModel(
      status: json['status'],
      totalCount: json['total_count'],
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => AttachmentModel.fromJson(e))
          .toList(),
    );
  }
}
