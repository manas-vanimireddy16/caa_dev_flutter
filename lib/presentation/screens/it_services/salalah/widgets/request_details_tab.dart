import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/cardInfo.dart';
import 'package:flutter/material.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';

class SalalahRequestDetailScreen extends StatelessWidget {
  final RequestDetailData data;

  const SalalahRequestDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ----------- STATUS INFORMATION -----------
        CardInfo(
          title: "Status Information",
          info: {
            "Approver": data.approvalDetails?.isNotEmpty == true
                ? data.approvalDetails![0].approverUser?.email ?? 'N/A'
                : 'N/A',
            "Assigned To": data.approvalDetails?.isNotEmpty == true
                ? data.approvalDetails![0].approverUser?.employeeName ?? "N/A"
                : "N/A",
            "Request Date": data.request?.createdAt?.toString() ?? 'N/A',
            "Status": data.request?.status ?? "N/A",
          },
        ),

        5.toVerticalSizedBox,

        /// ----------- REQUEST INFORMATION -----------
        CardInfo(
          title: "Request Information",
          info: {
            "Request For": data.request?.requestFor ?? 'N/A',
            "Service Type": data.request?.service?.name ?? 'N/A',
            "Sub Service": data.request?.subService?.subServiceName ?? 'N/A',
            "Problem Statement": data.request?.problem ?? 'N/A',
            "Description": data.request?.description ?? 'N/A',
          },
        ),

        5.toVerticalSizedBox,

        /// ----------- TECHNICAL DETAILS -----------
        CardInfo(
          title: "Technical Details",
          info: {"Extension Number": data.request?.extnNum ?? 'N/A'},
        ),
      ],
    );
  }
}
