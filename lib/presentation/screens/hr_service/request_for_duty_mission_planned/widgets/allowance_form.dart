part of '../view.dart';

class AllowanceForm extends StatefulWidget {
  final Service service;
  final SubService subService;
  final List<EmployeeList> users;
  final Map<String, dynamic>? initialValues;
  final void Function(Map<String, dynamic>) onSubmit;
  final VoidCallback onCancel;
  final int maxEmployees;

  const AllowanceForm({
    super.key,
    required this.users,
    required this.service,
    required this.subService,
    this.initialValues,
    required this.onSubmit,
    required this.onCancel,
    required this.maxEmployees,
  });

  @override
  State<AllowanceForm> createState() => _AllowanceFormState();
}

class _AllowanceFormState extends State<AllowanceForm> {
  final _formKey = GlobalKey<FormState>();

  int? selectedUserId;
  int? allowancePercentage;
  late int missionDays;
  late TextEditingController perDayCtrl;

  @override
  void initState() {
    super.initState();

    /// ---- INITIAL VALUES (RUNS ONLY ONCE) ----
    selectedUserId = widget.initialValues?['employeeId'];
    allowancePercentage = widget.initialValues?['allowancePercentage'];

    missionDays = int.tryParse('${widget.initialValues?['missionDays']}') ?? 0;

    perDayCtrl = TextEditingController(
      text:
          widget.initialValues?['allowancePerDay']?.toString() ??
          missionDays.toString(),
    );
  }

  @override
  void dispose() {
    perDayCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Allowance Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              /// -------- EMPLOYEE --------
              KDropdownField<int>(
                fieldHeadingText: 'Employee Name *',
                value: selectedUserId,
                items: widget.users
                    .map(
                      (e) => KDropdownItem<int>(
                        value: e.id,
                        child: Text(e.employeeName),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  setState(() => selectedUserId = v);
                },
              ),

              const SizedBox(height: 16),

              /// -------- ALLOWANCE % --------
              KDropdownField<int>(
                fieldHeadingText: 'Allowance Percentage *',
                value: allowancePercentage,
                items: [
                  KDropdownItem(value: 0, child: Text('0%')),
                  KDropdownItem(value: 50, child: Text('50%')),
                  KDropdownItem(value: 100, child: Text('100%')),
                ],
                onChanged: (v) {
                  setState(() => allowancePercentage = v);
                },
              ),

              const SizedBox(height: 16),

              /// -------- ALLOWANCE PER DAY --------
              KTextField(
                fieldHeadingText: 'Allowance Per Day *',
                controller: perDayCtrl,
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),

              const SizedBox(height: 20),

              /// -------- ACTIONS --------
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: widget.onCancel,
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(onPressed: _onSave, child: const Text('Save')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;
    if (selectedUserId == null || allowancePercentage == null) return;

    final employee = widget.users.firstWhere((e) => e.id == selectedUserId);

    widget.onSubmit({
      'employeeId': employee.id,
      'employeeName': employee.employeeName,
      'department': employee.department?.departmentName,
      'position': employee.position?.name,
      'grade': employee.grade,
      'allowancePercentage': allowancePercentage,
      'allowancePerDay': double.parse(perDayCtrl.text),
      'missionDays': missionDays,
    });
  }
}
