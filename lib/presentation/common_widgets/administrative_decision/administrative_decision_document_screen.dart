import 'package:code_setup/presentation/common_widgets/administrative_decision/administrative_decision_data.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Pixel layout constants matching the 794px-wide A4 HTML reference.
abstract final class _PreviewLayout {
  static const marginLeft = 52.0;
  static const marginRight = 70.0;
  static const marginTop = 15.0;
  static const marginBottom = 30.0;

  static const headerHeight = 120.0;
  static const leftLogoWidth = 55.0;
  static const leftLogoHeight = 35.0;
  static const centerLogoWidth = 65.0;
  static const centerLogoHeight = 50.0;
  static const rightLogoWidth = 75.0;
  static const rightLogoHeight = 65.0;

  static const bodyPaddingLeft = 80.0 - marginLeft;
  static const bodyPaddingRight = 95.0 - marginRight;

  static const dividerBlack = Color(0xFF1A1A1A);
  static const dividerGrey = Color(0xFFD9D9D9);
  static const footerGrey = Color(0xFF777777);
}

/// Official CAA administrative decision document preview (A4-style, RTL).
class AdministrativeDecisionDocumentScreen extends StatelessWidget {
  final AdministrativeDecisionData data;

  const AdministrativeDecisionDocumentScreen({
    super.key,
    required this.data,
  });

  TextStyle _cairo({
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    Color color = Colors.black,
    double? height,
  }) {
    return GoogleFonts.cairo(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          title: Text(
            'قرار إداري',
            style: AppTextStyles.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 794),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: _PreviewLayout.marginLeft,
                  right: _PreviewLayout.marginRight,
                  top: _PreviewLayout.marginTop,
                  bottom: _PreviewLayout.marginBottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 15),
                    Text(
                      data.documentTitle,
                      textAlign: TextAlign.center,
                      style: _cairo(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: _PreviewLayout.bodyPaddingLeft,
                        right: _PreviewLayout.bodyPaddingRight,
                      ),
                      child: Text(
                        data.introduction,
                        textAlign: TextAlign.right,
                        style: _cairo(fontSize: 13, height: 24 / 13),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data.decisionHeading,
                      textAlign: TextAlign.center,
                      style: _cairo(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: _PreviewLayout.bodyPaddingLeft,
                        right: _PreviewLayout.bodyPaddingRight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (var i = 0; i < data.articles.length; i++)
                            _buildArticle(
                              data.articles[i],
                              isLast: i == data.articles.length - 1,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: _PreviewLayout.bodyPaddingLeft,
                        right: _PreviewLayout.bodyPaddingRight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'صدر في ${data.issuedDate}',
                            textAlign: TextAlign.right,
                            style: _cairo(fontSize: 13),
                          ),
                          if (data.approverNote != null) ...[
                            const SizedBox(height: 12),
                            Text(
                              data.approverNote!,
                              textAlign: TextAlign.right,
                              style: _cairo(fontSize: 13),
                            ),
                          ],
                          const SizedBox(height: 8),
                          Text(
                            data.signatoryName,
                            textAlign: TextAlign.right,
                            style: _cairo(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data.designation,
                            textAlign: TextAlign.right,
                            style: _cairo(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    const Divider(
                      color: _PreviewLayout.dividerGrey,
                      thickness: 1,
                      height: 1,
                    ),
                    const SizedBox(height: 12),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: _PreviewLayout.headerHeight,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _logo(
                  'assets/images/pdfimage1.png',
                  width: _PreviewLayout.leftLogoWidth,
                  height: _PreviewLayout.leftLogoHeight,
                ),
                const Spacer(),
                _logo(
                  'assets/images/pdfimage.png',
                  width: _PreviewLayout.centerLogoWidth,
                  height: _PreviewLayout.centerLogoHeight,
                ),
                const SizedBox(width: 16),
                Container(
                  width: 1,
                  height: 60,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(width: 16),
                _logo(
                  'assets/images/caa_logo.png',
                  width: _PreviewLayout.rightLogoWidth,
                  height: _PreviewLayout.rightLogoHeight,
                ),
              ],
            ),
          ),
        ),
        Container(height: 1, color: _PreviewLayout.dividerBlack),
      ],
    );
  }

  Widget _logo(String asset, {required double width, required double height}) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => SizedBox(width: width, height: height),
      ),
    );
  }

  Widget _buildArticle(AdministrativeDecisionArticle article, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            article.title,
            textAlign: TextAlign.right,
            style: _cairo(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            article.body,
            textAlign: TextAlign.right,
            style: _cairo(fontSize: 13, height: 1.85),
          ),
        ],
      ),
    );
  }
  Widget _buildFooter() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    'صندوق البريد: 1، الرمز البريدي: 111 مسقط - سلطنة عمان',
                    textAlign: TextAlign.left,
                    style: _cairo(
                      fontSize: 8,
                      color: _PreviewLayout.footerGrey,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
              Text(
                'P.C.: 111, Muscat - Sultanate of Oman',
                style: _cairo(
                  fontSize: 9,
                  color: _PreviewLayout.footerGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Fax: +968 23368684 - www.caa.gov.om - '
            '24354435 968+ / 24354433 968+ / 24354437 968+ / 24354436 968+',
            style: _cairo(
              fontSize: 8,
              color: _PreviewLayout.footerGrey,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
