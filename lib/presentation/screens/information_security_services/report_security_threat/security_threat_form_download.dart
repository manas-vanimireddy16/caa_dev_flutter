import 'dart:convert';

class SecurityThreatFormDownloadInput {
  const SecurityThreatFormDownloadInput({
    required this.submittedBy,
    required this.department,
    this.contactNumber = '',
    this.priority = '',
    this.ticketName = '',
    this.sourceOfIncident = '',
    this.typeOfIncidentDetected = '',
    this.typeOfThreat = '',
    this.description = '',
    this.title = '',
    this.incidentTicketNumber = '',
    this.computerSystemBreached = '',
  });

  final String submittedBy;
  final String department;
  final String contactNumber;
  final String priority;
  final String ticketName;
  final String sourceOfIncident;
  final String typeOfIncidentDetected;
  final String typeOfThreat;
  final String description;
  final String title;
  final String incidentTicketNumber;
  final String computerSystemBreached;

  /// Excel template pre-fills only these three fields (matches web `downloadExcel`).
  factory SecurityThreatFormDownloadInput.forExcel({
    required String submittedBy,
    required String department,
    String priority = '',
  }) {
    return SecurityThreatFormDownloadInput(
      submittedBy: submittedBy,
      department: department,
      priority: priority,
    );
  }
}

/// Client-side Security Threat incident form export (Excel XML + CSV),
/// matching web `SecurityThreatModal.tsx` downloadExcel / downloadWord.
class SecurityThreatFormDownload {
  static const List<String> _incidentTypes = [
    'Denial of Service',
    'Unauthorized Use / Access / Use of Data / Compromised User Account',
    'Unauthorized changes to systems, software, or data',
    'Malicious Code',
    'Unplanned Downtime',
    'Loss or Theft of equipment',
    'Ransomware Attacks',
    'Physical Security Breach',
    'Leakage of Secret or Top Secret Data',
    'Other',
  ];

  static const List<String> _notificationInCaa = [
    'Head of Information Security',
    'Director of Information Technology',
    'Legal Department',
    'Head of Infrastructure',
  ];

  static const List<String> _notificationOutsideCaa = [
    'Cyber Defense Center',
    'ROP',
    'MTCIT',
  ];

  static const List<String> _actionFields = [
    'Identification Measures (Incident Verified, Assessed, Options Evaluated)',
    'Containment Measures',
    'Evidence Collected (system logs, audit logs etc.)',
    'Eradication/Mitigation Measures',
    'Recovery Measures',
    'Other Mitigation Measures',
  ];

  static const List<String> _evaluationFields = [
    'How good was the response?',
    'Were our documented procedures followed and effective?',
    'Were any steps taken which inhibited recovery?',
    'How could we improve our readiness and procedures?',
  ];

  static String escapeXml(String unsafe) {
    if (unsafe.isEmpty) return '';
    return unsafe
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');
  }

  static String fileDateSuffix() {
    final now = DateTime.now();
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    return '${now.year}-$month-$day';
  }

  static String excelFileName() =>
      'Security_Threat_Incident_Form_${fileDateSuffix()}.xls';

  static String csvFileName() =>
      'Security_Threat_Incident_Form_${fileDateSuffix()}.csv';

  static String _headerRow(String text) {
    return '''    <Row>
      <Cell ss:StyleID="Header" ss:MergeAcross="1">
        <Data ss:Type="String">${escapeXml(text)}</Data>
      </Cell>
    </Row>''';
  }

  static String _labelFieldRow(String label, [String value = '']) {
    final escapedLabel = escapeXml(label);
    final valueCell = value.isEmpty
        ? '      <Cell ss:StyleID="Field"></Cell>'
        : '''      <Cell ss:StyleID="Field">
        <Data ss:Type="String">${escapeXml(value)}</Data>
      </Cell>''';

    return '''    <Row>
      <Cell ss:StyleID="Label"><Data ss:Type="String">$escapedLabel</Data></Cell>
$valueCell
    </Row>''';
  }

  static String _longLabelFieldRow(String label, [String value = '']) {
    final escapedLabel = escapeXml(label);
    final valueCell = value.isEmpty
        ? '      <Cell ss:StyleID="Field"></Cell>'
        : '''      <Cell ss:StyleID="Field">
        <Data ss:Type="String">${escapeXml(value)}</Data>
      </Cell>''';

    return '''    <Row>
      <Cell ss:StyleID="Label">
        <Data ss:Type="String">$escapedLabel</Data>
      </Cell>
$valueCell
    </Row>''';
  }

