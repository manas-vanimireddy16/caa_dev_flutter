import 'package:code_setup/presentation/common_widgets/status_widget.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/utils/helper/colors.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:code_setup/utils/helper/icons.dart';
import 'package:flutter/material.dart';

class EmployeeInformationCard extends StatefulWidget {
  final DashboardL10n l10n;
  final String? requestId;
  final String? status;
  final String? assignedTo;
  final UserModel? user;
  final String Function(String key)? labelBuilder;

  const EmployeeInformationCard({
    super.key,
    required this.l10n,
    this.requestId,
    this.status,
    this.assignedTo,
    this.user,
    this.labelBuilder,
  });

  @override
  State<EmployeeInformationCard> createState() =>
      _EmployeeInformationCardState();
}

class _EmployeeInformationCardState extends State<EmployeeInformationCard> {
  bool _expanded = true;

  String _label(String key) =>
      widget.labelBuilder?.call(key) ?? widget.l10n.requestDetailsLabel(key);

  String _orNa(String? value) {
    if (value == null || value.trim().isEmpty) return 'N/A';
    return value.trim();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final jobTitle = _orNa(
      user?.position?.name ?? user?.directorate ?? user?.arabicPosition,
    );
    final department = _orNa(
      user?.department?.departmentName ?? user?.category,
    );

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(16), //.fromLTRB(16, 16, 16, 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: const Color(0xFFD8D8D8)),
      ),
      elevation: 0,
      child: Column(
        children: [
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  KImageProvider(
                    image: AppIcons.employeeInfoRequestDetails,
                    width: 22,
                    height: 22,
                    tintColor: Color(0xFF000000),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.l10n.employeeInformationTitle,
                      style: TextStyle(color: AppColors.mainTitleColor),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4), // radius
                      border: Border.all(
                        color: Color(0xFFD8D8D8),
                        width: 1, // border width
                      ),
                    ),
                    child: Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            Divider(color: Colors.grey.shade300, thickness: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final useTwoColumns = constraints.maxWidth > 520;

                      final fields = <_EmployeeField>[
                        _EmployeeField(
                          icon: AppIcons.requestIdEmployeeCard,
                          label: _label('Request Id'),
                          value: _orNa(widget.requestId),
                        ),

                        _EmployeeField(
                          icon: AppIcons.empIdEmployeeCard,
                          label: _label('Employee ID'),
                          value: _orNa(
                            user?.employeeId ?? user?.civilEmployeeId,
                          ),
                        ),

                        /// NEW FIELD
                        _EmployeeField(
                          icon: AppIcons.employeeInfoRequestDetails,
                          label: _label('Name'),
                          value: _orNa(user?.employeeName),
                        ),

                        _EmployeeField(
                          icon: AppIcons.jobTitleEmployeeCard,
                          label: _label('Job Title / Designation'),
                          value: jobTitle,
                        ),

                        _EmployeeField(
                          icon: AppIcons.mailEmployeeCard,
                          label: _label('Email Address'),
                          value: _orNa(user?.email),
                        ),

                        _EmployeeField(
                          icon: AppIcons.departmentEmployeeCard,
                          label: _label('Department'),
                          value: department,
                        ),

                        _EmployeeField(
                          icon: AppIcons.phoneEmployeeCard,
                          label: _label('Contact Number'),
                          value: _orNa(user?.mobile ?? user?.officeNumber),
                        ),
                      ];

                      if (useTwoColumns) {
                        return Column(
                          children: [
                            for (int i = 0; i < fields.length; i += 2) ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _EmployeeFieldTile(field: fields[i]),
                                  ),

                                  const SizedBox(width: 16),

                                  Expanded(
                                    child: i + 1 < fields.length
                                        ? _EmployeeFieldTile(
                                            field: fields[i + 1],
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 14),
                            ],
                          ],
                        );
                      }

                      return Column(
                        children: [
                          ...fields.map(
                            (f) => Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: _EmployeeFieldTile(field: f),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  if (widget.status != null &&
                      widget.status!.trim().isNotEmpty) ...[
                    _StatusRow(label: _label('Status'), status: widget.status!),
                    const SizedBox(height: 14),
                  ],
                  if (widget.assignedTo != null &&
                      widget.assignedTo!.trim().isNotEmpty)
                    _EmployeeFieldTile(
                      field: _EmployeeField(
                        icon: AppIcons.assignedToEmployeeCard,
                        label: _label('Assigned To'),
                        value: widget.assignedTo!,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmployeeField {
  final String icon;
  final String label;
  final String value;

  const _EmployeeField({
    required this.icon,
    required this.label,
    required this.value,
  });
}

class _EmployeeFieldTile extends StatelessWidget {
  final _EmployeeField field;

  const _EmployeeFieldTile({required this.field});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KImageProvider(
          image: field.icon,
          width: 20,
          height: 20,
          tintColor: Color(0xFF000000),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field.label,
                style: TextStyle(color: AppColors.headingColor),
              ),
              const SizedBox(height: 2),
              Text(
                field.value,
                style: TextStyle(color: AppColors.contentColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String label;
  final String status;

  const _StatusRow({required this.label, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KImageProvider(
          image: AppIcons.statusInfoRequestDetails,
          width: 20,
          height: 20,
          tintColor: Color(0xFF000000),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: AppColors.headingColor)),
              const SizedBox(height: 6),
              StatusChip(status: status),
            ],
          ),
        ),
      ],
    );
  }
}
