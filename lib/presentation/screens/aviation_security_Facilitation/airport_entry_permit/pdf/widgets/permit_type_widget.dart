import 'package:pdf/widgets.dart' as pw;

import '../airport_permit_pdf_constants.dart';
import '../airport_permit_pdf_data.dart';
import 'pdf_primitives.dart';

class PermitTypeWidget extends pw.StatelessWidget {
  final AirportPermitPdfData data;
  final pw.Font regularFont;
  final pw.Font boldFont;

  PermitTypeWidget({
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
          title: AirportPermitPdfConstants.permitTypeTitle,
          boldFont: boldFont,
        ),
        pw.SizedBox(height: AirportPermitPdfConstants.pt(10)),
        pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Wrap(
            spacing: AirportPermitPdfConstants.checkboxGap,
            runSpacing: AirportPermitPdfConstants.pt(8),
            children: [
              airportPermitCheckboxItem(
                checked: data.isIssuing,
                label: 'إصدار',
                regularFont: regularFont,
              ),
              airportPermitCheckboxItem(
                checked: data.isRenewal,
                label: 'تجديد',
                regularFont: regularFont,
              ),
              airportPermitCheckboxItem(
                checked: data.isReplacement,
                label: 'بدل فاقد',
                regularFont: regularFont,
              ),
              airportPermitCheckboxItem(
                checked: data.isAddingAreas,
                label: 'إضافة مناطق',
                regularFont: regularFont,
              ),
              airportPermitCheckboxItem(
                checked: data.isChangeProfession,
                label: 'تغيير مسمى',
                regularFont: regularFont,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
