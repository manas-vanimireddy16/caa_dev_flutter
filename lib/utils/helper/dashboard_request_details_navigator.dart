import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/pending_request_detail_tab_registry.dart';
import 'package:code_setup/utils/helper/request_details_tab_index.dart';
import 'package:flutter/foundation.dart';

const _itServiceSubServiceCodes = {'CAA003', 'CAA004', 'CAA005', 'CAA059'};

Future<void> navigateToDashboardRequestDetails({
  required String subServiceCode,
  required int requestId,
  Service? service,
  SubService? subService,
  bool fromActionItems = false,
  int initialTabIndex = RequestDetailsTabIndex.requestDetails,
}) async {
  final resolvedService = service ?? Service();
  final resolvedSubService = subService ?? SubService();
  final from = fromActionItems ? 'action items' : '';
  final serviceId = resolvedService.id ?? 0;
  final subServiceId = resolvedSubService.id ?? 0;
  final normalizedCode = subServiceCode.trim();

  if (_itServiceSubServiceCodes.contains(normalizedCode) &&
      initialTabIndex != RequestDetailsTabIndex.requestDetails) {
    PendingRequestDetailTabRegistry.set(
      serviceId: serviceId,
      subServiceId: subServiceId,
      tabIndex: initialTabIndex,
    );
  }

  switch (normalizedCode) {
    /// IT Services
    case 'CAA004':
      await KAppX.router.push(
        MuscatRequestDetailsTabRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA005':
      await KAppX.router.push(
        VPNRequestDetailsTabRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA003':
      await KAppX.router.push(
        SalalahRequestDetailsTabRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA059':
      await KAppX.router.push(
        RequestEventSupportDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;

    /// Training Services
    case 'CAA015':
      await KAppX.router.push(
        RequestTrainingDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA016':
      await KAppX.router.push(
        RequestForStudyLeaveDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA018':
      await KAppX.router.push(
        AnnualTrainingPlanDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA019':
      await KAppX.router.push(
        RequestForCancellationDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA049':
      await KAppX.router.push(
        RequestforTrainingRoomBookingDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA050':
      await KAppX.router.push(
        RequestToBookCAAHallsDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;

    /// Logistics
    case 'CAA031':
      await KAppX.router.push(
        LogisticsRequestDetailsTabRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA032':
      await KAppX.router.push(
        LogisticsForeignRequestDetailsTabRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA033':
      await KAppX.router.push(
        RequestForVehicleMaintenanceDetailsTabRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;

    /// Legal Services

    case 'CAA029':
      await KAppX.router.push(
        AppealAgainstAdministrativeDecisionsDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA027':
      await KAppX.router.push(
        LegalConsultationandReviewofAdministrativeDecisionsDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA028':
      await KAppX.router.push(
        RaiseLegalComplaintDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA030':
      await KAppX.router.push(
        RequestForLegalContractReviewDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;

    /// Aviation Security
    case 'CAA010':
      await KAppX.router.push(
        AirportEntryRequestDetailsTabRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;

    /// Hotel Reservation
    case 'CAA046':
      await KAppX.router.push(
        HotelReservationRequestDetailsTabRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;

    /// Maintenance
    case 'CAA045':
      await KAppX.router.push(
        MaintenanceofExternalServiceDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA035':
      await KAppX.router.push(
        RequestMaintenanceDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;

    case 'CAA021':
      await KAppX.router.push(
        AccessCardRequestDetailsTabRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA023':
      await KAppX.router.push(
        ImportExportMaterialPermissionNewRequestDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA025':
      await KAppX.router.push(
        ComplaintLostPropertyReportDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA006':
      await KAppX.router.push(
        SecurityThreatRequestDetailsTabRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA020':
      await KAppX.router.push(
        RequestforCoverageDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA011':
      await KAppX.router.push(
        RequestTenderServiceDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA012':
      await KAppX.router.push(
        RequestAServiceToRespondToEnquiriesDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA013':
      await KAppX.router.push(
        RequestTenderAnalysisServiceDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA014':
      await KAppX.router.push(
        ContractServiceRequestDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA034':
      await KAppX.router.push(
        AssignaTasktoEmployeeDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA065':
      await KAppX.router.push(
        FollowUpReportDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA036':
      await KAppX.router.push(
        RequiredNewResourceDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA037':
      await KAppX.router.push(
        PerformanceManagementDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA038':
      await KAppX.router.push(
        SkillsEnhancementDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA039':
      await KAppX.router.push(
        RequestForHumanResourceAnnualPlanningDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA040':
      await KAppX.router.push(
        RequestforDutyMissionDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA060':
      await KAppX.router.push(
        AssignmentDecisionDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA061':
      await KAppX.router.push(
        SecondmentDecisionDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA062':
      await KAppX.router.push(
        TemporaryAssignmentDecisionDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA063':
      await KAppX.router.push(
        ServiceTransferDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA064':
      await KAppX.router.push(
        TransferFromOneJobtoAnotherJobNatureDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA066':
      await KAppX.router.push(
        PaymentofShiftAllowanceDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA067':
      await KAppX.router.push(
        PaymentofCashAllowanceForLeaveDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA068':
      await KAppX.router.push(
        PromotionsDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    case 'CAA069':
      await KAppX.router.push(
        AnnualIncrementDetailsRoute(
          id: requestId,
          from: from,
          service: resolvedService,
          subService: resolvedSubService,
          serviceId: serviceId,
          subServiceId: subServiceId,
        ),
      );
      break;
    default:
      debugPrint(
        'No dashboard request details route found for $subServiceCode',
      );
  }
}
