import 'package:code_setup/presentation/common_widgets/reusable_expandable_table.dart';
import 'package:flutter/material.dart';
import '../models/request_detail_table.dart';

class RequestDetailTableRenderer extends StatelessWidget {
  final RequestDetailTable table;

  const RequestDetailTableRenderer({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    switch (table) {
      case GoalsRequestTable():
        final t = table as GoalsRequestTable;
        return ReusableExpandableTable(
          headings: const ["Goal Title", "Description", "Weight %"],
          rows: t.rows,
          isExpandable: true,
          totalText: "Total",
          totalValue: "${t.totalWeight}%",
        );

      case AllowanceRequestTable():
        final t = table as AllowanceRequestTable;
        return ReusableExpandableTable(
          headings: const ["Employee", "Allowance", "Amount"],
          rows: t.rows,
        );

      case HrPlanningRequestTable():
        final t = table as HrPlanningRequestTable;
        return ReusableExpandableTable(
          headings: const ["Task", "Frequency", "Duration"],
          rows: t.rows,
        );
      case RequestForAccommodationInMuscatGovernorateTable():
        final t = table as RequestForAccommodationInMuscatGovernorateTable;
        return ReusableExpandableTable(
          headings: const ["Emp Id", "Name", "Designation", "Grade", "Contact"],
          rows: t.rows,
        );
    }
  }
}
