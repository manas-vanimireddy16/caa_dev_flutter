import 'package:pdf/widgets.dart' as pw;

import '../airport_permit_pdf_colors.dart';
import '../airport_permit_pdf_constants.dart';
import 'pdf_primitives.dart';

/// Matches web approval table — agree/disagree stay empty for wet signature.
/// Single TableRow keeps header + body together (no page split).
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
    return pw.Table(
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
          children: [
            _column(
              header: AirportPermitPdfConstants.aviationSecurityHeader,
              body: _aviationSecurityBody(),
            ),
            _column(
              header: AirportPermitPdfConstants.deptDirectorHeader,
              body: _departmentDirectorBody(),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _column({required String header, required pw.Widget body}) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        pw.Container(
          color: AirportPermitPdfColors.approvalHeaderGray,
          padding: pw.EdgeInsets.symmetric(
            horizontal: AirportPermitPdfConstants.pt(8),
            vertical: AirportPermitPdfConstants.pt(6),
          ),
          alignment: pw.Alignment.center,
          child: pw.Text(
            header,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              font: boldFont,
              fontSize: AirportPermitPdfConstants.bodyFontSize,
              fontWeight: pw.FontWeight.bold,
              color: AirportPermitPdfColors.black,
            ),
            textDirection: pw.TextDirection.rtl,
          ),
        ),
        pw.Container(height: 1, color: AirportPermitPdfColors.black),
        body,
      ],
    );
  }

  pw.Widget _departmentDirectorBody() {
    return pw.Container(
      padding: pw.EdgeInsets.all(AirportPermitPdfConstants.pt(8)),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          _labeledLine('الاسم:', departmentDirectorName),
          pw.SizedBox(height: AirportPermitPdfConstants.pt(8)),
          _labeledLine('التوقيع/ الختم:', ''),
        ],
      ),
    );
  }

  pw.Widget _aviationSecurityBody() {
    return pw.Container(
      padding: pw.EdgeInsets.all(AirportPermitPdfConstants.pt(8)),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          _choice('أوافق على إصدار التصريح.'),
          pw.SizedBox(height: AirportPermitPdfConstants.pt(4)),
          _choice('لا أوافق على إصدار التصريح.'),
          pw.SizedBox(height: AirportPermitPdfConstants.pt(8)),
          _labeledLine('الملاحظات:', ''),
        ],
      ),
    );
  }

  pw.Widget _choice(String label) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Expanded(
          child: pw.Text(
            label,
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(
              font: regularFont,
              fontSize: AirportPermitPdfConstants.bodyFontSize,
              color: AirportPermitPdfColors.black,
            ),
            textDirection: pw.TextDirection.rtl,
          ),
        ),
        pw.SizedBox(width: AirportPermitPdfConstants.pt(6)),
        airportPermitCheckbox(checked: false),
      ],
    );
  }

  pw.Widget _labeledLine(String label, String value) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: airportPermitDottedValue(
            value: value,
            font: regularFont,
            align: pw.TextAlign.right,
          ),
        ),
        pw.SizedBox(width: AirportPermitPdfConstants.pt(6)),
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
      ],
    );
  }
}
