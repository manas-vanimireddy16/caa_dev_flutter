import 'package:code_setup/presentation/models/details_models.dart';

class AllowanceEmployee {
  final String employeeName;
  final double allowancePerDay;
  final double totalAmount;

  AllowanceEmployee({
    required this.employeeName,
    required this.allowancePerDay,
    required this.totalAmount,
  });

  factory AllowanceEmployee.fromEmployee(EmployeeDutyMission e) {
    return AllowanceEmployee(
      employeeName: e.employeeName ?? '',
      allowancePerDay: double.tryParse(e.allowancePerDay ?? '0') ?? 0,
      totalAmount: double.tryParse(e.totalAllowance ?? '0') ?? 0,
    );
  }
}
