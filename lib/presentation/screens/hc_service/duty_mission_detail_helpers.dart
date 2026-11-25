import 'package:code_setup/presentation/models/details_models.dart';

/// Air-ticket employees that need Business/Economy before approve.
List<AirTicketDetail> airTicketsNeedingType(RequestModel? request) {
  final required = (request?.airTicketRequired ?? '').trim().toLowerCase();
  final needsTicket =
      required == 'yes' || required == 'true' || required == 'y';
  if (!needsTicket) return const [];
  return request?.airTicketDetails ?? const [];
}

String dutyDisplayOrNA(Object? value) {
  if (value == null) return 'NA';
  final text = value.toString().trim();
  if (text.isEmpty || text.toLowerCase() == 'null') return 'NA';
  return text;
}

String dutyCompanyDisplayName(RequestModel? request) {
  final sponsored = (request?.missionSponsoredBy ?? request?.ifSponsored ?? '')
      .toString()
      .trim()
      .toLowerCase();
  if (sponsored == 'caa') return 'CAA';
  return dutyDisplayOrNA(request?.companyName);
}

String _employeeNames(RequestModel? request) {
  final employees = request?.employeesDetails ?? const [];
  if (employees.isEmpty) {
    return dutyDisplayOrNA(request?.createdByUser?.employeeName);
  }
  final names = employees
      .map((e) => e.employeeName?.trim() ?? '')
      .where((name) => name.isNotEmpty)
      .toList();
  if (names.isEmpty) return 'NA';
  return names.join(', ');
}

String _departmentName(RequestModel? request) {
  return dutyDisplayOrNA(
    request?.reqDepartment?.departmentName ??
        request?.createdByUser?.department?.departmentName,
  );
}

String _directorateName(RequestModel? request) {
  return dutyDisplayOrNA(
    request?.directorateName ?? request?.createdByUser?.directorate,
  );
}

String _missionLocation(RequestModel? request) {
  final place = request?.placeOfMission?.trim();
  if (place != null && place.isNotEmpty) return place;
  final from = request?.travellingAreaFrom?.trim() ?? '';
  final to = request?.travellingAreaTo?.trim() ?? '';
  if (from.isNotEmpty || to.isNotEmpty) {
    if (from.isNotEmpty && to.isNotEmpty) return '$from → $to';
    return from.isNotEmpty ? from : to;
  }
  return dutyDisplayOrNA(request?.travelPlace);
}

/// Shared mission summary shown at the top of request details.
Map<String, String> buildDutyMissionSummary(RequestModel? request) {
  return {
    'Mission ID': dutyDisplayOrNA(request?.missionId ?? request?.missionNumber),
    'Mission Type': dutyDisplayOrNA(request?.tripType),
    'Department': _departmentName(request),
    'Directorate': _directorateName(request),
    'Employee Name': _employeeNames(request),
    'Purpose': dutyDisplayOrNA(request?.missionPurpose),
    'No. of Employees': dutyDisplayOrNA(
      request?.numberOfEmployees ?? request?.employeesDetails?.length,
    ),
    'Mission Location': _missionLocation(request),
    'Company Name': dutyCompanyDisplayName(request),
  };
}

/// Annual request cost / month fields.
Map<String, String> buildAnnualCostFields(RequestModel? request) {
  return {
    'Month': dutyDisplayOrNA(request?.month),
    'Place of Mission': dutyDisplayOrNA(request?.placeOfMission),
    'Allowance %': dutyDisplayOrNA(request?.allowancePercentage),
    'Allowance Fees (OMR)': dutyDisplayOrNA(request?.allowanceFeesOmr),
    'Ticket Fee': dutyDisplayOrNA(request?.ticketFee),
    'Total': dutyDisplayOrNA(request?.missionTotal),
    'Notes': dutyDisplayOrNA(request?.notes),
  };
}

