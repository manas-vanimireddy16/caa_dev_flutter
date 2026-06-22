class AdministrativeDecisionArticle {
  final String title;
  final String body;

  const AdministrativeDecisionArticle({
    required this.title,
    required this.body,
  });
}

/// Content for the official CAA administrative decision document.
class AdministrativeDecisionData {
  final String documentTitle;
  final String introduction;
  final String decisionHeading;
  final List<AdministrativeDecisionArticle> articles;
  final String issuedDate;
  final String signatoryName;
  final String designation;
  final String? approverNote;

  const AdministrativeDecisionData({
    this.documentTitle = 'قرار إداري رقم',
    this.introduction =
        'استنادا إلى قانون الخدمة المدنية الصادر بالمرسوم السلطاني رقم (٢٠٠٤ /١٢٠)، وإلى نظام هيئة الطيران المدني الصادر بالمرسوم السلطاني رقم (٢٠١٣/٤٣)، وإلى اللائحة التنفيذية لقانون الخدمة المدنية الصادرة بالقرار رقم (٢٠١٠/٩)، وبناء على ما تقتضيه مصلحة العمل',
    this.decisionHeading = 'تقرر',
    required this.articles,
    required this.issuedDate,
    this.signatoryName = 'م. نايف بن علي بن حمد العبري',
    this.designation = 'رئيس هيئة الطيران المدني',
    this.approverNote,
  });
}

enum AdministrativeDecisionDocumentType {
  assignment,
  secondment,
  temporaryAssignment,
  serviceTransfer,
  shiftAllowance,
}
