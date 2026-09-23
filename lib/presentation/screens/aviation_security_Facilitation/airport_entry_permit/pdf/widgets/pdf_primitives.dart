import 'dart:convert';

import 'package:pdf/widgets.dart' as pw;

import '../airport_permit_pdf_colors.dart';
import '../airport_permit_pdf_constants.dart';

/// Pre-rendered checkmark image — does not depend on fonts or CustomPaint.
final pw.MemoryImage airportPermitCheckMarkImage = pw.MemoryImage(
  base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAgklEQVR4nO3W0QqAMAiFYd//pesuYqQ7TqeDjrC7tf8bFCRX8wgBBBBQEhF5VjngHS8HjPFSABLfBkDjWwBf8XaAub8zrgI8B0TiEAC6xWIcBpgvUSCuAtCDo3ETMAt4P7clgIXIiEMALZYRhwEzRGRcT2fH3YARkTH/+CUjgICjATcbeYo7QMXckgAAAABJRU5ErkJggg==',
  ),
);

/// Checkbox matching the web `renderCheckbox` look.
pw.Widget airportPermitCheckbox({required bool checked}) {
  final size = AirportPermitPdfConstants.checkboxSize;
  return pw.Container(
    width: size,
    height: size,
    alignment: pw.Alignment.center,
    decoration: pw.BoxDecoration(
      border: pw.Border.all(
        color: AirportPermitPdfColors.black,
        width: 1.2,
      ),
      color: AirportPermitPdfColors.white,
    ),
    child: checked
        ? pw.Image(
            airportPermitCheckMarkImage,
            width: size * 0.78,
            height: size * 0.78,
            fit: pw.BoxFit.contain,
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
        pw.SizedBox(width: AirportPermitPdfConstants.pt(6)),
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
      minHeight: minHeight ?? AirportPermitPdfConstants.pt(14),
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
    padding: pw.EdgeInsets.only(bottom: AirportPermitPdfConstants.pt(2)),
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
