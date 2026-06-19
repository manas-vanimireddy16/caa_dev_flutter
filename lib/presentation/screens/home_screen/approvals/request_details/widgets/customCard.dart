import 'package:code_setup/presentation/screens/home_screen/approvals/model/attachmentsModel.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/request_details/widgets/IconAction.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Attachmentsmodel data;
  final List<CardAction> actions;

  const CustomCard({super.key, required this.data, this.actions = const []});

  @override
  Widget build(BuildContext context) {
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
                    data.documentName,
                    style: AppTextStyles.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
            const SizedBox(height: 8),
            Text(
              "File Type: ${data.fileType}",
              style: AppTextStyles.cairo(),
            ),
            Text(
              "Uploaded Date: ${data.uploadedDate}",
              style: AppTextStyles.cairo(),
            ),
          ],
        ),
      ),
    );
  }
}
