import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
import 'package:code_setup/presentation/screens/security_access/widgets/cardInfo.dart';
import 'package:flutter/material.dart';

class RequestDetailsTabContent extends StatelessWidget {
  final String from;
  final LogisticsRequestDetailData? request;
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
        if (from == 'employee') ...[
          CardInfo(
            title: "Request Information",
            info: {
              "Request for": request?.request?.vehicleRequiredFor ?? 'N/A',
              "Service Type": request?.request?.service?.name ?? 'N/A',
              "Sub Service ":
                  request?.request?.subService?.subServiceName ?? 'N/A',
              "Vehicle Type": request?.request?.typeOfVehicleRequired ?? 'N/A',
              "Travel Date": request?.request?.typeOfVehicleRequired ?? 'N/A',
              "Travel Time": request?.request?.typeOfVehicleRequired ?? 'N/A',
              "Duration (Days)":
                  request?.request?.dateOfTravel.toString() ?? 'N/A',
              "Duration (Hours)": request?.request?.timeOfTravel ?? 'N/A',
              "Location": request?.request?.vehicleRequiredLocation ?? 'N/A',
            },
          ),
        ],

        // if (from == 'foreign') ...[
        //   CardInfo(
        //     title: "Request Information",
        //     info: {
        //       "Service Type": request?.request?.service?.name ?? 'N/A',
        //       "Sub Service ":
        //           request?.request?.subService?.subServiceName ?? 'N/A',
        //       "Origin City ": request?.request?.originCity ?? 'N/A',
        //       "Destination City": request?.request?.destinationCity ?? 'N/A',
        //       'Arrival/Departure Date & Time':
        //           request?.request?.arrivalDepartureDatetime.toString() ??
        //           'N/A',

        //       "No of Passengers":
        //           request?.request?.numberOfPassengers.toString() ?? '0',
        //       "Pupose of Travel": request?.request?.purposeOfTravel ?? 'N/A',
        //       "Vehicle Required Location":
        //           request?.request?.vehicleRequiredLocation ?? 'N/A',
        //     },
        //   ),
        // ],
        5.toVerticalSizedBox,

        if (from == 'employee') ...[
          CardInfo(
            title: "Technical Details",
            info: {
              "Category": request?.request?.category ?? 'N/A',
              "Type of Request": request?.request?.typeOfRequest ?? 'N/A',
            },
          ),
        ],

        // if (from == 'foreign') ...[
        //   CardInfo(
        //     title: "Technical Details",
        //     info: {
        //       "Type of Request": request?.request?.typeOfRequest ?? 'N/A',
        //       "Employee ID/Passport":
        //           request?.request?.employeeIdPassport ?? 'N/A',
        //       'Special Instructions':
        //           request?.request?.specialInstructions ?? 'N/A',
        //     },
        //   ),
        // ],
      ],
    );
  }
}
