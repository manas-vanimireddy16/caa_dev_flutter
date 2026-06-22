import 'package:equatable/equatable.dart';

enum ChatbotShellVisibility {
  /// Only the floating launcher is visible.
  hidden,

  /// Welcome / feature intro panel.
  intro,

  /// Active chat window.
  chat,
}

class ChatbotShellState extends Equatable {
  final ChatbotShellVisibility visibility;
  final bool isExpanded;

  const ChatbotShellState({
    required this.visibility,
    this.isExpanded = false,
  });

  const ChatbotShellState.initial()
      : visibility = ChatbotShellVisibility.hidden,
        isExpanded = false;

  bool get showsFloatingButton => visibility == ChatbotShellVisibility.hidden;
  bool get showsIntro => visibility == ChatbotShellVisibility.intro;
  bool get showsChat => visibility == ChatbotShellVisibility.chat;

  ChatbotShellState copyWith({
    ChatbotShellVisibility? visibility,
    bool? isExpanded,
  }) {
    return ChatbotShellState(
      visibility: visibility ?? this.visibility,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  @override
  List<Object?> get props => [visibility, isExpanded];
}
