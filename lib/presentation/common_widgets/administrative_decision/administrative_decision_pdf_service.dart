import 'package:code_setup/presentation/common_widgets/administrative_decision/administrative_decision_data.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Pixel spec is based on 794px-wide A4 HTML layout; PDF uses pt (px × 0.75).
abstract final class _PdfLayout {
  static const double px = 0.75;

  static double pt(double pixels) => pixels * px;

  static final marginLeft = pt(52);
  static final marginRight = pt(70);
  static final marginTop = pt(15);
  static final marginBottom = pt(30);

  static final headerHeight = pt(120);
  static final logoRowHeight = pt(60);

  static final leftLogoWidth = pt(55);
  static final leftLogoHeight = pt(35);
  static final centerLogoWidth = pt(65);
  static final centerLogoHeight = pt(50);
  static final rightLogoWidth = pt(75);
  static final rightLogoHeight = pt(65);

  static const dividerBlack = PdfColor.fromInt(0xFF1A1A1A);
  static const dividerGrey = PdfColor.fromInt(0xFFD9D9D9);
  static const footerGrey = PdfColor.fromInt(0xFF777777);

  static final titleFontSize = pt(20);
  static final introFontSize = pt(13);
  static final introLineHeight = pt(24) / introFontSize;
  static final sectionHeadingFontSize = pt(18);
  static final articleLabelFontSize = pt(15);
  static final bodyFontSize = pt(13);
  static final bodyLineHeight = 1.85;
  static final signatureNameFontSize = pt(14);
  static final designationFontSize = pt(12);
  static final footerFontSize = pt(8);
  static final footerEnFontSize = pt(9);

  static final bodyPaddingLeft = pt(80) - marginLeft;
  static final bodyPaddingRight = pt(95) - marginRight;
}

/// Builds and saves official CAA administrative decision PDFs.
abstract final class AdministrativeDecisionPdfService {
  AdministrativeDecisionPdfService._();

