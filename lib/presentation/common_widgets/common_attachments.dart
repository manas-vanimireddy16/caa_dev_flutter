import 'package:flutter/material.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/models/details_models.dart';

class CommonAttachmentsTabContent extends StatelessWidget {
  final List<AttachmentModel> attachments;

  const CommonAttachmentsTabContent({super.key, required this.attachments});

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) {
      return const Center(child: Text("No attachments available"));
    }

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE0E0E0), width: 1.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 400.toAutoScaledHeight,
          child: ListView.builder(
            itemCount: attachments.length,
            itemBuilder: (context, index) {
              final item = attachments[index];
              return _buildAttachmentTile(item);
            },
          ),
        ),
      ),
    );
  }

  /// 🔹 Single attachment tile shown in list
  Widget _buildAttachmentTile(AttachmentModel file) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFEAEAEA)),
      ),
      child: ListTile(
        leading: const Icon(Icons.attach_file, color: Colors.grey),

        title: Text(
          file.fileName ?? "Unknown File",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (file.fileSize != null)
              Text(
                "Size: ${file.fileSize}",
                style: const TextStyle(fontSize: 12),
              ),

            if (file.user != null)
              Text(
                "Uploaded by: ${file.user?.employeeName}",
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),

            if (file.createdAt != null)
              Text(
                "Uploaded at: ${file.createdAt}",
                style: const TextStyle(fontSize: 12, color: Colors.black45),
              ),
          ],
        ),

        trailing: Wrap(
          spacing: 8,
          children: [
            /// Download
            IconButton(
              icon: const Icon(Icons.download, color: Colors.green),
              onPressed: () {
                debugPrint("Download → ${file.fileUrl}");
              },
            ),

            /// Preview
            // IconButton(
            //   icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
            //   onPressed: () {
            //     debugPrint("Preview → ${file.fileUrl}");
            //   },
            // ),

            // /// 🔴 Delete
            // IconButton(
            //   icon: const Icon(Icons.delete, color: Colors.red),
            //   onPressed: () {
            //     debugPrint("Delete Attachment Id → ${file.id}");
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
