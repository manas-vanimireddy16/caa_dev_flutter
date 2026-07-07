part of '../view.dart';

class AssignUserDialog extends ConsumerStatefulWidget {
  final int approverId;
  final Service service;
  final SubService subService;

  const AssignUserDialog({
    super.key,
    required this.approverId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<AssignUserDialog> createState() => _AssignUserDialogState();
}

class _AssignUserDialogState extends ConsumerState<AssignUserDialog> {
  static const _borderColor = Color(0xFFD8D8D8);
  static const _assignGreen = Color(0xFF3B873E);

  late final _VSControllerParams _providerArgs;
  int? _selectedUserId;
  bool _isSubmitting = false;
  bool _isFetchingEmployees = true;

  @override
  void initState() {
    super.initState();
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    Future.microtask(() async {
      await ref
          .read(_vsProvider(_providerArgs).notifier)
          .fetchAssignEmployeesList();
      if (mounted) {
        setState(() => _isFetchingEmployees = false);
      }
    });
  }

  EmployeeSummary? _selectedEmployee(List<EmployeeSummary> employees) {
    if (_selectedUserId == null) return null;
    for (final employee in employees) {
      if (employee.userId == _selectedUserId) return employee;
    }
    return null;
  }

  Widget _employeeLabel(EmployeeSummary employee) {
    final name = employee.employeeName?.trim() ?? 'Unknown';

    return Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textHeading,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final state = ref.watch(_vsProvider(_providerArgs));
    final employees = state.employeeList;
    final selectedEmployee = _selectedEmployee(employees);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Assign',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textHeading,
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: _isSubmitting ? null : () => Navigator.of(context).pop(),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.close,
                    size: 22,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: _borderColor),
          const SizedBox(height: 20),
          const Row(
            children: [
              Text(
                'User',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textHeading,
                ),
              ),
              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (_isFetchingEmployees)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 28),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (employees.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _borderColor),
              ),
              child: const Text(
                'No users available to assign',
                style: TextStyle(fontSize: 14, color: AppColors.secondaryText),
              ),
            )
          else
            DropdownButtonFormField<int>(
              value: selectedEmployee?.userId,
              isExpanded: true,
              menuMaxHeight: 320,
              decoration: InputDecoration(
                hintText: 'Select User',
                hintStyle: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 16,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: _borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: _borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.primaryBlue75),
                ),
              ),
              selectedItemBuilder: (context) {
                return employees
                    .map(
                      (employee) => Align(
                        alignment: Alignment.centerLeft,
                        child: _employeeLabel(employee),
                      ),
                    )
                    .toList();
              },
              items: employees.map((employee) {
                return DropdownMenuItem<int>(
                  value: employee.userId,
                  child: _employeeLabel(employee),
                );
              }).toList(),
              onChanged: _isSubmitting
                  ? null
                  : (value) => setState(() => _selectedUserId = value),
            ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSubmitting
                      ? null
                      : () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.secondaryText,
                    side: const BorderSide(color: _borderColor),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      _selectedUserId == null ||
                          _isSubmitting ||
                          employees.isEmpty
                      ? null
                      : () async {
                          setState(() => _isSubmitting = true);
                          final success = await controller.assignEngineer(
                            engineerUserId: _selectedUserId!,
                            approverId: widget.approverId,
                          );
                          if (!mounted) return;
                          Navigator.of(context).pop();
                          if (success) {
                            KAppX.router.pop();
                            controller.returnToMyRequestsTab();
                            await controller.refreshAfterReturn();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _assignGreen,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFFE0E0E0),
                    disabledForegroundColor: AppColors.secondaryText,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send_rounded, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Assign',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
