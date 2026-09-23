/// Layout constants for the Airport Entry Permit A4 PDF.
/// Tuned to fit the full form on a single A4 page.
abstract final class AirportPermitPdfConstants {
  AirportPermitPdfConstants._();

  static const double pxToPt = 0.75;

  static double pt(double pixels) => pixels * pxToPt;

  static final margin = pt(14);

  static final logoMaxWidth = pt(72);
  static final logoMaxHeight = pt(56);
  static final logoGap = pt(10);

  static final titleFontSize = pt(15);
  static final sectionTitleFontSize = pt(11);
  static final bodyFontSize = pt(9);
  static final tableHeaderFontSize = pt(8);
  static final tableBodyFontSize = pt(7.5);
  static final footerFontSize = pt(7);
  static final checkboxMarkFontSize = pt(9);

  static final checkboxSize = pt(15);
  static final sectionGap = pt(7);
  static final titleTopGap = pt(8);
  static final titleBottomGap = pt(8);
  static final detailsRowGap = pt(7);
  static final checkboxGap = pt(12);
  static final durationGap = pt(18);
  static final tableRowMinHeight = pt(22);
  static final codeColumnWidth = pt(70);
  static final tableCellPadding = pt(4);

  static const String arabicTitle = 'استمارة طلب تصريح أمني لدخول المطار';
  static const String applicantSectionTitle = 'بيانات مقدم الطلب';
  static const String permitTypeTitle = 'نوع التصريح:';
  static const String permitDurationTitle = 'الفترة المطلوبة للتصريح:';
  static const String additionalServicesTitle = 'خدمات إضافية:';

  static const String labelEmployeeName = 'اسم الموظف';
  static const String labelJobTitle = 'المسمى الوظيفي';
  static const String labelDepartment = 'الدائرة';
  static const String labelPhone = 'رقم الهاتف';
  static const String labelNationality = 'الجنسية';
  static const String labelAirport = 'اسم المطار';

  static const String tableCodeHeader = 'الرمز';
  static const String tableAreaHeader = 'المناطق الأمنية المطلوب دخولها للمطار';
  static const String tableTaskHeader = 'مهام العمل المطلوب تأديتها بكل منطقة';

  static const String deptDirectorHeader = 'موافقة مدير الدائرة المختصة';
  static const String aviationSecurityHeader =
      'اعتماد مدير دائرة أمن الطيران والتسهيلات';

  /// Web footer line 1: Arabic | English
  static const String footerLine1Ar =
      'ص.ب: 1، الرمز البريدي: 111، مسقط - سلطنة عمان';
  static const String footerLine1En =
      'P.O. Box: 1, P.C. 111, Muscat - Sultanate of Oman';

  /// Web footer line 2
  static const String footerLine2 =
      'Fax: +968 24354544 | www.caa.gov.om | +968 24354441/2';

  static const String caaLogoAsset = 'assets/images/caa_logo.png';
  static const String fiftyYearsLogoAsset = 'assets/images/50years_image.png';
}
