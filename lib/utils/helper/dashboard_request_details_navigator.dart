import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/foundation.dart';

Future<void> navigateToDashboardRequestDetails({
  required String subServiceCode,
  required int requestId,
  Service? service,
  SubService? subService,
  bool fromActionItems = false,
}) async {
  final resolvedService = service ?? Service();
  final resolvedSubService = subService ?? SubService();
  final from = fromActionItems ? 'action items' : '';
  final serviceId = resolvedService.id ?? 0;
  final subServiceId = resolvedSubService.id ?? 0;

  switch (subServiceCode.trim()) {
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
    case 'CAA028':
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
    default:
      debugPrint(
        'No dashboard request details route found for $subServiceCode',
      );
  }
}
