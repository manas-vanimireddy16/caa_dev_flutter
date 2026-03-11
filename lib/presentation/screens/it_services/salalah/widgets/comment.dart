part of '../view.dart';

class _SalalahComment extends StatelessWidget {
  final _ViewState state;
  final _VSController stateController;
  final List<ChatMessageModel> entries;

  const _SalalahComment({
    super.key,
    required this.entries,
    required this.state,
    required this.stateController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.globalProvider.read(KAppX.theme.current).themeBox;

    return Card(
      color: Colors.white, // PURE WHITE CARD
      elevation: 2,
      shadowColor: Colors.black12,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Color(0xFFDDDDDD), // light grey border (visible)
          width: 1.2,
        ),
      ),
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              children: [
                const Icon(Icons.history, size: 20, color: Colors.black87),
                const SizedBox(width: 8),
                Text(
                  "Comments / Routing Overview",
                  style: TextStyle(
                    fontSize: theme.fontSizes.s16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(),

            /// ⭐ FIXED HEIGHT WHITE CHAT LIST
            SizedBox(
              height: 320,
              child: entries.isEmpty
                  ? const Center(
                      child: Text(
                        "No comments yet",
                        style: TextStyle(color: Colors.black38),
                      ),
                    )
                  : ListView.separated(
                      itemCount: entries.length,
                      padding: const EdgeInsets.only(bottom: 10),
                      separatorBuilder: (_, __) => const SizedBox(height: 6),
                      itemBuilder: (_, index) =>
                          CommentEntry(data: entries[index]),
                    ),
            ),

            const SizedBox(height: 14),

            /// Input Section (white)
            AddCommentBox(
              controller: stateController.chatController,
              attachments: [],
              onAttach: () {},
              onSend: () async{
                // stateController.addCommentInFinRequest(
                //   id: state.requestDetails?.request?.id,
                // );
              },
              actionType: ActionButtonsType.none,
              onClose: () async {
                // stateController.approveRequest(
                //   id: state.requestDetails?.request?.id,
                // );
              },
              onReject: () async {
                // stateController.rejectRequest(
                //   id: state.requestDetails?.request?.id,
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
