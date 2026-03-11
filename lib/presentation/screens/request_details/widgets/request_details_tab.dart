import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/cardInfo.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestDetail.dart';
import 'package:flutter/material.dart';

class RequestDetailsTabContent extends StatelessWidget {
  final SalalahRequestData? request;
  const RequestDetailsTabContent({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardInfo(
          title: "Status Information",
          info: {
            "Request Date": request?.requestDate ?? 'N/A',
            "Status": request?.status ?? "N/A",
            "Approver": request?.reportingManager ?? 'N/A',
            "Assigned To": request?.assignedTo ?? "N/A",
          },
        ),
        5.toVerticalSizedBox,
        CardInfo(
          title: "Request Information",
          info: {
            "Request for": request?.requestFor ?? 'N/A',
            "Service Type": request?.serviceType?.name ?? 'N/A',
            "Problem Statement": request?.problem ?? 'N/A',
            "Description": request?.description ?? 'N/A',
          },
        ),
        5.toVerticalSizedBox,
        CardInfo(
          title: "Technical Details",
          info: {"extension number": request?.extnNum ?? 'N/A'},
        ),
      ],
    );
  }
}
