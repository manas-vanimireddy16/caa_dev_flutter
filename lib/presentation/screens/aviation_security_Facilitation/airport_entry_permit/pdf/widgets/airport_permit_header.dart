import 'package:pdf/widgets.dart' as pw;

import '../airport_permit_pdf_constants.dart';

class AirportPermitHeader extends pw.StatelessWidget {
  final pw.MemoryImage caaLogo;
  final pw.MemoryImage fiftyYearsLogo;

  AirportPermitHeader({
    required this.caaLogo,
    required this.fiftyYearsLogo,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Directionality(
      textDirection: pw.TextDirection.ltr,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Image(
            caaLogo,
            width: AirportPermitPdfConstants.logoMaxWidth,
            height: AirportPermitPdfConstants.logoMaxHeight,
            fit: pw.BoxFit.contain,
          ),
          pw.SizedBox(width: AirportPermitPdfConstants.logoGap),
          pw.Image(
            fiftyYearsLogo,
            width: AirportPermitPdfConstants.logoMaxWidth,
            height: AirportPermitPdfConstants.logoMaxHeight,
            fit: pw.BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
