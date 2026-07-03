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
    final values = state.values;

    // final uploadedFiles = List<FileUploadItem>.from(
    //   state.values[field.name] ?? [],
    // );
    final uploadedFiles = (state.values[field.name] is List<FileUploadItem>)
        ? List<FileUploadItem>.from(state.values[field.name])
        : <FileUploadItem>[];

    final errorText = state.errors[field.name];
    final isRequired =
        field.required || (field.requiredWhen?.call(values) ?? false);
    final isDisabled =
        field.disabled || (field.disabledWhen?.call(values) ?? false);

    return Opacity(
      opacity: isDisabled ? 0.5 : 1,
      child: AbsorbPointer(
        absorbing: isDisabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FileUploadWidget(
              title: field.label.trim().isNotEmpty ? field.label.trim() : null,
              maxFiles: field.maxFiles ?? 1,
              maxFileSizeInMB: field.maxFileSizeInMB ?? 10,
              isRequired: isRequired,
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
        ),
      ),
    );
  }
}
