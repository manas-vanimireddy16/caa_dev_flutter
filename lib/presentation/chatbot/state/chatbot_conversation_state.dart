import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/presentation/chatbot/models/chat_message.dart';
import 'package:code_setup/presentation/chatbot/models/chatbot_answer_response.dart';
import 'package:code_setup/presentation/chatbot/models/chatbot_question_response.dart';
import 'package:equatable/equatable.dart';

/// Which selectable option list is currently visible in the chat.
enum ChatbotOptionsPanel { none, services, subServices, questions }

class ChatbotConversationState extends Equatable {
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool isInputEnabled;
  final String? errorMessage;
  final ChatbotOptionsPanel optionsPanel;
  final List<Service> services;
  final List<SubService> subServices;
  final List<ChatbotQuestion> questions;
  final Service? selectedService;
  final String? selectedServiceCode;
  final SubService? selectedSubService;
  final String? selectedSubServiceCode;
  final ChatbotQuestion? selectedQuestion;
  final ChatbotAnswerResponse? currentAnswer;

  const ChatbotConversationState({
    this.messages = const [],
    this.isLoading = false,
    this.isInputEnabled = false,
    this.errorMessage,
    this.optionsPanel = ChatbotOptionsPanel.none,
    this.services = const [],
    this.subServices = const [],
    this.questions = const [],
    this.selectedService,
    this.selectedServiceCode,
    this.selectedSubService,
    this.selectedSubServiceCode,
    this.selectedQuestion,
    this.currentAnswer,
  });

  bool get hasSelectedService => selectedService != null;
  bool get hasSelectedSubService => selectedSubService != null;
  bool get hasQuestions => questions.isNotEmpty;

  ChatbotConversationState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? isInputEnabled,
    String? errorMessage,
    bool clearErrorMessage = false,
    ChatbotOptionsPanel? optionsPanel,
    List<Service>? services,
    List<SubService>? subServices,
    List<ChatbotQuestion>? questions,
    Service? selectedService,
    bool clearSelectedService = false,
    String? selectedServiceCode,
    bool clearSelectedServiceCode = false,
    SubService? selectedSubService,
    bool clearSelectedSubService = false,
    String? selectedSubServiceCode,
    bool clearSelectedSubServiceCode = false,
    ChatbotQuestion? selectedQuestion,
    bool clearSelectedQuestion = false,
    ChatbotAnswerResponse? currentAnswer,
    bool clearCurrentAnswer = false,
  }) {
    return ChatbotConversationState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isInputEnabled: isInputEnabled ?? this.isInputEnabled,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
      optionsPanel: optionsPanel ?? this.optionsPanel,
      services: services ?? this.services,
      subServices: subServices ?? this.subServices,
      questions: questions ?? this.questions,
      selectedService: clearSelectedService
          ? null
          : selectedService ?? this.selectedService,
      selectedServiceCode: clearSelectedServiceCode
          ? null
          : selectedServiceCode ?? this.selectedServiceCode,
      selectedSubService: clearSelectedSubService
          ? null
          : selectedSubService ?? this.selectedSubService,
      selectedSubServiceCode: clearSelectedSubServiceCode
          ? null
          : selectedSubServiceCode ?? this.selectedSubServiceCode,
      selectedQuestion: clearSelectedQuestion
          ? null
          : selectedQuestion ?? this.selectedQuestion,
      currentAnswer: clearCurrentAnswer
          ? null
          : currentAnswer ?? this.currentAnswer,
    );
  }

  @override
  List<Object?> get props => [
    messages,
    isLoading,
    isInputEnabled,
    errorMessage,
    optionsPanel,
    services,
    subServices,
    questions,
    selectedService,
    selectedServiceCode,
    selectedSubService,
    selectedSubServiceCode,
    selectedQuestion,
    currentAnswer,
  ];
}
