import 'package:code_setup/presentation/screens/aviation_security_Facilitation/airport_entry_permit/pdf/airport_permit_pdf_colors.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/airport_entry_request_model.dart';
import 'package:pdf/pdf.dart';

class AirportPermitAreaDefinition {
  final String key;
  final String code;
  final String arabic;
  final PdfColor color;

  const AirportPermitAreaDefinition({
    required this.key,
    required this.code,
    required this.arabic,
    required this.color,
  });
}

class AirportPermitSelectedArea {
  final String code;
  final String arabic;
  final PdfColor color;
  final String workTask;

  const AirportPermitSelectedArea({
    required this.code,
    required this.arabic,
    required this.color,
    required this.workTask,
  });
}

/// Maps English area names (including React alternate names) to code / Arabic / color.
abstract final class AirportPermitAreaMapper {
  AirportPermitAreaMapper._();

  static const List<AirportPermitAreaDefinition> allAreas = [
    AirportPermitAreaDefinition(
      key: 'VIP Building',
      code: 'VIP',
      arabic: 'مبنى كبار الشخصيات',
      color: AirportPermitPdfColors.vipLavender,
    ),
    AirportPermitAreaDefinition(
      key: 'Cargo Building (Imports & Exports)',
      code: 'Car',
      arabic: 'مبنى الشحن (الصادر والوارد)',
      color: AirportPermitPdfColors.cargoBlue,
    ),
    AirportPermitAreaDefinition(
      key: 'Arrivals Hall / Arrivals Building',
      code: 'Arr',
      arabic: 'صالة القادمين ومبنى القادمين',
      color: AirportPermitPdfColors.arrivalOrange,
    ),
    AirportPermitAreaDefinition(
      key: 'Departures Hall / Departures Building',
      code: 'Dep',
      arabic: 'صالة المغادرين ومبنى المغادرين',
      color: AirportPermitPdfColors.departureGreen,
    ),
    AirportPermitAreaDefinition(
      key: 'Information Center / Control Tower',
      code: 'ATC',
      arabic: 'مبنى مركز المعلومات وبرج المراقبة',
      color: AirportPermitPdfColors.atcYellow,
    ),
    AirportPermitAreaDefinition(
      key:
          'Aircraft Parking Area, Aircraft Maintenance Building, Vehicle Repair Workshop, Fire Station, and Fueling Stations',
      code: 'Apr',
      arabic:
          'ساحة مواقف الطائرات، مبنى صيانة الطائرات، ورشة تصليح المركبات، مركز الإطفاء ومحطات تعبئة الوقود.',
      color: AirportPermitPdfColors.aprBlue,
    ),
    AirportPermitAreaDefinition(
      key: 'Baggage Sorting Area',
      code: 'BHS',
      arabic: 'منطقة فرز الحقائب',
      color: AirportPermitPdfColors.bhsPink,
    ),
    AirportPermitAreaDefinition(
      key: 'Catering Building',
      code: 'Cat',
      arabic: 'مبنى التموين',
      color: AirportPermitPdfColors.catGray,
    ),
    AirportPermitAreaDefinition(
      key: 'Aircraft Maintenance Building',
      code: 'MRO',
      arabic: 'مبنى صيانة الطائرات',
      color: AirportPermitPdfColors.mroBrown,
    ),
    AirportPermitAreaDefinition(
      key: 'Gold Building',
      code: 'GLD',
      arabic: 'مبنى الذهب',
      color: AirportPermitPdfColors.goldBuilding,
    ),
  ];

  static final Map<String, AirportPermitAreaDefinition> _aliasMap = {
    'VIP Building': allAreas[0],
    'VIP building': allAreas[0],
    'Cargo Building (Imports & Exports)': allAreas[1],
    'Cargo Building with import and export sections': allAreas[1],
    'Arrivals Hall / Arrivals Building': allAreas[2],
    '[ Arrivals Hall] and Arrivals building': allAreas[2],
    'Departures Hall / Departures Building': allAreas[3],
    '[departures Hall ] and departures building': allAreas[3],
    'Information Center / Control Tower': allAreas[4],
    'Information centre and control tower building': allAreas[4],
    'Aircraft Parking Area, Aircraft Maintenance Building, Vehicle Repair Workshop, Fire Station, and Fueling Stations':
        allAreas[5],
    'Vehicle, Aircraft building, Aircraft parking area, fire station and fuel filling stations, repair shop':
        allAreas[5],
    'Baggage Sorting Area': allAreas[6],
    'Baggage sorting area': allAreas[6],
    'Catering Building': allAreas[7],
    'Supply building': allAreas[7],
    'Aircraft Maintenance Building': allAreas[8],
    'Gold Building': allAreas[9],
  };

  /// Builds ordered table rows for every known area, with work tasks for selected ones.
  static List<AirportPermitSelectedArea> buildTableRows(
    List<PermissionToRequiredAreas>? permissionAreas,
  ) {
    final selectedCodes = <String>{};
    final selectedTasks = <String, String>{};
    final processed = <String>{};

    final areas = permissionAreas ?? const <PermissionToRequiredAreas>[];
    for (final areaObj in areas) {
      final permitName = (areaObj.permit ?? '').trim();
      final workTask = (areaObj.text ?? '').trim();
      if (permitName.isEmpty) continue;

      final normalized = permitName.toLowerCase();
      if (processed.contains(normalized)) continue;
      processed.add(normalized);

      final matched = _matchArea(permitName);
      if (matched == null) continue;

      if (!selectedCodes.contains(matched.code)) {
        selectedCodes.add(matched.code);
        selectedTasks[matched.code] = workTask;
      } else if (workTask.isNotEmpty) {
        final existing = selectedTasks[matched.code] ?? '';
        if (workTask != existing) {
          selectedTasks[matched.code] = existing.isEmpty
              ? workTask
              : '$existing\n$workTask';
        }
      }
    }

    return allAreas
        .map(
          (area) => AirportPermitSelectedArea(
            code: area.code,
            arabic: area.arabic,
            color: area.color,
            workTask: selectedCodes.contains(area.code)
                ? (selectedTasks[area.code] ?? '')
                : '',
          ),
        )
        .toList();
  }

  static AirportPermitAreaDefinition? _matchArea(String areaStr) {
    for (final entry in _aliasMap.entries) {
      final key = entry.key;
      if (areaStr.toLowerCase().contains(key.toLowerCase()) ||
          key.toLowerCase().contains(areaStr.toLowerCase())) {
        return entry.value;
      }
    }

    for (final area in allAreas) {
      if (areaStr.toLowerCase().contains(area.code.toLowerCase()) ||
          areaStr.toLowerCase().contains(area.arabic.toLowerCase()) ||
          area.key.toLowerCase().contains(areaStr.toLowerCase())) {
        return area;
      }
    }
    return null;
  }
}
