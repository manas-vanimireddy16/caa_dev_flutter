import 'package:pdf/widgets.dart' as pw;

import '../airport_permit_pdf_constants.dart';
import '../airport_permit_pdf_data.dart';
import 'pdf_primitives.dart';

class AdditionalServicesWidget extends pw.StatelessWidget {
  final AirportPermitPdfData data;
  final pw.Font regularFont;
  final pw.Font boldFont;

  AdditionalServicesWidget({
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
          title: AirportPermitPdfConstants.additionalServicesTitle,
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
                checked: data.hasLaptopTablet,
                label: 'لاب توب / جهاز لوحي',
                regularFont: regularFont,
              ),
              airportPermitCheckboxItem(
                checked: data.hasBoardingAssistance,
                label: 'صعود الطائرة',
                regularFont: regularFont,
              ),
              airportPermitCheckboxItem(
                checked: data.hasSpecialNeedsAssistance,
                label: 'الموظف المساعد لذوي الاحتياجات الخاصة',
                regularFont: regularFont,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
