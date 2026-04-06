import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class CommonPolicyDialog extends StatelessWidget {
  final String title;
  final String content;
  final String acceptText;
  final String cancelText;

  const CommonPolicyDialog({
    super.key,
    required this.title,
    required this.content,
    this.acceptText = 'Accept',
    this.cancelText = 'Close',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 🔹 Title
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          /// 🔹 Scrollable Content
          SizedBox(
            height: 260,
            child: SingleChildScrollView(
              child: Text(content, style: const TextStyle(fontSize: 14)),
            ),
          ),

          const SizedBox(height: 16),

          /// 🔹 Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    KAppX.router.pop();
                  },
                  child: Text(cancelText),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    KAppX.router.pop(true);
                  },
                  child: Text(acceptText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
