import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/cardInfo.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestDetail.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
import 'package:flutter/material.dart';

class RequestDetailsTabContent<T> extends StatelessWidget {
  final String from;
  final T? request;

  const RequestDetailsTabContent({
    super.key,
    required this.request,
    this.from = '',
  });

  @override
  Widget build(BuildContext context) {
    if (request == null) {
      return const Center(child: Text("No request data available"));
    }

    // 👇 Render UI based on the model type
    if (request is LogisticsRequestDetailData) {
      return _buildLogisticsUI(request as LogisticsRequestDetailData);
    } else if (request is SalalahRequestDetailData) {
      return _buildSalalahUI(request as SalalahRequestDetailData);
    } else {
      return const Center(child: Text("Unsupported request type"));
    }
  }

  /// 🧱 UI for LogisticsRequestDetailData
  Widget _buildLogisticsUI(LogisticsRequestDetailData data) {
    return Column(
      children: [
        CardInfo(
          title: "Status Information",
          info: {
            "Request Date": data.request?.createdAt.toString() ?? 'N/A',
            "Status": data.request?.status ?? "N/A",
            "Approver": data.approvalDetails?[0].approverRole?.name ?? 'N/A',
            "Assigned To": data.approvalDetails?[0].approverRole?.name ?? "N/A",
          },
        ),
        5.toVerticalSizedBox,
        if (from == 'employee') ...[
          CardInfo(
            title: "Request Information",
            info: {
              "Request for": data.request?.vehicleRequiredFor ?? 'N/A',
              "Service Type": data.request?.service?.name ?? 'N/A',
              "Sub Service": data.request?.subService?.subServiceName ?? 'N/A',
              "Vehicle Type": data.request?.typeOfVehicleRequired ?? 'N/A',
              "Travel Date": data.request?.dateOfTravel?.toString() ?? 'N/A',
              "Travel Time": data.request?.timeOfTravel ?? 'N/A',
              "Duration (Days)":
                  data.request?.expDurationOfUseDays?.toString() ?? 'N/A',
              "Duration (Hours)":
                  data.request?.expDurationOfUseHrs?.toString() ?? 'N/A',
              "Location": data.request?.vehicleRequiredLocation ?? 'N/A',
            },
          ),
          5.toVerticalSizedBox,
          CardInfo(
            title: "Technical Details",
            info: {
              "Category": data.request?.category ?? 'N/A',
              "Type of Request": data.request?.typeOfRequest ?? 'N/A',
            },
          ),
        ],
      ],
    );
  }

  Widget _buildSalalahUI(SalalahRequestDetailData data) {
    return Column(
      children: [
        CardInfo(
          title: "Status Information",
          info: {
            "Approver": data.approvalDetails?[0].approverUser?.email ?? 'N/A',
            "Assigned To":
                data.approvalDetails?[0].approverUser?.employeeName ?? "N/A",
            "Request Date": data.request?.createdAt.toString() ?? 'N/A',
            "Status": data.request?.status ?? "N/A",
          },
        ),
        5.toVerticalSizedBox,
        if (from == 'salalah') ...[
          CardInfo(
            title: "Request Information",
            info: {
              "Request for": data.request?.requestFor ?? 'N/A',
              "Service Type": data.request?.service?.name ?? 'N/A',
              "Sub Service": data.request?.subService?.subServiceName ?? 'N/A',

              "Problem Statement": data.request?.problem ?? 'N/A',
              "Description": data.request?.description ?? 'N/A',
            },
          ),
          5.toVerticalSizedBox,
          CardInfo(
            title: "Technical Details",
            info: {"Extension Number": data.request?.extnNum ?? 'N/A'},
          ),
        ],
      ],
    );
  }
}
