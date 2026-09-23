import 'package:pdf/widgets.dart' as pw;

import '../airport_permit_pdf_colors.dart';
import '../airport_permit_pdf_constants.dart';

/// Matches web footer HTML:
/// ```
/// ص.ب: ... | P.O. Box: ...
/// Fax: +968 24354544 | www.caa.gov.om | +968 24354441/2
/// ```
class FooterWidget extends pw.StatelessWidget {
  final pw.Font regularFont;

  FooterWidget({required this.regularFont});

  @override
  pw.Widget build(pw.Context context) {
    final style = pw.TextStyle(
      font: regularFont,
      fontSize: AirportPermitPdfConstants.footerFontSize,
      color: AirportPermitPdfColors.footerGray,
    );

    return pw.Container(
      alignment: pw.Alignment.center,
      padding: pw.EdgeInsets.only(top: AirportPermitPdfConstants.pt(8)),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Text(
            '${AirportPermitPdfConstants.footerLine1Ar} | ${AirportPermitPdfConstants.footerLine1En}',
            textAlign: pw.TextAlign.center,
            style: style,
          ),
          pw.SizedBox(height: AirportPermitPdfConstants.pt(2)),
          pw.Directionality(
            textDirection: pw.TextDirection.ltr,
            child: pw.Text(
              AirportPermitPdfConstants.footerLine2,
              textAlign: pw.TextAlign.center,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
