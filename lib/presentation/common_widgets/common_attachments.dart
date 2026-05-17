import 'dart:typed_data';

import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/repository/common/domain/domain.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
      return Center(child: Text(labels.noAttachmentsAvailable));
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
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

    final lower = _fileName.toLowerCase();
    final isImage =
        lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp');

    if (!isImage) {
      ShowFlutterToast().showFlutterToastFailure(
        widget.l10n.previewNotAvailable,
      );
      return;
    }

    if (!mounted) return;
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
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
