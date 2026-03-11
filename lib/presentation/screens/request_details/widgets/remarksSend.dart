part of '../view.dart';

class RemarksSend extends ConsumerWidget {
  final String? title;
  final String? subtitle;
  final int id;

  const RemarksSend({super.key, this.title, this.subtitle, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    // final comments = ref.watch(remarksCommentProvider);
    final state = ref.watch(_vsProvider);
    final controller = ref.read(_vsProvider.notifier);
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
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s14,
                  fontWeight: currentTheme.fontWeights.wBold,
                ),
              ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
                child: Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: currentTheme.fontSizes.s13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

            // Input row with textfield and send button
            Row(
              children: [
                // Expanded text field
                Expanded(
                  child: KTextField(
                    controller: controller.chatController,
                    hintText: "Add your comments",
                    onChanged: (value) {
                      //ref.read(remarksCommentProvider.notifier).state = value;
                    },
                  ),
                ),

                8.toHorizontalSizedBox,

                // Send button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        controller.chatController.text != null &&
                            controller.chatController.text.isNotEmpty
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
                  onPressed: () {
                    print('${id} --- ${controller.chatController.text}');
                    if (controller.chatController.text != null &&
                        controller.chatController.text.isNotEmpty) {
                      final result = controller.sendChat(
                        id,
                        controller.chatController.text,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    size: currentTheme.fontSizes.s18,
                    color: Colors.white,
                  ),
                  label: Text("Send", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
