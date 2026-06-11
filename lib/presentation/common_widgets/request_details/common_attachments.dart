import 'dart:typed_data';

import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/repository/common/domain/domain.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

/// Upload File
const Color uploadFileColor = Color(0xFF26285F);

/// File Drop Here
const Color fileDropHereColor = Color(0xB01B2B41);

/// Files Text
const Color filesTextColor = Color(0xFF676767);

class CommonAttachmentsUploadArea extends StatelessWidget {
  final String? title;
  final bool isRequired;
  final bool isUploading;
  final VoidCallback? onUploadTap;
  final List<String> allowedExtensions;
  final int maxFileSizeInMB;
  final Widget? footer;

  const CommonAttachmentsUploadArea({
    super.key,
    this.title,
    this.isRequired = false,
    this.isUploading = false,
    this.onUploadTap,
    this.allowedExtensions = const ['doc', 'docx', 'pdf', 'png', 'jpeg'],
    this.maxFileSizeInMB = 10,
    this.footer,
  });

  String get _allowedFilesText {
    final displayExtensions = allowedExtensions
        .map((ext) => ext.toLowerCase())
        .where((ext) => ext != 'jpg')
        .toList();

    return 'You can upload ${displayExtensions.join(', ')} files';
  }

  @override
  Widget build(BuildContext context) {
    final label = title?.trim().isNotEmpty == true
        ? title!.trim()
        : 'Attachments (Optional)';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.secondaryText,
            ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _DashedBorderContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: isUploading ? null : onUploadTap,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8E6EF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: isUploading
                            ? const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: uploadFileColor,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Uploading...',
                                    style: TextStyle(
                                      color: uploadFileColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            : const Text(
                                'Upload File..',
                                style: TextStyle(
                                  color: uploadFileColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.file_upload_outlined,
                      size: 22,
                      color: fileDropHereColor,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Drop file here',
                      style: TextStyle(
                        color: fileDropHereColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  _allowedFilesText,
                  style: const TextStyle(
                    color: filesTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
                Text(
                  "File can't be larger than ${maxFileSizeInMB}MB",
                  style: const TextStyle(
                    color: filesTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
                if (footer != null) ...[const SizedBox(height: 12), footer!],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DashedBorderContainer extends StatelessWidget {
  final Widget child;

  const _DashedBorderContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const _DashedBorderPainter(
        color: Color(0xFFD0D5DD),
        strokeWidth: 1.2,
        radius: 10,
      ),
      child: SizedBox(width: double.infinity, child: child),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;

  const _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final path = Path()..addRRect(rrect);

    for (final metric in path.computeMetrics()) {
      const dashWidth = 6.0;
      const dashSpace = 4.0;
      var distance = 0.0;

      while (distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, end.clamp(0, metric.length)),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth ||
        radius != oldDelegate.radius;
  }
}

class CommonAttachmentsTabContent extends StatelessWidget {
  final List<AttachmentModel> attachments;
  final DashboardL10n? l10n;

  const CommonAttachmentsTabContent({
    super.key,
    required this.attachments,
    this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final labels = l10n ?? DashboardL10n.of(context);

    if (attachments.isEmpty) {
      return Center(
        child: Text(
          labels.noAttachmentsAvailable,
          style: TextStyle(color: AppColors.contentColor),
        ),
      );
    }

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE0E0E0), width: 1.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.description_outlined, color: Colors.indigo.shade900),
                const SizedBox(width: 8),
                Text(
                  labels.fileListTitle,
                  style: TextStyle(color: AppColors.mainTitleColor),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...attachments.map(
              (file) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _AttachmentFileCard(file: file, l10n: labels),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentFileCard extends StatefulWidget {
  final AttachmentModel file;
  final DashboardL10n l10n;

  const _AttachmentFileCard({required this.file, required this.l10n});

  @override
  State<_AttachmentFileCard> createState() => _AttachmentFileCardState();
}

class _AttachmentFileCardState extends State<_AttachmentFileCard> {
  final _repository = CommonRepoistory();
  bool _isLoading = false;

  String get _fileName =>
      widget.file.fileName ?? widget.l10n.attachmentUnknownFile;

  String get _fileType {
    final type = widget.file.fileType?.trim();
    if (type != null && type.isNotEmpty) return type;
    final name = widget.file.fileName ?? '';
    if (name.contains('.')) return name.split('.').last;
    return widget.l10n.notAvailableValue();
  }

  String get _uploadedDate {
    final raw = widget.file.createdAt;
    if (raw == null || raw.toString().trim().isEmpty) {
      return widget.l10n.notAvailableValue();
    }
    return widget.l10n.formatDetailDate(raw.toString());
  }

  bool get _canDownload => (widget.file.fileUrl ?? '').trim().isNotEmpty;

  bool get _isImage {
    final lower = _fileName.toLowerCase();
    return lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp');
  }

  bool get _isPdf {
    final lower = _fileName.toLowerCase();
    if (lower.endsWith('.pdf')) return true;
    return _fileType.toLowerCase() == 'pdf';
  }

  Future<Uint8List?> _fetchBytes() async {
    final fileUrl = widget.file.fileUrl?.trim();
    if (fileUrl == null || fileUrl.isEmpty) return null;

    setState(() => _isLoading = true);
    try {
      return await _repository.downloadAttachment(fileUrl: fileUrl);
    } on ApiException catch (e) {
      if (mounted) {
        ShowFlutterToast().showFlutterToastFailure(e.message);
      }
      return null;
    } catch (_) {
      if (mounted) {
        ShowFlutterToast().showFlutterToastFailure(widget.l10n.downloadFailed);
      }
      return null;
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _onDownload() async {
    final bytes = await _fetchBytes();
    if (bytes == null || !mounted) return;

    await FilePicker.platform.saveFile(fileName: _fileName, bytes: bytes);

    if (mounted) {
      ShowFlutterToast().showFlutterToastSuccess(widget.l10n.downloadSuccess);
    }
  }

  Future<void> _onView() async {
    final bytes = await _fetchBytes();
    if (bytes == null || !mounted) return;

    if (_isImage) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                title: Text(_fileName, overflow: TextOverflow.ellipsis),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
              SizedBox(
                height: 360,
                width: double.maxFinite,
                child: InteractiveViewer(
                  child: Image.memory(bytes, fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
      );
      return;
    }

    if (_isPdf) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (ctx) => Scaffold(
            appBar: AppBar(
              title: Text(_fileName, overflow: TextOverflow.ellipsis),
            ),
            body: PdfPreview(
              maxPageWidth: 700,
              canChangePageFormat: false,
              canChangeOrientation: false,
              allowPrinting: false,
              allowSharing: false,
              pdfFileName: _fileName,
              build: (_) async => bytes,
            ),
          ),
        ),
      );
      return;
    }

    ShowFlutterToast().showFlutterToastFailure(widget.l10n.previewNotAvailable);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(label: widget.l10n.documentNameLabel, value: _fileName),
          10.toVerticalSizedBox,
          _InfoRow(label: widget.l10n.fileTypeLabel, value: _fileType),
          10.toVerticalSizedBox,
          _InfoRow(label: widget.l10n.uploadedDateLabel, value: _uploadedDate),
          14.toVerticalSizedBox,
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isLoading || !_canDownload ? null : _onView,
                  icon: const Icon(Icons.remove_red_eye_outlined, size: 18),
                  label: Text(widget.l10n.viewButtonLabel),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: const BorderSide(color: Color(0xFF1A1A2E)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isLoading || !_canDownload ? null : _onDownload,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.download_outlined, size: 18),
                  label: Text(widget.l10n.downloadButtonLabel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _canDownload
                        ? const Color(0xFF1A1A2E)
                        : Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: AppColors.headingColor)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(color: AppColors.contentColor)),
      ],
    );
  }
}
