import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/presentation/chatbot/models/chat_message.dart';
import 'package:code_setup/presentation/chatbot/models/chatbot_answer_response.dart';
import 'package:code_setup/presentation/chatbot/models/chatbot_question_response.dart';
import 'package:code_setup/presentation/chatbot/state/chatbot_conversation_state.dart';
import 'package:code_setup/repository/chatbot/domain/domain.dart';
import 'package:code_setup/repository/common_dashboard_all_services/domain/domain.dart';
import 'package:code_setup/utils/helper/mobile_service_scope.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatbotConversationProvider =
    NotifierProvider.autoDispose<
      ChatbotConversationNotifier,
      ChatbotConversationState
    >(ChatbotConversationNotifier.new);

/// Handles chat messages and outbound requests to the chatbot service.
class ChatbotConversationNotifier
    extends AutoDisposeNotifier<ChatbotConversationState> {
  final ChatbotRepository _chatbotRepository = ChatbotRepository();
  final CommonDashboardRepository _dashboardRepository =
      CommonDashboardRepository();

  int _messageCounter = 0;
  String? _cachedRoleName;
  bool _didStart = false;

  @override
  ChatbotConversationState build() {
    final initialState = ChatbotConversationState(
      messages: [
        _createMessage(
          role: ChatMessageRole.assistant,
          text: "Hello! I'm your AI assistant. How can I help you today?",
        ),
        _createMessage(
          role: ChatMessageRole.assistant,
          text: 'Please select a service to continue.',
        ),
      ],
    );

    if (!_didStart) {
      _didStart = true;
      Future.microtask(loadServices);
    }

    return initialState;
  }

  Future<void> loadServices() async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      isInputEnabled: false,
      showFeedbackButtons: false,
      step: ChatbotConversationStep.services,
      subServices: const [],
      questions: const [],
      clearSelectedService: true,
      clearSelectedServiceCode: true,
      clearSelectedSubService: true,
      clearSelectedSubServiceCode: true,
      clearSelectedQuestion: true,
      clearCurrentAnswer: true,
      clearErrorMessage: true,
    );

    try {
      final userId = _resolveUserId();
      if (userId == null) {
        throw ApiException('Unable to identify your user account.');
      }

      final response = await _dashboardRepository.getUserRoles(userId);
      final services = _uniqueMobileServices(response.data?.roleDetails ?? []);

      state = state.copyWith(
        services: services,
        isLoading: false,
        step: ChatbotConversationStep.services,
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
      _showError(keepInputEnabled: false);
    }
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
      selectedSubService: null,
      clearSelectedSubService: true,
      selectedSubServiceCode: null,
      clearSelectedSubServiceCode: true,
      selectedQuestion: null,
      clearSelectedQuestion: true,
      currentAnswer: null,
      clearCurrentAnswer: true,
      subServices: subServices,
      questions: const [],
      step: ChatbotConversationStep.subServices,
      isInputEnabled: false,
      showFeedbackButtons: false,
      clearErrorMessage: true,
    );
  }

  Future<void> selectSubService(SubService subService) async {
    if (state.isLoading) return;

    final subServiceCode = (subService.code ?? '').trim();
    if (subServiceCode.isEmpty) {
      _showError(keepInputEnabled: false);
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
      selectedQuestion: null,
      clearSelectedQuestion: true,
      currentAnswer: null,
      clearCurrentAnswer: true,
      isLoading: true,
      isInputEnabled: false,
      showFeedbackButtons: false,
      clearErrorMessage: true,
    );

    try {
      final userId = _requireUserId();
      final role = await _resolveRoleName(userId);
      final response = await _chatbotRepository.getQuestions(
        subServiceCode: subServiceCode,
        userId: userId,
        role: role,
      );

      if (response.questionCount == 0 || response.questions.isEmpty) {
        state = state.copyWith(
          messages: [
            ...state.messages,
            _createMessage(
              role: ChatMessageRole.assistant,
              text: 'Unable to load questions. Please try again.',
            ),
          ],
          questions: const [],
          step: ChatbotConversationStep.subServices,
          isLoading: false,
          isInputEnabled: false,
          showFeedbackButtons: false,
        );
        return;
      }

      state = state.copyWith(
        messages: [
          ...state.messages,
          _createMessage(
            role: ChatMessageRole.assistant,
            text: 'Please answer the following questions.',
          ),
        ],
        questions: response.questions,
        step: ChatbotConversationStep.questions,
        isLoading: false,
      );
    } catch (_) {
      _showError(keepInputEnabled: false);
    }
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
      showFeedbackButtons: false,
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
      _appendAnswer(response, keepInputEnabled: false);
    } catch (_) {
      _showError(keepInputEnabled: false);
    }
  }

  void markHelpful() {
    if (state.isLoading) return;

    final selectedService = state.selectedService;
    final subServices = selectedService == null
        ? const <SubService>[]
        : MobileServiceScope.filterSubServices(
            selectedService.subservices ?? const [],
          );

    state = state.copyWith(
      messages: [
        ...state.messages,
        _createMessage(
          role: ChatMessageRole.assistant,
          text: 'Please select another service or sub-service.',
        ),
      ],
      step: ChatbotConversationStep.services,
      subServices: subServices,
      questions: const [],
      isInputEnabled: false,
      showFeedbackButtons: false,
      clearSelectedSubService: true,
      clearSelectedSubServiceCode: true,
      clearSelectedQuestion: true,
      clearCurrentAnswer: true,
    );

    if (state.services.isEmpty) {
      Future.microtask(loadServices);
    }
  }

  void markNotHelpful() {
    if (state.isLoading) return;

    state = state.copyWith(
      messages: [
        ...state.messages,
        _createMessage(
          role: ChatMessageRole.assistant,
          text: 'Please describe your question.',
        ),
      ],
      step: ChatbotConversationStep.manualInput,
      isInputEnabled: true,
      showFeedbackButtons: false,
    );
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
      showFeedbackButtons: false,
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
      _appendAnswer(response, keepInputEnabled: true);
    } catch (_) {
      _showError(keepInputEnabled: true);
    }
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
        _createMessage(role: ChatMessageRole.assistant, text: answer),
      ],
      currentAnswer: response,
      isLoading: false,
      isInputEnabled: keepInputEnabled,
      showFeedbackButtons: true,
      questions: const [],
    );
  }

  void _showError({required bool keepInputEnabled}) {
    state = state.copyWith(
      messages: [
        ...state.messages,
        _createMessage(
          role: ChatMessageRole.assistant,
          text: 'Unable to process your request. Please try again.',
        ),
      ],
      isLoading: false,
      isInputEnabled: keepInputEnabled,
      showFeedbackButtons: false,
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
  }) {
    _messageCounter += 1;
    return ChatMessage(
      id: 'msg_$_messageCounter',
      role: role,
      text: text,
      createdAt: DateTime.now(),
    );
  }
}
