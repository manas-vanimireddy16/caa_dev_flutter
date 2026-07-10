part of '../view.dart';

class SecurityThreatFormHeaderSection extends ConsumerWidget {
  const SecurityThreatFormHeaderSection({
    super.key,
    required this.controller,
    required this.l10n,
  });

  final _VSController controller;
  final DashboardL10n l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(dynamicFormProvider.notifier);
    final state = ref.watch(dynamicFormProvider);
    final uploadedFiles = (state.values['attachments'] is List<FileUploadItem>)
        ? List<FileUploadItem>.from(state.values['attachments'])
        : <FileUploadItem>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.securityThreatDownloadFormHint,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF6B7280),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10),
        PopupMenuButton<String>(
          offset: const Offset(0, 44),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onSelected: (format) async {
            final values = ref.read(dynamicFormProvider).values;
            if (format == 'excel') {
              await controller.downloadSecurityThreatExcel(values: values);
            } else {
              await controller.downloadSecurityThreatCsv(values: values);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'excel',
              child: Text(l10n.securityThreatDownloadExcelLabel),
            ),
            PopupMenuItem(
              value: 'csv',
              child: Text(l10n.securityThreatDownloadCsvLabel),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.buttonGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.download, color: Colors.white, size: 18),
                const SizedBox(width: 10),
                Text(
                  l10n.securityThreatDownloadThreatFormLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        FileUploadWidget(
          title: l10n.securityThreatAttachFormLabel,
          maxFiles: 1,
          maxFileSizeInMB: 10,
          isRequired: false,
          existingFiles: uploadedFiles,
          allowedExtensions: const ['doc', 'docx', 'pdf', 'png', 'jpeg', 'jpg'],
          onUploadSuccess: (file) {
            notifier.onUploadFileSuccess('attachments', file);
          },
          onDelete: (index) {
            notifier.onRemoveFile('attachments', index);
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
