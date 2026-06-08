import 'dart:io';

import 'package:code_setup/presentation/common_widgets/common_attachments.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/repository/authentication/domain.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadWidget extends StatefulWidget {
  final void Function(FileUploadItem fileDetails)? onUploadSuccess;
  final void Function(int index)? onDelete;

  final int maxFiles;
  final int maxFileSizeInMB;
  final List<String> allowedExtensions;

  /// ✅ FROM STATE (IMPORTANT)
  final List<FileUploadItem> existingFiles;

  /// Section heading above the upload box (e.g. dynamic form field label).
  /// When null, defaults to "Attachments".
  final String? title;
  final bool isRequired;

  const FileUploadWidget({
    Key? key,
    this.onUploadSuccess,
    this.onDelete,
    this.maxFiles = 5,
    this.maxFileSizeInMB = 10,
    this.existingFiles = const [],
    this.allowedExtensions = const ['doc', 'docx', 'pdf', 'png', 'jpeg', 'jpg'],
    this.title,
    this.isRequired = false,
  }) : super(key: key);

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  String? _errorMessage;
  bool _isUploading = false;

  /// ✅ ALWAYS USE STATE FILES
  List<FileUploadItem> get files => widget.existingFiles;

  Future<void> _pickFile() async {
    setState(() => _errorMessage = null);

    /// ✅ MAX FILE CHECK
    if (files.length >= widget.maxFiles) {
      setState(() {
        _errorMessage = "You can upload maximum ${widget.maxFiles} files";
      });
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: widget.allowedExtensions,
    );

    if (result == null || result.files.isEmpty) return;

    final pickedFile = result.files.single;

    if (pickedFile.path == null) return;

    final file = File(pickedFile.path!);
    final size = await file.length();

    /// ✅ EXTENSION VALIDATION
    final extension = pickedFile.name.split('.').last.toLowerCase();

    if (!widget.allowedExtensions.contains(extension)) {
      setState(() {
        _errorMessage =
            "Invalid file type. Allowed: ${widget.allowedExtensions.join(', ')}";
      });
      return;
    }

    /// ✅ SIZE VALIDATION
    final maxBytes = widget.maxFileSizeInMB * 1024 * 1024;

    if (size > maxBytes) {
      setState(() {
        _errorMessage = "File can't be larger than ${widget.maxFileSizeInMB}MB";
      });
      return;
    }

    await _uploadFile(file);
  }

  Future<void> _uploadFile(File file) async {
    setState(() {
      _isUploading = true;
      _errorMessage = null;
    });

    try {
      final fileName = file.path.split('/').last;

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final authRepo = AuthRepository();
      final response = await authRepo.uploadFile(formData);

      final uploadedFile = response?.data?.files?.first;

      final fileItem = FileUploadItem(
        documentId: uploadedFile?.documentId,
        filename: uploadedFile?.filename,
        originalName: uploadedFile?.originalName,
        size: uploadedFile?.size,
        downloadUrl: uploadedFile?.downloadUrl,
      );

      /// ✅ SEND TO STATE
      widget.onUploadSuccess?.call(fileItem);

      ShowFlutterToast().showFlutterToastSuccess(
        response?.message ?? "File uploaded successfully!",
      );
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to upload file";
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _deleteFile(int index) {
    widget.onDelete?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return CommonAttachmentsUploadArea(
      title: widget.title?.trim().isNotEmpty == true
          ? widget.title!.trim()
          : 'Attachments (Optional)',
      isRequired: widget.isRequired,
      isUploading: _isUploading,
      onUploadTap: _pickFile,
      allowedExtensions: widget.allowedExtensions,
      maxFileSizeInMB: widget.maxFileSizeInMB,
      footer: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (files.isNotEmpty) ...[
            Text(
              '${files.length} / ${widget.maxFiles} files uploaded',
              style: const TextStyle(
                fontSize: 12,
                color: filesTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            ...List.generate(files.length, (index) {
              final file = files[index];

              return ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(
                  file.originalName ?? 'File ${index + 1}',
                  style: TextStyle(fontSize: currentTheme.fontSizes.s13),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 20,
                  ),
                  onPressed: () => _deleteFile(index),
                ),
              );
            }),
          ],
          if (_errorMessage != null)
            Text(
              _errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
