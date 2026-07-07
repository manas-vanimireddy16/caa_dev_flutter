import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/mobile_service_scope.dart';

class SubServiceDestination {
  final Service service;
  final SubService subService;
  final PageRouteInfo<dynamic>? route;

  const SubServiceDestination({
    required this.service,
    required this.subService,
    required this.route,
  });

  bool get isSupported => route != null;
}

class SubServiceRouteResolver {
  const SubServiceRouteResolver._();

  static PageRouteInfo<dynamic>? serviceShellRouteFor(Service service) {
    if (!MobileServiceScope.isApprovedService(service)) return null;

    final serviceCode = (service.code ?? '').trim();
    final subServiceCodes = (service.subservices ?? [])
        .map((subService) => (subService.code ?? '').trim())
        .toSet();

    // The parent service owns the shell. Sub-service codes are only a fallback
    // for legacy service data that does not provide a recognized service code.
    switch (serviceCode) {
      case 'CAAS01':
        return const ITServicesHomeRoute();
      case 'CAAS014':
        return const HotelReservationHomeRoute();
      case 'CAAS013':
        return const AviationSecurityFacilitationHomeRoute();
      case 'CAAS03':
        return const RequestForAccessHomeRoute();
      case 'CAAS016':
        return const MaintenanceHomeRoute();
      case 'CAAS010':
        return const LogisticsHomeRoute();
      case 'CAAS05':
        return const LegalConsultationServicesHomeRoute();
      case 'CAAS02':
        return const TrainingandDevelopmentHomeRoute();
      case 'HSS':
        return const HallServicesHomeRoute();
      case 'CAAS09':
        return const MediaCoverageHomeRoute();
      case 'CAAS012':
        return const TenderServiceHomeRoute();
      case 'CAAS015':
        return const TrainingsandDevelopmentHomeRoute();
      case 'CAAS08':
        return const HRServiceHomeRoute();
      case 'CAAS011':
        return const SecuritySelfHomeRoute();
    }

    if (subServiceCodes.any(
      {'CAA003', 'CAA004', 'CAA005', 'CAA059'}.contains,
    )) {
      return const ITServicesHomeRoute();
    }
    if (subServiceCodes.contains('CAA046')) {
      return const HotelReservationHomeRoute();
    }
    if (subServiceCodes.contains('CAA010')) {
      return const AviationSecurityFacilitationHomeRoute();
    }
    if (subServiceCodes.any({'CAA021', 'CAA023', 'CAA025'}.contains)) {
      return const RequestForAccessHomeRoute();
    }
    if (subServiceCodes.any({'CAA035', 'CAA045'}.contains)) {
      return const MaintenanceHomeRoute();
    }
    if (subServiceCodes.any({'CAA031', 'CAA032', 'CAA033'}.contains)) {
      return const LogisticsHomeRoute();
    }
    if (subServiceCodes.any({'CAA027', 'CAA028', 'CAA029'}.contains)) {
      return const LegalConsultationServicesHomeRoute();
    }
    if (subServiceCodes.any(
      {'CAA015', 'CAA016', 'CAA018', 'CAA019', 'CAA049'}.contains,
    )) {
      return const TrainingandDevelopmentHomeRoute();
    }
    if (subServiceCodes.contains('CAA050')) {
      return const HallServicesHomeRoute();
    }
    if (subServiceCodes.contains('CAA020')) {
      return const MediaCoverageHomeRoute();
    }
    if (subServiceCodes.any(
      {'CAA011', 'CAA012', 'CAA013', 'CAA014'}.contains,
    )) {
      return const TenderServiceHomeRoute();
    }
    if (subServiceCodes.any({'CAA034', 'CAA065'}.contains)) {
      return const TrainingsandDevelopmentHomeRoute();
    }
    if (subServiceCodes.contains('CAA006')) {
      return const SecuritySelfHomeRoute();
    }
    if (subServiceCodes.any(
      {
        'CAA036',
        'CAA037',
        'CAA038',
        'CAA039',
        'CAA040',
        'CAA060',
        'CAA061',
        'CAA062',
        'CAA063',
        'CAA064',
        'CAA066',
        'CAA067',
        'CAA068',
        'CAA069',
      }.contains,
    )) {
      return const HRServiceHomeRoute();
    }

    return null;
  }

