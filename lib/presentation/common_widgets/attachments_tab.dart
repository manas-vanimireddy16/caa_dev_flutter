import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/screens/it_services/vpn/models/vpn_request_by_id.dart';
import 'package:flutter/material.dart';

// Assuming you already have these types somewhere in your project
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';

class AttachmentsTabContent<T> extends StatelessWidget {
  final List<dynamic> attachments;

  const AttachmentsTabContent({super.key, required this.attachments});

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) {
      return const Center(child: Text("No attachments available"));
    }

    // ✅ Detect type once (not per item)
    if (attachments.first is AttachmentDetail) {
      return _buildLogisticsAttachments();
    } else if (attachments.first is VPNAttachment) {
      return _buildVPNAttachments();
    } else {
      return const Center(child: Text("Unsupported attachment type"));
    }
  }

  // 🟦 Logistics Attachment Builder
  Widget _buildLogisticsAttachments() {
    final logisticsAttachments = attachments.cast<AttachmentDetail>();

    return _buildAttachmentCard(
      list: logisticsAttachments.map((a) {
        return _buildAttachmentTile(
          name: a.fileName ?? "Unknown File",
          url: a.fileUrl ?? "",
        );
      }).toList(),
    );
  }

  // 🟩 VPN Attachment Builder
  Widget _buildVPNAttachments() {
    final vpnAttachments = attachments.cast<VPNAttachment>();

    return _buildAttachmentCard(
      list: vpnAttachments.map((a) {
        return _buildAttachmentTile(
          name: a.fileName ?? "Unknown File",
          url: a.fileUrl ?? "",
        );
      }).toList(),
    );
  }

  // ♻️ Shared reusable UI card
  Widget _buildAttachmentCard({required List<Widget> list}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 400.toAutoScaledHeight,
          child: ListView(children: list),
        ),
      ),
    );
  }

  // 🧩 Shared attachment row builder
  Widget _buildAttachmentTile({required String name, required String url}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.attach_file, color: Colors.grey),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(url.isNotEmpty ? url : "No URL"),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: const Icon(Icons.download, color: Colors.green),
              onPressed: () => debugPrint("Download $url"),
            ),
            IconButton(
              icon: const Icon(Icons.remove_red_eye, color: Colors.blueGrey),
              onPressed: () => debugPrint("View $name"),
            ),
          ],
        ),
      ),
    );
  }
}
