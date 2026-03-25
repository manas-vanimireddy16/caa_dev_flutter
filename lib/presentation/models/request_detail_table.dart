import 'package:code_setup/presentation/common_widgets/reusable_table_row_model.dart';

sealed class RequestDetailTable {
  const RequestDetailTable();
}

class GoalsRequestTable extends RequestDetailTable {
  final List<ReusableTableRow> rows;
  final int totalWeight;

  const GoalsRequestTable({required this.rows, required this.totalWeight});
}

class AllowanceRequestTable extends RequestDetailTable {
  final List<ReusableTableRow> rows;

  const AllowanceRequestTable({required this.rows});
}

class HrPlanningRequestTable extends RequestDetailTable {
  final List<ReusableTableRow> rows;

  const HrPlanningRequestTable({required this.rows});
}

class RequestForAccommodationInMuscatGovernorateTable
    extends RequestDetailTable {
  final List<ReusableTableRow> rows;

  const RequestForAccommodationInMuscatGovernorateTable({required this.rows});
}
