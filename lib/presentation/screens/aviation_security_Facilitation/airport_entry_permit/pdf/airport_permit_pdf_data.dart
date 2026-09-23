import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/airport_entry_permit/pdf/airport_permit_area_mapper.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/airport_entry_request_model.dart';

/// Flattened view-model used by the PDF generator.
/// Field extraction mirrors the web `generateAirportEntryPermitArabicPDF`.
class AirportPermitPdfData {
  final String employeeName;
  final String jobTitle;
  final String department;
  final String phoneNumber;
  final String nationality;
  final String airportName;
  final String categoryOfPermit;
  final String typeOfPermit;
  final String temporaryStartDate;
  final String temporaryEndDate;
  final List<String> additionalServices;
  final List<AirportPermitSelectedArea> areaRows;
  final String departmentDirectorName;
  final int? requestId;

  const AirportPermitPdfData({
    required this.employeeName,
    required this.jobTitle,
    required this.department,
    required this.phoneNumber,
    required this.nationality,
    required this.airportName,
    required this.categoryOfPermit,
    required this.typeOfPermit,
    required this.temporaryStartDate,
    required this.temporaryEndDate,
    required this.additionalServices,
    required this.areaRows,
    required this.departmentDirectorName,
    this.requestId,
  });

  factory AirportPermitPdfData.fromRequestDetails(RequestDetailData details) {
    final request = details.request;
    final createdByUser = request?.createdByUser ?? details.createdByUser;
    final reqDepartment = request?.reqDepartment ?? details.reqDepartment;
    final raw = details.rawJson ?? const <String, dynamic>{};
    final rawRequest = raw['request'] is Map
        ? Map<String, dynamic>.from(raw['request'] as Map)
        : raw;

    // Web: createdByUser?.employee_name || createdByUser?.name
    final employeeName = _firstNonEmpty([
      createdByUser?.employeeName,
      rawRequest['created_by_user'] is Map
          ? (rawRequest['created_by_user'] as Map)['employee_name']?.toString()
          : null,
      raw['created_by_user'] is Map
          ? (raw['created_by_user'] as Map)['employee_name']?.toString()
          : null,
    ]);

    // Web: job_title?.name || job_title || position?.name
    final jobTitle = _firstNonEmpty([
      createdByUser?.position?.name,
      request?.occupationStaff,
      details.occupationStaff,
      rawRequest['occupation_staff']?.toString(),
    ]);

    final department = _firstNonEmpty([
      reqDepartment?.departmentName,
      rawRequest['req_department'] is Map
          ? (rawRequest['req_department'] as Map)['department_name']?.toString()
          : null,
    ]);

    // Web: createdByUser?.mobile || phone_number
    final phoneNumber = _firstNonEmpty([
      createdByUser?.mobile,
      createdByUser?.officeNumber,
      request?.phoneNumber,
      details.phoneNumber,
      rawRequest['phone_number']?.toString(),
    ]);

    final nationality = _firstNonEmpty([
      request?.nationality,
      details.nationality,
      rawRequest['nationality']?.toString(),
    ]);

    final airportName = _firstNonEmpty([
      request?.location,
      details.location,
      rawRequest['location']?.toString(),
      request?.place,
      details.place,
    ]);

    // Web exact strings for checkbox matching
    final categoryOfPermit = _firstNonEmpty([
      request?.categoryOfPermit,
      details.categoryOfPermit,
      rawRequest['category_of_permit']?.toString(),
    ]);

    final typeOfPermit = _firstNonEmpty([
      request?.typeOfPermit,
      details.typeOfPermit,
      rawRequest['type_of_permit']?.toString(),
    ]);

    // Web uses temporary_start_date / temporary_end_date;
    // API also returns temporary_start_time / end_date
    final temporaryStartDate = _formatDate(
      _firstNonEmpty([
        request?.temporaryStartTime,
        details.temporaryStartTime,
        rawRequest['temporary_start_time']?.toString(),
        rawRequest['temporary_start_date']?.toString(),
      ]),
    );
    final temporaryEndDate = _formatDate(
      _firstNonEmpty([
        request?.endDate,
        details.endDate,
        rawRequest['end_date']?.toString(),
        rawRequest['temporary_end_date']?.toString(),
      ]),
    );

    final additionalServices = _parseAdditionalServices(
      request?.additionalServices ?? rawRequest['additional_services'],
    );

    final permissionAreas =
        request?.permissionToRequiredAreas ??
        _permissionAreasFromRaw(rawRequest['permission_to_required_areas']) ??
        _coercePermissionAreas(details.permissionToRequiredAreas);

    final departmentDirectorName = _resolveDepartmentDirectorName(details, raw);

    return AirportPermitPdfData(
      employeeName: employeeName,
      jobTitle: jobTitle,
      department: department,
      phoneNumber: phoneNumber,
      nationality: nationality,
      airportName: airportName,
      categoryOfPermit: categoryOfPermit,
      typeOfPermit: typeOfPermit,
      temporaryStartDate: temporaryStartDate,
      temporaryEndDate: temporaryEndDate,
      additionalServices: additionalServices,
      areaRows: AirportPermitAreaMapper.buildTableRows(permissionAreas),
      departmentDirectorName: departmentDirectorName,
      requestId: request?.id ?? details.id,
    );
  }

