import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/modules/router/route_names.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  static final AppRouter instance = AppRouter._internal();
  AppRouter._internal();
  factory AppRouter() => instance;

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
    /// --- AUTH ---
    AutoRoute(
      page: MicrosoftLoginRoute.page,
      path: RouteNames.login,
      initial: true,
    ),

    /// --- HOME WITH BOTTOM TABS ---
    AutoRoute(
      page: HomeRoute.page,
      path: RouteNames.homeScreen,
      children: [
        AutoRoute(page: ApprovalsList.page),
        AutoRoute(page: AnnouncementRoute.page),
        AutoRoute(page: ServicesRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),

    /// --- HOTEL RESERVATION ---
    AutoRoute(
      page: HotelReservationHomeRoute.page,
      path: RouteNames.hotelReservationHomePage,
      children: [
        AutoRoute(page: HotelReservationDashboardRoute.page, initial: true),
        AutoRoute(page: HotelReservationRoute.page),
      ],
    ),

    AutoRoute(
      page: HotelReservationNewRequestRoute.page,
      path: RouteNames.hotelNewRequest,
    ),

    AutoRoute(
      page: HotelReservationRequestDetailsTabRoute.page,
      path: RouteNames.hotelReservationRequestDetailsTabScreen,
    ),

    /// --- SECURITY THREAT ---
    AutoRoute(
      page: SecuritySelfHomeRoute.page,
      path: RouteNames.securitySelfHomePage,
      children: [
        AutoRoute(page: SecuritySelfDashboardRoute.page, initial: true),
        AutoRoute(page: SecurityThreatRoute.page),
        AutoRoute(page: OrganizeSecurityAwarenessRoute.page),
        AutoRoute(page: RequestForProjectApprovalRoute.page),
        AutoRoute(page: RequestForVAPTAndInfrastructureReviewRoute.page),
        AutoRoute(page: RequestForInternalAuditRoute.page),
        AutoRoute(page: CyberSecurityRiskManagementRoute.page),
      ],
    ),

    AutoRoute(
      page: SecurityThreatNewRequestRoute.page,
      path: RouteNames.reportSecurityThreatRequest,
    ),

    AutoRoute(
      page: SecurityThreatRequestDetailsTabRoute.page,
      path: RouteNames.reportSecurityThreatRequestDetailsTabScreen,
    ),

    /// --- REQUEST TO ORGANIZE SECURITY AWARENESS ---
    AutoRoute(
      page: OrganizeSecurityAwarenessNewRequestRoute.page,
      path: RouteNames.organizeSecurityAwarenessRequest,
    ),

    AutoRoute(
      page: OrganizeSecurityAwarenessRequestDetailsTabRoute.page,
      path: RouteNames.organizeSecurityAwarenessRequestDetailsTabScreen,
    ),
    AutoRoute(
      page: RequestForProjectApprovalNewRequestRoute.page,
      path: RouteNames.requestForProjectApprovalNewRequest,
    ),
    AutoRoute(
      page: RequestForProjectApprovalDetailsRoute.page,
      path: RouteNames.requestForProjectApprovalDetails,
    ),
    AutoRoute(
      page: RequestForVAPTAndInfrastructureReviewNewRequestRoute.page,
      path: RouteNames.requestForVAPTAndInfrastructureReviewNewRequest,
    ),
    AutoRoute(
      page: RequestForVAPTAndInfrastructureReviewDetailsRoute.page,
      path: RouteNames.requestForVAPTAndInfrastructureReviewDetails,
    ),
    AutoRoute(
      page: RequestForInternalAuditNewRequestRoute.page,
      path: RouteNames.requestForInternalAuditNewRequest,
    ),
    AutoRoute(
      page: RequestForInternalAuditDetailsRoute.page,
      path: RouteNames.requestForInternalAuditDetails,
    ),
    AutoRoute(
      page: CyberSecurityRiskManagementNewRequestRoute.page,
      path: RouteNames.cyberSecurityRiskManagementNewRequest,
    ),
    AutoRoute(
      page: CyberSecurityRiskManagementDetailsRoute.page,
      path: RouteNames.cyberSecurityRiskManagementDetails,
    ),

    /// --- IT SERVICES ---
    AutoRoute(
      page: ITServicesHomeRoute.page,
      path: RouteNames.itService,
      children: [
        AutoRoute(page: SalalahDashboard.page, initial: true),
        AutoRoute(page: MuscatDashboard.page),
        AutoRoute(page: VpnDashboard.page),
        AutoRoute(page: RequestEventSupportRoute.page),
      ],
    ),

    AutoRoute(
      page: VPNRequestDetailsTabRoute.page,
      path: RouteNames.vpnDetailPage,
    ),

    AutoRoute(page: VpnNewRequestRoute.page, path: RouteNames.vpnNewRequest),

    AutoRoute(
      page: SalalahRequestDetailsTabRoute.page,
      path: RouteNames.salalahRequestDetailsTabScreen,
    ),

    AutoRoute(
      page: SalalahHOSNewRequestRoute.page,
      path: RouteNames.salalahNewHOSRequest,
    ),

    AutoRoute(
      page: SalalahNewItTechnicianRequestRoute.page,
      path: RouteNames.salalahNewItTechnicianRequest,
    ),

    /// --- MUSCAT REQUESTS ---
    AutoRoute(
      page: MuscatEmployeeNewRequestRoute.page,
      path: RouteNames.muscatEmployeeNewRequest,
    ),

    AutoRoute(
      page: MuscatRequestDetailsTabRoute.page,
      path: RouteNames.muscatRequestDetailsTabScreen,
    ),

    // AutoRoute(
    //   page: MuscutHOSNewRequestRoute.page,
    //   path: RouteNames.muscatHosRequestScreen,
    // ),
    AutoRoute(
      page: RequestEventSupportDetailsRoute.page,
      path: RouteNames.requestEventSupportDetails,
    ),
    AutoRoute(
      page: RequestEventSupportNewRequestRoute.page,
      path: RouteNames.requestEventSupportNewRequest,
    ),

    /// --- LOGISTICS ---
    AutoRoute(
      page: LogisticsVehicleRequestRoute.page,
      path: RouteNames.vehicleRequestLogistics,
    ),

    AutoRoute(
      page: LogisticsPassengersVehicleRequestRoute.page,
      path: RouteNames.logisticsPassengersVehicleRequestScreen,
    ),

    AutoRoute(
      page: LogisticsRequestDetailsTabRoute.page,
      path: RouteNames.logisticsRequestDetail,
    ),

    AutoRoute(
      page: LogisticsForeignRequestDetailsTabRoute.page,
      path: RouteNames.logisticsForeignRequestDetail,
    ),
    AutoRoute(
      page: RequestForVehicleMaintenanceDetailsTabRoute.page,
      path: RouteNames.logisticsVehicleMaintenanceRequestDetail,
    ),

    AutoRoute(
      page: RequestForVehicleMaintenanceNewRequestRoute.page,
      path: RouteNames.logisticsVehicleMaintenanceNewRequest,
    ),

    AutoRoute(
      page: SalalahNewRequestRoute.page,
      path: RouteNames.salalahNewRequest,
    ),

    AutoRoute(
      page: LogisticsHomeRoute.page,
      path: RouteNames.logistics,
      children: [
        AutoRoute(page: LogisticsRequestPortalRoute.page),
        AutoRoute(page: LogisticsDashboardRoute.page),
        AutoRoute(page: LogisticsForeignersRequestPortalRoute.page),
        AutoRoute(page: RequestForVehicleMaintenanceRoute.page),
      ],
    ),

    AutoRoute(
      page: RequestDetailsTabRoute.page,
      path: RouteNames.requestDetailsTabScreen,
    ),

    /// --- BOTTOM NAVIGATOR ---
    // AutoRoute(
    //   page: KBottomNavigatorRoute.page,
    //   path: RouteNames.bottomNavigator,
    //   children: [
    //     AutoRoute(page: SalalahDashboard.page, initial: true),
    //     AutoRoute(page: MuscatDashboard.page),
    //     AutoRoute(page: RequestPortalRoute.page),
    //     AutoRoute(page: RequestEventDashboardRoute.page),
    //   ],
    // ),

    /// --- ACCESS CARD ---
    AutoRoute(
      page: RequestForAccessHomeRoute.page,
      path: RouteNames.requestForAccessHome,
      children: [
        AutoRoute(page: AccessCardDashboardRoute.page),
        AutoRoute(page: AccessCardRequestRoute.page),
      ],
    ),

    AutoRoute(
      page: AccessCardRequestDetailsTabRoute.page,
      path: RouteNames.accessCardDetailScreen,
    ),

    AutoRoute(
      page: AccessCardNewRequestRoute.page,
      path: RouteNames.accessCardNewRequest,
    ),

    AutoRoute(page: RequestDetailRoute.page, path: RouteNames.requestDetail),

    // / --- AVIATION SECURITY FACILITATION ---
    AutoRoute(
      page: AviationSecurityFacilitationHomeRoute.page,
      path: RouteNames.homeRouteAirportPermit,
      children: [
        AutoRoute(
          page: AviationSecurityFacilitationDashboardRoute.page,
          initial: true,
        ),
        AutoRoute(page: AirportEntryPermitRoute.page),
      ],
    ),

    AutoRoute(
      page: AirportEntryPermitNewRequestRoute.page,
      path: RouteNames.airportPermitNewRequest,
    ),

    AutoRoute(
      page: AirportEntryRequestDetailsTabRoute.page,
      path: RouteNames.airportPermitDetails,
    ),

    /// --- Assignment Decision ---
    AutoRoute(
      page: HRServiceHomeRoute.page,
      path: RouteNames.homeRouteHRService,
      children: [
        AutoRoute(page: AssignmentDecisionDashboardRoute.page, initial: true),
        AutoRoute(page: AssignmentDecisionRoute.page),
        AutoRoute(page: SecondmentDecisionRoute.page),
        AutoRoute(page: TemporaryAssignmentDecisionRoute.page),
        AutoRoute(page: ServiceTransferRoute.page),
        AutoRoute(page: RequestforDutyMissionRoute.page),
        AutoRoute(page: RequestforDutyMissionPlannedRoute.page),
        AutoRoute(page: RequestforDutyMissionUnplannedRoute.page),
        AutoRoute(page: TransferFromOneJobtoAnotherJobNatureRoute.page),
        AutoRoute(page: PaymentofShiftAllowanceRoute.page),
        AutoRoute(page: PaymentofCashAllowanceForLeaveRoute.page),
        AutoRoute(page: RequiredNewResourceRoute.page),
        AutoRoute(page: PromotionsRoute.page),
        AutoRoute(page: AnnualIncrementRoute.page),
        AutoRoute(page: SkillsEnhancementRoute.page),
        AutoRoute(page: PerformanceManagementRoute.page),
        AutoRoute(page: RequestForHumanResourceAnnualPlanningRoute.page),
      ],
    ),

    AutoRoute(
      page: AssignmentDecisionDetailsRoute.page,
      path: RouteNames.decisionAssignmentDetails,
    ),

    AutoRoute(
      page: SecondmentDecisionDetailsRoute.page,
      path: RouteNames.secondmentDecisionDetails,
    ),

    // AutoRoute(
    //   page: NewTemporaryAssignmentDecisionRequestRoute.page,
    //   path: RouteNames.temporaryAssignmentDecisionNewRequest,
    // ),
    AutoRoute(
      page: TemporaryAssignmentDecisionDetailsRoute.page,
      path: RouteNames.temporaryAssignmentDecisionDetails,
    ),

    AutoRoute(
      page: ServiceTransferDetailsRoute.page,
      path: RouteNames.serviceTransferDecisionDetails,
    ),

    AutoRoute(
      page: RequestforDutyMissionRequestRoute.page,
      path: RouteNames.annualDutyMissionDecisionNewRequest,
    ),

    AutoRoute(
      page: RequestforDutyMissionDetailsRoute.page,
      path: RouteNames.annualDutyMissionDecisionDetails,
    ),

    AutoRoute(
      page: RequestforDutyMissionPlannedRequestRoute.page,
      path: RouteNames.plannedDutyMissionDecisionNewRequest,
    ),

    AutoRoute(
      page: RequestforDutyMissionPlannedDetailsRoute.page,
      path: RouteNames.plannedDutyMissionDecisionDetails,
    ),

    AutoRoute(
      page: RequestforDutyMissionUnplannedRequestRoute.page,
      path: RouteNames.unPlannedDutyMissionDecisionNewRequest,
    ),

    AutoRoute(
      page: RequestforDutyMissionUnplannedDetailsRoute.page,
      path: RouteNames.unPlannedDutyMissionDecisionDetails,
    ),
    AutoRoute(
      page: TransferFromOneJobtoAnotherJobNatureNewRequestRoute.page,
      path: RouteNames.transferFromOneJobtoAnotherJobNatureNewRequest,
    ),

    AutoRoute(
      page: TransferFromOneJobtoAnotherJobNatureDetailsRoute.page,
      path: RouteNames.transferFromOneJobtoAnotherJobNatureDetails,
    ),

    // AutoRoute(
    //   page: PaymentofShiftAllowanceNewRequestRoute.page,
    //   path: RouteNames.paymentofShiftAllowanceNewRequest,
    // ),
    AutoRoute(
      page: PaymentofShiftAllowanceDetailsRoute.page,
      path: RouteNames.paymentofShiftAllowanceDetails,
    ),

    // AutoRoute(
    //   page: PaymentofCashAllowanceForLeaveNewRequestRoute.page,
    //   path: RouteNames.paymentofCashAllowanceForLeaveNewRequest,
    // ),
    AutoRoute(
      page: PaymentofCashAllowanceForLeaveDetailsRoute.page,
      path: RouteNames.paymentofCashAllowanceForLeaveDetails,
    ),
    AutoRoute(
      page: RequiredNewResourceNewRequestRoute.page,
      path: RouteNames.requiredNewResourceNewRequest,
    ),

    AutoRoute(
      page: RequiredNewResourceDetailsRoute.page,
      path: RouteNames.requiredNewResourceDetails,
    ),
    AutoRoute(
      page: PromotionsNewRequestRoute.page,
      path: RouteNames.requiredNewResourceNewRequest,
    ),

    AutoRoute(
      page: PromotionsDetailsRoute.page,
      path: RouteNames.requiredNewResourceDetails,
    ),
    AutoRoute(
      page: AnnualIncrementNewRequestRoute.page,
      path: RouteNames.annualIncrementNewRequest,
    ),
    AutoRoute(
      page: AnnualIncrementDetailsRoute.page,
      path: RouteNames.annualIncrementDetails,
    ),
    AutoRoute(
      page: SkillsEnhancementNewRequestRoute.page,
      path: RouteNames.skillsEnhancementNewRequest,
    ),
    AutoRoute(
      page: SkillsEnhancementDetailsRoute.page,
      path: RouteNames.skillsEnhancementDetails,
    ),
    AutoRoute(
      page: PerformanceManagementNewRequestRoute.page,
      path: RouteNames.performanceManagementNewRequest,
    ),
    AutoRoute(
      page: PerformanceManagementDetailsRoute.page,
      path: RouteNames.performanceManagementDetails,
    ),
    AutoRoute(
      page: RequestForHumanResourceAnnualPlanningNewRequestRoute.page,
      path: RouteNames.requestForHumanResourceAnnualPlanningNewRequest,
    ),
    AutoRoute(
      page: RequestForHumanResourceAnnualPlanningDetailsRoute.page,
      path: RouteNames.requestForHumanResourceAnnualPlanningDetails,
    ),

    /// --- TASK MANAGEMENT ---
    AutoRoute(
      page: TrainingsandDevelopmentHomeRoute.page,
      path: RouteNames.trainingsanddevelopmentHomeScreen,
      children: [
        AutoRoute(page: AssignaTasktoEmployeeRoute.page, initial: true),
        AutoRoute(page: FollowUpReportRoute.page),
      ],
    ),

    AutoRoute(
      page: AssignaTasktoEmployeeDetailsRequestRoute.page,
      path: RouteNames.trainingsanddevelopmentNewRequest,
    ),
    AutoRoute(
      page: AssignaTasktoEmployeeDetailsRoute.page,
      path: RouteNames.trainingsanddevelopmentDetails,
    ),
    AutoRoute(
      page: FollowUpReportNewRequestRoute.page,
      path: RouteNames.followUpReportNewRequest,
    ),
    AutoRoute(
      page: FollowUpReportDetailsRoute.page,
      path: RouteNames.followUpReportDetails,
    ),

    /// --- ASSET AFFAIRS ---
    AutoRoute(
      page: AssetAffairsHomeRoute.page,
      path: RouteNames.homeRouteAssetAffairs,
      children: [
        AutoRoute(
          page: RequestForAccommodationInMuscatGovernorateRoute.page,
          initial: true,
        ),
        AutoRoute(page: ResidentalUnitRentalRoute.page),
        AutoRoute(page: RequestToRenewalHousingContractRoute.page),
        AutoRoute(page: CancelHousingContractRoute.page),
      ],
    ),
    AutoRoute(
      page: RequestForAccommodationInMuscatGovernorateNewRequestRoute.page,
      path: RouteNames.requestForAccommodationInMuscatGovernorateNewRequest,
    ),
    AutoRoute(
      page: RequestForAccommodationInMuscatGovernorateDetailsRoute.page,
      path: RouteNames.requestForAccommodationInMuscatGovernorateDetails,
    ),
    AutoRoute(
      page: ResidentalUnitRentalNewRequestRoute.page,
      path: RouteNames.residentalUnitRentalNewRequest,
    ),
    AutoRoute(
      page: ResidentalUnitRentalDetailsRoute.page,
      path: RouteNames.residentalUnitRentalDetails,
    ),
    AutoRoute(
      page: RenewalHousingContractNewRequestRoute.page,
      path: RouteNames.requestToRenewalHousingContractNewRequest,
    ),
    AutoRoute(
      page: RequestToRenewalHousingContractDetailsRoute.page,
      path: RouteNames.requestToRenewalHousingContractDetails,
    ),
    AutoRoute(
      page: CancelHousingContractNewRequestRoute.page,
      path: RouteNames.cancelHousingContractNewRequest,
    ),
    AutoRoute(
      page: CancelHousingContractDetailsRoute.page,
      path: RouteNames.cancelHousingContractDetails,
    ),

    /// --- MEDIA COVERAGE ---
    AutoRoute(
      page: MediaCoverageHomeRoute.page,
      path: RouteNames.mediaCoverageHomeScreen,
      children: [
        AutoRoute(page: MediaServicesDashboardRoute.page, initial: true),
        AutoRoute(page: RequestforCoverageRoute.page),
      ],
    ),

    AutoRoute(
      page: RequestforCoverageDetailsRoute.page,
      path: RouteNames.mediaCoverageDetails,
    ),
    AutoRoute(
      page: RequestforCoverageRequestRoute.page,
      path: RouteNames.mediaCoverageNewRequest,
    ),

    /// --- TRAINING AND DEVELOPMENT ---
    AutoRoute(
      page: TrainingandDevelopmentHomeRoute.page,
      path: RouteNames.traininganddevelopmentHomeScreen,
      children: [
        AutoRoute(
          page: TrainingandDevelopmentDashboardRoute.page,
          initial: true,
        ),
        AutoRoute(page: RequestforTrainingRoomBookingRoute.page),
        AutoRoute(page: AnnualTrainingPlanRoute.page),
        AutoRoute(page: RequestTrainingRoute.page),
        AutoRoute(page: RequestForStudyLeaveRoute.page),
        AutoRoute(page: RequestForCancellationRoute.page),
        AutoRoute(page: RequestToBookCAAHallsRoute.page),
      ],
    ),

    AutoRoute(
      page: RequestforTrainingRoomBookingDetailsRoute.page,
      path: RouteNames.traininganddevelopmentDetails,
    ),
    AutoRoute(
      page: RequestforTrainingRoomBookingRequestRoute.page,
      path: RouteNames.traininganddevelopmentNewRequest,
    ),
    AutoRoute(
      page: AnnualTrainingPlanDetailsRoute.page,
      path: RouteNames.annualTrainingPlanDetails,
    ),
    AutoRoute(
      page: AnnualTrainingPlanRequestRoute.page,
      path: RouteNames.annualTrainingPlanNewRequest,
    ),
    AutoRoute(
      page: RequestTrainingDetailsRoute.page,
      path: RouteNames.requestTrainingDetails,
    ),
    AutoRoute(
      page: RequestTrainingNewRequestRoute.page,
      path: RouteNames.requestTrainingNewRequest,
    ),
    AutoRoute(
      page: RequestForStudyLeaveNewRequestRoute.page,
      path: RouteNames.requestForStudyLeaveNewRequest,
    ),
    AutoRoute(
      page: RequestForStudyLeaveDetailsRoute.page,
      path: RouteNames.requestForStudyLeaveDetails,
    ),
    AutoRoute(
      page: RequestForCancellationNewRequestRoute.page,
      path: RouteNames.requestForCancellationNewRequest,
    ),
    AutoRoute(
      page: RequestForCancellationDetailsRoute.page,
      path: RouteNames.requestForCancellationDetails,
    ),

    AutoRoute(
      page: RequestToBookCAAHallsDetailsRoute.page,
      path: RouteNames.requestToBookCAAHallsDetails,
    ),
    AutoRoute(
      page: RequestToBookCAAHallsNewRequestRoute.page,
      path: RouteNames.requestToBookCAAHallsNewRequest,
    ),

    /// --- Assignment Decision ---
    AutoRoute(
      page: LegalConsultationServicesHomeRoute.page,
      path: RouteNames.homeRouteLegalConsultationServices,
      children: [
        AutoRoute(page: RequestForLegalContractReviewRoute.page, initial: true),
        AutoRoute(page: AppealAgainstAdministrativeDecisionsRoute.page),
        AutoRoute(page: RaiseLegalComplaintRoute.page),
        AutoRoute(
          page: LegalConsultationandReviewofAdministrativeDecisionsRoute.page,
        ),
      ],
    ),
    AutoRoute(
      page: RequestForLegalContractReviewDetailsRoute.page,
      path: RouteNames.legalConsultationServicesRequestDetails,
    ),
    AutoRoute(
      page: RequestForLegalContractReviewNewRequestRoute.page,
      path: RouteNames.legalConsultationServicesNewRequest,
    ),
    AutoRoute(
      page: AppealAgainstAdministrativeDecisionsDetailsRoute.page,
      path: RouteNames.appealAgainstAdministrativeDecisionsDetails,
    ),
    AutoRoute(
      page: AppealAgainstAdministrativeDecisionsNewRequestRoute.page,
      path: RouteNames.appealAgainstAdministrativeDecisionsNewRequest,
    ),
    AutoRoute(
      page: RaiseLegalComplaintDetailsRoute.page,
      path: RouteNames.raiseLegalComplaintDetails,
    ),
    AutoRoute(
      page: RaiseLegalComplaintNewRequestRoute.page,
      path: RouteNames.raiseLegalComplaintNewRequest,
    ),
    AutoRoute(
      page:
          LegalConsultationandReviewofAdministrativeDecisionsDetailsRoute.page,
      path: RouteNames.legalConsultationServicesRequestDetails,
    ),
    AutoRoute(
      page: LegalConsultationandReviewofAdministrativeDecisionsNewRequestRoute
          .page,
      path: RouteNames.legalConsultationServicesNewRequest,
    ),

    /// --- Tender Services ---
    AutoRoute(
      page: TenderServiceHomeRoute.page,
      path: RouteNames.tenderServiceHomeScreen,
      children: [
        AutoRoute(page: RequestTenderServiceRoute.page),
        AutoRoute(page: RequestAServiceToRespondToEnquiriesRoute.page),
        AutoRoute(page: RequestTenderAnalysisServiceRoute.page),
        AutoRoute(page: ContractServiceRequestRoute.page),
      ],
    ),

    AutoRoute(
      page: RequestTenderServiceDetailsRoute.page,
      path: RouteNames.requestTenderServiceDetails,
    ),
    AutoRoute(
      page: RequestTenderServiceNewRequestRoute.page,
      path: RouteNames.requestTenderServiceNewRequest,
    ),
    AutoRoute(
      page: RequestAServiceToRespondToEnquiriesDetailsRoute.page,
      path: RouteNames.respondToEnquiryDetails,
    ),
    AutoRoute(
      page: RequestAServiceToRespondToEnquiriesNewRequestRoute.page,
      path: RouteNames.respondToEnquiryNewRequest,
    ),
    AutoRoute(
      page: RequestTenderAnalysisServiceDetailsRoute.page,
      path: RouteNames.requestTenderAnalysisDetails,
    ),
    AutoRoute(
      page: RequestTenderAnalysisServiceNewRequestRoute.page,
      path: RouteNames.requestTenderAnalysisNewRequest,
    ),

    AutoRoute(
      page: ContractServiceRequestDetailsRoute.page,
      path: RouteNames.contractServiceRequestDetails,
    ),
    AutoRoute(
      page: ContractServiceRequestNewRequestRoute.page,
      path: RouteNames.contractServiceRequestNewRequest,
    ),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
