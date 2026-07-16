import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/presentation/chatbot/chatbot_theme.dart';
import 'package:code_setup/presentation/chatbot/models/chatbot_question_response.dart';
import 'package:code_setup/presentation/chatbot/notifiers/chatbot_conversation_notifier.dart';
import 'package:code_setup/presentation/chatbot/state/chatbot_conversation_state.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_feedback_buttons.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_icon.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_input_bar.dart';
import 'package:code_setup/presentation/chatbot/widgets/chatbot_message_bubble.dart';
import 'package:code_setup/utils/helper/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Full-screen chat conversation body for the AI assistant.
class ChatbotConversationView extends ConsumerStatefulWidget {
  const ChatbotConversationView({super.key});

  @override
  ConsumerState<ChatbotConversationView> createState() =>
      _ChatbotConversationViewState();
}

class _ChatbotConversationViewState
    extends ConsumerState<ChatbotConversationView>
    with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(chatbotConversationProvider, (_, __) => _scrollToBottom());

    final conversation = ref.watch(chatbotConversationProvider);
    final notifier = ref.read(chatbotConversationProvider.notifier);

    return ColoredBox(
      color: ChatbotTheme.surface,
      child: Column(
        children: [
          Expanded(
            child: conversation.messages.isEmpty
                ? _EmptyChatState(isLoading: conversation.isLoading)
                : ListView(
                    controller: _scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    children: [
                      for (final message in conversation.messages)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ChatbotMessageBubble(
                            text: message.text,
                            isUser: message.isUser,
                          ),
                        ),
                      if (conversation.isLoading)
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: ChatbotMessageBubble(
                            text: 'Loading…',
                            isUser: false,
                            isPending: true,
                          ),
                        ),
                      _ChatbotGuidedOptions(
                        conversation: conversation,
                        onRetry: notifier.loadServices,
                        onServiceSelected: notifier.selectService,
                        onSubServiceSelected: notifier.selectSubService,
                        onQuestionSelected: notifier.selectQuestion,
                      ),
                      if (conversation.showFeedbackButtons)
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 12),
                          child: ChatbotFeedbackButtons(
                            onHelpful: conversation.isLoading
                                ? null
                                : notifier.markHelpful,
                            onNotHelpful: conversation.isLoading
                                ? null
                                : notifier.markNotHelpful,
                          ),
                        ),
                    ],
                  ),
          ),
          if (conversation.isInputEnabled)
            ChatbotInputBar(
              enabled: !conversation.isLoading,
              onSend: notifier.sendMessage,
            ),
        ],
      ),
    );
  }
}

class _EmptyChatState extends StatelessWidget {
  final bool isLoading;

