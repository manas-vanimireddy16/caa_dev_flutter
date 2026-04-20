import 'package:code_setup/presentation/common_widgets/file_upload.dart';
import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileFieldWidget extends ConsumerWidget {
  final DynamicField field;

  const FileFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);

    // final uploadedFiles = List<FileUploadItem>.from(
    //   state.values[field.name] ?? [],
    // );
    final uploadedFiles = (state.values[field.name] is List<FileUploadItem>)
        ? List<FileUploadItem>.from(state.values[field.name])
        : <FileUploadItem>[];

    final errorText = state.errors[field.name];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FileUploadWidget(
          maxFiles: field.maxFiles ?? 1,
          maxFileSizeInMB: field.maxFileSizeInMB ?? 10,

          existingFiles: uploadedFiles,
          allowedExtensions:
              field.allowedExtensions ??
              ['doc', 'docx', 'pdf', 'png', 'jpeg', 'jpg'],
          onUploadSuccess: (file) {
            notifier.onUploadFileSuccess(field.name, file);
          },

          onDelete: (index) {
            notifier.onRemoveFile(field.name, index);
          },
        ),

        // 🔴 Validation error
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              errorText,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
