import 'package:code_setup/presentation/common_widgets/statusWidget.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
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
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
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
                  Icon(Icons.person_outline, color: Colors.indigo.shade900),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.l10n.employeeInformationTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey.shade700,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            Divider(height: 1, color: Colors.grey.shade300),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final useTwoColumns = constraints.maxWidth > 520;
                  final fields = <_EmployeeField>[
                    _EmployeeField(
                      icon: Icons.badge_outlined,
                      label: _label('Request Id'),
                      value: _orNa(widget.requestId),
                    ),
                    _EmployeeField(
                      icon: Icons.perm_identity_outlined,
                      label: _label('Employee ID'),
                      value: _orNa(user?.employeeId ?? user?.civilEmployeeId),
                    ),
                    _EmployeeField(
                      icon: Icons.work_outline,
                      label: _label('Job Title / Designation'),
                      value: jobTitle,
                    ),
                    _EmployeeField(
                      icon: Icons.email_outlined,
                      label: _label('Email Address'),
                      value: _orNa(user?.email),
                    ),
                    _EmployeeField(
                      icon: Icons.apartment_outlined,
                      label: _label('Department'),
                      value: department,
                    ),
                    _EmployeeField(
                      icon: Icons.phone_outlined,
                      label: _label('Contact Number'),
                      value: _orNa(user?.mobile ?? user?.officeNumber),
                    ),
                    _EmployeeField(
                      icon: Icons.assignment_ind_outlined,
                      label: _label('Assigned To'),
                      value: _orNa(widget.assignedTo),
                    ),
                  ];

                  if (useTwoColumns) {
                    return Column(
                      children: [
                        for (int i = 0; i < fields.length; i += 2) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _EmployeeFieldTile(field: fields[i])),
                              const SizedBox(width: 16),
                              Expanded(
                                child: i + 1 < fields.length
                                    ? _EmployeeFieldTile(field: fields[i + 1])
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                        ],
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _StatusRow(
                            label: _label('Status'),
                            status: widget.status ?? 'N/A',
                          ),
                        ),
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
                      _StatusRow(
                        label: _label('Status'),
                        status: widget.status ?? 'N/A',
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmployeeField {
  final IconData icon;
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
        Icon(field.icon, size: 20, color: Colors.indigo.shade900),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field.label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                field.value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
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
        Icon(Icons.info_outline, size: 20, color: Colors.indigo.shade900),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              StatusChip(status: status),
            ],
          ),
        ),
      ],
    );
  }
}
