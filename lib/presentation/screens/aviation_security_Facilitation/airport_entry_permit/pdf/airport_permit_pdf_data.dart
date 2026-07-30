import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/airport_entry_permit/pdf/airport_permit_area_mapper.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/airport_entry_request_model.dart';

/// Flattened view-model used by the PDF generator (business data only).
class AirportPermitPdfData {
  final String employeeName;
  final String jobTitle;
  final String department;
  final String phoneNumber;
  final String nationality;
  final String airportName;
  final String categoryOfPermit;
  final bool isPermanent;
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
    required this.isPermanent,
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

    final employeeName =
        createdByUser?.employeeName ??
        request?.nameFullFamilyName ??
        details.nameFullFamilyName ??
        '';

    final jobTitle =
        createdByUser?.position?.name ??
        request?.occupationStaff ??
        details.occupationStaff ??
        '';

    final department = reqDepartment?.departmentName ?? '';

    final phoneNumber =
        createdByUser?.mobile ??
        request?.phoneNumber ??
        details.phoneNumber ??
        '';

    final nationality = request?.nationality ?? details.nationality ?? '';

    final airportName =
        request?.location ??
        request?.place ??
        details.location ??
        details.place ??
        '';

    final categoryOfPermit =
        request?.categoryOfPermit ?? details.categoryOfPermit ?? '';

    final typeOfPermit = request?.typeOfPermit ?? details.typeOfPermit ?? '';
    final isPermanent = typeOfPermit.toLowerCase() == 'permanent';

    final temporaryStartDate =
        request?.temporaryStartTime ?? details.temporaryStartTime ?? '';
    final temporaryEndDate = request?.endDate ?? details.endDate ?? '';

    final additionalServices =
        request?.additionalServices ?? const <String>[];

    final permissionAreas =
        request?.permissionToRequiredAreas ??
        _coercePermissionAreas(details.permissionToRequiredAreas);

    final approvalDetails = details.approvalDetails ?? const [];
    ApprovalDetailModel? departmentDirectorApproval;
    for (final a in approvalDetails) {
      final status = (a.approvalStatus ?? '').toLowerCase().trim();
      if (status == 'approved' || status == 'closed') {
        departmentDirectorApproval = a;
        break;
      }
    }
    final departmentDirectorName =
        departmentDirectorApproval?.approverUser?.employeeName ??
        departmentDirectorApproval?.approvedByUser?.employeeName ??
        '';

    return AirportPermitPdfData(
      employeeName: employeeName,
      jobTitle: jobTitle,
      department: department,
      phoneNumber: phoneNumber,
      nationality: nationality,
      airportName: airportName,
      categoryOfPermit: categoryOfPermit,
      isPermanent: isPermanent,
      temporaryStartDate: temporaryStartDate,
      temporaryEndDate: temporaryEndDate,
      additionalServices: additionalServices,
      areaRows: AirportPermitAreaMapper.buildTableRows(permissionAreas),
      departmentDirectorName: departmentDirectorName,
      requestId: request?.id ?? details.id,
    );
  }

  bool get isIssuing => categoryOfPermit == 'Issuing New Permit';
  bool get isRenewal => categoryOfPermit == 'Renewal of Permit';
  bool get isReplacement => categoryOfPermit == 'Replacement for Lost Permit';
  bool get isAddingAreas => categoryOfPermit == 'Adding Areas';
  bool get isChangeProfession => categoryOfPermit == 'Change of Profession';

  bool hasAdditionalService(String value) => additionalServices.contains(value);

  static List<PermissionToRequiredAreas>? _coercePermissionAreas(
    List<String>? raw,
  ) {
    if (raw == null || raw.isEmpty) return null;
    return raw
        .map((e) => PermissionToRequiredAreas(permit: e, text: ''))
        .toList();
  }
}
