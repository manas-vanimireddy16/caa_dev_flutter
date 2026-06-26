import 'package:code_setup/presentation/screens/home_screen/dashboard/models/important_links_model.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ImportantLinkCard extends StatelessWidget {
  final ImportantLinkModel link;
  final String postedOnLabel;

  const ImportantLinkCard({
    super.key,
    required this.link,
    required this.postedOnLabel,
  });

  static const _borderColor = Color(0xFFE5E7EB);
  static const _urlColor = Color(0xFF2563EB);
  static const _mutedColor = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    final title = link.title?.trim().isNotEmpty == true ? link.title! : '-';
    final url = link.url?.trim().isNotEmpty == true ? link.url! : '';
    final postedOn = _formatPostedOn(link.createdAt);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textHeading,
            ),
          ),
          if (url.isNotEmpty) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _openUrl(url),
              child: Text(
                url,
                style: AppTextStyles.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _urlColor,
                  decoration: TextDecoration.underline,
                  decorationColor: _urlColor,
                ),
              ),
            ),
          ],
          if (postedOn.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              '$postedOnLabel $postedOn',
              style: AppTextStyles.cairo(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: _mutedColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatPostedOn(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(raw).toLocal();
      final date = DateFormat('d MMM, yyyy').format(dateTime);
      final time = DateFormat('hh:mm a').format(dateTime);
      return '$date | $time';
    } catch (_) {
      return raw;
    }
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }
}
