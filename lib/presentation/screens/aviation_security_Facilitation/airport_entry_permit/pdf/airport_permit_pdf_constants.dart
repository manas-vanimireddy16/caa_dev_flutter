/// Layout constants for the Airport Entry Permit A4 PDF.
/// Pixel values from the React 794px-wide layout; PDF uses pt (px × 0.75).
abstract final class AirportPermitPdfConstants {
  AirportPermitPdfConstants._();

  static const double pxToPt = 0.75;

  static double pt(double pixels) => pixels * pxToPt;

  static final margin = pt(18);

  static final logoMaxWidth = pt(100);
  static final logoMaxHeight = pt(80);
  static final logoGap = pt(12);

  static final titleFontSize = pt(18);
  static final sectionTitleFontSize = pt(13);
  static final bodyFontSize = pt(11);
  static final tableHeaderFontSize = pt(10);
  static final tableBodyFontSize = pt(9);
  static final footerFontSize = pt(8);
  static final checkboxMarkFontSize = pt(10);

  static final checkboxSize = pt(16);
  static final sectionGap = pt(12);
  static final titleTopGap = pt(14);
  static final titleBottomGap = pt(14);
  static final detailsRowGap = pt(12);
  static final checkboxGap = pt(18);
  static final durationGap = pt(28);
  static final tableRowMinHeight = pt(42);
  static final codeColumnWidth = pt(90);

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

  static const String footerLine1Ar =
      'ص.ب: 1، الرمز البريدي: 111، مسقط - سلطنة عمان';
  static const String footerLine1En =
      'P.O. Box: 1, P.C. 111, Muscat - Sultanate of Oman';
  static const String footerLine2 =
      'Fax: +968 24354544 | www.caa.gov.om | +968 24354441/2';

  static const String caaLogoAsset = 'assets/images/caa_logo.png';
  static const String fiftyYearsLogoAsset = 'assets/images/50years_image.png';
}
