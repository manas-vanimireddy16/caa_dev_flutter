import 'dart:io';
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

  const FileUploadWidget({
    Key? key,
    this.onUploadSuccess,
    this.onDelete,
    this.maxFiles = 5,
    this.maxFileSizeInMB = 10,
    this.allowedExtensions = const ['doc', 'docx', 'pdf', 'png', 'jpeg', 'jpg'],
  }) : super(key: key);

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  final List<File> _selectedFiles = [];
  final List<String?> _uploadedUrls = [];

  String? _errorMessage;
  bool _isUploading = false;
  int? _uploadingIndex;

  Future<void> _pickFile() async {
    setState(() {
      _errorMessage = null;
    });

    // ✅ Max file count validation
    if (_selectedFiles.length >= widget.maxFiles) {
      setState(() {
        if (widget.maxFiles == 1) {
          _errorMessage = "";
        } else {
          _errorMessage = "You can upload maximum ${widget.maxFiles} files";
        }
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

    // ✅ Validate extension manually (extra safety)
    final extension = pickedFile.name.split('.').last.toLowerCase();

    if (!widget.allowedExtensions
        .map((e) => e.toLowerCase())
        .contains(extension)) {
      setState(() {
        _errorMessage =
            "Invalid file type. Allowed: ${widget.allowedExtensions.join(', ')}";
      });
      return;
    }

    // ✅ File size validation
    final maxFileSizeBytes = widget.maxFileSizeInMB * 1024 * 1024;

    if (size > maxFileSizeBytes) {
      setState(() {
        _errorMessage = "File can't be larger than ${widget.maxFileSizeInMB}MB";
      });
      return;
    }

    setState(() {
      _selectedFiles.add(file);
      _uploadedUrls.add(null);
    });

    await _uploadFile(_selectedFiles.length - 1);
  }

  Future<void> _uploadFile(int index) async {
    if (index >= _selectedFiles.length) return;

    setState(() {
      _isUploading = true;
      _uploadingIndex = index;
      _errorMessage = null;
    });

    try {
      final file = _selectedFiles[index];
      final fileName = file.path.split('/').last;

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final authRepo = AuthRepository();
      final response = await authRepo.uploadFile(formData);

      final uploadedFile = response?.data?.files?.first;

      setState(() {
        _isUploading = false;
        _uploadingIndex = null;
        _uploadedUrls[index] = uploadedFile?.downloadUrl ?? '';
      });

      if (widget.onUploadSuccess != null) {
        widget.onUploadSuccess!(
          FileUploadItem(
            documentId: uploadedFile?.documentId,
            filename: uploadedFile?.filename,
            originalName: uploadedFile?.originalName,
            size: uploadedFile?.size,
            downloadUrl: uploadedFile?.downloadUrl,
          ),
        );
      }

      ShowFlutterToast().showFlutterToastSuccess(
        response?.message ?? "File uploaded successfully!",
      );
    } catch (e) {
      setState(() {
        _isUploading = false;
        _uploadingIndex = null;
        _uploadedUrls[index] = null;
        _errorMessage = "Failed to upload file";
      });
    }
  }

  void _deleteFile(int index) {
    if (index < 0 || index >= _selectedFiles.length) return;

    setState(() {
      _selectedFiles.removeAt(index);
      _uploadedUrls.removeAt(index);
    });

    widget.onDelete?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            "Attachments",
            style: TextStyle(
              fontWeight: currentTheme.fontWeights.wBold,
              fontSize: currentTheme.fontSizes.s12,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: _isUploading ? null : _pickFile,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _isUploading
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 10),
                            Text("Uploading..."),
                          ],
                        )
                      : Text(
                          "Upload File",
                          style: TextStyle(
                            fontWeight: currentTheme.fontWeights.wBold,
                            fontSize: currentTheme.fontSizes.s14,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 14),

              Text(
                "${_selectedFiles.length} / ${widget.maxFiles} files uploaded",
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s12,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Allowed: ${widget.allowedExtensions.join(', ')}\n"
                "Max size: ${widget.maxFileSizeInMB}MB per file",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s12,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 10),

              if (_selectedFiles.isNotEmpty)
                ...List.generate(_selectedFiles.length, (index) {
                  final file = _selectedFiles[index];
                  return ListTile(
                    dense: true,
                    title: Text(
                      file.path.split('/').last,
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

              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
