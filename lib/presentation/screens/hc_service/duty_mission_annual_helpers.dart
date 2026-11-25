/// Total = missionDays × allowance% / 100 × allowanceFee × employeeCount
/// ("10+" counts as 10). Rounded to 3 decimal places.
double calculateAnnualMissionTotal({
  required Object? missionDays,
  required Object? allowancePercentage,
  required Object? allowanceFeesOmr,
  required Object? numberOfEmployees,
}) {
  final days = _toDouble(missionDays);
  final pct = _toDouble(allowancePercentage);
  final fee = _toDouble(allowanceFeesOmr);
  final employees = _employeeCount(numberOfEmployees);
  if (days <= 0 || fee <= 0 || employees <= 0) return 0;
  final raw = days * (pct / 100) * fee * employees;
  return double.parse(raw.toStringAsFixed(3));
}

int _employeeCount(Object? value) {
  if (value == null) return 0;
  final text = value.toString().trim();
  if (text == '10+' || text.toLowerCase() == '10+') return 10;
  return int.tryParse(text) ?? 0;
}

double _toDouble(Object? value) {
  if (value == null) return 0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString().trim()) ?? 0;
}

Map<String, dynamic> buildAnnualMissionBody(
  Map<String, dynamic> values, {
  required String tripType,
  int? serviceId,
  int? subServiceId,
  int? departmentId,
  int? sectionId,
  bool includeRequesterMeta = true,
}) {
  final days = values['missionDays'];
  final pct = values['allowancePercentage'] ?? values['allowance_percentage'];
  final fee = values['allowanceFeesOmr'] ?? values['allowance_fees_omr'];
  final employees = values['noOfEmployees'] ?? values['number_of_employees'];
  final total = calculateAnnualMissionTotal(
    missionDays: days,
    allowancePercentage: pct,
    allowanceFeesOmr: fee,
    numberOfEmployees: employees,
  );

  final sponsored = values['missionSponsoredBy'];
  final companyName = sponsored == 'CAA'
      ? 'CAA'
      : (values['sponsoredCompanyName'] ?? values['company_name']);

  final body = <String, dynamic>{
    'trip_type': tripType,
    'choose_type': values['chooseType'] ?? values['choose_type'],
    'mission_sponsored_by': sponsored,
    'if_sponsored': sponsored,
    'company_name': companyName,
    'mission_purpose': values['missionPurpose'] ?? values['mission_purpose'],
    'mission_number': values['missionNumber'] ?? values['mission_number'],
    'mission_start_date':
        values['missionStartDate'] ?? values['mission_start_date'],
    'mission_end_date': values['missionEndDate'] ?? values['mission_end_date'],
    'mission_days':
        int.tryParse(days?.toString() ?? '') ?? days ?? 0,
    'number_of_employees': employees?.toString(),
    'month': values['month']?.toString(),
    'place_of_mission':
        values['placeOfMission'] ?? values['place_of_mission'],
    'allowance_percentage': pct?.toString(),
    'allowance_fees_omr': fee?.toString(),
    'ticket_fee':
        (values['ticketFee'] ?? values['ticket_fee'])?.toString(),
    'total': total.toStringAsFixed(3),
    'notes': values['notes']?.toString(),
    'remarks': values['remarks']?.toString() ?? '',
  };

  if (includeRequesterMeta) {
    if (serviceId != null) body['service_id'] = serviceId;
    if (subServiceId != null) body['sub_service_id'] = subServiceId;
    if (departmentId != null) body['req_user_department_id'] = departmentId;
    if (sectionId != null) body['req_user_section_id'] = sectionId;
  }

  body.removeWhere(
    (key, value) =>
        value == null || (value is String && value.trim().isEmpty),
  );
  return body;
}
