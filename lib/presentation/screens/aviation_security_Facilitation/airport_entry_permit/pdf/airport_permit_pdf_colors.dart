import 'package:pdf/pdf.dart';

/// Hex colors matching the React Airport Entry Permit PDF reference.
abstract final class AirportPermitPdfColors {
  AirportPermitPdfColors._();

  static const PdfColor black = PdfColor.fromInt(0xFF000000);
  static const PdfColor white = PdfColor.fromInt(0xFFFFFFFF);
  static const PdfColor caaBlue = PdfColor.fromInt(0xFF23245B);
  static const PdfColor headerGray = PdfColor.fromInt(0xFFF0F0F0);
  static const PdfColor approvalHeaderGray = PdfColor.fromInt(0xFFD9D9D9);
  static const PdfColor footerGray = PdfColor.fromInt(0xFF666666);

  static const PdfColor vipLavender = PdfColor.fromInt(0xFFCCC0DA);
  static const PdfColor cargoBlue = PdfColor.fromInt(0xFFDAEEF3);
  static const PdfColor arrivalOrange = PdfColor.fromInt(0xFFFBBF8F);
  static const PdfColor departureGreen = PdfColor.fromInt(0xFF00B050);
  static const PdfColor atcYellow = PdfColor.fromInt(0xFFFFFF00);
  static const PdfColor aprBlue = PdfColor.fromInt(0xFF4D93D9);
  static const PdfColor bhsPink = PdfColor.fromInt(0xFFD86DCD);
  static const PdfColor catGray = PdfColor.fromInt(0xFFD9D9D9);
  static const PdfColor mroBrown = PdfColor.fromInt(0xFF7A4A21);
  static const PdfColor goldBuilding = PdfColor.fromInt(0xFFB8860B);
}
