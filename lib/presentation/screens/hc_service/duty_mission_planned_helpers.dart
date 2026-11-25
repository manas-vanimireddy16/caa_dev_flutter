import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/allowance_entry.dart';

const kDutyMissionOmanCountry = 'Oman';

/// Builds the create payload for Planned / Unplanned duty missions.
Map<String, dynamic> buildPlannedUnplannedDutyMissionPayload({
  required String tripType,
  required int serviceId,
  required int subServiceId,
  required Map<String, dynamic> values,
  required List<AllowanceEntry> entries,
  required int departmentId,
  required int sectionId,
  bool includeMissionId = true,
}) {
  final sponsored = values['missionSponsoredBy'];
  final companyName = sponsored == 'CAA'
      ? 'CAA'
      : (values['sponsoredCompanyName'] ?? sponsored);

  final attachments = (values['attachments'] as List<FileUploadItem>? ?? [])
      .map((file) => file.toJson())
      .toList();

  final requestType = values['requestType']?.toString().trim();

  final payload = <String, dynamic>{
    'req_user_department_id': departmentId,
    'req_user_section_id': sectionId,
    'service_id': serviceId,
    'sub_service_id': subServiceId,
    'trip_type': tripType,
    'choose_type': values['chooseType'],
    'mission_sponsored_by': sponsored,
    'if_sponsored': sponsored,
    'company_name': companyName,
    'mission_purpose': values['missionPurpose'],
    'mission_number': values['missionNumber'],
    'mission_start_date': values['missionStartDate'],
    'mission_end_date': values['missionEndDate'],
    'mission_days':
        int.tryParse(values['missionDays']?.toString() ?? '') ??
        values['missionDays'],
    'number_of_employees': values['noOfEmployees']?.toString(),
    'travelling_area_from': values['travellingAreaFrom'],
    'travelling_area_to': values['travellingAreaTo'],
    'from_country': values['fromCountry'],
    'to_country': values['toCountry'],
    'travel_start_date': values['travelStartDate'],
    'travel_return_date': values['travelReturnDate'],
    'air_ticket_required': values['airTicketRequired'],
    'vehicle_required': values['vehicleRequired'],
    'remarks': values['remarks'] ?? '',
    'employees_details': entries.map((entry) {
      final v = entry.values;
      final perDay =
          double.tryParse(v['allowancePerDay']?.toString() ?? '0') ?? 0;
      final gradeDefault = double.tryParse(
            v['gradeDefaultAllowancePerDay']?.toString() ?? '',
          ) ??
          perDay;
      final isModified = v['isAllowanceModified'] == true ||
          (v['gradeDefaultAllowancePerDay'] != null && perDay != gradeDefault);

      return {
        'employee_id': v['employeeId'],
        'employee_name': v['employeeName'],
        'department': v['department'],
        'grade': v['grade']?.toString(),
        'position': v['position'],
        'percentage':
            int.tryParse(v['allowancePercentage']?.toString() ?? '0') ?? 0,
        'allowance_per_day': perDay,
        'total_allowance':
            double.tryParse(v['totalAllowance']?.toString() ?? '0') ?? 0,
        'is_allowance_modified': isModified,
      };
    }).toList(),
    'air_ticket_details': entries
        .where((e) => e.values['ticketType'] != null)
        .map((entry) {
          final v = entry.values;
          return {
            'employee_id': v['employeeId'],
            'employee_name': v['employeeName'],
            'ticket_type': v['ticketType'],
            'decision_date': v['decisionDate'],
            'departure_date': values['travelStartDate'],
            'return_date': values['travelReturnDate'],
            'decision_number': v['decisionNumber'],
            'mission_number': values['missionNumber'],
            'passport_no': v['passportNo'],
            'passport_issue_date': v['passportIssueDate'],
            'passport_expiry_date': v['passportExpiryDate'],
          };
        })
        .toList(),
    'attachments': attachments,
  };

  if (requestType != null && requestType.isNotEmpty) {
    payload['request_type'] = requestType;
  }

  if (includeMissionId) {
    final missionId = values['missionId']?.toString().trim();
    if (missionId != null && missionId.isNotEmpty) {
      payload['mission_id'] = missionId;
    }
  }

  return payload;
}