  static SubServiceDestination resolve({
    required Service service,
    required SubService subService,
  }) {
    PageRouteInfo<dynamic>? route;

    if (!MobileServiceScope.isApprovedService(service) ||
        !MobileServiceScope.isApprovedSubService(subService)) {
      return SubServiceDestination(
        service: service,
        subService: subService,
        route: null,
      );
    }

    switch ((subService.code ?? '').trim()) {
      case 'CAA010':
        route = AirportEntryPermitRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA006':
        route = SecurityThreatRoute(service: service, subService: subService);
        break;
      case 'CAA011':
        route = RequestTenderServiceRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA012':
        route = RequestAServiceToRespondToEnquiriesRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA013':
        route = RequestTenderAnalysisServiceRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA014':
        route = ContractServiceRequestRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA015':
        route = RequestTrainingRoute(service: service, subService: subService);
        break;
      case 'CAA016':
        route = RequestForStudyLeaveRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA018':
        route = AnnualTrainingPlanRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA019':
        route = RequestForCancellationRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA020':
        route = RequestforCoverageRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA021':
        route = AccessCardRequestRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA023':
        route = ImportExportMaterialPermissionRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA025':
        route = ComplaintLostPropertyReportRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA003':
        route = SalalahDashboard(service: service, subService: subService);
        break;
      case 'CAA004':
        route = MuscatDashboard(service: service, subService: subService);
        break;
      case 'CAA005':
        route = VpnDashboard(service: service, subService: subService);
        break;
      case 'CAA027':
        route = LegalConsultationandReviewofAdministrativeDecisionsRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA028':
        route = RaiseLegalComplaintRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA029':
        route = AppealAgainstAdministrativeDecisionsRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA030':
        route = RequestForLegalContractReviewRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA031':
        route = LogisticsRequestPortalRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA032':
        route = LogisticsForeignersRequestPortalRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA033':
        route = RequestForVehicleMaintenanceRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA035':
        route = RequestMaintenanceRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA034':
        route = AssignaTasktoEmployeeRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA036':
        route = RequiredNewResourceRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA037':
        route = PerformanceManagementRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA038':
        route = SkillsEnhancementRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA039':
        route = RequestForHumanResourceAnnualPlanningRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA040':
        route = RequestforDutyMissionRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA045':
        route = MaintenanceofExternalServiceRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA059':
        route = RequestEventSupportRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA046':
        route = HotelReservationRoute(service: service, subService: subService);
        break;
      case 'CAA049':
        route = RequestforTrainingRoomBookingRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA050':
        route = RequestToBookCAAHallsRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA060':
        route = AssignmentDecisionRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA061':
        route = SecondmentDecisionRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA062':
        route = TemporaryAssignmentDecisionRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA063':
        route = ServiceTransferRoute(service: service, subService: subService);
        break;
      case 'CAA064':
        route = TransferFromOneJobtoAnotherJobNatureRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA065':
        route = FollowUpReportRoute(service: service, subService: subService);
        break;
      case 'CAA066':
        route = PaymentofShiftAllowanceRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA067':
        route = PaymentofCashAllowanceForLeaveRoute(
          service: service,
          subService: subService,
        );
        break;
      case 'CAA068':
        route = PromotionsRoute(service: service, subService: subService);
        break;
      case 'CAA069':
        route = AnnualIncrementRoute(service: service, subService: subService);
        break;
    }

    return SubServiceDestination(
      service: service,
      subService: subService,
      route: route,
    );
  }

  static List<SubServiceDestination> destinationsFor(Service service) {
    return MobileServiceScope.filterSubServices(service.subservices ?? const [])
        .map((subService) => resolve(service: service, subService: subService))
        .toList(growable: false);
  }

  static Future<bool> navigateToSubService({
    required Service service,
    required SubService subService,
  }) async {
    final destination = resolve(service: service, subService: subService);
    if (destination.route == null) return false;

    await KAppX.router.push(destination.route!);
    return true;
  }
}
