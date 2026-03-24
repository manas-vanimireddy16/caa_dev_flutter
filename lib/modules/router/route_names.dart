class RouteNames {
  // ───────────────────────────────
  // AUTH
  // ───────────────────────────────
  static const String splash = '/splash';
  static const String login = '/login';
  static const String verifyOTP = '/verifyOTP';

  // ───────────────────────────────
  // MAIN NAVIGATION
  // ───────────────────────────────
  static const String bottomNavigator = '/bottomNavigator';
  static const String homeScreen = '/homeScreen';
  static const String notification = '/notification';
  static const String account = '/account';

  // These should also be absolute:
  static const String home = '/home';
  static const String records = '/records';
  static const String menu = '/menu';
  static const String patientProfile = '/patientProfile';

  // ───────────────────────────────
  // OTHER COMMON ROUTES
  // ───────────────────────────────
  static const String patientProfileDuplicate = '/patientProfileDuplicate';
  static const String webView = '/webView';
  static const String refundPolicy = '/refundPolicy';
  static const String getPremium = '/getPremium';
  static const String paymentStatus = '/paymentStatus';
  static const String paymentHistory = '/paymentHistory';
  static const String caseListFullView = '/caseListFullView';
  static const String casesFullView = '/casesFullView';
  static const String members = '/members';

  // ───────────────────────────────
  // REQUESTS
  // ───────────────────────────────
  static const String requestDetail = '/requestDetail';
  static const String requestDetailsTabScreen = '/requestDetailsTabScreen';
  static const String newRequest = '/newRequest';
  static const String muscatNewRequest = '/muscatNewRequest';
  static const String reuseRequestDetailsTab = '/reuseRequestDetailsTab';
  static const String requestEventSupport = '/requestEventSupport';
  static const String newRequestRequestSupportState =
      '/newRequestRequestSupportState';

  // ───────────────────────────────
  // LOGISTICS
  // ───────────────────────────────
  static const String logistics = '/logisticsHomePage';
  static const String vehicleRequestLogistics = '/vehicleRequestLogistics';
  static const String logisticsPassengersVehicleRequestScreen =
      '/logisticsPassengersVehicleRequestScreen';
  static const String logisticsForeignersRequestPortalScreen =
      '/logisticsForeignersRequestPortalScreen';

  /// FIXED duplicates: give each unique path
  static const String salalahNewRequest = '/salalahNewRequest';
  static const String salalahNewHOSRequest = '/salalahNewHOSRequest';
  static const String salalahNewItTechnicianRequest =
      '/salalahNewItTechnicianRequest';

  static const String logisticsRequestDetail = '/logisticsRequestDetails';
  static const String logisticsForeignRequestDetail =
      '/logisticsForeignRequestDetails';
  static const String logisticsDashboardRequestDetail =
      '/logisticsDashboardRequestDetail';

  // ───────────────────────────────
  // ACCESS CARD
  // ───────────────────────────────
  static const String requestForAccessHome = '/requestForAccessHome';
  static const String accessCardDashboard = '/accessCardDashboard';
  static const String accessCardRequest = '/accessCardRequest';
  static const String accessCardDetailScreen = '/accessCardDetailScreen';
  static const String accessCardDashboardRequest =
      '/accessCardDashboardRequest';
  static const String accessCardNewRequest = '/accessCardNewRequest';

  // ───────────────────────────────
  // HOTEL RESERVATION
  // ───────────────────────────────
  static const String hotelReservationHomePage = '/hotelReservationHomePage';
  static const String hotelNewRequest = '/hotelNewRequest';
  static const String hotelReservationRequestDetailsTabScreen =
      '/hotelReservationRequestDetailsTabScreen';

  // ───────────────────────────────
  // SECURITY THREAT
  // ───────────────────────────────
  static const String securitySelfHomePage = '/securitySelfHomePage';
  static const String reportSecurityThreatRequest =
      '/reportSecurityThreatRequest';
  static const String reportSecurityThreatRequestDetailsTabScreen =
      '/reportSecurityThreatRequestDetailsTabScreen';

  // ───────────────────────────────
  // Organize Security Awareness
  // ───────────────────────────────
  static const String organizeSecurityAwarenessRequest =
      '/organizeSecurityAwarenessRequest';
  static const String organizeSecurityAwarenessRequestDetailsTabScreen =
      '/organizeSecurityAwarenessRequestDetailsTabScreen';

  // ───────────────────────────────
  // IT SERVICES
  // ───────────────────────────────
  static const String itService = '/itService';

  static const String vpnDetailPage = '/vpnDetailPage';
  static const String vpnNewRequest = '/vpnNewRequest';

  static const String salalahRequestDetailsTabScreen =
      '/salalahRequestDetailsTabScreen';

  // ───────────────────────────────
  // MUSCAT
  // ───────────────────────────────
  static const String muscatEmployeeNewRequest = '/muscatEmployeeNewRequest';
  static const String muscatRequestDetailsTabScreen =
      '/muscatRequestDetailsTabScreen';
  static const String muscatHosRequestScreen = '/muscatHosRequestScreen';

  // ───────────────────────────────
  // AVIATION SECURITY FACILITATION
  // ───────────────────────────────
  static const String homeRouteAirportPermit = '/homeRouteAirportPermit';

  /// FIX: Two screens were using same path before
  static const String airportPermitNewRequest = '/airportPermitNewRequest';
  static const String airportPermitDetails = '/airportPermitDetails';

  // ───────────────────────────────
  // AVIATION SECURITY FACILITATION
  // ───────────────────────────────
  static const String homeRouteHRService = '/homeRouteAirportPermitHRServices';

  /// FIX: Two screens were using same path before
  static const String decisionAssignmentNewRequest =
      '/decisionAssignmentNewRequest';
  static const String decisionAssignmentDetails = '/decisionAssignmentDetails';

  static const String secondmentDecisionNewRequest =
      '/secondmentDecisionNewRequest';
  static const String secondmentDecisionDetails = '/secondmentDecisionDetails';
  static const String temporaryAssignmentDecisionNewRequest =
      '/temporaryAssignmentDecisionNewRequest';
  static const String temporaryAssignmentDecisionDetails =
      '/temporaryAssignmentDecisionDetails';

  static const String serviceTransferDecisionNewRequest =
      '/serviceTransferDecisionNewRequest ';
  static const String serviceTransferDecisionDetails =
      '/serviceTransferDecisionDetails';
  static const String annualDutyMissionDecisionNewRequest =
      '/annualDutyMissionDecisionNewRequest';
  static const String annualDutyMissionDecisionDetails =
      '/annualDutyMissionDecisionDetails';

  static const String plannedDutyMissionDecisionNewRequest =
      '/plannedDutyMissionDecisionNewRequest';
  static const String plannedDutyMissionDecisionDetails =
      '/plannedDutyMissionDecisionDetails';

  static const String unPlannedDutyMissionDecisionNewRequest =
      '/unPlannedDutyMissionDecisionNewRequest';
  static const String unPlannedDutyMissionDecisionDetails =
      '/unPlannedDutyMissionDecisionDetails';
  static const String transferFromOneJobtoAnotherJobNatureNewRequest =
      '/transferFromOneJobtoAnotherJobNatureNewRequest';
  static const String transferFromOneJobtoAnotherJobNatureDetails =
      '/transferFromOneJobtoAnotherJobNatureDetails';
  static const String paymentofShiftAllowanceNewRequest =
      '/paymentofShiftAllowanceNewRequest';
  static const String paymentofShiftAllowanceDetails =
      '/paymentofShiftAllowanceDetails';
  static const String paymentofCashAllowanceForLeaveNewRequest =
      '/paymentofCashAllowanceForLeaveNewRequest';
  static const String paymentofCashAllowanceForLeaveDetails =
      '/paymentofCashAllowanceForLeaveDetails';
  static const String allowanceSummaryPage = '/allowanceSummaryPage';

  /// Trainings and Development
  static const String trainingsanddevelopmentHomeScreen =
      '/homeRouteAirportPermitHRServices';

  /// FIX: Two screens were using same path before
  static const String trainingsanddevelopmentNewRequest =
      '/decisionAssignmentNewRequest';
  static const String trainingsanddevelopmentDetails =
      '/decisionAssignmentDetails';

  /// Media Coverage
  static const String mediaCoverageHomeScreen = '/mediaCoverageHomeScreen';

  /// FIX: Two screens were using same path before
  static const String mediaCoverageNewRequest = '/mediaCoverageNewRequest';
  static const String mediaCoverageDetails = '/mediaCoverageDetails';

  /// Training and Development
  static const String traininganddevelopmentHomeScreen =
      '/traininganddevelopmentHomeScreen';

  /// FIX: Two screens were using same path before
  static const String traininganddevelopmentNewRequest =
      '/traininganddevelopmentNewRequest';
  static const String traininganddevelopmentDetails =
      '/traininganddevelopmentDetails';
  static const String annualTrainingPlanNewRequest =
      '/annualTrainingPlanNewRequest';
  static const String annualTrainingPlanDetails = '/annualTrainingPlanDetails';

  static const String requestTrainingDetails = '/requestTrainingDetails';
  static const String requestTrainingNewRequest = '/requestTrainingNewRequest';
  static const String requestForStudyLeaveDetails =
      '/requestForStudyLeaveDetails';
  static const String requestForStudyLeaveNewRequest =
      '/requestForStudyLeaveNewRequest';
  static const String requiredNewResourceNewRequest =
      '/requestForTrainingDetailsTabScreen';
  static const String requiredNewResourceDetails =
      '/requestForStudyLeaveDetailsTabScreen';
  static const String promotionsNewRequest = '/promotionsDetailsTabScreen';
  static const String promotionsDetails = '/promotionsDetailsTabScreen';
  static const String annualIncrementNewRequest = '/annualIncrementNewRequest';
  static const String annualIncrementDetails = '/annualIncrementDetails';
  static const String skillsEnhancementNewRequest =
      '/skillsEnhancementNewRequest';
  static const String skillsEnhancementDetails = '/skillsEnhancementDetails';
  static const String performanceManagementNewRequest =
      '/performanceManagementNewRequest';
  static const String performanceManagementDetails =
      '/performanceManagementDetails';
  static const String requestForHumanResourceAnnualPlanningNewRequest =
      '/requestForHumanResourceAnnualPlanningNewRequest';
  static const String requestForHumanResourceAnnualPlanningDetails =
      '/requestForHumanResourceAnnualPlanningDetails';
}
