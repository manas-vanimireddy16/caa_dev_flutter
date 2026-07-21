import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/presentation/chatbot/models/chat_message.dart';
import 'package:code_setup/presentation/chatbot/models/chatbot_answer_response.dart';
import 'package:code_setup/presentation/chatbot/models/chatbot_question_response.dart';
import 'package:code_setup/presentation/chatbot/state/chatbot_conversation_state.dart';
import 'package:code_setup/repository/chatbot/domain/domain.dart';
import 'package:code_setup/repository/common_dashboard_all_services/domain/domain.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:code_setup/utils/helper/mobile_service_scope.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatbotConversationProvider =
    NotifierProvider.autoDispose<
      ChatbotConversationNotifier,
      ChatbotConversationState
    >(ChatbotConversationNotifier.new);

/// Handles chat messages, navigation, and chatbot API calls.
class ChatbotConversationNotifier
    extends AutoDisposeNotifier<ChatbotConversationState> {
  final ChatbotRepository _chatbotRepository = ChatbotRepository();
  final CommonDashboardRepository _dashboardRepository =
      CommonDashboardRepository();

  int _messageCounter = 0;
  String? _cachedRoleName;
  bool _didStart = false;
  bool _servicesLoaded = false;

  /// Cached questions keyed by sub-service code.
  final Map<String, List<ChatbotQuestion>> _questionsCache = {};

  @override
  ChatbotConversationState build() {
    final initialState = ChatbotConversationState(
      messages: [
        _createMessage(
          role: ChatMessageRole.assistant,
          text: "Hello! I'm your AI assistant. How can I help you today?",
        ),
      ],
    );

    if (!_didStart) {
      _didStart = true;
      Future.microtask(loadServices);
    }

    return initialState;
  }

  /// Loads role-services once and shows the services option panel.
  Future<void> loadServices({bool forceRefresh = false}) async {
    if (state.isLoading) return;

    if (_servicesLoaded && state.services.isNotEmpty && !forceRefresh) {
      state = state.copyWith(
        optionsPanel: ChatbotOptionsPanel.services,
        clearErrorMessage: true,
      );
      return;
    }

    state = state.copyWith(
      isLoading: true,
      optionsPanel: ChatbotOptionsPanel.services,
      clearErrorMessage: true,
    );

    try {
      final userId = _resolveUserId();
      if (userId == null) {
        throw ApiException('Unable to identify your user account.');
      }

      final response = await _dashboardRepository.getUserRoles(userId);
      final services = _uniqueMobileServices(response.data?.roleDetails ?? []);
      _servicesLoaded = true;

      state = state.copyWith(
        services: services,
        isLoading: false,
        optionsPanel: ChatbotOptionsPanel.services,
        messages: services.isEmpty
            ? [
                ...state.messages,
                _createMessage(
                  role: ChatMessageRole.assistant,
                  text: 'Unable to process your request. Please try again.',
                ),
              ]
            : state.messages,
      );
    } catch (_) {
      _showError();
    }
  }

  /// Re-show cached services without clearing conversation history.
  void showServices() {
    if (state.isLoading) return;

    if (state.services.isEmpty) {
      Future.microtask(() => loadServices(forceRefresh: true));
      return;
    }

    state = state.copyWith(
      optionsPanel: ChatbotOptionsPanel.services,
      clearErrorMessage: true,
    );
  }

  /// Re-show sub-services for the current service (no services API call).
  void showSubServices() {
    if (state.isLoading) return;
    final service = state.selectedService;
    if (service == null) return;

    final subServices = MobileServiceScope.filterSubServices(
      service.subservices ?? const [],
    );

    state = state.copyWith(
      subServices: subServices,
      optionsPanel: ChatbotOptionsPanel.subServices,
      clearErrorMessage: true,
    );
  }

  /// Re-show predefined questions for the current sub-service (uses cache).
  Future<void> showQuestions() async {
    if (state.isLoading) return;
    final subService = state.selectedSubService;
    final code = state.selectedSubServiceCode?.trim();
    if (subService == null || code == null || code.isEmpty) return;

    final cached = _questionsCache[code];
    if (cached != null) {
      state = state.copyWith(
        questions: cached,
        optionsPanel: cached.isEmpty
            ? ChatbotOptionsPanel.none
            : ChatbotOptionsPanel.questions,
        clearErrorMessage: true,
      );
      if (cached.isEmpty) {
        _appendNoQuestionsMessage();
      }
      return;
    }

    await _loadQuestionsForSubService(code, announce: false);
  }

  Future<void> selectService(Service service) async {
    if (state.isLoading) return;

    final subServices = MobileServiceScope.filterSubServices(
      service.subservices ?? const [],
    );
    final serviceName = _serviceLabel(service);

    state = state.copyWith(
      messages: [
        ...state.messages,
        _createMessage(role: ChatMessageRole.user, text: serviceName),
        _createMessage(
          role: ChatMessageRole.assistant,
          text: 'Please select a sub-service.',
        ),
      ],
      selectedService: service,
      selectedServiceCode: (service.code ?? '').trim(),
      clearSelectedSubService: true,
      clearSelectedSubServiceCode: true,
      clearSelectedQuestion: true,
      clearCurrentAnswer: true,
      subServices: subServices,
      questions: const [],
      optionsPanel: ChatbotOptionsPanel.subServices,
      isInputEnabled: false,
      clearErrorMessage: true,
    );
  }

  Future<void> selectSubService(SubService subService) async {
    if (state.isLoading) return;

    final subServiceCode = (subService.code ?? '').trim();
    if (subServiceCode.isEmpty) {
      _showError();
      return;
    }

    state = state.copyWith(
      messages: [
        ...state.messages,
        _createMessage(
          role: ChatMessageRole.user,
          text: _subServiceLabel(subService),
        ),
      ],
      selectedSubService: subService,
      selectedSubServiceCode: subServiceCode,
      clearSelectedQuestion: true,
      clearCurrentAnswer: true,
      clearErrorMessage: true,
    );

    final cached = _questionsCache[subServiceCode];
    if (cached != null) {
      _applyQuestions(cached, announce: true);
      return;
    }

    await _loadQuestionsForSubService(subServiceCode, announce: true);
  }

  Future<void> selectQuestion(ChatbotQuestion question) async {
    if (state.isLoading) return;

    state = state.copyWith(
      messages: [
        ...state.messages,
        _createMessage(role: ChatMessageRole.user, text: question.question),
      ],
      selectedQuestion: question,
      isLoading: true,
      isInputEnabled: false,
      optionsPanel: ChatbotOptionsPanel.none,
      clearCurrentAnswer: true,
      clearErrorMessage: true,
    );

    try {
      final userId = _requireUserId();
      final role = await _resolveRoleName(userId);
      final response = await _chatbotRepository.getAnswer(
        questionId: question.questionId,
        userId: userId,
        role: role,
      );
      // Keep input hidden until the user taps Not Helpful.
      _appendAnswer(response, keepInputEnabled: false);
    } catch (_) {
      _showError(keepInputEnabled: false);
    }
  }

  Future<void> sendMessage(String rawText) async {
    final text = rawText.trim();
    if (text.isEmpty || state.isLoading || !state.isInputEnabled) return;

    final subServiceCode = state.selectedSubServiceCode?.trim();
    if (subServiceCode == null || subServiceCode.isEmpty) {
      _showError(keepInputEnabled: true);
      return;
    }

    state = state.copyWith(
      messages: [
        ...state.messages,
        _createMessage(role: ChatMessageRole.user, text: text),
      ],
      isLoading: true,
      optionsPanel: ChatbotOptionsPanel.none,
      clearErrorMessage: true,
    );

    try {
      final userId = _requireUserId();
      final role = await _resolveRoleName(userId);
      final response = await _chatbotRepository.askFaq(
        query: text,
        serviceCode: subServiceCode,
        userId: userId,
        role: role,
      );
      // After a custom question, keep the text field enabled.
      _appendAnswer(response, keepInputEnabled: true);
    } catch (_) {
      _showError(keepInputEnabled: true);
    }
  }

  /// Records helpful / not-helpful feedback for a specific answer message.
  ///
  /// Not Helpful enables the text field so the user can ask a custom question.
  void submitFeedback(String messageId, {required bool helpful}) {
    final index = state.messages.indexWhere((m) => m.id == messageId);
    if (index < 0) return;

    final message = state.messages[index];
    if (!message.isAnswer || message.hasFeedback) return;

    final updated = List<ChatMessage>.from(state.messages);
    updated[index] = message.copyWith(
      feedback: helpful
          ? ChatbotFeedbackChoice.helpful
          : ChatbotFeedbackChoice.notHelpful,
    );

    if (helpful) {
      state = state.copyWith(messages: updated);
      return;
    }

    state = state.copyWith(
      messages: [
        ...updated,
        _createMessage(
          role: ChatMessageRole.assistant,
          text: 'Please describe your question.',
        ),
      ],
      isInputEnabled: true,
      optionsPanel: ChatbotOptionsPanel.none,
    );
  }

  Future<void> _loadQuestionsForSubService(
    String subServiceCode, {
    required bool announce,
  }) async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);

    try {
      final userId = _requireUserId();
      final role = await _resolveRoleName(userId);
      final response = await _chatbotRepository.getQuestions(
        subServiceCode: subServiceCode,
        userId: userId,
        role: role,
      );

      final questions = response.questions;
      _questionsCache[subServiceCode] = questions;
      _applyQuestions(questions, announce: announce);
    } catch (_) {
      _showError(keepInputEnabled: true);
    }
  }

  void _applyQuestions(List<ChatbotQuestion> questions, {required bool announce}) {
    if (questions.isEmpty) {
      state = state.copyWith(
        questions: const [],
        optionsPanel: ChatbotOptionsPanel.none,
        isLoading: false,
        isInputEnabled: true,
      );
      if (announce) {
        _appendNoQuestionsMessage();
      }
      return;
    }

    final messages = announce
        ? [
            ...state.messages,
            _createMessage(
              role: ChatMessageRole.assistant,
              text: 'Please select a question, or type your own below.',
            ),
          ]
        : state.messages;

    state = state.copyWith(
      messages: messages,
      questions: questions,
      optionsPanel: ChatbotOptionsPanel.questions,
      isLoading: false,
      isInputEnabled: true,
    );
  }

  void _appendNoQuestionsMessage() {
    final alreadyShown = state.messages.any(
      (m) =>
          m.isAssistant &&
          m.text.contains('No predefined questions are available'),
    );
    if (alreadyShown &&
        state.messages.isNotEmpty &&
        state.messages.last.text.contains(
          'No predefined questions are available',
        )) {
      return;
    }

    state = state.copyWith(
      messages: [
        ...state.messages,
        _createMessage(
          role: ChatMessageRole.assistant,
          text:
              'No predefined questions are available for this sub-service. You can ask your question below.',
        ),
      ],
      optionsPanel: ChatbotOptionsPanel.none,
      isInputEnabled: true,
    );
  }

  void _appendAnswer(
    ChatbotAnswerResponse response, {
    required bool keepInputEnabled,
  }) {
    final answer = response.answer?.trim();
    if (answer == null || answer.isEmpty) {
      throw ApiException('Empty chatbot response');
    }

    state = state.copyWith(
      messages: [
        ...state.messages,
        _createMessage(
          role: ChatMessageRole.assistant,
          text: answer,
          isAnswer: true,
        ),
      ],
      currentAnswer: response,
      isLoading: false,
      isInputEnabled: keepInputEnabled,
      optionsPanel: ChatbotOptionsPanel.none,
    );
  }

  void _showError({bool keepInputEnabled = false}) {
    final enableInput = keepInputEnabled || state.hasSelectedSubService;

    state = state.copyWith(
      messages: [
        ...state.messages,
        _createMessage(
          role: ChatMessageRole.assistant,
          text: 'Unable to process your request. Please try again.',
          isError: true,
        ),
      ],
      isLoading: false,
      isInputEnabled: enableInput,
      // Keep the options panel closed so the error + nav actions are visible.
      optionsPanel: ChatbotOptionsPanel.none,
    );
  }

  int? _resolveUserId() {
    final userInfoId = ref.read(userInfoProvider)?.data?.id;
    if (userInfoId != null && userInfoId.isNotEmpty) {
      return int.tryParse(userInfoId);
    }
    return ref.read(userProvider)?.userId;
  }

  int _requireUserId() {
    final userId = _resolveUserId();
    if (userId == null) {
      throw ApiException('Unable to identify your user account.');
    }
    return userId;
  }

  Future<String> _resolveRoleName(int userId) async {
    if (_cachedRoleName != null && _cachedRoleName!.isNotEmpty) {
      return _cachedRoleName!;
    }

    final selectedRole = ref.read(rolesProvider)?.roleName;
    if (selectedRole != null && selectedRole.isNotEmpty) {
      _cachedRoleName = selectedRole;
      return selectedRole;
    }

    try {
      final response = await _dashboardRepository.getUserRoles(userId);
      final roleName = response.data?.rolesSummary
          ?.map((role) => role.roleName?.trim())
          .whereType<String>()
          .where((name) => name.isNotEmpty)
          .firstOrNull;

      if (roleName != null && roleName.isNotEmpty) {
        _cachedRoleName = roleName;
        return roleName;
      }
    } catch (_) {}

    return 'Employee';
  }

  List<Service> _uniqueMobileServices(List<RoleDetail> roleDetails) {
    final byKey = <String, Service>{};

    for (final roleDetail in roleDetails) {
      for (final service in roleDetail.services ?? const <Service>[]) {
        final serviceKey = _serviceKey(service);
        if (serviceKey.isEmpty) continue;

        final existing = byKey[serviceKey];
        if (existing == null) {
          byKey[serviceKey] = service;
          continue;
        }

        byKey[serviceKey] = _mergeServices(existing, service);
      }
    }

    final filtered = MobileServiceScope.filterServices(byKey.values);
    filtered.sort(
      (a, b) => _serviceLabel(
        a,
      ).toLowerCase().compareTo(_serviceLabel(b).toLowerCase()),
    );
    return filtered;
  }

  Service _mergeServices(Service existing, Service incoming) {
    final subServicesByKey = <String, SubService>{};
    for (final subService in [
      ...(existing.subservices ?? const <SubService>[]),
      ...(incoming.subservices ?? const <SubService>[]),
    ]) {
      final key = _subServiceKey(subService);
      if (key.isEmpty) continue;
      subServicesByKey[key] = subService;
    }

    final subServices = subServicesByKey.values.toList()
      ..sort(
        (a, b) => _subServiceLabel(
          a,
        ).toLowerCase().compareTo(_subServiceLabel(b).toLowerCase()),
      );

    return Service(
      id: existing.id ?? incoming.id,
      code: existing.code ?? incoming.code,
      name: existing.name ?? incoming.name,
      description: existing.description ?? incoming.description,
      logoUrl: existing.logoUrl ?? incoming.logoUrl,
      subservices: subServices,
      arabicName: existing.arabicName ?? incoming.arabicName,
      arabicDescription:
          existing.arabicDescription ?? incoming.arabicDescription,
    );
  }

  String _serviceKey(Service service) {
    final code = service.code?.trim();
    if (code != null && code.isNotEmpty) return code;
    return service.id?.toString() ?? '';
  }

  String _subServiceKey(SubService subService) {
    final code = subService.code?.trim();
    if (code != null && code.isNotEmpty) return code;
    return subService.id?.toString() ?? '';
  }

  String _serviceLabel(Service service) {
    final name = service.name?.trim();
    if (name != null && name.isNotEmpty) return name;
    return service.code?.trim().isNotEmpty == true
        ? service.code!.trim()
        : 'Service';
  }

  String _subServiceLabel(SubService subService) {
    final name = subService.subServiceName?.trim();
    if (name != null && name.isNotEmpty) return name;
    return subService.code?.trim().isNotEmpty == true
        ? subService.code!.trim()
        : 'Sub-service';
  }

  ChatMessage _createMessage({
    required ChatMessageRole role,
    required String text,
    bool isAnswer = false,
    bool isError = false,
  }) {
    _messageCounter += 1;
    return ChatMessage(
      id: 'msg_$_messageCounter',
      role: role,
      text: text,
      createdAt: DateTime.now(),
      isAnswer: isAnswer,
      isError: isError,
    );
  }
}
