import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../airport_permit_pdf_colors.dart';
import '../airport_permit_pdf_constants.dart';

/// 16×16 checkbox matching the React PDF markup.
pw.Widget airportPermitCheckbox({required bool checked}) {
  final size = AirportPermitPdfConstants.checkboxSize;
  return pw.Container(
    width: size,
    height: size,
    alignment: pw.Alignment.center,
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: AirportPermitPdfColors.black, width: 1),
      color: AirportPermitPdfColors.white,
    ),
    child: checked
        ? pw.CustomPaint(
            size: PdfPoint(size, size),
            painter: (PdfGraphics canvas, PdfPoint size) {
              final w = size.x;
              final h = size.y;
              canvas
                ..setStrokeColor(AirportPermitPdfColors.black)
                ..setLineWidth(1.4)
                ..setLineCap(PdfLineCap.round)
                ..drawLine(w * 0.22, h * 0.52, w * 0.42, h * 0.72)
                ..drawLine(w * 0.42, h * 0.72, w * 0.78, h * 0.28);
            },
          )
        : null,
  );
}

pw.Widget airportPermitCheckboxItem({
  required bool checked,
  required String label,
  required pw.Font regularFont,
}) {
  return pw.Directionality(
    textDirection: pw.TextDirection.rtl,
    child: pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        airportPermitCheckbox(checked: checked),
        pw.SizedBox(width: AirportPermitPdfConstants.pt(8)),
        pw.Text(
          label,
          style: pw.TextStyle(
            font: regularFont,
            fontSize: AirportPermitPdfConstants.bodyFontSize,
            color: AirportPermitPdfColors.black,
          ),
        ),
      ],
    ),
  );
}

/// Dotted underline field used for applicant values and approval lines.
pw.Widget airportPermitDottedValue({
  required String value,
  required pw.Font font,
  pw.TextAlign align = pw.TextAlign.right,
  double? minHeight,
}) {
  return pw.Container(
    constraints: pw.BoxConstraints(
      minHeight: minHeight ?? AirportPermitPdfConstants.pt(18),
    ),
    alignment: align == pw.TextAlign.right
        ? pw.Alignment.centerRight
        : pw.Alignment.centerLeft,
    decoration: const pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(
          color: AirportPermitPdfColors.black,
          width: 1,
          style: pw.BorderStyle.dotted,
        ),
      ),
    ),
    padding: pw.EdgeInsets.only(bottom: AirportPermitPdfConstants.pt(4)),
    child: pw.Text(
      value,
      maxLines: 2,
      style: pw.TextStyle(
        font: font,
        fontSize: AirportPermitPdfConstants.bodyFontSize,
        color: AirportPermitPdfColors.black,
      ),
      textAlign: align,
    ),
  );
}

pw.Widget airportPermitSectionTitle({
  required String title,
  required pw.Font boldFont,
}) {
  return pw.Align(
    alignment: pw.Alignment.centerRight,
    child: pw.Text(
      title,
      style: pw.TextStyle(
        font: boldFont,
        fontSize: AirportPermitPdfConstants.sectionTitleFontSize,
        fontWeight: pw.FontWeight.bold,
        color: AirportPermitPdfColors.black,
      ),
      textDirection: pw.TextDirection.rtl,
    ),
  );
}
