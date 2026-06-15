import 'package:code_setup/presentation/common_widgets/request_details/request_detail_table_renderer.dart';
import 'package:code_setup/presentation/models/allowance_employee.dart';
import 'package:code_setup/presentation/models/request_detail_table.dart';
import 'package:code_setup/presentation/screens/hc_service/models/goal_weight_model.dart';
import 'package:code_setup/presentation/screens/hc_service/performance_management/widgets/goals_table.dart';
import 'package:code_setup/presentation/screens/hc_service/request_for_duty_mission/widgets/allowance_table.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/presentation/common_widgets/request_details/card_info.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';

class CommonRequestDetails extends StatelessWidget {
  final List<AllowanceEmployee>? allowanceEmployees;
  final List<GoalModel>? goals;
  final bool showAllowanceSection;
  final bool showGoalsSection;
  final RequestDetailTable? table;

  final Map<String, String>? statusInfo;
  final Map<String, String>? requestInfo;
  final Map<String, String>? technicalInfo;
  final Map<String, String>? coverageInfo;

  final String? coverageInformationTitle;
  final String? statusInformationTitle;
  final String? requestInformationTitle;
  final String? technicalInformationTitle;
  final String Function(String key)? requestDetailsLabelBuilder;

  const CommonRequestDetails({
    super.key,
    this.allowanceEmployees,
    this.statusInfo,
    this.requestInfo,
    this.technicalInfo,
    this.coverageInfo,
    this.showAllowanceSection = false,
    this.goals,
    this.showGoalsSection = false,
    this.table,
    this.coverageInformationTitle,
    this.statusInformationTitle,
    this.requestInformationTitle,
    this.technicalInformationTitle,
    this.requestDetailsLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// -------- Coverage --------
        if (coverageInfo != null) ...[
          CardInfo(
            title: coverageInformationTitle ?? "Coverage Information",
            info: coverageInfo!,
            requestDetailsBuilder: requestDetailsLabelBuilder,
          ),
          6.toVerticalSizedBox,
        ],

        /// -------- Status --------
        if (statusInfo != null) ...[
          CardInfo(
            title: statusInformationTitle ?? "Status Information",
            info: statusInfo!,
            requestDetailsBuilder: requestDetailsLabelBuilder,
          ),
          6.toVerticalSizedBox,
        ],

        /// -------- Request --------
        if (requestInfo != null) ...[
          CardInfo(
            title: requestInformationTitle ?? "Request Information",
            info: requestInfo!,
            requestDetailsBuilder: requestDetailsLabelBuilder,
            customContent: table != null
                ? RequestDetailTableRenderer(
                    table:
                        table ??
                        RequestForAccommodationInMuscatGovernorateTable(
                          rows: [],
                        ),
                  )
                : showAllowanceSection
                ? AllowanceTable(employees: allowanceEmployees ?? [])
                : showGoalsSection
                ? GoalsTable(goals: goals ?? [], isOnHold: true)
                : null,
          ),
          6.toVerticalSizedBox,
        ],

        /// -------- Technical --------
        if (technicalInfo != null) ...[
          CardInfo(
            title: technicalInformationTitle ?? "Technical Details",
            info: technicalInfo!,
            requestDetailsBuilder: requestDetailsLabelBuilder,
          ),
        ],
      ],
    );
  }
}