  const _EmptyChatState({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ChatbotIcon(size: 72),
            const SizedBox(height: 16),
            Text(
              'Hi, I\'m your AI Assistant',
              textAlign: TextAlign.center,
              style: AppTextStyles.cairo(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: ChatbotTheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ask me about requests, meetings, or circulars.',
              textAlign: TextAlign.center,
              style: AppTextStyles.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ChatbotTheme.mutedText,
              ),
            ),
            if (isLoading) ...[
              const SizedBox(height: 16),
              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChatbotGuidedOptions extends StatelessWidget {
  final ChatbotConversationState conversation;
  final VoidCallback onRetry;
  final ValueChanged<Service> onServiceSelected;
  final ValueChanged<SubService> onSubServiceSelected;
  final ValueChanged<ChatbotQuestion> onQuestionSelected;

  const _ChatbotGuidedOptions({
    required this.conversation,
    required this.onRetry,
    required this.onServiceSelected,
    required this.onSubServiceSelected,
    required this.onQuestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (conversation.isLoading || conversation.showFeedbackButtons) {
      return const SizedBox.shrink();
    }

    final optionGroups = _buildOptionGroups();
    final hasOptions = optionGroups.any((group) => group.items.isNotEmpty);

    if (!hasOptions && conversation.step == ChatbotConversationStep.services) {
      return Align(
        alignment: Alignment.centerLeft,
        child: _OptionSelectionCard(
          title: 'Select Service',
          items: [
            _OptionItem(
              title: 'Retry',
              subtitle: 'Tap to load services again',
              icon: Icons.refresh_rounded,
              onTap: onRetry,
            ),
          ],
        ),
      );
    }

    if (!hasOptions) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 12, left: 36),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final group in optionGroups)
              if (group.items.isNotEmpty) ...[
                _OptionSelectionCard(title: group.title, items: group.items),
                const SizedBox(height: 12),
              ],
          ],
        ),
      ),
    );
  }

  List<_OptionGroup> _buildOptionGroups() {
    return switch (conversation.step) {
      ChatbotConversationStep.services => [
        _OptionGroup(
          title: 'Select Service',
          items: conversation.services
              .map(
                (service) => _OptionItem(
                  title: _serviceTitle(service),
                  subtitle: _serviceCode(service),
                  icon: Icons.folder_outlined,
                  selected: _isSelectedService(service),
                  onTap: () => onServiceSelected(service),
                ),
              )
              .toList(),
        ),
        if (conversation.subServices.isNotEmpty)
          _OptionGroup(
            title: 'Select Sub-Service',
            items: conversation.subServices
                .map(
                  (subService) => _OptionItem(
                    title: _subServiceTitle(subService),
                    subtitle: _subServiceCode(subService),
                    icon: Icons.description_outlined,
                    selected: _isSelectedSubService(subService),
                    onTap: () => onSubServiceSelected(subService),
                  ),
                )
                .toList(),
          ),
      ],
      ChatbotConversationStep.subServices => [
        _OptionGroup(
          title: 'Select Sub-Service',
          items: conversation.subServices
              .map(
                (subService) => _OptionItem(
                  title: _subServiceTitle(subService),
                  subtitle: _subServiceCode(subService),
                  icon: Icons.description_outlined,
                  selected: _isSelectedSubService(subService),
                  onTap: () => onSubServiceSelected(subService),
                ),
              )
              .toList(),
        ),
      ],
      ChatbotConversationStep.questions => [
        _OptionGroup(
          title: 'Questions',
          items: conversation.questions
              .map(
                (question) => _OptionItem(
                  title: question.question,
                  icon: Icons.help_outline_rounded,
                  selected:
                      conversation.selectedQuestion?.questionId ==
                      question.questionId,
                  onTap: () => onQuestionSelected(question),
                ),
              )
              .toList(),
        ),
      ],
      ChatbotConversationStep.manualInput => const <_OptionGroup>[],
    };
  }

  bool _isSelectedService(Service service) {
    final selectedCode = conversation.selectedServiceCode?.trim();
    final code = service.code?.trim();
    if (selectedCode != null && selectedCode.isNotEmpty && code != null) {
      return selectedCode == code;
    }
    return conversation.selectedService?.id == service.id;
  }

  bool _isSelectedSubService(SubService subService) {
    final selectedCode = conversation.selectedSubServiceCode?.trim();
    final code = subService.code?.trim();
    if (selectedCode != null && selectedCode.isNotEmpty && code != null) {
      return selectedCode == code;
    }
    return conversation.selectedSubService?.id == subService.id;
  }

  String _serviceTitle(Service service) {
    final name = service.name?.trim();
    if (name != null && name.isNotEmpty) return name;
    return _serviceCode(service) ?? 'Service';
  }

  String? _serviceCode(Service service) {
    final code = service.code?.trim();
    return code != null && code.isNotEmpty ? code : null;
  }

  String _subServiceTitle(SubService subService) {
    final name = subService.subServiceName?.trim();
    if (name != null && name.isNotEmpty) return name;
    return _subServiceCode(subService) ?? 'Sub-service';
  }

  String? _subServiceCode(SubService subService) {
    final code = subService.code?.trim();
    return code != null && code.isNotEmpty ? code : null;
  }
}

class _OptionGroup {
  final String title;
  final List<_OptionItem> items;

  const _OptionGroup({required this.title, required this.items});
}

class _OptionItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;

  const _OptionItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.subtitle,
    this.selected = false,
  });
}

class _OptionSelectionCard extends StatelessWidget {
  static const double _height = 304;
  static const Color _headerColor = Color(0xFF1F2A67);

  final String title;
  final List<_OptionItem> items;

  const _OptionSelectionCard({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.sizeOf(context).width - 96;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      child: SizedBox(
        key: ValueKey('$title-${items.length}'),
        height: _height,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth.clamp(260.0, 380.0).toDouble(),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ChatbotTheme.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: _headerColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Text(
                      title,
                      style: AppTextStyles.cairo(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: const MaterialScrollBehavior().copyWith(
                        scrollbars: false,
                      ),
                      child: ListView.separated(
                        primary: false,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const Divider(
                          height: 1,
                          thickness: 1,
                          color: ChatbotTheme.border,
                        ),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return _OptionTile(item: item);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final _OptionItem item;

  const _OptionTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = item.selected
        ? ChatbotTheme.primary.withValues(alpha: 0.08)
        : Colors.white;
    final iconBackground = item.selected
        ? ChatbotTheme.primary
        : ChatbotTheme.primary.withValues(alpha: 0.08);
    final iconColor = item.selected ? Colors.white : ChatbotTheme.primary;

    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: item.onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, size: 20, color: iconColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.cairo(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: ChatbotTheme.aiBubbleText,
                          height: 1.25,
                        ),
                      ),
                      if (item.subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          item.subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.cairo(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: ChatbotTheme.mutedText,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: item.selected
                      ? ChatbotTheme.primary
                      : ChatbotTheme.mutedText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
