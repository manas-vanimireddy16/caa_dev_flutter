import 'package:code_setup/presentation/models/base_request_model.dart';

class EventSupportModel {
  /// ⭐ BASE MODEL (COMMON FIELDS)
  final BaseRequestModel? base;

  /// ⭐ EVENT SUPPORT FIELDS
  final String? eventTitle;
  final String? requestFor;
  final String? dateOfEvent;
  final String? locationOfEvent;
  final String? typeOfEvent;
  final String? phoneNumber;
  final String? reasonForRequest;
  final int? eventDepartmentId;

  const EventSupportModel({
    this.base,
    this.eventTitle,
    this.requestFor,
    this.dateOfEvent,
    this.locationOfEvent,
    this.typeOfEvent,
    this.phoneNumber,
    this.reasonForRequest,
    this.eventDepartmentId,
  });

  /// ================= FROM JSON =================
  factory EventSupportModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const EventSupportModel();

    return EventSupportModel(
      /// ⭐ BASE
      base: BaseRequestModel.fromJson(json),

      eventTitle: json['event_title'],
      requestFor: json['request_for'],
      dateOfEvent: json['date_of_event'],
      locationOfEvent: json['location_of_event'],
      typeOfEvent: json['type_of_event'],
      phoneNumber: json['phone_number'],
      reasonForRequest: json['reason_for_request'],
      eventDepartmentId: json['event_department_id'],
    );
  }

  /// ================= TO JSON =================
}
