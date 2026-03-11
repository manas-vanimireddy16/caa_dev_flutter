import 'package:code_setup/presentation/models/allowance_employee.dart';
import 'package:code_setup/presentation/screens/hr_service/request_for_duty_mission/widgets/allowance_table.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/presentation/common_widgets/cardInfo.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';

class CommonRequestDetails extends StatelessWidget {
  final List<AllowanceEmployee>? allowanceEmployees;
  final bool showAllowanceSection;

  final Map<String, String>? statusInfo;
  final Map<String, String>? requestInfo;
  final Map<String, String>? technicalInfo;
  final Map<String, String>? coverageInfo;

  const CommonRequestDetails({
    super.key,
    this.allowanceEmployees,
    this.statusInfo,
    this.requestInfo,
    this.technicalInfo,
    this.coverageInfo,
    this.showAllowanceSection = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// -------- Coverage --------
        if (coverageInfo != null) ...[
          CardInfo(title: "Coverage Information", info: coverageInfo!),
          6.toVerticalSizedBox,
        ],

        /// -------- Status --------
        if (statusInfo != null) ...[
          CardInfo(title: "Status Information", info: statusInfo!),
          6.toVerticalSizedBox,
        ],

        /// -------- Request --------
        if (requestInfo != null) ...[
          CardInfo(
            title: "Request Information",
            info: requestInfo!,
            customContent: showAllowanceSection
                ? AllowanceTable(employees: allowanceEmployees ?? [])
                : null,
          ),
          6.toVerticalSizedBox,
        ],

        /// -------- Technical --------
        if (technicalInfo != null) ...[
          CardInfo(title: "Technical Details", info: technicalInfo!),
        ],
      ],
    );
  }
}
