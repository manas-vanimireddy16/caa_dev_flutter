import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/cardInfo.dart';
import 'package:code_setup/presentation/screens/logistics/models/foreign_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_foreign_model.dart';
import 'package:flutter/material.dart';

class RequestDetailsTabContent extends StatelessWidget {
  final String from;
  final ForeignRequestData? request;
  const RequestDetailsTabContent({
    super.key,
    required this.request,
    this.from = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardInfo(
          title: "Status Information",
          info: {
            "Request Date": request?.request?.createdAt.toString() ?? 'N/A',
            "Status": request?.request?.status ?? "N/A",
            "Approver":
                request?.approvalDetails?[0].approverRole?.name ?? 'N/A',
            "Assigned To":
                request?.approvalDetails?[0].approverRole?.name ?? "N/A",
          },
        ),
        5.toVerticalSizedBox,

        if (from == 'foreign') ...[
          CardInfo(
            title: "Request Information",
            info: {
              "Service Type": request?.request?.service?.name ?? 'N/A',
              "Sub Service ":
                  request?.request?.subService?.subServiceName ?? 'N/A',
              "Origin City ": request?.request?.originCity ?? 'N/A',
              "Destination City": request?.request?.destinationCity ?? 'N/A',
              'Arrival/Departure Date & Time':
                  request?.request?.arrivalDepartureDatetime.toString() ??
                  'N/A',

              "No of Passengers":
                  request?.request?.numberOfPassengers.toString() ?? '0',
              "Pupose of Travel": request?.request?.purposeOfTravel ?? 'N/A',
              "Vehicle Required Location":
                  request?.request?.vehicleRequiredLocation ?? 'N/A',
            },
          ),
        ],
        5.toVerticalSizedBox,

        if (from == 'foreign') ...[
          CardInfo(
            title: "Technical Details",
            info: {
              "Type of Request": request?.request?.requestType ?? 'N/A',
              "Employee ID/Passport":
                  request?.request?.employeeIdPassport ?? 'N/A',
              'Special Instructions':
                  request?.request?.specialInstructions ?? 'N/A',
            },
          ),
        ],
      ],
    );
  }
}
