import 'package:pdf/widgets.dart' as pw;

import '../airport_permit_pdf_colors.dart';
import '../airport_permit_pdf_constants.dart';
import '../airport_permit_pdf_data.dart';
import 'pdf_primitives.dart';

class ApplicantDetailsWidget extends pw.StatelessWidget {
  final AirportPermitPdfData data;
  final pw.Font regularFont;
  final pw.Font boldFont;

  ApplicantDetailsWidget({
    required this.data,
    required this.regularFont,
    required this.boldFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        airportPermitSectionTitle(
          title: AirportPermitPdfConstants.applicantSectionTitle,
          boldFont: boldFont,
        ),
        pw.SizedBox(height: AirportPermitPdfConstants.pt(8)),
        pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Column(
            children: [
              _row(
                leftLabel: AirportPermitPdfConstants.labelEmployeeName,
                leftValue: data.employeeName,
                rightLabel: AirportPermitPdfConstants.labelJobTitle,
                rightValue: data.jobTitle,
              ),
              pw.SizedBox(height: AirportPermitPdfConstants.detailsRowGap),
              _row(
                leftLabel: AirportPermitPdfConstants.labelDepartment,
                leftValue: data.department,
                rightLabel: AirportPermitPdfConstants.labelPhone,
                rightValue: data.phoneNumber,
              ),
              pw.SizedBox(height: AirportPermitPdfConstants.detailsRowGap),
              _row(
                leftLabel: AirportPermitPdfConstants.labelNationality,
                leftValue: data.nationality,
                rightLabel: AirportPermitPdfConstants.labelAirport,
                rightValue: data.airportName,
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _row({
    required String leftLabel,
    required String leftValue,
    required String rightLabel,
    required String rightValue,
  }) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(child: _field(leftLabel, leftValue)),
        pw.SizedBox(width: AirportPermitPdfConstants.pt(22)),
        pw.Expanded(child: _field(rightLabel, rightValue)),
      ],
    );
  }

  pw.Widget _field(String label, String value) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            font: boldFont,
            fontSize: AirportPermitPdfConstants.bodyFontSize,
            fontWeight: pw.FontWeight.bold,
            color: AirportPermitPdfColors.black,
          ),
          textDirection: pw.TextDirection.rtl,
        ),
        pw.SizedBox(width: AirportPermitPdfConstants.pt(10)),
        pw.Expanded(
          child: airportPermitDottedValue(
            value: value,
            font: regularFont,
            align: pw.TextAlign.right,
          ),
        ),
      ],
    );
  }
}
