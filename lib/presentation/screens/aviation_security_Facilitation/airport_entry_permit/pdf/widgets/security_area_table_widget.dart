import 'package:pdf/widgets.dart' as pw;

import '../airport_permit_area_mapper.dart';
import '../airport_permit_pdf_colors.dart';
import '../airport_permit_pdf_constants.dart';

class SecurityAreaTableWidget extends pw.StatelessWidget {
  final List<AirportPermitSelectedArea> rows;
  final pw.Font regularFont;
  final pw.Font boldFont;

  SecurityAreaTableWidget({
    required this.rows,
    required this.regularFont,
    required this.boldFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    // Column widths: Task 28% | Arabic Name 57% | Code 15%
    // In RTL visual order: Code | Arabic | Task
    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Table(
        border: pw.TableBorder.all(
          color: AirportPermitPdfColors.black,
          width: 1,
        ),
        columnWidths: const {
          0: pw.FlexColumnWidth(0.15),
          1: pw.FlexColumnWidth(0.57),
          2: pw.FlexColumnWidth(0.28),
        },
        defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
        children: [
          pw.TableRow(
            decoration: const pw.BoxDecoration(
              color: AirportPermitPdfColors.headerGray,
            ),
            children: [
              _headerCell(AirportPermitPdfConstants.tableCodeHeader),
              _headerCell(AirportPermitPdfConstants.tableAreaHeader),
              _headerCell(AirportPermitPdfConstants.tableTaskHeader),
            ],
          ),
          for (final row in rows)
            pw.TableRow(
              children: [
                _codeCell(row),
                _areaCell(row),
                _taskCell(row.workTask),
              ],
            ),
        ],
      ),
    );
  }

  pw.Widget _headerCell(String text) {
    return pw.Container(
      padding: pw.EdgeInsets.all(AirportPermitPdfConstants.pt(10)),
      alignment: pw.Alignment.center,
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          font: boldFont,
          fontSize: AirportPermitPdfConstants.tableHeaderFontSize,
          fontWeight: pw.FontWeight.bold,
          color: AirportPermitPdfColors.black,
        ),
        textDirection: pw.TextDirection.rtl,
      ),
    );
  }

  pw.Widget _codeCell(AirportPermitSelectedArea row) {
    return pw.Container(
      constraints: pw.BoxConstraints(
        minHeight: AirportPermitPdfConstants.tableRowMinHeight,
      ),
      color: row.color,
      padding: pw.EdgeInsets.all(AirportPermitPdfConstants.pt(8)),
      alignment: pw.Alignment.center,
      child: pw.Directionality(
        textDirection: pw.TextDirection.ltr,
        child: pw.Text(
          row.code,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            font: boldFont,
            fontSize: AirportPermitPdfConstants.tableBodyFontSize,
            fontWeight: pw.FontWeight.bold,
            color: AirportPermitPdfColors.black,
          ),
        ),
      ),
    );
  }

  pw.Widget _areaCell(AirportPermitSelectedArea row) {
    return pw.Container(
      constraints: pw.BoxConstraints(
        minHeight: AirportPermitPdfConstants.tableRowMinHeight,
      ),
      color: row.color,
      padding: pw.EdgeInsets.all(AirportPermitPdfConstants.pt(8)),
      alignment: pw.Alignment.centerRight,
      child: pw.Text(
        row.arabic,
        textAlign: pw.TextAlign.right,
        style: pw.TextStyle(
          font: boldFont,
          fontSize: AirportPermitPdfConstants.tableBodyFontSize,
          fontWeight: pw.FontWeight.bold,
          color: AirportPermitPdfColors.black,
        ),
        textDirection: pw.TextDirection.rtl,
      ),
    );
  }

  pw.Widget _taskCell(String task) {
    return pw.Container(
      constraints: pw.BoxConstraints(
        minHeight: AirportPermitPdfConstants.tableRowMinHeight,
      ),
      color: AirportPermitPdfColors.white,
      padding: pw.EdgeInsets.all(AirportPermitPdfConstants.pt(8)),
      alignment: pw.Alignment.centerRight,
      child: pw.Text(
        task,
        textAlign: pw.TextAlign.right,
        style: pw.TextStyle(
          font: regularFont,
          fontSize: AirportPermitPdfConstants.tableBodyFontSize,
          color: AirportPermitPdfColors.black,
        ),
        textDirection: pw.TextDirection.rtl,
      ),
    );
  }
}
