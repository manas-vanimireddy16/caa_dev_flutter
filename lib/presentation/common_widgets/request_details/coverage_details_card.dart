import 'package:code_setup/presentation/common_widgets/section_content_divider.dart';
import 'package:code_setup/presentation/common_widgets/status_widget.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/icons.dart';
import 'package:flutter/material.dart';

class CoverageDetailsCard extends StatefulWidget {
  final DashboardL10n l10n;
  final String? eventName;
  final String? status;
  final String? suggestedPhotography;
  final String? eventDetails;
  final String? postedOn;
  final String? department;
  final String? phone;
  final String? email;

  const CoverageDetailsCard({
    super.key,
    required this.l10n,
    this.eventName,
    this.status,
    this.suggestedPhotography,
    this.eventDetails,
    this.postedOn,
    this.department,
    this.phone,
    this.email,
  });

  @override
  State<CoverageDetailsCard> createState() => _CoverageDetailsCardState();
}

class _CoverageDetailsCardState extends State<CoverageDetailsCard> {
  bool _expanded = true;

  String _orNa(String? value) {
    if (value == null || value.trim().isEmpty) {
      return widget.l10n.notAvailableValue();
    }
    return value.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(color: Color(0xFFD8D8D8)),
      ),
      elevation: 0,
      child: Column(
        children: [
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  KImageProvider(
                    image: AppIcons.employeeInfoRequestDetails,
                    width: 22,
                    height: 22,
                    tintColor: const Color(0xFF000000),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.l10n.coverageDetailsSection,
                      style: AppTextStyles.requestDetailsSectionHeading(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: const Color(0xFFD8D8D8),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            const SectionContentDivider(horizontalPadding: 16),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _orNa(widget.eventName),
                    style: AppTextStyles.requestDetailsSectionHeading(),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (widget.status != null &&
                          widget.status!.trim().isNotEmpty)
                        StatusChip(status: widget.status!),
                      if (widget.suggestedPhotography != null &&
                          widget.suggestedPhotography!.trim().isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3CD),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: const Color(0xFFFFE69C)),
                          ),
                          child: Text(
                            widget.suggestedPhotography!,
                            style: AppTextStyles.requestDetailsFieldContent()
                                .copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF856404),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (widget.eventDetails != null &&
                      widget.eventDetails!.trim().isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      widget.eventDetails!,
                      style: AppTextStyles.requestDetailsFieldContent(),
                    ),
                  ],
                  if (widget.postedOn != null &&
                      widget.postedOn!.trim().isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      '${widget.l10n.postedOn} ${widget.postedOn!}',
                      style: AppTextStyles.requestDetailsFieldContent(),
                    ),
                  ],
                  if (widget.department != null &&
                      widget.department!.trim().isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      widget.department!,
                      style: AppTextStyles.requestDetailsFieldContent(),
                    ),
                  ],
                  if (widget.phone != null && widget.phone!.trim().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          KImageProvider(
                            image: AppIcons.phoneEmployeeCard,
                            width: 18,
                            height: 18,
                            tintColor: const Color(0xFF818184),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.phone!,
                              style: AppTextStyles.requestDetailsFieldContent(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (widget.email != null && widget.email!.trim().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          KImageProvider(
                            image: AppIcons.mailEmployeeCard,
                            width: 18,
                            height: 18,
                            tintColor: const Color(0xFF818184),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.email!,
                              style: AppTextStyles.requestDetailsFieldContent(),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
