import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/iconAction.dart';
import 'package:code_setup/presentation/screens/request_details/models/attachmentModel.dart';
import 'package:code_setup/presentation/screens/request_details/widgets/iconAction.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/newRequestPayload.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestDetail.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final AttachmentDetail data;
  final List<CardAction> actions;

  const CustomCard({super.key, required this.data, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 3,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with document name + dynamic actions
            Row(
              children: [
                Expanded(
                  child: Text(
                    data?.fileName ?? 'N/A',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: currentTheme.fontSizes.s16,
                    ),
                  ),
                ),
                ...actions.map(
                  (a) => IconButton(
                    icon: Icon(a.icon, color: a.color),
                    onPressed: a.onPressed,
                  ),
                ),
              ],
            ),
            8.toVerticalSizedBox,
            Text("File Type: ${data.fileType}"),
            Text("Uploaded Date: ${data.createdAt}"),
          ],
        ),
      ),
    );
  }
}
