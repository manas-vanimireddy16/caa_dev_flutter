import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/customCard.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/iconAction.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class AttachmentsTabContent extends StatelessWidget {
  final List<AttachmentDetail> attachments;

  const AttachmentsTabContent({super.key, required this.attachments});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 400.toAutoScaledHeight,
          child: ListView.builder(
            itemCount: attachments.length,
            itemBuilder: (context, index) {
              final attachment = attachments[index];
              return CustomCard(
                data: attachment,
                actions: [
                  CardAction(
                    icon: Icons.download,
                    color: Colors.green,
                    onPressed: () =>
                        debugPrint("Download ${attachment.fileUrl}"),
                  ),
                  CardAction(
                    icon: Icons.remove_red_eye,
                    color: Colors.blueGrey,
                    onPressed: () => debugPrint("View ${attachment.fileName}"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
