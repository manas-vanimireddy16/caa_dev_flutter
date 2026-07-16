import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/presentation/chatbot/models/chat_message.dart';
import 'package:code_setup/presentation/chatbot/models/chatbot_answer_response.dart';
import 'package:code_setup/presentation/chatbot/models/chatbot_question_response.dart';
import 'package:equatable/equatable.dart';

enum ChatbotConversationStep { services, subServices, questions, manualInput }

class ChatbotConversationState extends Equatable {
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool isInputEnabled;
  final bool showFeedbackButtons;
  final String? errorMessage;
  final ChatbotConversationStep step;
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
    this.showFeedbackButtons = false,
    this.errorMessage,
    this.step = ChatbotConversationStep.services,
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

  ChatbotConversationState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? isInputEnabled,
    bool? showFeedbackButtons,
    String? errorMessage,
    bool clearErrorMessage = false,
    ChatbotConversationStep? step,
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
      showFeedbackButtons: showFeedbackButtons ?? this.showFeedbackButtons,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
      step: step ?? this.step,
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
    showFeedbackButtons,
    errorMessage,
    step,
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
