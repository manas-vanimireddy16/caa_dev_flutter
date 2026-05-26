part of '../view.dart';

class AirportPermissionWidget extends ConsumerStatefulWidget {
  final Function(List<Map<String, dynamic>>) onChanged;
  final Service service;
  final SubService subService;

  const AirportPermissionWidget({
    super.key,
    required this.onChanged,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<AirportPermissionWidget> createState() =>
      _AirportPermissionWidgetState();
}

class _AirportPermissionWidgetState
    extends ConsumerState<AirportPermissionWidget> {
  late List<AirportPermitAreaModel> areas;
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
    final airportAreas = ref.read(_vsProvider(_providerArgs)).airportAreas;

    areas = airportAreas;
  }

  void _updateData() {
    final data = areas
        .where((e) => e.isSelected)
        .map((e) => e.toJson())
        .toList();

    widget.onChanged(data);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = DashboardL10n.of(context);
    final formState = ref.watch(dynamicFormProvider);
    final errorText = formState.errors['required_areas'];
    final textDirection = Directionality.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: l10n.permissionToRequiredAreas,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        Wrap(
          spacing: 10,
          runSpacing: 10,

          children: areas.map((item) {
            return Container(
              width: 500,
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade300),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    textDirection: textDirection,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: item.isSelected,
                        onChanged: (value) {
                          setState(() {
                            item.isSelected = value ?? false;

                            if (!item.isSelected) {
                              item.text = '';
                            }
                          });

                          _updateData();
                        },
                      ),

                      const SizedBox(width: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),

                        decoration: BoxDecoration(
                          color: item.color,
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Text(
                          item.code,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            l10n.airportPermitAreaLabel(item.permit),
                            textAlign: l10n.isArabic
                                ? TextAlign.right
                                : TextAlign.left,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (item.isSelected) ...[
                    const SizedBox(height: 14),

                    TextFormField(
                      initialValue: item.text,
                      maxLines: 3,
                      textDirection: textDirection,
                      textAlign: l10n.isArabic
                          ? TextAlign.right
                          : TextAlign.left,

                      decoration: InputDecoration(
                        hintText: l10n.permissionAreaTaskHint,
                        errorText: item.text.trim().isEmpty
                            ? l10n.permissionAreaTaskRequired
                            : null,

                        filled: true,
                        fillColor: Colors.grey.shade100,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),

                        contentPadding: const EdgeInsets.all(16),
                      ),

                      onChanged: (value) {
                        item.text = value;
                        _updateData();
                      },
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText,
            textAlign: l10n.isArabic ? TextAlign.right : TextAlign.left,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ],
    );
  }
}