  static String fileNameFor({
    required AdministrativeDecisionDocumentType type,
    required String requestId,
    DateTime? date,
  }) {
    final fileDate = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());
    final prefix = switch (type) {
      AdministrativeDecisionDocumentType.assignment => 'Assignment_Decision',
      AdministrativeDecisionDocumentType.secondment => 'Secondment_Decision',
      AdministrativeDecisionDocumentType.temporaryAssignment =>
        'Temporary_Assignment_Decision',
      AdministrativeDecisionDocumentType.serviceTransfer =>
        'Service_Transfer_Decision',
      AdministrativeDecisionDocumentType.shiftAllowance =>
        'Shift_Allowance_Decision',
    };
    return '${prefix}_${requestId}_$fileDate.pdf';
  }

  static AdministrativeDecisionData dataFromRequestDetails({
    required AdministrativeDecisionDocumentType type,
    required RequestDetailData request,
    required String issuedDate,
  }) {
    final nested = request.request;
    final decisionNumber = _safe(
      request.decisionNumber ?? nested?.decisionNumber,
    );
    final employeeName = _safe(
      request.assignedEmployeeName ??
          request.employeeName ??
          nested?.assignedEmployeeName ??
          nested?.employeeName,
    );
    final employeeNumber = _safe(
      request.employeeId ??
          request.civilIdCardNumber ??
          nested?.employeeId ??
          nested?.civilIdCardNumber ??
          decisionNumber,
    );
    final fromEntity = _safe(
      request.fromEntity ??
          request.currentEntity ??
          nested?.fromEntity,
    );
    final currentJobPosition = _safe(
      request.currentJobPosition ?? nested?.currentJobPosition,
    );
    final assignedJobPosition = _safe(
      request.assignedJobPosition ?? nested?.assignedJobPosition,
    );
    final jobPosition = assignedJobPosition != '—'
        ? assignedJobPosition
        : currentJobPosition;
    final startDate = _formatDate(request.startDate ?? nested?.startDate);
    final endDate = _formatDate(request.endDate ?? nested?.endDate);

    final title = switch (type) {
      AdministrativeDecisionDocumentType.assignment => 'قرار إداري تكليف رقم',
      AdministrativeDecisionDocumentType.secondment => 'قرار إداري رقم',
      AdministrativeDecisionDocumentType.temporaryAssignment => 'قرار إداري رقم',
      AdministrativeDecisionDocumentType.serviceTransfer => 'قرار إداري رقم',
      AdministrativeDecisionDocumentType.shiftAllowance => 'قرار إداري رقم',
    };

    final articles = switch (type) {
      AdministrativeDecisionDocumentType.assignment => [
        AdministrativeDecisionArticle(
          title: 'المادة الأولى:',
          body:
              'يُكلف الفاضل/$employeeName رقمه ($employeeNumber) الشاغل لوظيفة "$fromEntity" إضافة إلى عمله الأصلي القيام بأعمال "$jobPosition" خلال الفترة من $startDate إلى $endDate',
        ),
        const AdministrativeDecisionArticle(
          title: 'المادة الثانية:',
          body: 'يصرف للفاضل المكلف بدل تكليف بواقع 44.00% من الراتب الأساسي.',
        ),
        const AdministrativeDecisionArticle(
          title: 'المادة الثالثة:',
          body: 'يلغى كل ما يخالف هذا القرار ، وعلى جهات الاختصاص تنفيذه.',
        ),
      ],
      AdministrativeDecisionDocumentType.secondment => [
        AdministrativeDecisionArticle(
          title: 'المادة الأولى:',
          body:
              'يُندب الموظف/$employeeName رقمه ($employeeNumber) الشاغل لوظيفة "$currentJobPosition" من $fromEntity بوظيفة "$assignedJobPosition"',
        ),
        const AdministrativeDecisionArticle(
          title: 'المادة الثانية:',
          body: 'على جهات الاختصاص تنفيذ هذا القرار اعتبارا من تاريخ صدوره.',
        ),
      ],
      AdministrativeDecisionDocumentType.temporaryAssignment => [
        AdministrativeDecisionArticle(
          title: 'المادة الأولى:',
          body:
              'يُكلف مؤقتاً الفاضل/$employeeName رقمه ($employeeNumber) الشاغل لوظيفة "$fromEntity" القيام بأعمال "$jobPosition" خلال الفترة من $startDate إلى $endDate',
        ),
        const AdministrativeDecisionArticle(
          title: 'المادة الثانية:',
          body: 'يلغى كل ما يخالف هذا القرار ، وعلى جهات الاختصاص تنفيذه.',
        ),
      ],
      AdministrativeDecisionDocumentType.serviceTransfer => [
        AdministrativeDecisionArticle(
          title: 'المادة الأولى:',
          body:
              'ينقل الفاضل/$employeeName رقمه ($employeeNumber) من "$fromEntity" إلى الجهة المنقول إليها اعتباراً من $startDate',
        ),
        const AdministrativeDecisionArticle(
          title: 'المادة الثانية:',
          body: 'يلغى كل ما يخالف هذا القرار ، وعلى جهات الاختصاص تنفيذه.',
        ),
      ],
      AdministrativeDecisionDocumentType.shiftAllowance => [
        AdministrativeDecisionArticle(
          title: 'المادة الأولى:',
          body:
              'يُكلف الفاضل/$employeeName رقمه ($employeeNumber) الشاغل لوظيفة "$fromEntity" إضافة إلى عمله الأصلي القيام بأعمال "$jobPosition" خلال الفترة من $startDate إلى $endDate',
        ),
        const AdministrativeDecisionArticle(
          title: 'المادة الثانية:',
          body: 'يصرف للفاضل المكلف بدل تكليف بواقع 44.00% من الراتب الأساسي.',
        ),
        const AdministrativeDecisionArticle(
          title: 'المادة الثالثة:',
          body: 'يلغى كل ما يخالف هذا القرار ، وعلى جهات الاختصاص تنفيذه.',
        ),
      ],
    };

    return AdministrativeDecisionData(
      documentTitle: title,
      articles: articles,
      issuedDate: issuedDate,
      approverNote: type == AdministrativeDecisionDocumentType.secondment
          ? null
          : 'الموافق: NA',
    );
  }

  static Future<void> savePdf({
    required AdministrativeDecisionData data,
    required AdministrativeDecisionDocumentType type,
    required String requestId,
  }) async {
    try {
      final pdfBytes = await buildPdfBytes(data);
      final fileName = fileNameFor(type: type, requestId: requestId);
      await FilePicker.platform.saveFile(fileName: fileName, bytes: pdfBytes);
      Fluttertoast.showToast(msg: 'PDF downloaded successfully');
    } catch (e, st) {
      debugPrint('Administrative decision PDF error: $e');
      debugPrintStack(stackTrace: st);
      Fluttertoast.showToast(msg: 'Error generating PDF. Please try again.');
    }
  }

  static Future<Uint8List> buildPdfBytes(AdministrativeDecisionData data) async {
    final pdf = pw.Document();
    final logos = await Future.wait([
      _loadImage('assets/images/pdfimage1.png'),
      _loadImage('assets/images/pdfimage.png'),
      _loadImage('assets/images/caa_logo.png'),
    ]);

    final regularFont = await PdfGoogleFonts.notoNaskhArabicRegular();
    final boldFont = await PdfGoogleFonts.notoNaskhArabicBold();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(
          left: _PdfLayout.marginLeft,
          right: _PdfLayout.marginRight,
          top: _PdfLayout.marginTop,
          bottom: _PdfLayout.marginBottom,
        ),
        build: (context) {
          final bodyStyle = pw.TextStyle(
            font: regularFont,
            fontSize: _PdfLayout.bodyFontSize,
            height: _PdfLayout.bodyLineHeight,
          );
          final articleLabelStyle = pw.TextStyle(
            font: boldFont,
            fontSize: _PdfLayout.articleLabelFontSize,
            fontWeight: pw.FontWeight.bold,
          );
          final titleStyle = pw.TextStyle(
            font: boldFont,
            fontSize: _PdfLayout.titleFontSize,
            fontWeight: pw.FontWeight.bold,
          );
          final introStyle = pw.TextStyle(
            font: regularFont,
            fontSize: _PdfLayout.introFontSize,
            height: _PdfLayout.introLineHeight,
          );
          final sectionHeadingStyle = pw.TextStyle(
            font: boldFont,
            fontSize: _PdfLayout.sectionHeadingFontSize,
            fontWeight: pw.FontWeight.bold,
          );

          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(logos),
                      pw.SizedBox(height: _PdfLayout.pt(15)),
                      pw.Center(
                        child: pw.Text(data.documentTitle, style: titleStyle),
                      ),
                      pw.SizedBox(height: _PdfLayout.pt(10)),
                      pw.Padding(
                        padding: pw.EdgeInsets.only(
                          left: _PdfLayout.bodyPaddingLeft,
                          right: _PdfLayout.bodyPaddingRight,
                        ),
                        child: pw.Text(
                          data.introduction,
                          style: introStyle,
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.SizedBox(height: _PdfLayout.pt(10)),
                      pw.Center(
                        child: pw.Text(
                          data.decisionHeading,
                          style: sectionHeadingStyle,
                        ),
                      ),
                      pw.SizedBox(height: _PdfLayout.pt(15)),
                      pw.Padding(
                        padding: pw.EdgeInsets.only(
                          left: _PdfLayout.bodyPaddingLeft,
                          right: _PdfLayout.bodyPaddingRight,
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                          children: [
                            for (var i = 0; i < data.articles.length; i++)
                              pw.Padding(
                                padding: pw.EdgeInsets.only(
                                  bottom: i < data.articles.length - 1
                                      ? _PdfLayout.pt(20)
                                      : 0,
                                ),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.stretch,
                                  children: [
                                    pw.Text(
                                      data.articles[i].title,
                                      style: articleLabelStyle,
                                      textAlign: pw.TextAlign.right,
                                    ),
                                    pw.SizedBox(height: _PdfLayout.pt(8)),
                                    pw.Text(
                                      data.articles[i].body,
                                      style: bodyStyle,
                                      textAlign: pw.TextAlign.right,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: _PdfLayout.pt(15)),
                      pw.Padding(
                        padding: pw.EdgeInsets.only(
                          left: _PdfLayout.bodyPaddingLeft,
                          right: _PdfLayout.bodyPaddingRight,
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                          children: [
                            pw.Text(
                              'صدر في ${data.issuedDate}',
                              style: bodyStyle,
                              textAlign: pw.TextAlign.right,
                            ),
                            if (data.approverNote != null) ...[
                              pw.SizedBox(height: _PdfLayout.pt(12)),
                              pw.Text(
                                data.approverNote!,
                                style: bodyStyle,
                                textAlign: pw.TextAlign.right,
                              ),
                            ],
                            pw.SizedBox(height: _PdfLayout.pt(8)),
                            pw.Text(
                              data.signatoryName,
                              style: pw.TextStyle(
                                font: boldFont,
                                fontSize: _PdfLayout.signatureNameFontSize,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                            pw.SizedBox(height: _PdfLayout.pt(4)),
                            pw.Text(
                              data.designation,
                              style: pw.TextStyle(
                                font: regularFont,
                                fontSize: _PdfLayout.designationFontSize,
                                height: _PdfLayout.bodyLineHeight,
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      pw.Spacer(),
                    ],
                  ),
                ),
                pw.SizedBox(height: _PdfLayout.pt(15)),
                pw.Divider(
                  color: _PdfLayout.dividerGrey,
                  thickness: 1,
                ),
                pw.SizedBox(height: _PdfLayout.pt(12)),
                _buildPdfFooter(regularFont),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(List<pw.MemoryImage> logos) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        pw.SizedBox(
          height: _PdfLayout.headerHeight,
          child: pw.Directionality(
            textDirection: pw.TextDirection.ltr,
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                _logo(
                  logos[0],
                  width: _PdfLayout.leftLogoWidth,
                  height: _PdfLayout.leftLogoHeight,
                ),
                pw.Spacer(),
                _logo(
                  logos[1],
                  width: _PdfLayout.centerLogoWidth,
                  height: _PdfLayout.centerLogoHeight,
                ),
                pw.SizedBox(width: _PdfLayout.pt(16)),
                pw.Container(
                  width: 1,
                  height: _PdfLayout.logoRowHeight,
                  color: PdfColors.grey300,
                ),
                pw.SizedBox(width: _PdfLayout.pt(16)),
                _logo(
                  logos[2],
                  width: _PdfLayout.rightLogoWidth,
                  height: _PdfLayout.rightLogoHeight,
                ),
              ],
            ),
          ),
        ),
        pw.Container(
          height: 1,
          color: _PdfLayout.dividerBlack,
        ),
      ],
    );
  }

  static pw.Widget _buildPdfFooter(pw.Font regularFont) {
    final footerStyle = pw.TextStyle(
      font: regularFont,
      fontSize: _PdfLayout.footerFontSize,
      color: _PdfLayout.footerGrey,
      height: 1.6,
    );
    final footerEnStyle = pw.TextStyle(
      font: regularFont,
      fontSize: _PdfLayout.footerEnFontSize,
      color: _PdfLayout.footerGrey,
    );

    return pw.Directionality(
      textDirection: pw.TextDirection.ltr,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Expanded(
                child: pw.Directionality(
                  textDirection: pw.TextDirection.rtl,
                  child: pw.Text(
                    'صندوق البريد: 1، الرمز البريدي: 111 مسقط - سلطنة عمان',
                    style: footerStyle,
                    textAlign: pw.TextAlign.left,
                  ),
                ),
              ),
              pw.Text(
                'P.C.: 111, Muscat - Sultanate of Oman',
                style: footerEnStyle,
              ),
            ],
          ),
          pw.SizedBox(height: _PdfLayout.pt(5)),
          pw.Text(
            'Fax: +968 23368684 - www.caa.gov.om - '
            '24354435 968+ / 24354433 968+ / 24354437 968+ / 24354436 968+',
            style: footerStyle,
            textAlign: pw.TextAlign.left,
          ),
        ],
      ),
    );
  }

  static Future<pw.MemoryImage> _loadImage(String assetPath) async {
    final bytes = await rootBundle.load(assetPath);
    return pw.MemoryImage(bytes.buffer.asUint8List());
  }

  static pw.Widget _logo(
    pw.MemoryImage image, {
    required double width,
    required double height,
  }) {
    return pw.SizedBox(
      width: width,
      height: height,
      child: pw.Image(image, fit: pw.BoxFit.contain),
    );
  }

  static String _safe(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return 'N/A';
    return trimmed;
  }

  static String _formatDate(String? value) {
    if (value == null || value.trim().isEmpty) return 'N/A';
    try {
      return DateFormat('dd/MM/yyyy').format(DateTime.parse(value));
    } catch (_) {
      return value;
    }
  }
}
