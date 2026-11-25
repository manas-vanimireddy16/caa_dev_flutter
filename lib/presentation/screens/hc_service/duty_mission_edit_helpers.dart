import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/allowance_entry.dart';

/// Maps an Annual duty-mission request into DynamicForm `apiValues`.
Map<String, dynamic> mapAnnualDutyMissionToFormValues(RequestModel? request) {
  if (request == null) return {};
  return {
    'tripType': 'Annual',
    'chooseType': request.chooseType,
    'month': request.month,
    'missionSponsoredBy': request.missionSponsoredBy,
    'sponsoredCompanyName': request.companyName ?? request.ifSponsored,
    'missionPurpose': request.missionPurpose,
    'missionNumber': request.missionNumber,
    'missionStartDate': request.missionStartDate,
    'missionEndDate': request.missionEndDate,
    'missionDays': request.missionDays?.toString(),
    'noOfEmployees': request.numberOfEmployees?.toString(),
    'placeOfMission': request.placeOfMission,
    'allowancePercentage': request.allowancePercentage,
    'allowanceFeesOmr': request.allowanceFeesOmr,
    'ticketFee': request.ticketFee,
    'missionTotal': request.missionTotal?.toString() ?? '0.000',
    'notes': request.notes,
    'remarks': request.remarks,
  };
}

/// Convert request attachments into DynamicForm file-upload items.
List<FileUploadItem> mapAttachmentsToFileUploadItems(
  List<AttachmentModel>? attachments,
) {
  if (attachments == null || attachments.isEmpty) return [];
  return attachments.map((a) {
    final size = int.tryParse(a.fileSize?.toString() ?? '');
    return FileUploadItem(
      documentId: a.id?.toString() ?? a.fileUrl,
      filename: a.fileName,
      originalName: a.fileName,
      size: size,
      downloadUrl: a.fileUrl,
    );
  }).toList();
}

/// Maps a duty-mission request into DynamicForm `apiValues`.
Map<String, dynamic> mapDutyMissionToFormValues(RequestModel? request) {
  if (request == null) return {};
  return {
    'tripType': request.tripType,
    'requestType': request.requestType,
    'chooseType': request.chooseType,
    'missionId': request.missionId,
    'missionSponsoredBy': request.missionSponsoredBy,
    'sponsoredCompanyName': request.companyName ?? request.ifSponsored,
    'missionPurpose': request.missionPurpose,
    'missionNumber': request.missionNumber,
    'missionStartDate': request.missionStartDate,
    'missionEndDate': request.missionEndDate,
    'missionDays': request.missionDays?.toString(),
    'noOfEmployees': request.numberOfEmployees?.toString() ??
        request.employeesDetails?.length.toString(),
    'fromCountry': request.fromCountry,
    'toCountry': request.toCountry,
    'travellingAreaFrom': request.travellingAreaFrom,
    'travellingAreaTo': request.travellingAreaTo,
    'travelStartDate': request.travelStartDate,
    'travelReturnDate': request.travelReturnDate,
    'airTicketRequired': request.airTicketRequired,
    'vehicleRequired': request.vehicleRequired,
    'remarks': request.remarks,
  };
}

/// Builds allowance/passport entries, matching air-ticket rows by employee id.
List<AllowanceEntry> mapDutyMissionToAllowanceEntries(RequestModel? request) {
  final employees = request?.employeesDetails ?? const <EmployeeDutyMission>[];
  final tickets = request?.airTicketDetails ?? const <AirTicketDetail>[];

  return employees.map((e) {
    final empId = e.employeeId?.toString();
    AirTicketDetail? ticket;
    for (final t in tickets) {
      if (t.employeeId?.toString() == empId) {
        ticket = t;
        break;
      }
    }

    final perDay = double.tryParse(e.allowancePerDay?.toString() ?? '') ?? 0;
    return AllowanceEntry(
      id: empId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      values: {
        'employeeId': int.tryParse(empId ?? '') ?? empId,
        'employeeName': e.employeeName,
        'department': e.department,
        'grade': e.grade,
        'position': e.position,
        'allowancePercentage':
            int.tryParse(e.percentage?.toString() ?? '') ?? 0,
        'allowancePerDay': perDay,
        'gradeDefaultAllowancePerDay': perDay,
        'isAllowanceModified': e.isAllowanceModified == true,
        'totalAllowance':
            double.tryParse(e.totalAllowance?.toString() ?? '') ?? 0,
        'missionDays': request?.missionDays,
        // Preserve air-ticket identity fields on edit (match by employee id).
        'ticketType': ticket?.ticketType,
        'decisionDate': ticket?.decisionDate,
        'decisionNumber': ticket?.decisionNumber,
        'passportNo': ticket?.passportNo,
        'passportIssueDate': ticket?.passportIssueDate,
        'passportExpiryDate': ticket?.passportExpiryDate,
      },
    );
  }).toList();
}