/// Planned-only section sourced from linked annual approved mission.
Map<String, String> buildAnnualPlanDetails(
  LinkedAnnualApprovedMission? linked,
) {
  return {
    'Mission Days': dutyDisplayOrNA(linked?.missionDays),
    'No. of Employees': dutyDisplayOrNA(linked?.numberOfEmployees),
    'Place of Mission': dutyDisplayOrNA(linked?.placeOfMission),
    'Allowance Fees': dutyDisplayOrNA(linked?.allowanceFeesOmr),
    'Ticket Fee': dutyDisplayOrNA(linked?.ticketFee),
    'Allowance %': dutyDisplayOrNA(linked?.allowancePercentage),
    'Total': dutyDisplayOrNA(linked?.total),
    'Notes': dutyDisplayOrNA(linked?.notes),
  };
}

/// Annual details: summary + cost fields.
Map<String, String> buildAnnualDutyRequestInfo(RequestModel? request) {
  return {
    ...buildDutyMissionSummary(request),
    'Choose Type': dutyDisplayOrNA(request?.chooseType),
    'Actual Mission Start Date': dutyDisplayOrNA(request?.missionStartDate),
    'Actual Mission End Date': dutyDisplayOrNA(request?.missionEndDate),
    'Mission Days': dutyDisplayOrNA(request?.missionDays),
    ...buildAnnualCostFields(request),
    'Remarks': dutyDisplayOrNA(request?.remarks),
  };
}

/// Planned travel / request fields (summary is shown separately).
/// Does not include Allowance % — that comes from linked annual plan.
Map<String, String> buildPlannedDutyRequestInfo(RequestModel? request) {
  return {
    'Request Type': dutyDisplayOrNA(request?.requestType),
    'Choose Type': dutyDisplayOrNA(request?.chooseType),
    'Paying Entity': dutyDisplayOrNA(
      request?.missionSponsoredBy ?? request?.ifSponsored,
    ),
    'Actual Mission Start Date': dutyDisplayOrNA(request?.missionStartDate),
    'Actual Mission End Date': dutyDisplayOrNA(request?.missionEndDate),
    'From Country': dutyDisplayOrNA(request?.fromCountry),
    'To Country': dutyDisplayOrNA(request?.toCountry),
    'Destination (From)': dutyDisplayOrNA(request?.travellingAreaFrom),
    'Destination (To)': dutyDisplayOrNA(request?.travellingAreaTo),
    'Air Ticket Required': dutyDisplayOrNA(request?.airTicketRequired),
    'Vehicle Required': dutyDisplayOrNA(request?.vehicleRequired),
    'Remarks': dutyDisplayOrNA(request?.remarks),
  };
}

/// Unplanned details: summary + travel.
Map<String, String> buildUnplannedDutyRequestInfo(RequestModel? request) {
  return {
    ...buildDutyMissionSummary(request),
    'Request Type': dutyDisplayOrNA(request?.requestType),
    'Choose Type': dutyDisplayOrNA(request?.chooseType),
    'Paying Entity': dutyDisplayOrNA(
      request?.missionSponsoredBy ?? request?.ifSponsored,
    ),
    'Actual Mission Start Date': dutyDisplayOrNA(request?.missionStartDate),
    'Actual Mission End Date': dutyDisplayOrNA(request?.missionEndDate),
    'From Country': dutyDisplayOrNA(request?.fromCountry),
    'To Country': dutyDisplayOrNA(request?.toCountry),
    'Destination (From)': dutyDisplayOrNA(request?.travellingAreaFrom),
    'Destination (To)': dutyDisplayOrNA(request?.travellingAreaTo),
    'Air Ticket Required': dutyDisplayOrNA(request?.airTicketRequired),
    'Vehicle Required': dutyDisplayOrNA(request?.vehicleRequired),
    'Allowance %': dutyDisplayOrNA(request?.allowancePercentage),
    'Remarks': dutyDisplayOrNA(request?.remarks),
  };
}
