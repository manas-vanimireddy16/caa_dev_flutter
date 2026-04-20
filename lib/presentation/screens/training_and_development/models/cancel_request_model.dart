import 'package:code_setup/presentation/models/base_request_model.dart';

class CancellationRequestModel {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ CANCELLATION FIELDS
  final List<int>? affectedParticipantUserIds;
  final String? oldRequestNumber;
  final String? reasonForCancellation;
  final String? description;

  const CancellationRequestModel({
    this.base,
    this.affectedParticipantUserIds,
    this.oldRequestNumber,
    this.reasonForCancellation,
    this.description,
  });

  /// ================= FROM JSON =================
  factory CancellationRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CancellationRequestModel();

    return CancellationRequestModel(
      /// ⭐ BASE
      base: BaseRequestModel.fromJson(json),

      affectedParticipantUserIds:
          (json['affected_participant_user_ids'] as List?)
              ?.map((e) => e as int)
              .toList(),

      oldRequestNumber: json['old_request_number'],
      reasonForCancellation: json['reason_for_cancellation'],
      description: json['description'],
    );
  }
}