  /// Web: `typeOfPermit === "Permanent"`
  bool get isPermanent => _norm(typeOfPermit) == 'permanent';

  /// Web: `!isPermanent`
  bool get isTemporary => !isPermanent;

  /// Web: categoryOfPermit === "Issuing New Permit"
  bool get isIssuing => _categoryIs('issuing new permit', 'issuance');

  /// Web: categoryOfPermit === "Renewal of Permit"
  bool get isRenewal => _categoryIs('renewal of permit', 'renewal');

  /// Web: "Replacement for Lost Permit" / form: "Replacing lost"
  bool get isReplacement => _categoryIs(
    'replacement for lost permit',
    'replacing lost',
    'replacement for lost',
  );

  /// Web: categoryOfPermit === "Adding Areas"
  bool get isAddingAreas => _categoryIs('adding areas', 'adding areas/zones');

  /// Web: categoryOfPermit === "Change of Profession"
  bool get isChangeProfession => _categoryIs(
    'change of profession',
    'change of title',
    'change of title/designation',
  );

  /// Web: additionalServicesArray.includes("Laptop / Tablet")
  bool get hasLaptopTablet => _serviceIs('laptop / tablet', 'laptop/tablet');

  /// Web: additionalServicesArray.includes("Boarding the Aircraft")
  bool get hasBoardingAssistance =>
      _serviceIs('boarding the aircraft', 'airport boarding assistance');

  /// Web: includes("Employee Assisting People with Special Needs")
  bool get hasSpecialNeedsAssistance => _serviceIs(
    'employee assisting people with special needs',
    'employee assisting persons with special needs',
  );

  bool _categoryIs(String primary, [String? a, String? b]) {
    final value = _norm(categoryOfPermit);
    if (value.isEmpty) return false;
    if (value == primary || value.contains(primary)) return true;
    if (a != null && (value == a || value.contains(a))) return true;
    if (b != null && (value == b || value.contains(b))) return true;
    return false;
  }

  bool _serviceIs(String primary, [String? alt]) {
    for (final service in additionalServices) {
      final value = _norm(service);
      if (value == primary || value.contains(primary)) return true;
      if (alt != null && (value == alt || value.contains(alt))) return true;
    }
    return false;
  }

  static String _norm(String value) => value.trim().toLowerCase();

  static String _resolveDepartmentDirectorName(
    RequestDetailData details,
    Map<String, dynamic> raw,
  ) {
    final approvalDetails = details.approvalDetails ?? const [];
    for (final a in approvalDetails) {
      final status = (a.approvalStatus ?? '').toLowerCase().trim();
      if (status == 'approved' || status == 'closed') {
        final name = _firstNonEmpty([
          a.approverUser?.employeeName,
          a.approvedByUser?.employeeName,
        ]);
        if (name.isNotEmpty) return name;
      }
    }

    final rawApprovals = raw['approval_details'];
    if (rawApprovals is List) {
      for (final item in rawApprovals) {
        if (item is! Map) continue;
        final status =
            (item['approval_status'] ?? '').toString().toLowerCase().trim();
        if (status != 'approved' && status != 'closed') continue;
        final approver = item['approver_user'];
        final approvedBy = item['approved_by_user'];
        final name = _firstNonEmpty([
          approver is Map ? approver['employee_name']?.toString() : null,
          approvedBy is Map ? approvedBy['employee_name']?.toString() : null,
        ]);
        if (name.isNotEmpty) return name;
      }
    }
    return '';
  }

  static String _firstNonEmpty(List<String?> values) {
    for (final value in values) {
      final trimmed = value?.trim() ?? '';
      if (trimmed.isNotEmpty && trimmed.toLowerCase() != 'null') {
        return trimmed;
      }
    }
    return '';
  }

  static String _formatDate(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return '';
    if (value.contains('T')) return value.split('T').first;
    if (value.length >= 10 && value[4] == '-' && value[7] == '-') {
      return value.substring(0, 10);
    }
    return value;
  }

  static List<String> _parseAdditionalServices(dynamic raw) {
    if (raw == null) return const [];
    if (raw is String) {
      return raw
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
    }
    if (raw is List) {
      return raw
          .map((e) => e?.toString().trim() ?? '')
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return const [];
  }

  static List<PermissionToRequiredAreas>? _permissionAreasFromRaw(dynamic raw) {
    if (raw is! List || raw.isEmpty) return null;
    return raw
        .whereType<Map>()
        .map(
          (e) => PermissionToRequiredAreas(
            permit: e['permit']?.toString(),
            text: e['text']?.toString(),
          ),
        )
        .toList();
  }

  static List<PermissionToRequiredAreas>? _coercePermissionAreas(
    List<String>? raw,
  ) {
    if (raw == null || raw.isEmpty) return null;
    return raw
        .map((e) => PermissionToRequiredAreas(permit: e, text: ''))
        .toList();
  }
}
