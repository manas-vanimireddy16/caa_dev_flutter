import 'package:pdf/widgets.dart' as pw;

import '../airport_permit_pdf_colors.dart';
import '../airport_permit_pdf_constants.dart';
import '../airport_permit_pdf_data.dart';
import 'pdf_primitives.dart';

class PermitDurationWidget extends pw.StatelessWidget {
  final AirportPermitPdfData data;
  final pw.Font regularFont;
  final pw.Font boldFont;

  PermitDurationWidget({
    required this.data,
    required this.regularFont,
    required this.boldFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    final start = data.temporaryStartDate.isEmpty
        ? '___'
        : data.temporaryStartDate;
    final end = data.temporaryEndDate.isEmpty ? '___' : data.temporaryEndDate;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        airportPermitSectionTitle(
          title: AirportPermitPdfConstants.permitDurationTitle,
          boldFont: boldFont,
        ),
        pw.SizedBox(height: AirportPermitPdfConstants.pt(10)),
        pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Row(
            children: [
              airportPermitCheckboxItem(
                checked: data.isPermanent,
                label: 'دائم',
                regularFont: regularFont,
              ),
              pw.SizedBox(width: AirportPermitPdfConstants.durationGap),
              airportPermitCheckboxItem(
                checked: !data.isPermanent,
                label: 'مؤقت',
                regularFont: regularFont,
              ),
              pw.SizedBox(width: AirportPermitPdfConstants.durationGap),
              pw.Text(
                'من',
                style: pw.TextStyle(
                  font: regularFont,
                  fontSize: AirportPermitPdfConstants.bodyFontSize,
                ),
              ),
              pw.SizedBox(width: AirportPermitPdfConstants.pt(8)),
              _dateInline(start),
              pw.SizedBox(width: AirportPermitPdfConstants.pt(8)),
              pw.Text(
                'إلى',
                style: pw.TextStyle(
                  font: regularFont,
                  fontSize: AirportPermitPdfConstants.bodyFontSize,
                ),
              ),
              pw.SizedBox(width: AirportPermitPdfConstants.pt(8)),
              _dateInline(end),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _dateInline(String value) {
    return pw.Container(
      constraints: pw.BoxConstraints(
        minWidth: AirportPermitPdfConstants.pt(70),
      ),
      padding: pw.EdgeInsets.only(
        left: AirportPermitPdfConstants.pt(4),
        right: AirportPermitPdfConstants.pt(4),
        bottom: AirportPermitPdfConstants.pt(2),
      ),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: AirportPermitPdfColors.black,
            width: 1,
            style: pw.BorderStyle.dotted,
          ),
        ),
      ),
      child: pw.Directionality(
        textDirection: pw.TextDirection.ltr,
        child: pw.Text(
          value,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            font: regularFont,
            fontSize: AirportPermitPdfConstants.bodyFontSize,
            color: AirportPermitPdfColors.black,
          ),
        ),
      ),
    );
  }
}
