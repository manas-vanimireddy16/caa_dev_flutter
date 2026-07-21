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
                      for (final message in conversation.messages) ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: ChatbotMessageBubble(
                            text: message.text,
                            isUser: message.isUser,
                          ),
                        ),
                        if (message.isAnswer)
                          ChatbotMessageActions(
                            feedback: message.feedback,
                            showFeedback: true,
                            showShowServices: true,
                            showShowSubServices:
                                conversation.hasSelectedService,
                            showShowQuestions:
                                conversation.hasSelectedSubService,
                            onHelpful: conversation.isLoading
                                ? null
                                : () => notifier.submitFeedback(
                                    message.id,
                                    helpful: true,
                                  ),
                            onNotHelpful: conversation.isLoading
                                ? null
                                : () => notifier.submitFeedback(
                                    message.id,
                                    helpful: false,
                                  ),
                            onShowServices: conversation.isLoading
                                ? null
                                : notifier.showServices,
                            onShowSubServices: conversation.isLoading
                                ? null
                                : notifier.showSubServices,
                            onShowQuestions: conversation.isLoading
                                ? null
                                : () => notifier.showQuestions(),
                          ),
                        const SizedBox(height: 8),
                      ],
                      if (conversation.isLoading)
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: ChatbotMessageBubble(
                            text: 'Loading…',
                            isUser: false,
                            isPending: true,
                          ),
                        ),
                      _ChatbotOptionsPanel(
                        conversation: conversation,
                        onRetry: () =>
                            notifier.loadServices(forceRefresh: true),
                        onServiceSelected: notifier.selectService,
                        onSubServiceSelected: notifier.selectSubService,
                        onQuestionSelected: notifier.selectQuestion,
                      ),
                      if (!conversation.isLoading)
                        _ContextualNavActions(
                          conversation: conversation,
                          onShowServices: notifier.showServices,
                          onShowSubServices: notifier.showSubServices,
                          onShowQuestions: () => notifier.showQuestions(),
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

/// Navigation chips shown with the current options panel (not answer-specific).
class _ContextualNavActions extends StatelessWidget {
  final ChatbotConversationState conversation;
  final VoidCallback onShowServices;
  final VoidCallback onShowSubServices;
  final VoidCallback onShowQuestions;

  const _ContextualNavActions({
    required this.conversation,
    required this.onShowServices,
    required this.onShowSubServices,
    required this.onShowQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final panel = conversation.optionsPanel;

    // After an answer, nav lives on the answer message itself.
    if (panel == ChatbotOptionsPanel.none) {
      final last = conversation.messages.isEmpty
          ? null
          : conversation.messages.last;
      final showForEmptyQuestions =
          conversation.hasSelectedSubService &&
          last != null &&
          last.isAssistant &&
          !last.isAnswer &&
          last.text.contains('No predefined questions');
      final showForCustomPrompt =
          conversation.isInputEnabled &&
          last != null &&
          last.isAssistant &&
          !last.isAnswer &&
          last.text.contains('Please describe your question');
      final showForError =
          last != null &&
          last.isError &&
          conversation.hasSelectedSubService;

      if (!showForEmptyQuestions &&
          !showForCustomPrompt &&
          !showForError) {
        return const SizedBox.shrink();
      }

      return ChatbotMessageActions(
        showShowServices: true,
        showShowSubServices:
            !showForError && conversation.hasSelectedService,
        showShowQuestions: showForError && conversation.hasSelectedSubService,
        onShowServices: onShowServices,
        onShowSubServices: onShowSubServices,
        onShowQuestions: onShowQuestions,
      );
    }

    if (panel == ChatbotOptionsPanel.services) {
      return const SizedBox.shrink();
    }

    if (panel == ChatbotOptionsPanel.subServices) {
      return ChatbotMessageActions(
        showShowServices: true,
        onShowServices: onShowServices,
      );
    }

    // Questions panel
    return ChatbotMessageActions(
      showShowServices: true,
      showShowSubServices: conversation.hasSelectedService,
      onShowServices: onShowServices,
      onShowSubServices: onShowSubServices,
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

class _ChatbotOptionsPanel extends StatelessWidget {
  final ChatbotConversationState conversation;
  final VoidCallback onRetry;
  final ValueChanged<Service> onServiceSelected;
  final ValueChanged<SubService> onSubServiceSelected;
  final ValueChanged<ChatbotQuestion> onQuestionSelected;

  const _ChatbotOptionsPanel({
    required this.conversation,
    required this.onRetry,
    required this.onServiceSelected,
    required this.onSubServiceSelected,
    required this.onQuestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (conversation.isLoading ||
        conversation.optionsPanel == ChatbotOptionsPanel.none) {
      return const SizedBox.shrink();
    }

    final items = _buildItems();
    if (items.isEmpty) {
      if (conversation.optionsPanel == ChatbotOptionsPanel.services) {
        return Padding(
          padding: const EdgeInsets.only(left: 36, top: 4, bottom: 8),
          child: ChatbotActionChip(
            label: 'Retry loading services',
            icon: Icons.refresh_rounded,
            onTap: onRetry,
          ),
        );
      }
      return const SizedBox.shrink();
    }

    final title = switch (conversation.optionsPanel) {
      ChatbotOptionsPanel.services => 'Select a service',
      ChatbotOptionsPanel.subServices => 'Select a sub-service',
      ChatbotOptionsPanel.questions => 'Select a question',
      ChatbotOptionsPanel.none => '',
    };

    return Padding(
      padding: const EdgeInsets.only(left: 36, top: 4, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.cairo(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ChatbotTheme.mutedText,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: items),
        ],
      ),
    );
  }

  List<Widget> _buildItems() {
    return switch (conversation.optionsPanel) {
      ChatbotOptionsPanel.services => conversation.services
          .map(
            (service) => ChatbotActionChip(
              label: _serviceTitle(service),
              icon: Icons.folder_outlined,
              selected: _isSelectedService(service),
              onTap: () => onServiceSelected(service),
            ),
          )
          .toList(),
      ChatbotOptionsPanel.subServices => conversation.subServices
          .map(
            (subService) => ChatbotActionChip(
              label: _subServiceTitle(subService),
              icon: Icons.description_outlined,
              selected: _isSelectedSubService(subService),
              onTap: () => onSubServiceSelected(subService),
            ),
          )
          .toList(),
      ChatbotOptionsPanel.questions => conversation.questions
          .map(
            (question) => ChatbotActionChip(
              label: question.question,
              icon: Icons.help_outline_rounded,
              selected:
                  conversation.selectedQuestion?.questionId ==
                  question.questionId,
              onTap: () => onQuestionSelected(question),
            ),
          )
          .toList(),
      ChatbotOptionsPanel.none => const <Widget>[],
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
    final code = service.code?.trim();
    return code != null && code.isNotEmpty ? code : 'Service';
  }

  String _subServiceTitle(SubService subService) {
    final name = subService.subServiceName?.trim();
    if (name != null && name.isNotEmpty) return name;
    final code = subService.code?.trim();
    return code != null && code.isNotEmpty ? code : 'Sub-service';
  }
}
