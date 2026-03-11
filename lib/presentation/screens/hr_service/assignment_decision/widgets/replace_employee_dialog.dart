part of '../view.dart';

class ReplaceEmployeeDialog extends ConsumerStatefulWidget {
  final int requestId;
  final int approverId;
  final Service service;
  final SubService subService;

  const ReplaceEmployeeDialog({
    super.key,
    required this.requestId,
    required this.approverId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<ReplaceEmployeeDialog> createState() =>
      _ReplaceEmployeeDialogState();
}

class _ReplaceEmployeeDialogState extends ConsumerState<ReplaceEmployeeDialog> {
  late final ({Service service, SubService subService}) _providerArgs;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _providerArgs = (service: widget.service, subService: widget.subService);
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final state = ref.watch(_vsProvider(_providerArgs));

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ───────── HEADER ─────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Replace Employee",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => KAppX.router.pop,
                ),
              ],
            ),

            const Divider(height: 24),

            // ───────── EMPLOYEE DROPDOWN ─────────
            KDropdownField<int>(
              fieldHeadingText: 'Selected Role *',
              value: state.selectedUserId,
              decoration: const InputDecoration(
                labelText: "Select *",
                border: OutlineInputBorder(),
              ),
              // validator: (v) =>
              //     v == null ? "Please select employee" : null,
              items: state.usersList
                  .map(
                    (e) => KDropdownItem<int>(
                      value: e.id!,
                      child: Text(e.employeeName ?? ''),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.onUserChange(value);
                }
              },
            ),

            16.toVerticalSizedBox,

            // ───────── START & END DATE ─────────
            Row(
              children: [
                Expanded(
                  child: KTextField(
                    fieldHeadingText: "Start Date *",
                    readOnly: true,
                    controller: controller.startTimeController,
                    validator: (_) =>
                        controller.startTimeController.text.isEmpty
                        ? "Required"
                        : null,
                    onTap: () async {
                      final date = await KAppX.extendedRouter.showKDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );

                      if (date != null) {
                        controller.startTimeController.text = DateFormat(
                          'yyyy-MM-dd',
                        ).format(date);

                        /// 🔴 Clear End Date when Start Date changes
                        controller.endTimeController.clear();
                      }
                    },
                  ),
                ),

                16.toHorizontalSizedBox,
                Expanded(
                  child: KTextField(
                    fieldHeadingText: "End Date *",
                    readOnly: true,
                    enabled: controller.startTimeController.text.isNotEmpty,
                    controller: controller.endTimeController,
                    validator: (_) => controller.endTimeController.text.isEmpty
                        ? "Required"
                        : null,
                    onTap: controller.startTimeController.text.isEmpty
                        ? null
                        : () async {
                            /// 🟢 Start date
                            final startDate = DateTime.parse(
                              controller.startTimeController.text,
                            );

                            /// 🟢 Minimum end date = start + 6 days
                            final minEndDate = startDate.add(
                              const Duration(days: 6),
                            );

                            final date = await KAppX.extendedRouter
                                .showKDatePicker(
                                  initialDate:
                                      minEndDate, // ✅ must be >= firstDate
                                  firstDate: minEndDate,
                                  lastDate: DateTime(2100),
                                );

                            if (date != null) {
                              controller.endTimeController.text = DateFormat(
                                'yyyy-MM-dd',
                              ).format(date);
                            }
                          },
                  ),
                ),
              ],
            ),

            16.toVerticalSizedBox,

            // ───────── REASON ─────────
            KTextField(
              fieldHeadingText: "Reason for Replacement *",
              controller: controller.reasonForRequestController,
              maxLines: 4,
              validator: (v) => v == null || v.length < 10
                  ? "Minimum 10 characters required"
                  : null,
            ),

            const Spacer(),

            // ───────── ACTION BUTTONS ─────────
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
                12.toHorizontalSizedBox,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9FC59F),
                  ),
                  onPressed: () async {
                    final isValid = _formKey.currentState?.validate() ?? false;
                    if (!isValid) return;

                    await controller.replaceEmployee(
                      approverId: widget.approverId,

                      comment: controller.reasonForRequestController.text,
                    );

                    if (mounted) {
                      KAppX.router.pop(true);
                    }
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
