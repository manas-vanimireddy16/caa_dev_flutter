part of '../view.dart';

@RoutePage()
class FollowUpReportNewRequestScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;
  final bool isEditMode;
  final int? requestId;

  const FollowUpReportNewRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
    this.isEditMode = false,
    this.requestId,
  });

  @override
  ConsumerState<FollowUpReportNewRequestScreen> createState() =>
      _FollowUpReportNewRequestScreenState();
}

class _FollowUpReportNewRequestScreenState
    extends ConsumerState<FollowUpReportNewRequestScreen> {
  late _VSControllerParams _providerArgs;
  Map<String, dynamic>? _apiValues;
  bool _isLoadingDetails = false;
  String? _loadError;

  @override
  void initState() {
    super.initState();

    /// ✅ Create provider params ONCE
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    if (widget.isEditMode && widget.requestId != null) {
      _isLoadingDetails = true;
      Future.microtask(_loadEditData);
    }
  }

  Future<void> _loadEditData() async {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    try {
      final values = await controller.loadFormValuesForEdit(widget.requestId!);
      if (!mounted) return;
      setState(() {
        _apiValues = values ?? {};
        _isLoadingDetails = false;
        _loadError = values == null ? 'Failed to load request details' : null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingDetails = false;
        _loadError = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);
    final formTitle = widget.isEditMode
        ? l10n.followUpEditRequestTitle
        : (l10n.isArabic
              ? (widget.subService.arabicsubServiceName ??
                    widget.subService.subServiceName ??
                    l10n.createRequest)
              : (widget.subService.subServiceName ?? l10n.createRequest));

    if (widget.isEditMode && _isLoadingDetails) {
      return KScaffold(
        backgroundColor: Colors.white,
        appBar: KAppBar(useCloseButton: true, title: Text(formTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (widget.isEditMode && _loadError != null) {
      return KScaffold(
        backgroundColor: Colors.white,
        appBar: KAppBar(useCloseButton: true, title: Text(formTitle)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(_loadError!, textAlign: TextAlign.center),
          ),
        ),
      );
    }

    return KScaffold(
      backgroundColor: Colors.white,

      /// ✅ DynamicForm MUST be root-level in a screen
      body: ProviderScope(
        overrides: [
          dynamicFormProvider.overrideWith((ref) => DynamicFormNotifier(ref)),
        ],
        child: DynamicForm(
          title: formTitle,
          stepTitles: [
            l10n.followUpDetailsStepTitle,
            l10n.followUpActionsStepTitle,
          ],
          steps: [
            controller.buildFollowUpReportFields(
              l10n,
              isEditMode: widget.isEditMode,
            ),
            controller.buildFollowUpActionFields(
              l10n,
              isEditMode: widget.isEditMode,
            ),
          ],
          apiValues: widget.isEditMode ? _apiValues : null,
          submitButtonLabel:
              widget.isEditMode ? l10n.commentButtonUpdate : null,
          onSubmit: (values) async {
            final success = await controller.submitProjectApprovalRequest(
              widget.serviceId,
              widget.subServiceId,
              values,
              isEditMode: widget.isEditMode,
              requestId: widget.requestId,
            );

            if (!context.mounted) return;

            if (widget.isEditMode) {
              if (success) {
                context.router.pop(true);
              }
            } else {
              context.router.pop();
            }
          },
        ),
      ),
    );
  }
}
