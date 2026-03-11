import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/screens/request_details/view.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestDetail.dart';
import 'package:flutter/material.dart';

import '../../home_screen/approvals/request_details/widgets/statusInfo.dart';

class RequestHistoryTabContent extends StatelessWidget {
  final List<ChatMessageModel> comments;
  final int id;

  const RequestHistoryTabContent({
    super.key,
    required this.comments,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height:
                  400.toAutoScaledHeight, // fix height for the inner ListView
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return StatusInfo(
                    userName: comment.user?.employeeName ?? 'NA',
                    initials: getInitials(comment.user?.employeeName ?? 'NA'),
                    message: comment.message ?? 'NA',
                    dateTime: comment.createdAt ?? '',
                  );
                },
              ),
            ),

            RemarksSend(
              title: "Add Remarks",
              subtitle: "You can add your comments or remarks below.",
              id: id,
            ),
          ],
        ),
      ),
    );
  }
}

String getInitials(String? name) {
  if (name == null || name.isEmpty) return "NA";

  List<String> parts = name.trim().split(" ");
  if (parts.length == 1) {
    // If only one word, take first 2 letters
    return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
  } else {
    // If more than one word, take first letter of first 2 words
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}
