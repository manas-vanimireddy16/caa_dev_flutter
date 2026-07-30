import 'package:pdf/widgets.dart' as pw;

import '../airport_permit_pdf_colors.dart';
import '../airport_permit_pdf_constants.dart';
import 'pdf_primitives.dart';

class ApprovalSectionWidget extends pw.StatelessWidget {
  final String departmentDirectorName;
  final pw.Font regularFont;
  final pw.Font boldFont;

  ApprovalSectionWidget({
    required this.departmentDirectorName,
    required this.regularFont,
    required this.boldFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Table(
        border: pw.TableBorder.all(
          color: AirportPermitPdfColors.black,
          width: 1,
        ),
        columnWidths: const {
          0: pw.FlexColumnWidth(1),
          1: pw.FlexColumnWidth(1),
        },
        children: [
          pw.TableRow(
            decoration: const pw.BoxDecoration(
              color: AirportPermitPdfColors.approvalHeaderGray,
            ),
            children: [
              _header(AirportPermitPdfConstants.deptDirectorHeader),
              _header(AirportPermitPdfConstants.aviationSecurityHeader),
            ],
          ),
          pw.TableRow(
            children: [
              _departmentDirectorBody(),
              _aviationSecurityBody(),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _header(String text) {
    return pw.Container(
      padding: pw.EdgeInsets.all(AirportPermitPdfConstants.pt(10)),
      alignment: pw.Alignment.center,
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          font: boldFont,
          fontSize: AirportPermitPdfConstants.bodyFontSize,
          fontWeight: pw.FontWeight.bold,
          color: AirportPermitPdfColors.black,
        ),
        textDirection: pw.TextDirection.rtl,
      ),
    );
  }

  pw.Widget _departmentDirectorBody() {
    return pw.Container(
      padding: pw.EdgeInsets.all(AirportPermitPdfConstants.pt(10)),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          _labeledLine('الاسم:', departmentDirectorName),
          pw.SizedBox(height: AirportPermitPdfConstants.pt(10)),
          _labeledLine('التوقيع/ الختم:', ''),
        ],
      ),
    );
  }

  pw.Widget _aviationSecurityBody() {
    return pw.Container(
      padding: pw.EdgeInsets.all(AirportPermitPdfConstants.pt(10)),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          _choice('أوافق على إصدار التصريح.'),
          pw.SizedBox(height: AirportPermitPdfConstants.pt(6)),
          _choice('لا أوافق على إصدار التصريح.'),
          pw.SizedBox(height: AirportPermitPdfConstants.pt(14)),
          _labeledLine('الملاحظات:', ''),
        ],
      ),
    );
  }

  pw.Widget _choice(String label) {
    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          airportPermitCheckbox(checked: false),
          pw.SizedBox(width: AirportPermitPdfConstants.pt(8)),
          pw.Expanded(
            child: pw.Text(
              label,
              style: pw.TextStyle(
                font: regularFont,
                fontSize: AirportPermitPdfConstants.bodyFontSize,
                color: AirportPermitPdfColors.black,
              ),
              textDirection: pw.TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _labeledLine(String label, String value) {
    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Row(
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
          ),
          pw.SizedBox(width: AirportPermitPdfConstants.pt(8)),
          pw.Expanded(
            child: airportPermitDottedValue(
              value: value,
              font: regularFont,
              align: pw.TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
