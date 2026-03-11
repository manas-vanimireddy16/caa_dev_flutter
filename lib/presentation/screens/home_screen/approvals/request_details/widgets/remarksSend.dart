import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/request_details/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemarksSend extends ConsumerWidget {
  final String? title;
  final String? subtitle;

  const RemarksSend({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final comments = ref.watch(remarksCommentProvider);
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
                child: Text(
                  subtitle!,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ),

            // Input row with textfield and send button
            Row(
              children: [
                // Expanded text field
                Expanded(
                  child: KTextField(
                    hintText: "Add your comments",
                    onChanged: (value) {
                      //  ref.read(remarksCommentProvider.notifier).state = value;
                    },
                  ),
                ),

                const SizedBox(width: 8),

                // Send button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: comments != null && comments.isNotEmpty
                        ? Colors.blue
                        : Colors.grey, // gray background
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.send, size: 18, color: Colors.white),
                  label: const Text(
                    "Send",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