  static String _blankRow() {
    return '''    <Row>
      <Cell ss:StyleID="Field"></Cell>
      <Cell ss:StyleID="Field"></Cell>
    </Row>''';
  }

  static String buildExcelContent(SecurityThreatFormDownloadInput input) {
    const priorityLabel =
        'Priority (P1- Very Low, P2-Low, P3- Moderate, P4-High, P5- Very High)';

    // Image 1: header, top fields, reporter info, incident types.
    // Image 2: notifications, actions, evaluation questions.
    // Image 3: follow-up and sign-off rows.
    final rows = <String>[
      _headerRow('To be filled by Information Security Team'),
      _labelFieldRow('Incident Ticket Number', input.incidentTicketNumber),
      _labelFieldRow('Ticket Name', input.ticketName),
      _labelFieldRow('Source of Incident', input.sourceOfIncident),
      _labelFieldRow(priorityLabel, input.priority),
      _blankRow(),
      _labelFieldRow('Submitted By', input.submittedBy),
      _labelFieldRow('Title', input.title),
      _labelFieldRow('Department', input.department),
      _longLabelFieldRow(
        'Computer System/Server/Application Breached',
        input.computerSystemBreached,
      ),
      _headerRow('Type of Incident Detected'),
      ..._incidentTypes.map(_labelFieldRow),
      _blankRow(),
      _headerRow('Incident Notification in CAA'),
      ..._notificationInCaa.map(_labelFieldRow),
      _blankRow(),
      _headerRow('Incident Notification Outside CAA'),
      ..._notificationOutsideCaa.map(_labelFieldRow),
      _blankRow(),
      _headerRow('Actions'),
      ..._actionFields.map(_labelFieldRow),
      _blankRow(),
      _headerRow('Evaluation'),
      ..._evaluationFields.map(_labelFieldRow),
      _blankRow(),
      _labelFieldRow('Follow up'),
      _blankRow(),
      _labelFieldRow('Reviewed by'),
      _blankRow(),
      _labelFieldRow('Director of IT'),
      _labelFieldRow('CISO/Head of Information Security'),
    ];

    return '''<?xml version="1.0"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">

<Styles>
    <Style ss:ID="Header">
      <Font ss:Bold="1" ss:Size="12"/>
      <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
      <Borders>
        <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
        <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
        <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
        <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
      </Borders>
    </Style>

    <Style ss:ID="Label">
      <Font ss:Bold="1"/>
      <Alignment ss:Vertical="Center"/>
      <Borders>
        <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
        <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
        <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
        <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
      </Borders>
    </Style>

    <Style ss:ID="Field">
      <Borders>
        <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
        <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
        <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
        <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
      </Borders>
    </Style>
</Styles>

<Worksheet ss:Name="Incident Form">
<Table>
    <Column ss:Width="300"/>
    <Column ss:Width="300"/>

${rows.join('\n\n')}

</Table>
</Worksheet>
</Workbook>''';
  }

  static String buildCsvContent(SecurityThreatFormDownloadInput input) {
    String csvCell(String value) {
      final escaped = value.replaceAll('"', '""');
      return '"$escaped"';
    }

    final rows = <List<String>>[
      ['Field', 'Value'],
      ['Submitted By', input.submittedBy],
      ['Department', input.department],
      ['Contact Number', input.contactNumber],
      ['Priority', input.priority],
      ['Ticket Name', input.ticketName],
      ['Source of Incident', input.sourceOfIncident],
      ['Type of Incident Detected', input.typeOfIncidentDetected],
      ['Type of Threat', input.typeOfThreat],
      ['Description / Additional Notes', input.description],
      ['Incident Date', ''],
      ['Incident Time', ''],
      ['Location', ''],
      ['Systems Affected', ''],
      ['Immediate Actions Taken', ''],
      ['Evidence Collected', ''],
      ['Reported To', ''],
      ['Additional Comments', ''],
    ];

    return rows.map((row) => row.map(csvCell).join(',')).join('\n');
  }

  static List<int> excelBytes(SecurityThreatFormDownloadInput input) {
    return utf8.encode(buildExcelContent(input));
  }

  static List<int> csvBytes(SecurityThreatFormDownloadInput input) {
    return utf8.encode(buildCsvContent(input));
  }
}
