part of '../view.dart';

@RoutePage()
class MaintenanceExternalServiceNewRequestScreen
    extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Service service;
  final SubService subService;
  final bool isEditMode;
  final int? requestId;

  const MaintenanceExternalServiceNewRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
    required this.service,
    required this.subService,
    this.isEditMode = false,
    this.requestId,
  });

  @override
  ConsumerState<MaintenanceExternalServiceNewRequestScreen> createState() =>
      _MaintenanceExternalServiceNewRequestScreenState();
}

class _MaintenanceExternalServiceNewRequestScreenState
    extends ConsumerState<MaintenanceExternalServiceNewRequestScreen> {
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
        ? l10n.updateExternalServiceRequestTitle
        : (l10n.isArabic
              ? (widget.subService.arabicsubServiceName ??
                    widget.subService.subServiceName ??
                    l10n.createRequest)
              : (widget.subService.subServiceName ?? l10n.createRequest));

    if (widget.isEditMode && _isLoadingDetails) {
      return KScaffold(
        backgroundColor: Colors.white,
        appBar: KAppBar(
          useCloseButton: true,
          title: Text(formTitle),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (widget.isEditMode && _loadError != null) {
      return KScaffold(
        backgroundColor: Colors.white,
        appBar: KAppBar(
          useCloseButton: true,
          title: Text(formTitle),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _loadError!,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLoadingDetails = true;
                      _loadError = null;
                    });
                    _loadEditData();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
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
          stepTitles: const [''],
          steps: [controller.buildExternalMaintenanceFields(l10n)],
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
