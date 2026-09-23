import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'airport_permit_pdf_colors.dart';
import 'airport_permit_pdf_constants.dart';
import 'airport_permit_pdf_data.dart';
import 'widgets/additional_services_widget.dart';
import 'widgets/airport_permit_header.dart';
import 'widgets/applicant_details_widget.dart';
import 'widgets/approval_section_widget.dart';
import 'widgets/footer_widget.dart';
import 'widgets/permit_duration_widget.dart';
import 'widgets/permit_type_widget.dart';
import 'widgets/security_area_table_widget.dart';

/// Builds the Airport Entry Permit Arabic A4 PDF on a **single page**.
abstract final class AirportPermitPdfGenerator {
  AirportPermitPdfGenerator._();

  static Future<Uint8List> generate(AirportPermitPdfData data) async {
    final caaLogo = await _loadImage(
      AirportPermitPdfConstants.caaLogoAsset,
    );
    final fiftyYearsLogo = await _loadImage(
      AirportPermitPdfConstants.fiftyYearsLogoAsset,
    );

    final arabicRegular = await PdfGoogleFonts.notoNaskhArabicRegular();
    final arabicBold = await PdfGoogleFonts.notoNaskhArabicBold();

    debugPrint(
      'AirportPermitPDF checks: '
      'category="${data.categoryOfPermit}" '
      'type="${data.typeOfPermit}" '
      'services=${data.additionalServices} '
      'issuing=${data.isIssuing} renewal=${data.isRenewal} '
      'replacement=${data.isReplacement} adding=${data.isAddingAreas} '
      'change=${data.isChangeProfession} '
      'permanent=${data.isPermanent} temporary=${data.isTemporary} '
      'laptop=${data.hasLaptopTablet} boarding=${data.hasBoardingAssistance} '
      'specialNeeds=${data.hasSpecialNeedsAssistance}',
    );

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(AirportPermitPdfConstants.margin),
        theme: pw.ThemeData.withFont(
          base: arabicRegular,
          bold: arabicBold,
        ),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              AirportPermitHeader(
                caaLogo: caaLogo,
                fiftyYearsLogo: fiftyYearsLogo,
              ),
              pw.SizedBox(height: AirportPermitPdfConstants.titleTopGap),
              pw.Center(
                child: pw.Text(
                  AirportPermitPdfConstants.arabicTitle,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: arabicBold,
                    fontSize: AirportPermitPdfConstants.titleFontSize,
                    fontWeight: pw.FontWeight.bold,
                    color: AirportPermitPdfColors.black,
                  ),
                  textDirection: pw.TextDirection.rtl,
                ),
              ),
              pw.SizedBox(height: AirportPermitPdfConstants.titleBottomGap),
              ApplicantDetailsWidget(
                data: data,
                regularFont: arabicRegular,
                boldFont: arabicBold,
              ),
              pw.SizedBox(height: AirportPermitPdfConstants.sectionGap),
              PermitTypeWidget(
                data: data,
                regularFont: arabicRegular,
                boldFont: arabicBold,
              ),
              pw.SizedBox(height: AirportPermitPdfConstants.sectionGap),
              PermitDurationWidget(
                data: data,
                regularFont: arabicRegular,
                boldFont: arabicBold,
              ),
              pw.SizedBox(height: AirportPermitPdfConstants.sectionGap),
              AdditionalServicesWidget(
                data: data,
                regularFont: arabicRegular,
                boldFont: arabicBold,
              ),
              pw.SizedBox(height: AirportPermitPdfConstants.pt(8)),
              SecurityAreaTableWidget(
                rows: data.areaRows,
                regularFont: arabicRegular,
                boldFont: arabicBold,
              ),
              pw.SizedBox(height: AirportPermitPdfConstants.pt(8)),
              ApprovalSectionWidget(
                departmentDirectorName: data.departmentDirectorName,
                regularFont: arabicRegular,
                boldFont: arabicBold,
              ),
              pw.Spacer(),
              FooterWidget(regularFont: arabicRegular),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static String fileNameFor(int? requestId, {String? businessRequestId}) {
    final id = (businessRequestId != null && businessRequestId.isNotEmpty)
        ? businessRequestId
        : (requestId?.toString() ?? 'request');
    final stamp = DateTime.now().millisecondsSinceEpoch;
    return 'Airport_Entry_Permit_${id}_$stamp.pdf';
  }

  static Future<pw.MemoryImage> _loadImage(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    return pw.MemoryImage(data.buffer.asUint8List());
  }
}
