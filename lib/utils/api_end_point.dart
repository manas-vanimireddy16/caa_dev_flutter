class ApiEndPoint {
  ApiEndPoint._();

  ///upload files
  static const String uploadFiles = '/v1/user-service/upload';
  static const String downloadFiles = '/v1/user-service/download';

  static const String caaDrupal = '/api/caa-drupal';

  /// authentication
  static const String authMobileSignin = '/auth/mobilesignin';

  ///
  ///
  static const String getSections = '/v1/user-service/department/users/count';
  static const String getDepartments = '/v1/user-service/departments';

  static const String departments = '/v1/user-service/admin/departments';

  static const String rolesListing = '/v1/user-service/master/roles/listing';

  static const String masterRoles = '/v1/user-service/master/roles/listing';

  static const String sections = '/v1/user-service/master/sections/listing';

  static const String sectionsList = '/v1/user-service/admin/sections/';

  static String download(String id) => '/v1/user-service/download/$id';

  static String getBookmarks(String userId) =>
      '/v1/user-service/service/bookmarks/$userId';
  static const String updateBookmark = '/v1/user-service/service/bookmark';

  static const String departmentsList =
      '/v1/user-service/master/departments/listing';

  static String departmentsByDgDepartment(int departmentId) =>
      '/v1/user-service/master/departments/by-dg-department/$departmentId';
  static const String countryList = '/v1/user-service/country-master/list';

  /// Dashboard
  static const String dashboardActionItems =
      '/v1/user-service/dashboard/sla/for-approval';
  static const String dashboardMyRequests =
      '/v1/user-service/dashboard/sla/my-requests';
  static const String dashboardKpi =
      '/v1/user-service/dashboard/sla/my-requests/analytics/kpi';
  static const String dashboardApprovalKpi =
      '/v1/user-service/dashboard/sla/for-approval/analytics/kpi';

  static const String dashboardTrendBreakdown =
      '/v1/user-service/dashboard/sla/my-requests/analytics/trend-breakdown';
  static const String dashboardStatusBreakdown =
      '/v1/user-service/dashboard/sla/my-requests/analytics/status-breakdown';

  static const String dashboardApprovalTrendBreakdown =
      '/v1/user-service/dashboard/sla/my-requests/analytics/trend-breakdown';
  static const String dashboardApprovalStatusBreakdown =
      '/v1/user-service/dashboard/sla/my-requests/analytics/status-breakdown';

  static const String importantLinks = '/v1/user-service/important-links';
  static const String setActiveRole = '/v1/user-service/userrole/set-active';

  ///Salalah
  /// Salalah Helpdesk APIs

  /// CREATE REQUEST
  static const String sendSalalahRequest =
      '/v1/it-service/helpdesk/salalah/request';

  /// DROPDOWNS
  static const String servicesDropdown =
      '/v1/it-service/helpdesk/service/types';

  /// USER REQUESTS LIST
  static const String salalahRequests = '/v1/it-service/helpdesk/user/requests';

  /// REQUEST BY ID
  static String salalahRequestById(int requestId) =>
      '/v1/it-service/helpdesk/request/$requestId';

  /// REQUEST ATTACHMENT APIs
  static String salalahUploadAttachment(int requestId) =>
      '/v1/it-service/helpdesk/request/$requestId/attachment';

  static String salalahGetAttachments(int requestId) =>
      '/v1/it-service/helpdesk/request/$requestId/attachments';

  /// REQUEST CHAT APIs
  static String salalahSendChat(int requestId) =>
      '/v1/it-service/helpdesk/request/$requestId/chat';

  static String salalahGetChats(int requestId) =>
      '/v1/it-service/helpdesk/request/$requestId/chats';

  /// KPI APIs
  static const String salalahKpiCard = '/v1/it-service/helpdesk/analytics/kpi';

  static const String salalahApprovalKpiCard =
      '/v1/it-service/helpdesk/analytics/approvals/kpi-cards';

  /// STATUS BREAKDOWN
  static String salalahStatusBreakdown(String period) =>
      '/v1/it-service/helpdesk/analytics/status-breakdown?period=$period';

  /// TREND BREAKDOWN
  static String salalahTrendBreakdown(String period) =>
      '/v1/it-service/helpdesk/analytics/trends?period=$period';

  /// APPROVAL STATUS BREAKDOWN
  static String salalahApprovalStatusBreakdown(String period) =>
      '/v1/it-service/helpdesk/analytics/approvals/status-breakdown?period=$period';

  /// APPROVAL TREND BREAKDOWN
  static String salalahApprovalTrendBreakdown(String period) =>
      '/v1/it-service/helpdesk/analytics/approvals/trend-breakdown?period=$period';

  /// TECHNICIANS
  static const String salalahITTechnician =
      '/v1/it-service/helpdesk/Technicians';

  /// ACTION ITEMS
  static const String getActionItems =
      '/v1/it-service/helpdesk/approval/requests';

  static const String salalahActionItems =
      '/v1/it-service/helpdesk/approval/requests';

  /// SECTION DETAILS
  static String salalahSection(int id) => '/v1/user-service/admin/sections/$id';

  /// ASSIGN TO ME
  static const String assignToMe =
      '/v1/it-service/helpdesk/salalah/external/assign-to-me';

  /// APPROVE / CLOSE REQUEST
  static const String onClose = '/v1/it-service/helpdesk/salalah/approve';

  ///Muscat

  static const String muscatServicesDropdown =
      '/v1/it-service/helpdesk/service/types?service_id=1&sub_service_id=2';
  static const String sendMuscatRequest =
      '/v1/it-service/helpdesk/salalah/request';
  static const String servicesMuscatDropdown =
      '/v1/it-service/helpdesk/service/types?service_id=1&sub_service_id=2';
  static const String muscatRequests =
      '/v1/it-service/helpdesk/user/requests?service_id=1&sub_service_id=2';
  static String muscatRequestById(int id) =>
      '/v1/it-service/helpdesk/request/$id';
  static const String muscatKpiCard =
      '/v1/it-service/helpdesk/analytics/kpi?service_id=1&sub_service_id=2';
  static String muscatStatusBreakdown(String period) =>
      '/v1/it-service/helpdesk/analytics/status-breakdown?service_id=1&sub_service_id=2&time_period=$period';
  static String muscatTrendBreakdown(String period) =>
      '/v1/it-service/helpdesk/analytics/trends?service_id=1&sub_service_id=2&year=$period';
  static const String muscatITTechnician =
      '/v1/it-service/helpdesk/Technicians?role_name=IT%20Technician';

  static const String getMuscatActionItems =
      '/v1/it-service/helpdesk/approval/requests?service_id=1&sub_service_id=2';
  static String muscatSection(int id) => '/v1/user-service/admin/sections/$id';
  static const muscatActionItems =
      '/v1/it-service/helpdesk/approval/requests?service_id=1&sub_service_id=2';
  static const String muscatassignToMe =
      '/v1/it-service/helpdesk/salalah/external/assign-to-me';
  static const String onCloseMuscat = '/v1/it-service/helpdesk/salalah/approve';

  static const String userRolesMuscat =
      '/v1/it-service/helpdesk/muscat/roles-users';
  static const String usersInfoMuscat =
      '/v1/it-service/helpdesk/muscat/roles-users';
  static const String muscatApprove =
      '/v1/it-service/helpdesk/muscat/external/approve';

  /// Logistics
  static String sendVehicleRequest = '/v1/it-service/logistics/vehicle-request';

  static const String kpiCardLogistics =
      '/v1/it-service/logistics/analytics/kpi-cards';
  static const String kpiCardLogisticsEmployee =
      '/v1/it-service/logistics/analytics/logistics/kpi-cards?service_id=20&sub_service_id=12';
  static const String kpiCardLogisticsForeignVehicle =
      '/v1/it-service/logistics/analytics/foreign-vehicle/kpi-cards?service_id=20&sub_service_id=13';
  static const String postLogisticsForeignRequests =
      '/v1/it-service/logistics/foreign-vehicle-request';
  static const String logisticsActivityFeed =
      '/v1/it-service/logistics/analytics/activity-feed';
  static const String dashboardRequest = '/v1/it-service/logistics/requests';
  static const String dashboardAllRequest =
      '/v1/it-service/logistics/all-requests';
  static const String dashboardForeignRequest =
      '/v1/it-service/logistics/foreign-vehicle-requests';
  static String statusBreakdownLogistics(String condition) =>
      '/v1/it-service/logistics/analytics/logistics/status-breakdown?time_period=$condition';
  static String statusBreakdownForeignLogistics(String condition) =>
      '/v1/it-service/logistics/analytics/foreign-vehicle/status-breakdown?time_period=$condition';
  static String trendBreakdownLogistics(String condition) =>
      '/v1/it-service/logistics/analytics/logistics/trend-breakdown?year=$condition';
  static String trendBreakdownForeignLogistics(String condition) =>
      '/v1/it-service/logistics/analytics/foreign-vehicle/trend-breakdown?year=$condition';
  static String logisticsRequestDetailsById(int id) =>
      '/v1/it-service/logistics/request/$id';
  static String logisticsForeignRequestDetailsById(int id) =>
      '/v1/it-service/logistics/foreign-vehicle-request/$id';
  static String postLogisticsChat(int id) =>
      '/v1/it-service/logistics/request/$id/chat';
  static String allRequestsLogistics = '/v1/it-service/logistics/all-requests';

  /// role & user
  static String userRoles(int id) => '/v1/user-service/user/$id/roles-services';
  static String userInfo(int id) => '/v1/user-service/user/$id';

  /// chatbot
  static const String chatbotAsk = '/v1/chatbot-service/ask';
  static const String chatbotQuestions =
      '/v1/chatbot-service/chatbot/questions';
  static const String chatbotAnswer = '/v1/chatbot-service/chatbot/answer';
  static const String chatbotAskFaq = '/v1/chatbot-service/chatbot/ask_FAQ';

  /// ===================== VPN APIs =====================

  /// Send Request (Create Request)
  static const String vpnSendRequest = '/v1/it-service/vpn/request';

  /// Get my requests
  static const String vpnGetRequests = '/v1/it-service/vpn/requests';

  static const String vpnApprove = '/v1/it-service/vpn/approve';
  static const String vpnAssign = '/v1/it-service/vpn/request/assign';
  static const String vpnTechnicianList = '/v1/it-service/vpn/technicians';

  /// Get approval list (For approvers)
  static const String vpnGetActionItems =
      '/v1/it-service/vpn/requests/for-approval';

  /// Get request by ID
  static String vpnRequestById(int requestId) =>
      '/v1/it-service/vpn/request/$requestId';

  /// ===================== UPDATE REQUEST =====================

  static String vpnUpdateRequest(int requestId) =>
      '/v1/it-service/vpn/request/$requestId';

  /// ===================== CHAT APIs =====================

  /// Send chat
  static String vpnSendChatById(int requestId) =>
      '/v1/it-service/vpn/request/$requestId/chat';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String vpnSendAttachmentById(int requestId) =>
      '/v1/it-service/vpn/request/$requestId/attachment';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String vpnKpiCards = '/v1/it-service/vpn/analytics/kpi-cards';

  /// Approver KPI cards
  static const String vpnApprovalKpiCards =
      '/v1/it-service/vpn/analytics/approval-kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String vpnStatusBreakdown =
      '/v1/it-service/vpn/analytics/status-breakdown';

  /// Approval status breakdown
  static const String vpnApprovalStatusBreakdown =
      '/v1/it-service/vpn/analytics/approval-status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String vpnTrendBreakdown =
      '/v1/it-service/vpn/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String vpnApprovalTrendBreakdown =
      '/v1/it-service/vpn/analytics/approval-trend-breakdown';

  /// secuirty access
  static const String securityAccessPostRequest =
      '/v1/user-service/access-card/request';
  static const String securityAccessKpi =
      '/v1/user-service/access-card/kpi-cards';
  static const String securityAccessApprovalKpi =
      '/v1/user-service/access-card/analytics/approvals/kpi-cards';
  static const String securityAccessTrendBreakDown =
      '/v1/user-service/access-card/trend-breakdown';
  static const String securityAccessApprovalTrendBreakDown =
      '/v1/user-service/access-card/analytics/approvals/trend-breakdown';
  static const String securityAccessStatusBreakDown =
      '/v1/user-service/access-card/status-breakdown';
  static const String securityAccessApprovalStatusBreakDown =
      '/v1/user-service/access-card/analytics/approvals/status-breakdown';
  static const String securityAccessRequests =
      '/v1/user-service/access-card/requests';
  static const String securityAccessActionItems =
      '/v1/user-service/access-card/requests/for-approval';
  static String securityAccessRequestById(int id) =>
      '/v1/user-service/access-card/request/$id';
  static const String securityAccessApproval =
      '/v1/user-service/access-card/approve';
  // ================= ATTACHMENT =================

  // POST -> upload attachment
  static String securityAccessAttachmentPostById(int id) =>
      '/v1/user-service/access-card/request/$id/attachment';

  // GET -> fetch attachments
  static String securityAccessAttachmentsById(int id) =>
      '/v1/user-service/access-card/request/$id/attachments';

  // ================= CHAT =================

  // POST -> send chat message
  static String securityAccessChatPostById(int id) =>
      '/v1/user-service/access-card/request/$id/chat';

  // GET -> fetch chats
  static String securityAccessChatsById(int id) =>
      '/v1/user-service/access-card/request/$id/chats';

  // ===================== HOTEL RESERVATION APIs =====================

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String hotelReservationSendRequest =
      '/v1/it-service/hotelreservation/reservation';

  /// Get my requests
  static const String hotelReservationGetRequests =
      '/v1/it-service/hotelreservation/reservations';

  /// Get approval list (For approvers)
  static const String hotelReservationGetActionItems =
      '/v1/it-service/hotelreservation/reservations/for-approval';

  /// Get request by ID
  static String hotelReservationRequestById(int requestId) =>
      '/v1/it-service/hotelreservation/reservation/$requestId';

  /// ===================== UPDATE REQUEST =====================

  /// (Optional – if backend supports)
  static String hotelReservationUpdateRequest(int requestId) =>
      '/v1/it-service/hotelreservation/reservation/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String hotelReservationApprove =
      '/v1/it-service/hotelreservation/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat
  static String hotelReservationSendChatById(int requestId) =>
      '/v1/it-service/hotelreservation/reservation/$requestId/chat';

  /// Get chats
  static String hotelReservationChatsById(int requestId) =>
      '/v1/it-service/hotelreservation/reservation/$requestId/chats';

  /// Update chat
  static String hotelReservationUpdateChat(int chatId) =>
      '/v1/it-service/hotelreservation/chats/$chatId';

  /// Delete chat
  static String hotelReservationDeleteChat(int chatId) =>
      '/v1/it-service/hotelreservation/chats/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String hotelReservationSendAttachmentById(int requestId) =>
      '/v1/it-service/hotelreservation/reservation/$requestId/attachment';

  /// Get attachments
  static String hotelReservationAttachmentsById(int requestId) =>
      '/v1/it-service/hotelreservation/reservation/$requestId/attachments';

  /// Update attachment
  static String hotelReservationUpdateAttachment(int attachmentId) =>
      '/v1/it-service/hotelreservation/attachments/$attachmentId';

  /// Delete attachment
  static String hotelReservationDeleteAttachment(int attachmentId) =>
      '/v1/it-service/hotelreservation/attachments/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String hotelReservationKpiCards =
      '/v1/it-service/hotelreservation/analytics/kpi-cards';

  /// Approver KPI cards
  static const String hotelReservationApprovalKpiCards =
      '/v1/it-service/hotelreservation/analytics/hotel-approvals/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String hotelReservationStatusBreakdown =
      '/v1/it-service/hotelreservation/analytics/status-breakdown';

  /// Approval status breakdown
  static const String hotelReservationApprovalStatusBreakdown =
      '/v1/it-service/hotelreservation/analytics/hotel-approvals/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String hotelReservationTrendBreakdown =
      '/v1/it-service/hotelreservation/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String hotelReservationApprovalTrendBreakdown =
      '/v1/it-service/hotelreservation/analytics/hotel-approvals/trend-breakdown';

  /// Security self - Report Security Threat
  static const String reportSecurityThreatPostRequest =
      '/v1/it-service/security-threat/request';
  static String uploadReportSecurityThreatChat(String id) =>
      '/v1/it-service/security-threat/request/$id/chat';
  static const String reportSecurityThreatKpi =
      '/v1/it-service/security-threat/analytics/kpi-cards';
  static String reportSecurityThreatStatusBreakdown =
      '/v1/it-service/security-threat/analytics/status-breakdown';
  static String reportSecurityThreatTrendBreakdown =
      '/v1/it-service/security-threat/analytics/trend-breakdown';
  static String reportSecurityThreatApprovalStatusBreakdown =
      '/v1/it-service/security-threat/analytics/approvals/status-breakdown';
  static String reportSecurityThreatApprovalTrendBreakdown =
      '/v1/it-service/security-threat/analytics/approvals/trend-breakdown';
  static String reportSecurityThreatChatById(String id) =>
      '/v1/it-service/security-threat/request/$id/chats';
  static const String reportSecurityThreatApprovalKpi =
      '/v1/it-service/security-threat/analytics/approvals/kpi-cards';
  static const String reportSecurityThreatRequests =
      '/v1/it-service/security-threat/requests';
  static const String reportSecurityThreatActionItems =
      '/v1/it-service/security-threat/requests/for-approval';
  static String reportSecurityThreatRequestById(int id) =>
      '/v1/it-service/security-threat/request/$id';
  static String reportSecurityThreatApproval =
      '/v1/it-service/security-threat/approve';
  static String reportSecurityThreatAssign =
      '/v1/it-service/security-threat/approve';
  static String reportSecurityThreatEngineers(int id) =>
      '/v1/it-service/security-threat/users/by-role?roleId=$id';
  static const String combinedReportSecurityThreatRequests =
      '/v1/it-service/security-threat/all-requests';
  static const String combinedReportSecurityThreatActionItems =
      '/v1/it-service/security-threat/all-requests/for-approval';
  static const String combinedReportSecurityThreatKpi =
      '/v1/it-service/security-threat/analytics/combined/kpi-cards';
  static const String combinedReportSecurityThreatStatusBreakdown =
      '/v1/it-service/security-threat/analytics/combined/status-breakdown';
  static const String combinedReportSecurityThreatTrendBreakdown =
      '/v1/it-service/security-threat/analytics/combined/trend-breakdown';
  static const String combinedReportSecurityThreatApprovalKpi =
      '/v1/it-service/security-threat/analytics/combined/approvals/kpi-cards';
  static const String combinedReportSecurityThreatApprovalStatusBreakdown =
      '/v1/it-service/security-threat/analytics/combined/approvals/status-breakdown';
  static const String combinedReportSecurityThreatApprovalTrendBreakdown =
      '/v1/it-service/security-threat/analytics/combined/approvals/trend-breakdown';
  static const String reportSecurityThreatAssignToEngineer =
      '/v1/it-service/security-threat/assign';

  /// Security self - Request to Organize Security Awareness
  static const String organizeSecurityAwarenessPostRequest =
      '/v1/it-service/security-awareness/request';
  static String uploadOrganizeSecurityAwarenessChat(String id) =>
      '/v1/it-service/security-awareness/request/$id/chat';
  static const String organizeSecurityAwarenessKpi =
      '/v1/it-service/security-awareness/analytics/kpi-cards';
  static String organizeSecurityAwarenessStatusBreakdown =
      '/v1/it-service/security-awareness/analytics/status-breakdown';
  static String organizeSecurityAwarenessTrendBreakdown =
      '/v1/it-service/security-awareness/analytics/trend-breakdown';
  static String organizeSecurityAwarenessApprovalStatusBreakdown =
      '/v1/it-service/security-awareness/analytics/approvals/status-breakdown';
  static String organizeSecurityAwarenessApprovalTrendBreakdown =
      '/v1/it-service/security-awareness/analytics/approvals/trend-breakdown';
  static String organizeSecurityAwarenessChatById(String id) =>
      '/v1/it-service/security-awareness/request/$id/chats';
  static const String organizeSecurityAwarenessApprovalKpi =
      '/v1/it-service/security-awareness/analytics/approvals/kpi-cards';
  static const String organizeSecurityAwarenessRequests =
      '/v1/it-service/security-awareness/requests';
  static const String organizeSecurityAwarenessActionItems =
      '/v1/it-service/security-awareness/requests/for-approval';
  static String organizeSecurityAwarenessRequestById(int id) =>
      '/v1/it-service/security-awareness/request/$id';
  static String organizeSecurityAwarenessApproval =
      '/v1/it-service/security-awareness/approve';
  static String organizeSecurityAwarenessAssign =
      '/v1/it-service/security-awareness/assign';
  static String organizeSecurityAwarenessEngineers(int id) =>
      '/v1/it-service/security-awareness/users/by-role?roleId=$id';
  static String eventDateChange(int id) =>
      '/v1/it-service/security-awareness/request/$id/event-datetime';

  /// ===================== AIRPORT ENTRY APIs =====================

  /// Send Request (Create Request)
  static const String airportEntrySendRequest =
      '/v1/it-service/airport-entry-permit/request';

  /// Get my requests
  static const String airportEntryGetRequests =
      '/v1/it-service/airport-entry-permit/requests';

  /// Get approval list (For approvers)
  static const String airportEntryGetActionItems =
      '/v1/it-service/airport-entry-permit/requests/for-approval';

  /// Get request by ID
  static String airportEntryRequestById(int requestId) =>
      '/v1/it-service/airport-entry-permit/request/$requestId';

  /// ===================== UPDATE REQUEST =====================
  /// (Optional – if backend supports)

  static String airportEntryUpdateRequest(int requestId) =>
      '/v1/it-service/airport-entry-permit/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String airportEntryApprove =
      '/v1/it-service/airport-entry-permit/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat
  static String airportEntrySendChatById(int requestId) =>
      '/v1/it-service/airport-entry-permit/request/$requestId/chat';

  /// Get chats
  static String airportEntryChatsById(int requestId) =>
      '/v1/it-service/airport-entry-permit/request/$requestId/chats';

  /// Update chat
  static String airportEntryUpdateChat(int chatId) =>
      '/v1/it-service/airport-entry-permit/chats/$chatId';

  /// Delete chat
  static String airportEntryDeleteChat(int chatId) =>
      '/v1/it-service/airport-entry-permit/chats/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String airportEntrySendAttachmentById(int requestId) =>
      '/v1/it-service/airport-entry-permit/request/$requestId/attachment';

  /// Get attachments
  static String airportEntryAttachmentsById(int requestId) =>
      '/v1/it-service/airport-entry-permit/request/$requestId/attachments';

  /// Update attachment
  static String airportEntryUpdateAttachment(int attachmentId) =>
      '/v1/it-service/airport-entry-permit/attachments/$attachmentId';

  /// Delete attachment
  static String airportEntryDeleteAttachment(int attachmentId) =>
      '/v1/it-service/airport-entry-permit/attachments/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String airportEntryKpiCards =
      '/v1/it-service/airport-entry-permit/analytics/kpi-cards';

  /// Approver KPI cards
  static const String airportEntryApprovalKpiCards =
      '/v1/it-service/airport-entry-permit/analytics/approval-kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String airportEntryStatusBreakdown =
      '/v1/it-service/airport-entry-permit/analytics/status-breakdown';

  /// Approval status breakdown
  static const String airportEntryApprovalStatusBreakdown =
      '/v1/it-service/airport-entry-permit/analytics/approval-status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String airportEntryTrendBreakdown =
      '/v1/it-service/airport-entry-permit/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String airportEntryApprovalTrendBreakdown =
      '/v1/it-service/airport-entry-permit/analytics/approval-trend-breakdown';

  /// ===================== OTHER APIs =====================

  /// Nationality list
  static const String nationalityList = '/v1/user-service/nationality/list';

  /// HR Services
  ///
  /// Assignment Decision
  static const String assignmentDecisionUsers = '/v1/hr-service/users';
  static const String assignmentDecisionPositions = '/v1/hr-service/positions';
  static const String assignmentDecisionNewRequest =
      '/v1/hr-service/assignment-decision/request';
  static String assignmentDecisionStatusBreakdown =
      '/v1/hr-service/assignment-decision/analytics/status-breakdown';
  static String assignmentDecisionTrendBreakdown =
      '/v1/hr-service/assignment-decision/analytics/trend-breakdown';
  static String assignmentDecisionApprovalStatusBreakdown =
      '/v1/hr-service/assignment-decision/analytics/approval-status-breakdown';
  static String assignmentDecisionApprovalTrendBreakdown =
      '/v1/hr-service/assignment-decision/analytics/approval-trend-breakdown';
  static const String assignmentDecisionRequests =
      '/v1/hr-service/assignment-decision/requests';
  static const String assignmentDecisionApprovalRequests =
      '/v1/hr-service/assignment-decision/requests/for-approval';
  static String assignmentDecisionRequestById(int id) =>
      '/v1/hr-service/assignment-decision/request/$id';
  static const String assignmentDecisionApproval =
      '/v1/hr-service/assignment-decision/approve';
  static const String assignmentDecisionReject =
      '/v1/hr-service/assignment-decision/reject';
  static const String assignmentDecisionApprovalKpiData =
      '/v1/hr-service/assignment-decision/analytics/approval-kpi-cards';
  static const String assignmentDecisionKpiData =
      '/v1/hr-service/assignment-decision/analytics/kpi-cards';
  static const String assignmentDecisionEmployeesList =
      '/v1/hr-service/assignment-decision/employees';
  static const String assignmentDecisionEmployeeAssignEmployee =
      '/v1/hr-service/assignment-decision/request/assign';
  static const String assignmentDecisionReplaceEmployee =
      '/v1/hr-service/assignment-decision/request/replace-employee';

  static String assignmentDecisionAttachmentById(int id) =>
      '/v1/hr-service/assignment-decision/request/$id/attachments';
  static String assignmentDecisionSendAttachmentById(int id) =>
      '/v1/hr-service/assignment-decision/request/$id/attachment';

  static String assignmentDecisionGetChatsById(int id) =>
      '/v1/hr-service/assignment-decision/request/$id/chats';

  static String assignmentDecisionSendChatsById(int id) =>
      '/v1/hr-service/assignment-decision/request/$id/chat';

  /// Secondment Decision
  static const String secondmentDecisionUsers = '/v1/hr-service/users';

  static const String secondmentDecisionPositions = '/v1/hr-service/positions';

  static const String secondmentDecisionNewRequest =
      '/v1/hr-service/secondment-decisions/request';

  static const String secondmentDecisionRequests =
      '/v1/hr-service/secondment-decisions/requests';

  static const String secondmentDecisionApprovalRequests =
      '/v1/hr-service/secondment-decisions/requests/for-approval';

  static String secondmentDecisionRequestById(int id) =>
      '/v1/hr-service/secondment-decisions/request/$id';

  static const String secondmentDecisionApproval =
      '/v1/hr-service/secondment-decisions/approve';

  static const String secondmentDecisionReject =
      '/v1/hr-service/secondment-decisions/reject';

  static const String secondmentDecisionApprovalKpiData =
      '/v1/hr-service/secondment-decisions/analytics/approval-kpi-cards';

  static const String secondmentDecisionKpiData =
      '/v1/hr-service/secondment-decisions/analytics/kpi-cards';

  static String secondmentDecisionStatusBreakdown =
      '/v1/hr-service/secondment-decisions/analytics/status-breakdown';
  static String secondmentDecisionTrendBreakdown =
      '/v1/hr-service/secondment-decisions/analytics/trend-breakdown';
  static String secondmentDecisionApprovalStatusBreakdown =
      '/v1/hr-service/secondment-decisions/analytics/approval-status-breakdown';
  static String secondmentDecisionApprovalTrendBreakdown =
      '/v1/hr-service/secondment-decisions/analytics/approval-trend-breakdown';

  static const String secondmentDecisionEmployeesList =
      '/v1/hr-service/secondment-decisions/employees';

  static const String secondmentDecisionEmployeeAssignEmployee =
      '/v1/hr-service/secondment-decisions/request/assign';

  static const String secondmentDecisionReplaceEmployee =
      '/v1/hr-service/secondment-decisions/request/replace-employee';

  static String secondmentDecisionChatById(int id) =>
      '/v1/hr-service/secondment-decisions/request/$id/chats';

  static String secondmentDecisionSendChatById(int id) =>
      '/v1/hr-service/secondment-decisions/request/$id/chat';

  static String secondmentDecisionAttachmentById(int id) =>
      '/v1/hr-service/secondment-decisions/request/$id/attachments';

  static String secondmentDecisionSendAttachmentById(int id) =>
      '/v1/hr-service/secondment-decisions/request/$id/attachment';

  // ===================== Temporary Assignment Decision =====================

  /// Create Request
  static const String temporaryAssignmentDecisionNewRequest =
      '/v1/hr-service/temporary-assignment-decision/request';

  /// Get My Requests
  static const String temporaryAssignmentDecisionRequests =
      '/v1/hr-service/temporary-assignment-decision/requests';

  /// Approval Requests
  static const String temporaryAssignmentDecisionApprovalRequests =
      '/v1/hr-service/temporary-assignment-decision/requests/for-approval';

  /// Request By Id
  static String temporaryAssignmentDecisionRequestById(int id) =>
      '/v1/hr-service/temporary-assignment-decision/request/$id';

  /// ===================== APPROVAL APIs =====================

  static const String temporaryAssignmentDecisionApproval =
      '/v1/hr-service/temporary-assignment-decision/approve';

  static const String temporaryAssignmentDecisionReject =
      '/v1/hr-service/temporary-assignment-decision/reject';

  /// ===================== KPI APIs =====================

  /// Requester KPI
  static const String temporaryAssignmentDecisionKpiData =
      '/v1/hr-service/temporary-assignment-decision/analytics/kpi-cards';

  /// Approval KPI
  static const String temporaryAssignmentDecisionApprovalKpiData =
      '/v1/hr-service/temporary-assignment-decision/analytics/approval-kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request Status Breakdown
  static const String temporaryAssignmentDecisionStatusBreakdown =
      '/v1/hr-service/temporary-assignment-decision/analytics/status-breakdown';

  /// Approval Status Breakdown
  static const String temporaryAssignmentDecisionApprovalStatusBreakdown =
      '/v1/hr-service/temporary-assignment-decision/analytics/approval-status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request Trend Breakdown
  static const String temporaryAssignmentDecisionTrendBreakdown =
      '/v1/hr-service/temporary-assignment-decision/analytics/trend-breakdown';

  /// Approval Trend Breakdown
  static const String temporaryAssignmentDecisionApprovalTrendBreakdown =
      '/v1/hr-service/temporary-assignment-decision/analytics/approval-trend-breakdown';

  /// ===================== EMPLOYEE APIs =====================

  static const String temporaryAssignmentDecisionEmployeesList =
      '/v1/hr-service/temporary-assignment-decision/employees';

  static const String temporaryAssignmentDecisionEmployeeAssignEmployee =
      '/v1/hr-service/temporary-assignment-decision/request/assign';

  static const String temporaryAssignmentDecisionReplaceEmployee =
      '/v1/hr-service/temporary-assignment-decision/request/replace-employee';

  /// ===================== CHAT APIs =====================

  /// Get Chats
  static String temporaryAssignmentDecisionChatById(int id) =>
      '/v1/hr-service/temporary-assignment-decision/request/$id/chats';

  /// Send Chat
  static String temporaryAssignmentDecisionSendChatById(int id) =>
      '/v1/hr-service/temporary-assignment-decision/request/$id/chat';

  /// ===================== ATTACHMENT APIs =====================

  /// Get Attachments
  static String temporaryAssignmentDecisionAttachmentById(int id) =>
      '/v1/hr-service/temporary-assignment-decision/request/$id/attachments';

  /// Send Attachment
  static String temporaryAssignmentDecisionSendAttachmentById(int id) =>
      '/v1/hr-service/temporary-assignment-decision/request/$id/attachment';

  // Service Transfer

  static const String serviceTransferNewRequest =
      '/v1/hr-service/service-transfer/request';

  static const String serviceTransferRequests =
      '/v1/hr-service/service-transfer/requests';

  static const String serviceTransferApprovalRequests =
      '/v1/hr-service/service-transfer/requests/for-approval';

  static String serviceTransferRequestById(int id) =>
      '/v1/hr-service/service-transfer/request/$id';

  static const String serviceTransferApproval =
      '/v1/hr-service/service-transfer/approve';

  static const String serviceTransferReject =
      '/v1/hr-service/service-transfer/reject';

  static const String serviceTransferApprovalKpiData =
      '/v1/hr-service/service-transfer/analytics/approval-kpi-cards';

  static const String serviceTransferKpiData =
      '/v1/hr-service/service-transfer/analytics/kpi-cards';

  static String serviceTransferStatusBreakdown =
      '/v1/hr-service/service-transfer/analytics/status-breakdown';

  static String serviceTransferTrendBreakdown =
      '/v1/hr-service/service-transfer/analytics/trend-breakdown';

  static String serviceTransferApprovalStatusBreakdown =
      '/v1/hr-service/service-transfer/analytics/approval-status-breakdown';

  static String serviceTransferApprovalTrendBreakdown =
      '/v1/hr-service/service-transfer/analytics/approval-trend-breakdown';

  static const String serviceTransferEmployeesList =
      '/v1/hr-service/service-transfer/employees';

  static const String serviceTransferAssignEmployee =
      '/v1/hr-service/service-transfer/request/assign';

  static const String serviceTransferReplaceEmployee =
      '/v1/hr-service/service-transfer/request/replace-employee';

  static String serviceTransferChatById(int id) =>
      '/v1/hr-service/service-transfer/request/$id/chats';

  static String serviceTransferSendChatById(int id) =>
      '/v1/hr-service/service-transfer/request/$id/chat';

  static String serviceTransferAttachmentById(int id) =>
      '/v1/hr-service/service-transfer/request/$id/attachments';

  static String serviceTransferSendAttachmentById(int id) =>
      '/v1/hr-service/service-transfer/request/$id/attachment';

  /// training and development
  static const String assignTaskToEmployeeNewRequest =
      '/v1/it-service/assign-tasks-emp/request';
  static String assignTaskToEmployeeUsersList(int departmentId) =>
      '/v1/user-service/users/$departmentId';

  static const String assignTaskStatusBreakdown =
      '/v1/it-service/assign-tasks-emp/analytics/status-breakdown';
  static const String assignTaskTrendBreakdown =
      '/v1/it-service/assign-tasks-emp/analytics/trend-breakdown';

  static const String assignTaskKpiCards =
      '/v1/it-service/assign-tasks-emp/analytics/kpi-cards';

  static const String assignTaskApprovalKpiCards =
      '/v1/it-service/assign-tasks-emp/analytics/approvals/kpi-cards';

  /// Requests
  static const String assignTaskRequests =
      '/v1/it-service/assign-tasks-emp/requests';

  static const String assignTaskRequestsForApproval =
      '/v1/it-service/assign-tasks-emp/requests/for-approval';

  /// Single Request by ID
  static String assignTaskRequestById(int id) =>
      '/v1/it-service/assign-tasks-emp/request/$id';

  /// ------------------------------------------------------------
  /// Request to Book CAA Halls
  /// ------------------------------------------------------------

  /// Create Hall Request
  static const String bookCaaHallSendRequest = '/v1/hr-service/hall/request';

  /// Get My Requests
  static const String bookCaaHallGetRequests = '/v1/hr-service/hall/requests';

  /// Get Approval Requests
  static const String bookCaaHallGetActionItems =
      '/v1/hr-service/hall/requests/for-approval';

  /// Get Request By ID
  static String bookCaaHallRequestById(int requestId) =>
      '/v1/hr-service/hall/request/$requestId';

  /// ===================== AVAILABLE HALL APIs =====================

  /// Get Available Halls
  static const String bookCaaHallAvailableHalls =
      '/v1/hr-service/hall/halls/available';

  /// ===================== CHAT APIs =====================

  /// Send Chat
  static String bookCaaHallSendChatById(int requestId) =>
      '/v1/hr-service/hall/request/$requestId/chat';

  /// Get Chats
  static String bookCaaHallChatsById(int requestId) =>
      '/v1/hr-service/hall/request/$requestId/chats';

  static String bookCaaHallApprove = '/v1/hr-service/hall/request/approve';

  /// ===================== ATTACHMENT APIs =====================

  /// Send Attachment
  static String bookCaaHallSendAttachmentById(int requestId) =>
      '/v1/hr-service/hall/request/$requestId/attachment';

  /// Get Attachments
  static String bookCaaHallAttachmentsById(int requestId) =>
      '/v1/hr-service/hall/request/$requestId/attachments';

  /// ===================== KPI APIs =====================

  /// Request KPI Cards
  static const String bookCaaHallKpiCards =
      '/v1/hr-service/hall/analytics/kpi-cards';

  /// Approval KPI Cards
  static const String bookCaaHallApprovalKpiCards =
      '/v1/hr-service/hall/analytics/approvals/kpi-cards';

  /// ===================== STATUS BREAKDOWN APIs =====================

  /// Request Status Breakdown
  static const String bookCaaHallStatusBreakdown =
      '/v1/hr-service/hall/analytics/status-breakdown';

  /// Approval Status Breakdown
  static const String bookCaaHallApprovalStatusBreakdown =
      '/v1/hr-service/hall/analytics/approvals/status-breakdown';

  /// ===================== TREND BREAKDOWN APIs =====================

  /// Request Trend Breakdown
  static const String bookCaaHallTrendBreakdown =
      '/v1/hr-service/hall/analytics/trend-breakdown';

  /// Approval Trend Breakdown
  static const String bookCaaHallApprovalTrendBreakdown =
      '/v1/hr-service/hall/analytics/approvals/trend-breakdown';

  /// ------------------------------------------------------------
  /// Assign Task to Employee – Approval Analytics
  /// ------------------------------------------------------------

  static const String assignTaskApprovalStatusBreakdown =
      '/v1/it-service/assign-tasks-emp/analytics/approvals/status-breakdown';

  static const String assignTaskApprovalTrendBreakdown =
      '/v1/it-service/assign-tasks-emp/analytics/approvals/trend-breakdown';

  static String assignTaskChatById(int id) =>
      '/v1/it-service/assign-tasks-emp/request/$id/chats';
  static String assignTaskSendChatById(int id) =>
      '/v1/it-service/assign-tasks-emp/request/$id/chat';
  static String assignTaskAttachmentById(int id) =>
      '/v1/it-service/assign-tasks-emp/request/$id/attachments';
  static String assignTaskSendAttachmentById(int id) =>
      '/v1/it-service/assign-tasks-emp/request/$id/attachment';
  static String assignTaskSendInProgess(int id) =>
      '/v1/it-service/assign-tasks-emp/request/$id/status';
  static const String assignTaskComplete =
      '/v1/it-service/assign-tasks-emp/request/approve';

  /// followup reports
  ///
  /// ===================== FOLLOW UP REPORT APIs =====================

  /// ===================== REQUEST APIs =====================

  /// Create Follow Up Report Request
  static const String followUpReportSendRequest =
      '/v1/asset-affairs-service/follow-up-report/request';

  /// Get My Requests
  static const String followUpReportGetRequests =
      '/v1/asset-affairs-service/follow-up-report/requests';

  /// Get Approval Requests
  static const String followUpReportGetActionItems =
      '/v1/asset-affairs-service/follow-up-report/requests/for-approval';

  /// Get Request By ID
  static String followUpReportRequestById(int requestId) =>
      '/v1/asset-affairs-service/follow-up-report/request/$requestId';

  /// ===================== CHAT APIs =====================

  /// Send Chat
  static String followUpReportSendChatById(int requestId) =>
      '/v1/asset-affairs-service/follow-up-report/request/$requestId/chat';

  /// Get Chats
  static String followUpReportChatsById(int requestId) =>
      '/v1/asset-affairs-service/follow-up-report/request/$requestId/chats';

  /// ===================== KPI APIs =====================

  /// Request KPI Cards
  static const String followUpReportKpiCards =
      '/v1/asset-affairs-service/follow-up-report/analytics/kpi-cards';

  /// Approval KPI Cards
  static const String followUpReportApprovalKpiCards =
      '/v1/asset-affairs-service/follow-up-report/analytics/approvals/kpi-cards';

  /// ===================== STATUS BREAKDOWN APIs =====================

  /// Request Status Breakdown
  static const String followUpReportStatusBreakdown =
      '/v1/asset-affairs-service/follow-up-report/analytics/status-breakdown';

  /// Approval Status Breakdown
  static const String followUpReportApprovalStatusBreakdown =
      '/v1/asset-affairs-service/follow-up-report/analytics/approvals/status-breakdown';
  static String followUpReportApprove =
      '/v1/asset-affairs-service/follow-up-report/approve';

  /// ===================== TREND BREAKDOWN APIs =====================

  /// Request Trend Breakdown
  static const String followUpReportTrendBreakdown =
      '/v1/asset-affairs-service/follow-up-report/analytics/trend-breakdown';

  /// Approval Trend Breakdown
  static const String followUpReportApprovalTrendBreakdown =
      '/v1/asset-affairs-service/follow-up-report/analytics/approvals/trend-breakdown';

  /// ===================== ATTACHMENT APIs =====================

  /// Send Attachment
  static String followUpReportSendAttachmentById(int requestId) =>
      '/v1/asset-affairs-service/follow-up-report/request/$requestId/attachment';

  /// Get Attachments
  static String followUpReportAttachmentsById(int requestId) =>
      '/v1/asset-affairs-service/follow-up-report/request/$requestId/attachments';

  /// ===================== DUTY MISSION APIs =====================

  /// Create / Request Duty Mission
  static const String dutyMissionSendRequest = '/v1/hr-service/duty-mission';
  static const String dutyMissionGetRequest = '/v1/hr-service/duty-missions';
  static const String dutyMissionGetActionItems =
      '/v1/hr-service/duty-missions/for-approval';
  static const String dutyMissionUsers = '/v1/user-service/users';

  /// Get Duty Mission by ID
  static String dutyMissionRequestById(int id) =>
      '/v1/hr-service/duty-mission/$id';

  /// ===================== CHAT APIs =====================

  /// Get chats for a Duty Mission request
  static String dutyMissionChatsById(int id) =>
      '/v1/hr-service/duty-mission/request/$id/chats';

  /// Send chat message for a Duty Mission request
  static String dutyMissionSendChatById(int id) =>
      '/v1/hr-service/duty-mission/request/$id/chat';

  /// ===================== ATTACHMENT APIs (assumed standard) =====================

  /// Get attachments for Duty Mission request
  static String dutyMissionAttachmentsById(int id) =>
      '/v1/hr-service/duty-mission/request/$id/attachments';

  /// Upload attachment for Duty Mission request
  static String dutyMissionSendAttachmentById(int id) =>
      '/v1/hr-service/duty-mission/request/$id/attachment';

  /// ===================== STATUS / ACTION APIs (assumed standard) =====================

  /// Update Duty Mission status (approve / reject / in-progress etc.)
  static String dutyMissionUpdateStatusById(int id) =>
      '/v1/hr-service/duty-mission/request/$id/status';

  /// Approve Duty Mission request
  static const String dutyMissionApprove =
      '/v1/hr-service/duty-mission/approve';

  /// ===================== ANALYTICS APIs =====================

  /// KPI cards
  static const String dutyMissionKpiCards =
      '/v1/hr-service/analytics/duty-mission/kpi-cards';

  /// Status breakdown
  static const String dutyMissionStatusBreakdown =
      '/v1/hr-service/analytics/duty-mission/status-breakdown';

  /// Trend breakdown
  static const String dutyMissionTrendBreakdown =
      '/v1/hr-service/analytics/duty-mission/trend-breakdown';

  /// KPI cards
  static const String dutyMissionApprovalKpiCards =
      '/v1/hr-service/analytics/duty-mission-approvals/kpi-cards';

  /// Status breakdown
  static const String dutyMissionApprovalStatusBreakdown =
      '/v1/hr-service/analytics/duty-mission-approvals/status-breakdown';

  /// Trend breakdown
  static const String dutyMissionApprovalTrendBreakdown =
      '/v1/hr-service/analytics/duty-mission-approvals/trend-breakdown';

  static String dutyMissionChatById(int id) =>
      '/v1/hr-service/duty-mission/request/$id/chats';

  /// ===================== REQUEST FOR COVERAGE APIs =====================

  /// Create / Send Request for Coverage
  static const String requestForCoverageSendRequest =
      '/v1/hr-service/request-for-coverage/request-for-coverage-request';

  /// Get all Request for Coverage requests
  static const String requestForCoverageGetRequests =
      '/v1/hr-service/request-for-coverage/request-for-coverage-requests';

  /// Get approval list (For approvers)
  static const String requestForCoverageGetActionItems =
      '/v1/hr-service/request-for-coverage/request-for-coverage-requests/approvals';

  /// Get Request for Coverage by ID
  static String requestForCoverageRequestById(int requestId) =>
      '/v1/hr-service/request-for-coverage/request-for-coverage-request/$requestId';

  /// Approve / Reject Request for Coverage
  static const String requestForCoverageApprove =
      '/v1/hr-service/request-for-coverage/request-for-coverage-request/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String requestForCoverageSendChatById(int requestId) =>
      '/v1/hr-service/request-for-coverage/request-for-coverage-request/$requestId/chat';

  /// Get chats (GET)
  static String requestForCoverageChatsById(int requestId) =>
      '/v1/hr-service/request-for-coverage/request-for-coverage-request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Get attachments
  static String requestForCoverageAttachmentsById(int requestId) =>
      '/v1/hr-service/request-for-coverage/request-for-coverage-request/$requestId/attachments';

  /// ===================== ANALYTICS APIs =====================

  /// KPI cards
  static const String requestForCoverageKpiCards =
      '/v1/hr-service/request-for-coverage/request-for-coverage-request/analytics/kpi';

  /// Status breakdown
  static const String requestForCoverageStatusBreakdown =
      '/v1/hr-service/request-for-coverage/request-for-coverage-request/analytics/status-breakdown';

  /// Trend breakdown
  static const String requestForCoverageTrendBreakdown =
      '/v1/hr-service/request-for-coverage/request-for-coverage-request/analytics/trend-breakdown';

  /// ===================== APPROVAL ANALYTICS APIs =====================

  /// Approval KPI cards
  static const String requestForCoverageApprovalKpiCards =
      '/v1/hr-service/request-for-coverage/request-for-coverage-request/analytics/approvals/kpi';

  /// Approval status breakdown
  static const String requestForCoverageApprovalStatusBreakdown =
      '/v1/hr-service/request-for-coverage/request-for-coverage-request/analytics/approvals/status-breakdown';

  /// Approval Trend breakdown
  static const String requestForCoverageApprovalTrendBreakdown =
      '/v1/hr-service/request-for-coverage/request-for-coverage-request/analytics/approvals/trend-breakdown';

  /// ===================== REQUEST FOR TRAINING ROOM BOOKING APIs =====================

  /// Create / Send Request for Training Room Booking
  static const String requestForTrainingRoomBookingSendRequest =
      '/v1/hr-service/training-room-booking/training-room-booking-request';

  /// Get all Training Room Booking requests
  static const String requestForTrainingRoomBookingGetRequests =
      '/v1/hr-service/training-room-booking/training-room-booking-requests';

  /// Get approval list (For approvers)
  static const String requestForTrainingRoomBookingGetActionItems =
      '/v1/hr-service/training-room-booking/training-room-booking-requests/approvals';

  /// Get Training Room Booking request by ID
  static String requestForTrainingRoomBookingRequestById(int requestId) =>
      '/v1/hr-service/training-room-booking/training-room-booking-request/$requestId';

  /// Approve / Reject Training Room Booking request
  static const String requestForTrainingRoomBookingApprove =
      '/v1/hr-service/training-room-booking/training-room-booking-request/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String requestForTrainingRoomBookingSendChatById(int requestId) =>
      '/v1/hr-service/training-room-booking/training-room-booking-request/$requestId/chat';

  /// Get chats (GET)
  static String requestForTrainingRoomBookingChatsById(int requestId) =>
      '/v1/hr-service/training-room-booking/training-room-booking-request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Get attachments

  static String requestForTrainingRoomBookingSendAttachmentById(
    int requestId,
  ) =>
      '/v1/hr-service/request-for-training-room-booking/request-for-training-room-booking-request/$requestId/attachments';
  static String requestForTrainingRoomBookingAttachmentsById(int requestId) =>
      '/v1/hr-service/request-for-training-room-booking/request-for-training-room-booking-request/$requestId/attachments';

  /// ===================== ANALYTICS APIs =====================

  /// KPI cards
  static const String requestForTrainingRoomBookingKpiCards =
      '/v1/hr-service/training-room-booking/training-room-booking-request/analytics/kpi';
  static const String requestForTrainingRoomBookingApprovalsKpiCards =
      '/v1/hr-service/training-room-booking/training-room-booking-request/analytics/approvals/kpi';

  /// Status breakdown
  static const String requestForTrainingRoomBookingStatusBreakdown =
      '/v1/hr-service/training-room-booking/training-room-booking-request/analytics/status-breakdown';
  static const String requestForTrainingRoomBookingApprovalsStatusBreakdown =
      '/v1/hr-service/training-room-booking/training-room-booking-request/analytics/approvals/status-breakdown';

  /// Trend breakdown
  static const String requestForTrainingRoomBookingTrendBreakdown =
      '/v1/hr-service/training-room-booking/training-room-booking-request/analytics/trend-breakdown';
  static const String requestForTrainingRoomBookingApprovalsTrendBreakdown =
      '/v1/hr-service/training-room-booking/training-room-booking-request/analytics/approvals/trend-breakdown';

  /// ===================== ANNUAL TRAINING PLAN APIs =====================

  /// Create / Send Annual Training Plan request
  static const String annualTrainingPlanSendRequest =
      '/v1/hr-service/annual-training-plan/annual-training-plan-request';

  /// Get all Annual Training Plan requests
  static const String annualTrainingPlanGetRequests =
      '/v1/hr-service/annual-training-plan/annual-training-plan-requests';

  /// Get approval list (For approvers)
  static const String annualTrainingPlanGetActionItems =
      '/v1/hr-service/annual-training-plan/annual-training-plan-requests/approvals';

  /// Get Annual Training Plan request by ID
  static String annualTrainingPlanRequestById(int requestId) =>
      '/v1/hr-service/annual-training-plan/annual-training-plan-request/$requestId';

  /// Approve / Reject Annual Training Plan request
  static const String annualTrainingPlanApprove =
      '/v1/hr-service/annual-training-plan/annual-training-plan-request/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String annualTrainingPlanSendChatById(int requestId) =>
      '/v1/hr-service/annual-training-plan/annual-training-plan-request/$requestId/chat';

  /// Get chats (GET)
  static String annualTrainingPlanChatsById(int requestId) =>
      '/v1/hr-service/annual-training-plan/annual-training-plan-request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Send attachment
  static String annualTrainingPlanSendAttachmentById(int requestId) =>
      '/v1/hr-service/annual-training-plan/annual-training-plan-request/$requestId/attachment';

  /// Get attachments
  static String annualTrainingPlanAttachmentsById(int requestId) =>
      '/v1/hr-service/annual-training-plan/annual-training-plan-request/$requestId/attachments';

  /// ===================== ANALYTICS APIs =====================

  /// KPI cards
  static const String annualTrainingPlanKpiCards =
      '/v1/hr-service/annual-training-plan/annual-training-plan-request/analytics/kpi';

  static const String annualTrainingPlanApprovalsKpiCards =
      '/v1/hr-service/annual-training-plan/annual-training-plan-request/analytics/approvals/kpi';

  /// Status breakdown
  static const String annualTrainingPlanStatusBreakdown =
      '/v1/hr-service/annual-training-plan/annual-training-plan-request/analytics/status-breakdown';

  static const String annualTrainingPlanApprovalsStatusBreakdown =
      '/v1/hr-service/annual-training-plan/annual-training-plan-request/analytics/approvals/status-breakdown';

  /// Trend breakdown
  static const String annualTrainingPlanTrendBreakdown =
      '/v1/hr-service/annual-training-plan/annual-training-plan-request/analytics/trend-breakdown';

  static const String annualTrainingPlanApprovalsTrendBreakdown =
      '/v1/hr-service/annual-training-plan/annual-training-plan-request/analytics/approvals/trend-breakdown';

  /// ===================== TRAINING REQUEST APIs =====================

  static const String requestTrainingSendRequest =
      '/v1/hr-service/training/training-request';

  /// Get all Training requests
  static const String trainingRequestGetRequests =
      '/v1/hr-service/training/training-requests';

  static const String trainingRequestParticipants =
      '/v1/hr-service/annual-training-plan/annual-training-plan-requests/approved/participants';

  /// Get approval list (For approvers)
  static const String trainingRequestGetActionItems =
      '/v1/hr-service/training/training-request/approvals';

  /// Get Training request by ID
  static String trainingRequestById(int requestId) =>
      '/v1/hr-service/training/training-request/$requestId';

  /// Approve / Reject Training request
  static const String trainingRequestApprove =
      '/v1/hr-service/training/training-request/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String trainingRequestSendChatById(int requestId) =>
      '/v1/hr-service/training/training-request/$requestId/chat';

  /// Get chats (GET)
  static String trainingRequestChatsById(int requestId) =>
      '/v1/hr-service/training/training-request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Send attachment
  static String trainingRequestSendAttachmentById(int requestId) =>
      '/v1/hr-service/training/training-request/$requestId/attachment';

  /// Get attachments
  static String trainingRequestAttachmentsById(int requestId) =>
      '/v1/hr-service/training/training-request/$requestId/attachments';

  /// ===================== ANALYTICS APIs =====================

  /// KPI cards
  static const String trainingRequestKpiCards =
      '/v1/hr-service/training/training-request/analytics/kpi';

  /// Status breakdown
  static const String trainingRequestStatusBreakdown =
      '/v1/hr-service/training/training-request/analytics/status-breakdown';

  /// Trend breakdown
  static const String trainingRequestTrendBreakdown =
      '/v1/hr-service/training/training-request/analytics/trend-breakdown';

  /// Approvals KPI cards
  static const String trainingRequestApprovalsKpiCards =
      '/v1/hr-service/training/training-request/analytics/approvals/kpi';

  /// Approvals Status breakdown
  static const String trainingRequestApprovalsStatusBreakdown =
      '/v1/hr-service/training/training-request/analytics/approvals/status-breakdown';

  /// Approvals Trend breakdown
  static const String trainingRequestApprovalsTrendBreakdown =
      '/v1/hr-service/training/training-request/analytics/approvals/trend-breakdown';

  /// ===================== STUDY LEAVE APIs =====================

  /// Create / Send Study Leave request
  static const String studyLeaveSendRequest =
      '/v1/hr-service/study-leave/study-leave-request';

  /// Get all Study Leave requests
  static const String studyLeaveGetRequests =
      '/v1/hr-service/study-leave/study-leave-requests';

  /// Get approval list (For approvers)
  static const String studyLeaveGetActionItems =
      '/v1/hr-service/study-leave/study-leave-request/approvals';

  /// Get Study Leave request by ID
  static String studyLeaveById(int requestId) =>
      '/v1/hr-service/study-leave/study-leave-request/$requestId';

  /// Approve / Reject Study Leave request
  static const String studyLeaveApprove =
      '/v1/hr-service/study-leave/study-leave-request/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String studyLeaveSendChatById(int requestId) =>
      '/v1/hr-service/study-leave/study-leave-request/$requestId/chat';

  /// Get chats (GET)
  static String studyLeaveChatsById(int requestId) =>
      '/v1/hr-service/study-leave/study-leave-request/$requestId/chat';

  /// ===================== ATTACHMENT APIs =====================

  /// Send attachment
  static String studyLeaveSendAttachmentById(int requestId) =>
      '/v1/hr-service/study-leave/study-leave-request/$requestId/attachment';

  /// Get attachments
  static String studyLeaveAttachmentsById(int requestId) =>
      '/v1/hr-service/study-leave/study-leave-request/$requestId/attachments';

  /// ===================== ANALYTICS APIs =====================

  /// KPI cards
  static const String studyLeaveKpiCards =
      '/v1/hr-service/study-leave/study-leave-request/analytics/kpi';

  /// Status breakdown
  static const String studyLeaveStatusBreakdown =
      '/v1/hr-service/study-leave/study-leave-request/analytics/status-breakdown';

  /// Trend breakdown (kept pattern consistent even if not shared yet)
  static const String studyLeaveTrendBreakdown =
      '/v1/hr-service/study-leave/study-leave-request/analytics/trend-breakdown';

  /// Approvals KPI cards
  static const String studyLeaveApprovalsKpiCards =
      '/v1/hr-service/study-leave/study-leave-request/analytics/approvals/kpi';

  /// Approvals Status breakdown
  static const String studyLeaveApprovalsStatusBreakdown =
      '/v1/hr-service/study-leave/study-leave-request/analytics/approvals/status-breakdown';

  /// Approvals Trend breakdown
  static const String studyLeaveApprovalsTrendBreakdown =
      '/v1/hr-service/study-leave/study-leave-request/analytics/approvals/trend-breakdown';
  static const String studyLeaveLocations = '/v1/user-service/location/list';

  /// ===================== JOB TRANSFER APIs =====================

  /// Create / Send Job Transfer request (POST)
  static const String jobTransferSendRequest =
      '/v1/hr-service/job-transfer/requests';

  /// Get Job Transfer request by ID
  static String jobTransferRequestById(int requestId) =>
      '/v1/hr-service/job-transfer/requests/$requestId';

  /// Get approval list (For approvers)
  static const String jobTransferGetActionItems =
      '/v1/hr-service/job-transfer/requests/approval';
  static const String jobTransferGetRequests =
      '/v1/hr-service/job-transfer/requests';

  /// ===================== JOB TRANSFER ANALYTICS APIs =====================

  /// KPI cards (Approval dashboard)
  static const String jobTransferApprovalKpiCards =
      '/v1/hr-service/job-transfer/analytics/approval/kpi-cards';

  static const String jobTransferKpiCards =
      '/v1/hr-service/job-transfer/analytics/kpi-cards';

  /// Status breakdown
  static const String jobTransferStatusBreakdown =
      '/v1/hr-service/job-transfer/analytics/status-breakdown';

  /// Trend breakdown
  static const String jobTransferTrendBreakdown =
      '/v1/hr-service/job-transfer/analytics/trend-breakdown';

  static const String jobTransferApprovalTrendBreakdown =
      '/v1/hr-service/job-transfer/analytics/approval/trend-breakdown';

  /// Approvals Status breakdown
  static const String jobTransferApprovalStatusBreakdown =
      '/v1/hr-service/job-transfer/analytics/approval/status-breakdown';

  /// ===================== ASSIGN / APPROVAL APIs =====================

  /// Assign Job Transfer request
  static const String jobTransferAssign = '/v1/hr-service/job-transfer/assign';

  /// Approve Job Transfer request
  static const String jobTransferApprove =
      '/v1/hr-service/job-transfer/approve';

  /// Reject Job Transfer request
  static const String jobTransferReject = '/v1/hr-service/job-transfer/reject';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String jobTransferSendChatById(int requestId) =>
      '/v1/hr-service/job-transfer/requests/$requestId/chats';

  /// Get chats (GET)
  static String jobTransferChatsById(int requestId) =>
      '/v1/hr-service/job-transfer/requests/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Upload attachment for request (POST)
  static String jobTransferSendAttachmentById(int requestId) =>
      '/v1/hr-service/job-transfer/requests/$requestId/attachments';

  /// Get/Delete attachment by attachment ID
  static String jobTransferAttachmentById(int attachmentId) =>
      '/v1/hr-service/job-transfer/attachments/$attachmentId';

  /// ===================== PAYMENT FOR SHIFT ALLOWANCE APIs =====================

  /// Create / Send Payment For Shift Allowance request (POST)
  static const String paymentForShiftAllowanceSendRequest =
      '/v1/hr-service/shift-allowance/requests';

  /// Get Payment For Shift Allowance request by ID
  static String paymentForShiftAllowanceRequestById(int requestId) =>
      '/v1/hr-service/shift-allowance/requests/$requestId';

  /// Get approval list (For approvers)
  static const String paymentForShiftAllowanceGetActionItems =
      '/v1/hr-service/shift-allowance/requests/approval';

  /// Get all requests
  static const String paymentForShiftAllowanceGetRequests =
      '/v1/hr-service/shift-allowance/requests';

  /// ===================== PAYMENT FOR SHIFT ALLOWANCE ANALYTICS APIs =====================

  /// KPI cards (Approval dashboard)
  static const String paymentForShiftAllowanceApprovalKpiCards =
      '/v1/hr-service/shift-allowance/analytics/approval/kpi-cards';

  static const String paymentForShiftAllowanceKpiCards =
      '/v1/hr-service/shift-allowance/analytics/kpi-cards';

  /// Status breakdown
  static const String paymentForShiftAllowanceStatusBreakdown =
      '/v1/hr-service/shift-allowance/analytics/status-breakdown';

  /// Trend breakdown
  static const String paymentForShiftAllowanceTrendBreakdown =
      '/v1/hr-service/shift-allowance/analytics/trend-breakdown';

  static const String paymentForShiftAllowanceApprovalTrendBreakdown =
      '/v1/hr-service/shift-allowance/analytics/approval/trend-breakdown';

  /// Approvals Status breakdown
  static const String paymentForShiftAllowanceApprovalStatusBreakdown =
      '/v1/hr-service/shift-allowance/analytics/approval/status-breakdown';

  /// ===================== ASSIGN / APPROVAL APIs =====================

  /// Assign Payment For Shift Allowance request
  static const String paymentForShiftAllowanceAssign =
      '/v1/hr-service/shift-allowance/assign';

  /// Approve Payment For Shift Allowance request
  static const String paymentForShiftAllowanceApprove =
      '/v1/hr-service/shift-allowance/approve';

  /// Reject Payment For Shift Allowance request
  static const String paymentForShiftAllowanceReject =
      '/v1/hr-service/shift-allowance/reject';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String paymentForShiftAllowanceSendChatById(int requestId) =>
      '/v1/hr-service/shift-allowance-leave/requests/$requestId/chat';

  /// Get chats (GET)
  static String paymentForShiftAllowanceChatsById(int requestId) =>
      '/v1/hr-service/shift-allowance/requests/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Upload attachment for request (POST)
  static String paymentForShiftAllowanceSendAttachmentById(int requestId) =>
      '/v1/hr-service/shift-allowance/requests/$requestId/attachment';

  /// Get/Delete attachment by attachment ID
  static String paymentForShiftAllowanceAttachmentById(int attachmentId) =>
      '/v1/hr-service/shift-allowance/attachments/$attachmentId';
  static const String paymentForShiftAllowanceAssignEmployees =
      '/v1/hr-service/shift-allowance/employees';

  /// ===================== PAYMENT OF CASH ALLOWANCE FOR LEAVE APIs =====================

  /// Create / Send Payment Of Cash Allowance For Leave request (POST)
  static const String paymentofCashAllowanceForLeaveSendRequest =
      '/v1/hr-service/cash-allowance-leave/request';

  /// Get Payment Of Cash Allowance For Leave request by ID
  static String paymentofCashAllowanceForLeaveRequestById(int requestId) =>
      '/v1/hr-service/cash-allowance-leave/request/$requestId';

  /// Get approval list (For approvers)
  static const String paymentofCashAllowanceForLeaveGetActionItems =
      '/v1/hr-service/cash-allowance-leave/approvals';

  /// Get all requests
  static const String paymentofCashAllowanceForLeaveGetRequests =
      '/v1/hr-service/cash-allowance-leave/requests';

  /// ===================== PAYMENT OF CASH ALLOWANCE FOR LEAVE ANALYTICS APIs =====================

  /// KPI cards (Approval dashboard)
  static const String paymentofCashAllowanceForLeaveApprovalKpiCards =
      '/v1/hr-service/cash-allowance-leave/analytics/approvals/kpi';

  static const String paymentofCashAllowanceForLeaveKpiCards =
      '/v1/hr-service/cash-allowance-leave/analytics/my-requests/kpi';

  /// Status breakdown
  static const String paymentofCashAllowanceForLeaveStatusBreakdown =
      '/v1/hr-service/cash-allowance-leave/analytics/my-requests/status-breakdown';

  /// Trend breakdown
  static const String paymentofCashAllowanceForLeaveTrendBreakdown =
      '/v1/hr-service/cash-allowance-leave/analytics/my-requests/trend-breakdown';

  static const String paymentofCashAllowanceForLeaveApprovalTrendBreakdown =
      '/v1/hr-service/cash-allowance-leave/analytics/approvals/trend-breakdown';

  /// Approvals Status breakdown
  static const String paymentofCashAllowanceForLeaveApprovalStatusBreakdown =
      '/v1/hr-service/cash-allowance-leave/analytics/approvals/status-breakdown';

  /// ===================== ASSIGN / APPROVAL APIs =====================

  /// Assign Payment Of Cash Allowance For Leave request
  static const String paymentofCashAllowanceForLeaveAssign =
      '/v1/hr-service/cash-allowance-leave/assign';

  /// Approve Payment Of Cash Allowance For Leave request
  static const String paymentofCashAllowanceForLeaveApprove =
      '/v1/hr-service/cash-allowance-leave/approve';

  /// Reject Payment Of Cash Allowance For Leave request
  static const String paymentofCashAllowanceForLeaveReject =
      '/v1/hr-service/cash-allowance-leave/reject';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String paymentofCashAllowanceForLeaveSendChatById(int requestId) =>
      '/v1/hr-service/cash-allowance-leave/request/$requestId/chat';

  /// Get chats (GET)
  static String paymentofCashAllowanceForLeaveChatsById(int requestId) =>
      '/v1/hr-service/cash-allowance-leave/request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Upload attachment for request (POST)
  static String paymentofCashAllowanceForLeaveSendAttachmentById(
    int requestId,
  ) => '/v1/hr-service/cash-allowance-leave/request/$requestId/attachment';

  /// Get/Delete attachment by attachment ID
  static String paymentofCashAllowanceForLeaveAttachmentById(
    int attachmentId,
  ) => '/v1/hr-service/cash-allowance-leave/request/$attachmentId/attachments';

  static const String paymentofCashAllowanceForLeaveAssignEmployees =
      '/v1/hr-service/cash-allowance-leave/employees';

  /// ===================== REQUIRED NEW RESOURCE ANALYTICS APIs =====================
  ///
  static const String sendRequestForRequiresNewResource =
      '/v1/hr-service/new-resource/request';

  /// Get approval list (For approvers)
  static const String requiredNewResourceGetActionItems =
      '/v1/hr-service/new-resource/requests/approval';

  /// Get all requests
  static const String requiredNewResourceGetRequests =
      '/v1/hr-service/new-resource/requests';

  static String requiredNewResourceRequestById(int requestId) =>
      '/v1/hr-service/new-resource/request/$requestId';

  /// KPI cards (Approval dashboard)
  static const String requiredNewResourceApprovalKpiCards =
      '/v1/hr-service/new-resource/analytics/approval-kpi-cards';

  static const String requiredNewResourceKpiCards =
      '/v1/hr-service/new-resource/analytics/kpi-cards';

  /// Status breakdown
  static const String requiredNewResourceStatusBreakdown =
      '/v1/hr-service/new-resource/analytics/status-breakdown';

  /// Trend breakdown
  static const String requiredNewResourceTrendBreakdown =
      '/v1/hr-service/new-resource/analytics/trend-breakdown';

  static const String requiredNewResourceApprovalTrendBreakdown =
      '/v1/hr-service/new-resource/analytics/approval-trend-breakdown';

  /// Approvals Status breakdown
  static const String requiredNewResourceApprovalStatusBreakdown =
      '/v1/hr-service/new-resource/analytics/approval-status-breakdown';

  /// ===================== ASSIGN / APPROVAL APIs =====================

  /// Assign Required New Resource request
  static const String requiredNewResourceAssign =
      '/v1/hr-service/new-resource/request/assign';

  /// Approve Required New Resource request
  static const String requiredNewResourceApprove =
      '/v1/hr-service/new-resource/request/approve-reject';

  /// Reject Required New Resource request
  static const String requiredNewResourceReject =
      '/v1/hr-service/new-resource/request/approve-reject';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String requiredNewResourceSendChatById(int requestId) =>
      '/v1/hr-service/new-resource/request/chat';

  /// Get chats (GET)
  static String requiredNewResourceChatsById(int requestId) =>
      '/v1/hr-service/new-resource/request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Upload attachment for request (POST)
  static String requiredNewResourceSendAttachmentById(int requestId) =>
      '/v1/hr-service/new-resource/request/attachment';

  /// Get/Delete attachment by attachment ID
  static String requiredNewResourceAttachmentById(int attachmentId) =>
      '/v1/hr-service/new-resource/request/$attachmentId/attachments';

  static const String requiredNewResourceAssignEmployees =
      '/v1/hr-service/new-resource/employees';

  static const String requiredNewResourceGradeList =
      '/v1/user-service/financial-grade/list';

  /// ===================== PROMOTION ANALYTICS APIs =====================
  ///

  static const String sendRequestForPromotion =
      '/v1/hr-service/promotion/request';

  /// Get approval list (For approvers)
  static const String promotionGetActionItems =
      '/v1/hr-service/promotion/approvals';

  /// Get all requests
  static const String promotionGetRequests =
      '/v1/hr-service/promotion/requests';

  static String promotionRequestById(int requestId) =>
      '/v1/hr-service/promotion/request/$requestId';

  /// KPI cards (Approval dashboard)
  static const String promotionApprovalKpiCards =
      '/v1/hr-service/promotion/analytics/approvals/kpi';

  static const String promotionKpiCards =
      '/v1/hr-service/promotion/analytics/my-requests/kpi';

  /// Status breakdown
  static const String promotionStatusBreakdown =
      '/v1/hr-service/promotion/analytics/status-breakdown';

  /// Trend breakdown
  static const String promotionTrendBreakdown =
      '/v1/hr-service/promotion/analytics/trend-breakdown';

  static const String promotionApprovalTrendBreakdown =
      '/v1/hr-service/promotion/analytics/approval-trend-breakdown';

  /// Approvals Status breakdown
  static const String promotionApprovalStatusBreakdown =
      '/v1/hr-service/promotion/analytics/approval-status-breakdown';

  /// ===================== ASSIGN / APPROVAL APIs =====================

  /// Assign Promotion request
  static const String promotionAssign = '/v1/hr-service/promotion/assign';

  /// Approve Promotion request
  static const String promotionApprove = '/v1/hr-service/promotion/approve';

  /// Reject Promotion request
  static const String promotionReject = '/v1/hr-service/promotion/reject';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String promotionSendChatById(int requestId) =>
      '/v1/hr-service/promotion/request/chat';

  /// Get chats (GET)
  static String promotionChatsById(int requestId) =>
      '/v1/hr-service/promotion/request/$requestId/chat';

  /// ===================== ATTACHMENT APIs =====================

  /// Upload attachment for request (POST)
  static String promotionSendAttachmentById(int requestId) =>
      '/v1/hr-service/promotion/request/attachment';

  /// Get/Delete attachment by attachment ID
  static String promotionAttachmentById(int attachmentId) =>
      '/v1/hr-service/promotion/request/$attachmentId/attachments';

  static const String promotionAssignEmployees =
      '/v1/hr-service/promotion/employees';

  static const String promotionGradeList =
      '/v1/user-service/financial-grade/list';

  /// ===================== ANNUAL INCREMENT ANALYTICS APIs =====================
  ///

  static const String sendRequestForAnnualIncrement =
      '/v1/hr-service/annual-increment/request';

  /// Get approval list (For approvers)
  static const String annualIncrementGetActionItems =
      '/v1/hr-service/annual-increment/requests/approval';

  /// Get all requests
  static const String annualIncrementGetRequests =
      '/v1/hr-service/annual-increment/requests';

  static String annualIncrementRequestById(int requestId) =>
      '/v1/hr-service/annual-increment/request/$requestId';

  /// KPI cards (Approval dashboard)
  static const String annualIncrementApprovalKpiCards =
      '/v1/hr-service/annual-increment/analytics/approval-kpi-cards';

  static const String annualIncrementKpiCards =
      '/v1/hr-service/annual-increment/analytics/kpi-cards';

  /// Status breakdown
  static const String annualIncrementStatusBreakdown =
      '/v1/hr-service/annual-increment/analytics/status-breakdown';

  /// Trend breakdown
  static const String annualIncrementTrendBreakdown =
      '/v1/hr-service/annual-increment/analytics/trend-breakdown';

  static const String annualIncrementApprovalTrendBreakdown =
      '/v1/hr-service/annual-increment/analytics/approval-trend-breakdown';

  /// Approvals Status breakdown
  static const String annualIncrementApprovalStatusBreakdown =
      '/v1/hr-service/annual-increment/analytics/approval-status-breakdown';

  /// ===================== ASSIGN / APPROVAL APIs =====================

  /// Assign Annual Increment request
  static const String annualIncrementAssign =
      '/v1/hr-service/annual-increment/assign';

  /// Approve Annual Increment request
  static const String annualIncrementApprove =
      '/v1/hr-service/annual-increment/request/approve-reject';

  /// Reject Annual Increment request
  static const String annualIncrementReject =
      '/v1/hr-service/annual-increment/request/approve-reject';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String annualIncrementSendChatById(int requestId) =>
      '/v1/hr-service/annual-increment/request/chat';

  /// Get chats (GET)
  static String annualIncrementChatsById(int requestId) =>
      '/v1/hr-service/annual-increment/request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Upload attachment for request (POST)
  static String annualIncrementSendAttachmentById(int requestId) =>
      '/v1/hr-service/annual-increment/request/attachment';

  /// Get/Delete attachment by attachment ID
  static String annualIncrementAttachmentById(int attachmentId) =>
      '/v1/hr-service/annual-increment/request/$attachmentId/attachments';

  static const String annualIncrementAssignEmployees =
      '/v1/hr-service/annual-increment/employees';

  static const String annualIncrementGradeList =
      '/v1/user-service/financial-grade/list';

  /// ===================== SKILLS ENHANCEMENT ANALYTICS APIs =====================

  /// Send Request
  static const String sendRequestForSkillsEnhancement =
      '/v1/hr-service/skills-enhancement/request';

  /// Get approval list (For approvers)
  static const String skillsEnhancementGetActionItems =
      '/v1/hr-service/skills-enhancement/approvals';

  /// Get all requests
  static const String skillsEnhancementGetRequests =
      '/v1/hr-service/skills-enhancement/requests';

  static String skillsEnhancementRequestById(int requestId) =>
      '/v1/hr-service/skills-enhancement/request/$requestId';

  /// ===================== KPI APIs =====================

  /// KPI cards (General)
  static const String skillsEnhancementKpiCards =
      '/v1/hr-service/skills-enhancement/analytics/kpi-cards';

  /// Approval KPI cards (If separate dashboard exists)
  static const String skillsEnhancementApprovalKpiCards =
      '/v1/hr-service/skills-enhancement/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  static const String skillsEnhancementStatusBreakdown =
      '/v1/hr-service/skills-enhancement/analytics/status-breakdown';

  /// Approval Status breakdown
  static const String skillsEnhancementApprovalStatusBreakdown =
      '/v1/hr-service/skills-enhancement/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  static const String skillsEnhancementTrendBreakdown =
      '/v1/hr-service/skills-enhancement/analytics/trend-breakdown';

  /// Approval Trend breakdown
  static const String skillsEnhancementApprovalTrendBreakdown =
      '/v1/hr-service/skills-enhancement/analytics/approval/trend-breakdown';

  /// ===================== ASSIGN / APPROVAL APIs =====================

  /// Assign Skills Enhancement request
  static const String skillsEnhancementAssign =
      '/v1/hr-service/skills-enhancement/assign';

  /// Approve Skills Enhancement request
  static const String skillsEnhancementApprove =
      '/v1/hr-service/skills-enhancement/approve';

  /// Reject Skills Enhancement request
  static const String skillsEnhancementReject =
      '/v1/hr-service/skills-enhancement/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String skillsEnhancementSendChatById(int requestId) =>
      '/v1/hr-service/skills-enhancement/request/$requestId/chat';

  /// Get chats (GET)
  static String skillsEnhancementChatsById(int requestId) =>
      '/v1/hr-service/skills-enhancement/request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Upload attachment for request (POST)
  static String skillsEnhancementSendAttachmentById(int requestId) =>
      '/v1/hr-service/skills-enhancement/request/$requestId/attachment';

  /// Get/Delete attachment by attachment ID
  static String skillsEnhancementAttachmentById(int attachmentId) =>
      '/v1/hr-service/skills-enhancement/request/$attachmentId/attachments';

  /// ===================== MASTER DATA =====================

  static const String skillsEnhancementAssignEmployees =
      '/v1/hr-service/skills-enhancement/employees';

  static const String skillsEnhancementGradeList =
      '/v1/user-service/financial-grade/list';

  /// ===================== REQUEST APIs =====================

  /// Send Request
  static const String sendRequestForPerformanceManagement =
      '/v1/hr-service/performance-management/request';

  /// Get approval list (For approvers)
  static const String performanceManagementGetActionItems =
      '/v1/hr-service/performance-management/requests/approval';

  /// Get all requests
  static const String performanceManagementGetRequests =
      '/v1/hr-service/performance-management/requests';

  static String performanceManagementRequestById(int requestId) =>
      '/v1/hr-service/performance-management/requests/$requestId';

  static String performanceManagementGoalsRating(int requestId) =>
      '/v1/hr-service/performance-management/requests/$requestId/goals/rating';

  /// ===================== KPI APIs =====================

  /// KPI cards (General)
  static const String performanceManagementKpiCards =
      '/v1/hr-service/performance-management/analytics/kpi-cards';

  /// Approval KPI cards
  static const String performanceManagementApprovalKpiCards =
      '/v1/hr-service/performance-management/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  static const String performanceManagementStatusBreakdown =
      '/v1/hr-service/performance-management/analytics/status-breakdown';

  /// Approval Status breakdown
  static const String performanceManagementApprovalStatusBreakdown =
      '/v1/hr-service/performance-management/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  static const String performanceManagementTrendBreakdown =
      '/v1/hr-service/performance-management/analytics/trend-breakdown';

  /// Approval Trend breakdown
  static const String performanceManagementApprovalTrendBreakdown =
      '/v1/hr-service/performance-management/analytics/approval/trend-breakdown';

  /// ===================== ASSIGN / APPROVAL APIs =====================

  /// Assign Performance Management request
  static const String performanceManagementAssign =
      '/v1/hr-service/performance-management/assign';

  /// Approve Performance Management request
  static const String performanceManagementApprove =
      '/v1/hr-service/performance-management/approve';

  /// Reject Performance Management request
  static const String performanceManagementReject =
      '/v1/hr-service/performance-management/request/approve-reject';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String performanceManagementSendChatById(int requestId) =>
      '/v1/hr-service/performance-management/requests/$requestId/chat';

  /// Get chats (GET)
  static String performanceManagementChatsById(int requestId) =>
      '/v1/hr-service/performance-management/requests/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Upload attachment for request (POST)
  static String performanceManagementSendAttachmentById(int requestId) =>
      '/v1/hr-service/performance-management/requests/$requestId/attachment';

  /// Get/Delete attachment by attachment ID
  static String performanceManagementAttachmentById(int attachmentId) =>
      '/v1/hr-service/performance-management/requests/$attachmentId/attachments';
  static const String performanceManagementGoalsByCycle =
      '/v1/hr-service/performance-management/master/goals/by-cycle';

  /// ===================== REQUEST APIs =====================

  /// Send Request
  static const String sendRequestForHumanResourceAnnualPlanning =
      '/v1/hr-service/human-resource-annual-planning/request';

  /// Get approval list (For approvers)
  static const String humanResourceAnnualPlanningGetActionItems =
      '/v1/hr-service/human-resource-annual-planning/approvals';

  /// Get all requests
  static const String humanResourceAnnualPlanningGetRequests =
      '/v1/hr-service/human-resource-annual-planning/requests';

  static String humanResourceAnnualPlanningRequestById(int requestId) =>
      '/v1/hr-service/human-resource-annual-planning/request/$requestId';

  /// ===================== KPI APIs =====================

  /// KPI cards (General)
  static const String humanResourceAnnualPlanningKpiCards =
      '/v1/hr-service/human-resource-annual-planning/analytics/kpi-cards';

  /// Approval KPI cards
  static const String humanResourceAnnualPlanningApprovalKpiCards =
      '/v1/hr-service/human-resource-annual-planning/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  static const String humanResourceAnnualPlanningStatusBreakdown =
      '/v1/hr-service/human-resource-annual-planning/analytics/status-breakdown';

  /// Approval Status breakdown
  static const String humanResourceAnnualPlanningApprovalStatusBreakdown =
      '/v1/hr-service/human-resource-annual-planning/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  static const String humanResourceAnnualPlanningTrendBreakdown =
      '/v1/hr-service/human-resource-annual-planning/analytics/trend-breakdown';

  /// Approval Trend breakdown
  static const String humanResourceAnnualPlanningApprovalTrendBreakdown =
      '/v1/hr-service/human-resource-annual-planning/analytics/approval/trend-breakdown';

  /// ===================== ASSIGN / APPROVAL APIs =====================

  /// Assign request
  static const String humanResourceAnnualPlanningAssign =
      '/v1/hr-service/human-resource-annual-planning/assign';

  /// Approve request
  static const String humanResourceAnnualPlanningApprove =
      '/v1/hr-service/human-resource-annual-planning/approve';

  /// Reject request
  static const String humanResourceAnnualPlanningReject =
      '/v1/hr-service/human-resource-annual-planning/request/approve-reject';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String humanResourceAnnualPlanningSendChatById(int requestId) =>
      '/v1/hr-service/human-resource-annual-planning/request/$requestId/chat';

  /// Get chats (GET)
  static String humanResourceAnnualPlanningChatsById(int requestId) =>
      '/v1/hr-service/human-resource-annual-planning/request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Upload attachment for request (POST)
  static String humanResourceAnnualPlanningSendAttachmentById(int requestId) =>
      '/v1/hr-service/human-resource-annual-planning/request/$requestId/attachment';

  /// Get/Delete attachment by attachment ID
  static String humanResourceAnnualPlanningAttachmentById(int attachmentId) =>
      '/v1/hr-service/human-resource-annual-planning/request/$attachmentId/attachments';

  /// ===================== REQUEST APIs =====================

  /// Send Request
  static const String sendRequestForAccommodationinMuscatGovernorate =
      '/v1/asset-affairs-service/accommodation-request/request';

  /// Get approval list (For approvers)
  static const String accommodationinMuscatGovernorateGetActionItems =
      '/v1/asset-affairs-service/accommodation-request/requests/for-approval';

  /// Get all requests
  static const String accommodationinMuscatGovernorateGetRequests =
      '/v1/asset-affairs-service/accommodation-request/requests';

  static String accommodationinMuscatGovernorateRequestById(int requestId) =>
      '/v1/asset-affairs-service/accommodation-request/request/$requestId';

  /// ===================== KPI APIs =====================

  /// KPI cards (General)
  static const String accommodationinMuscatGovernorateKpiCards =
      '/v1/asset-affairs-service/accommodation-request/analytics/kpi-cards';

  /// Approval KPI cards
  static const String accommodationinMuscatGovernorateApprovalKpiCards =
      '/v1/asset-affairs-service/accommodation-request/analytics/approval-kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  static const String accommodationinMuscatGovernorateStatusBreakdown =
      '/v1/asset-affairs-service/accommodation-request/analytics/status-breakdown';

  /// Approval Status breakdown
  static const String accommodationinMuscatGovernorateApprovalStatusBreakdown =
      '/v1/asset-affairs-service/accommodation-request/analytics/approval-status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  static const String accommodationinMuscatGovernorateTrendBreakdown =
      '/v1/asset-affairs-service/accommodation-request/analytics/trend-breakdown';

  /// Approval Trend breakdown
  static const String accommodationinMuscatGovernorateApprovalTrendBreakdown =
      '/v1/asset-affairs-service/accommodation-request/analytics/approval/trend-breakdown';

  /// ===================== ASSIGN / APPROVAL APIs =====================

  /// Assign request
  static const String accommodationinMuscatGovernorateAssign =
      '/v1/asset-affairs-service/accommodation-request/assign';

  /// Approve request
  static const String accommodationinMuscatGovernorateApprove =
      '/v1/asset-affairs-service/accommodation-request/approve';

  /// Reject request
  static const String accommodationinMuscatGovernorateReject =
      '/v1/asset-affairs-service/accommodation-request/request/approve-reject';

  /// ===================== CHAT APIs =====================

  /// Send chat message (POST)
  static String accommodationinMuscatGovernorateSendChatById(int requestId) =>
      '/v1/asset-affairs-service/accommodation-request/request/$requestId/chat';

  /// Get chats (GET)
  static String accommodationinMuscatGovernorateChatsById(int requestId) =>
      '/v1/asset-affairs-service/accommodation-request/request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Upload attachment for request (POST)
  static String accommodationinMuscatGovernorateSendAttachmentById(
    int requestId,
  ) =>
      '/v1/asset-affairs-service/accommodation-request/request/$requestId/attachment';

  /// Get/Delete attachment by attachment ID
  static String accommodationinMuscatGovernorateAttachmentById(
    int attachmentId,
  ) =>
      '/v1/asset-affairs-service/accommodation-request/request/$attachmentId/attachments';

  /// ===================== REQUEST APIs =====================

  /// Send Request
  static const String sendRequestForResidentalUnitRental =
      '/v1/asset-affairs-service/residential-unit-rental/request';

  /// Get my requests
  static const String residentalUnitRentalGetRequests =
      '/v1/asset-affairs-service/residential-unit-rental/requests';

  /// Get all requests (no user filter)
  static const String residentalUnitRentalGetAllRequests =
      '/v1/asset-affairs-service/residential-unit-rental/requests/all';

  /// Get approval list (For approvers)
  static const String residentalUnitRentalGetActionItems =
      '/v1/asset-affairs-service/residential-unit-rental/requests/for-approval';

  /// Get request by ID
  static String residentalUnitRentalRequestById(int requestId) =>
      '/v1/asset-affairs-service/residential-unit-rental/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String residentalUnitRentalApprove =
      '/v1/asset-affairs-service/residential-unit-rental/approve';

  /// ===================== CHAT APIs =====================

  static String residentalUnitRentalSendChatById(int requestId) =>
      '/v1/asset-affairs-service/residential-unit-rental/request/$requestId/chat';

  static String residentalUnitRentalChatsById(int requestId) =>
      '/v1/asset-affairs-service/residential-unit-rental/request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  static String residentalUnitRentalSendAttachmentById(int requestId) =>
      '/v1/asset-affairs-service/residential-unit-rental/request/$requestId/attachment';

  static String residentalUnitRentalAttachmentsById(int requestId) =>
      '/v1/asset-affairs-service/residential-unit-rental/request/$requestId/attachments';

  /// ===================== KPI APIs =====================

  static const String residentalUnitRentalKpiCards =
      '/v1/asset-affairs-service/residential-unit-rental/analytics/kpi-cards';

  static const String residentalUnitRentalApprovalKpiCards =
      '/v1/asset-affairs-service/residential-unit-rental/analytics/approval-kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  static const String residentalUnitRentalStatusBreakdown =
      '/v1/asset-affairs-service/residential-unit-rental/analytics/status-breakdown';

  static const String residentalUnitRentalApprovalStatusBreakdown =
      '/v1/asset-affairs-service/residential-unit-rental/analytics/approval-status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  static const String residentalUnitRentalTrendBreakdown =
      '/v1/asset-affairs-service/residential-unit-rental/analytics/trend-breakdown';

  static const String residentalUnitRentalApprovalTrendBreakdown =
      '/v1/asset-affairs-service/residential-unit-rental/analytics/approval-trend-breakdown';
  static const String residentalUnitRentalApartmentTypes =
      '/v1/asset-affairs-service/admin-config/apartment-types';
  static const String residentalUnitRentalUnitLocations =
      '/v1/asset-affairs-service/admin-config/unit-locations';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Housing Contract Renewal)
  static const String renewHousingContractSendRequest =
      '/v1/asset-affairs-service/housing-contract-renewal/request';

  /// Get my requests
  static const String renewHousingContractGetRequests =
      '/v1/asset-affairs-service/housing-contract-renewal/requests';

  /// Get all requests (no user filter)
  static const String renewHousingContractGetAllRequests =
      '/v1/asset-affairs-service/housing-contract-renewal/requests/all';

  /// Get approval list (For approvers)
  static const String renewHousingContractGetActionItems =
      '/v1/asset-affairs-service/housing-contract-renewal/requests/for-approval';

  /// Get request by ID
  static String renewHousingContractRequestById(int requestId) =>
      '/v1/asset-affairs-service/housing-contract-renewal/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String renewHousingContractApprove =
      '/v1/asset-affairs-service/housing-contract-renewal/approve';

  /// ===================== CHAT APIs =====================

  static String renewHousingContractSendChatById(int requestId) =>
      '/v1/asset-affairs-service/housing-contract-renewal/request/$requestId/chat';

  static String renewHousingContractChatsById(int requestId) =>
      '/v1/asset-affairs-service/housing-contract-renewal/request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String renewHousingContractSendAttachmentById(int requestId) =>
      '/v1/asset-affairs-service/housing-contract-renewal/request/$requestId/attachment';

  /// Get attachments
  static String renewHousingContractAttachmentsById(int requestId) =>
      '/v1/asset-affairs-service/housing-contract-renewal/request/$requestId/attachments';

  /// ⭐ NEW API (from image)
  /// Delete attachment
  static String renewHousingContractDeleteAttachment(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/asset-affairs-service/housing-contract-renewal/request/$requestId/attachment/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String renewHousingContractKpiCards =
      '/v1/asset-affairs-service/housing-contract-renewal/analytics/kpi-cards';

  /// Approver KPI cards
  static const String renewHousingContractApprovalKpiCards =
      '/v1/asset-affairs-service/housing-contract-renewal/analytics/approval-kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String renewHousingContractStatusBreakdown =
      '/v1/asset-affairs-service/housing-contract-renewal/analytics/status-breakdown';

  /// Approval status breakdown
  static const String renewHousingContractApprovalStatusBreakdown =
      '/v1/asset-affairs-service/housing-contract-renewal/analytics/approval-status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String renewHousingContractTrendBreakdown =
      '/v1/asset-affairs-service/housing-contract-renewal/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String renewHousingContractApprovalTrendBreakdown =
      '/v1/asset-affairs-service/housing-contract-renewal/analytics/approval-trend-breakdown';

  // ===================== REQUEST APIs =====================

  /// Send Request (Create Housing Contract Cancel)
  static const String cancelHousingContractSendRequest =
      '/v1/asset-affairs-service/housing-contract-cancel/request';

  /// Get my requests
  static const String cancelHousingContractGetRequests =
      '/v1/asset-affairs-service/housing-contract-cancel/requests';

  /// Get all requests (no user filter)
  static const String cancelHousingContractGetAllRequests =
      '/v1/asset-affairs-service/housing-contract-cancel/requests/all';

  /// Get approval list (For approvers)
  static const String cancelHousingContractGetActionItems =
      '/v1/asset-affairs-service/housing-contract-cancel/requests/for-approval';

  /// Get request by ID
  static String cancelHousingContractRequestById(int requestId) =>
      '/v1/asset-affairs-service/housing-contract-cancel/request/$requestId';

  /// ===================== UPDATE REQUEST =====================

  /// Update request
  static String cancelHousingContractUpdateRequest(int requestId) =>
      '/v1/asset-affairs-service/housing-contract-cancel/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String cancelHousingContractApprove =
      '/v1/asset-affairs-service/housing-contract-cancel/approve';

  /// ===================== CHAT APIs =====================

  static String cancelHousingContractSendChatById(int requestId) =>
      '/v1/asset-affairs-service/housing-contract-cancel/request/$requestId/chat';

  static String cancelHousingContractChatsById(int requestId) =>
      '/v1/asset-affairs-service/housing-contract-cancel/request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String cancelHousingContractSendAttachmentById(int requestId) =>
      '/v1/asset-affairs-service/housing-contract-cancel/request/$requestId/attachment';

  /// Get attachments
  static String cancelHousingContractAttachmentsById(int requestId) =>
      '/v1/asset-affairs-service/housing-contract-cancel/request/$requestId/attachments';

  /// Delete attachment
  static String cancelHousingContractDeleteAttachment(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/asset-affairs-service/housing-contract-cancel/request/$requestId/attachment/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String cancelHousingContractKpiCards =
      '/v1/asset-affairs-service/housing-contract-cancel/analytics/kpi-cards';

  /// Approver KPI cards
  static const String cancelHousingContractApprovalKpiCards =
      '/v1/asset-affairs-service/housing-contract-cancel/analytics/approval-kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String cancelHousingContractStatusBreakdown =
      '/v1/asset-affairs-service/housing-contract-cancel/analytics/status-breakdown';

  /// Approval status breakdown
  static const String cancelHousingContractApprovalStatusBreakdown =
      '/v1/asset-affairs-service/housing-contract-cancel/analytics/approval-status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String cancelHousingContractTrendBreakdown =
      '/v1/asset-affairs-service/housing-contract-cancel/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String cancelHousingContractApprovalTrendBreakdown =
      '/v1/asset-affairs-service/housing-contract-cancel/analytics/approval-trend-breakdown';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Project Approval Request)
  static const String requestForProjectApprovalSendRequest =
      '/v1/it-service/request-for-project-approval/requests';

  /// Get my requests
  static const String requestForProjectApprovalGetRequests =
      '/v1/it-service/request-for-project-approval/requests';

  /// Get all requests (no user filter)
  static const String requestForProjectApprovalGetAllRequests =
      '/v1/it-service/request-for-project-approval/requests/all';

  /// Get approval list (For approvers)
  static const String requestForProjectApprovalGetActionItems =
      '/v1/it-service/request-for-project-approval/requests/approval';

  /// Get request by ID
  static String requestForProjectApprovalRequestById(int requestId) =>
      '/v1/it-service/request-for-project-approval/requests/$requestId';

  /// ===================== UPDATE REQUEST =====================

  /// Update request
  static String requestForProjectApprovalUpdateRequest(int requestId) =>
      '/v1/it-service/request-for-project-approval/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String requestForProjectApprovalApprove =
      '/v1/it-service/request-for-project-approval/approve';

  /// ===================== CHAT APIs =====================

  static String requestForProjectApprovalSendChatById(int requestId) =>
      '/v1/it-service/request-for-project-approval/requests/$requestId/chat';

  static String requestForProjectApprovalChatsById(int requestId) =>
      '/v1/it-service/request-for-project-approval/requests/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String requestForProjectApprovalSendAttachmentById(int requestId) =>
      '/v1/it-service/request-for-project-approval/requests/$requestId/attachment';

  /// Get attachments
  static String requestForProjectApprovalAttachmentsById(int requestId) =>
      '/v1/it-service/request-for-project-approval/requests/$requestId/attachments';

  /// Delete attachment
  static String requestForProjectApprovalDeleteAttachment(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/it-service/request-for-project-approval/request/$requestId/attachment/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String requestForProjectApprovalKpiCards =
      '/v1/it-service/request-for-project-approval/analytics/kpi-cards';

  /// Approver KPI cards
  static const String requestForProjectApprovalApprovalKpiCards =
      '/v1/it-service/request-for-project-approval/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String requestForProjectApprovalStatusBreakdown =
      '/v1/it-service/request-for-project-approval/analytics/status-breakdown';

  /// Approval status breakdown
  static const String requestForProjectApprovalApprovalStatusBreakdown =
      '/v1/it-service/request-for-project-approval/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String requestForProjectApprovalTrendBreakdown =
      '/v1/it-service/request-for-project-approval/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String requestForProjectApprovalApprovalTrendBreakdown =
      '/v1/it-service/request-for-project-approval/analytics/approval/trend-breakdown';
  static const String requestForProjectApprovalProjectEmployeesList =
      '/v1/it-service/request-for-project-approval/employees';
  static const String requestForProjectApprovalProjectAssignEmployee =
      '/v1/it-service/request-for-project-approval/assign';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create VAPT Request)
  static const String requestForVAPTSendRequest =
      '/v1/it-service/request-for-vapt/requests';

  /// Get my requests
  static const String requestForVAPTGetRequests =
      '/v1/it-service/request-for-vapt/requests';

  /// Get all requests (no user filter)
  static const String requestForVAPTGetAllRequests =
      '/v1/it-service/request-for-vapt/requests/all';

  /// Get approval list (For approvers)
  static const String requestForVAPTGetActionItems =
      '/v1/it-service/request-for-vapt/requests/approval';

  /// Get request by ID
  static String requestForVAPTRequestById(int requestId) =>
      '/v1/it-service/request-for-vapt/requests/$requestId';

  /// ===================== UPDATE REQUEST =====================
  /// Assign Request
  static const String requestForVAPTAssign =
      '/v1/it-service/request-for-vapt/assign';

  /// Update request
  static String requestForVAPTUpdateRequest(int requestId) =>
      '/v1/it-service/request-for-vapt/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String requestForVAPTApprove =
      '/v1/it-service/request-for-vapt/approve';

  /// ===================== CHAT APIs =====================

  static String requestForVAPTSendChatById(int requestId) =>
      '/v1/it-service/request-for-vapt/requests/$requestId/chat';

  static String requestForVAPTChatsById(int requestId) =>
      '/v1/it-service/request-for-vapt/requests/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String requestForVAPTSendAttachmentById(int requestId) =>
      '/v1/it-service/request-for-vapt/requests/$requestId/attachment';

  /// Get attachments
  static String requestForVAPTAttachmentsById(int requestId) =>
      '/v1/it-service/request-for-vapt/requests/$requestId/attachments';

  /// Delete attachment
  static String requestForVAPTDeleteAttachment(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/it-service/request-for-vapt/request/$requestId/attachment/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String requestForVAPTKpiCards =
      '/v1/it-service/request-for-vapt/analytics/kpi-cards';

  /// Approver KPI cards
  static const String requestForVAPTApprovalKpiCards =
      '/v1/it-service/request-for-vapt/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String requestForVAPTStatusBreakdown =
      '/v1/it-service/request-for-vapt/analytics/status-breakdown';

  /// Approval status breakdown
  static const String requestForVAPTApprovalStatusBreakdown =
      '/v1/it-service/request-for-vapt/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String requestForVAPTTrendBreakdown =
      '/v1/it-service/request-for-vapt/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String requestForVAPTApprovalTrendBreakdown =
      '/v1/it-service/request-for-vapt/analytics/approval/trend-breakdown';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Internal Audit Request)
  static const String requestForInternalAuditSendRequest =
      '/v1/it-service/cyber-security-audit/requests';

  /// Get my requests
  static const String requestForInternalAuditGetRequests =
      '/v1/it-service/cyber-security-audit/requests';

  /// Get all requests (no user filter)
  static const String requestForInternalAuditGetAllRequests =
      '/v1/it-service/cyber-security-audit/requests/all';

  /// Get approval list (For approvers)
  static const String requestForInternalAuditGetActionItems =
      '/v1/it-service/cyber-security-audit/requests/approval';

  /// Get request by ID
  static String requestForInternalAuditRequestById(int requestId) =>
      '/v1/it-service/cyber-security-audit/requests/$requestId';

  /// ===================== UPDATE REQUEST =====================

  /// Update request
  static String requestForInternalAuditUpdateRequest(int requestId) =>
      '/v1/it-service/cyber-security-audit/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String requestForInternalAuditApprove =
      '/v1/it-service/cyber-security-audit/approve';

  /// ===================== CHAT APIs =====================

  static String requestForInternalAuditSendChatById(int requestId) =>
      '/v1/it-service/cyber-security-audit/requests/$requestId/chat';

  static String requestForInternalAuditChatsById(int requestId) =>
      '/v1/it-service/cyber-security-audit/requests/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String requestForInternalAuditSendAttachmentById(int requestId) =>
      '/v1/it-service/cyber-security-audit/requests/$requestId/attachment';

  /// Get attachments
  static String requestForInternalAuditAttachmentsById(int requestId) =>
      '/v1/it-service/cyber-security-audit/requests/$requestId/attachments';

  /// Delete attachment
  static String requestForInternalAuditDeleteAttachment(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/it-service/cyber-security-audit/request/$requestId/attachment/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String requestForInternalAuditKpiCards =
      '/v1/it-service/cyber-security-audit/analytics/kpi-cards';

  /// Approver KPI cards
  static const String requestForInternalAuditApprovalKpiCards =
      '/v1/it-service/cyber-security-audit/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String requestForInternalAuditStatusBreakdown =
      '/v1/it-service/cyber-security-audit/analytics/status-breakdown';

  /// Approval status breakdown
  static const String requestForInternalAuditApprovalStatusBreakdown =
      '/v1/it-service/cyber-security-audit/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String requestForInternalAuditTrendBreakdown =
      '/v1/it-service/cyber-security-audit/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String requestForInternalAuditApprovalTrendBreakdown =
      '/v1/it-service/cyber-security-audit/analytics/approval/trend-breakdown';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String cyberSecurityRiskManagementSendRequest =
      '/v1/it-service/cyber-security-risk-management/requests';

  /// Get my requests
  static const String cyberSecurityRiskManagementGetRequests =
      '/v1/it-service/cyber-security-risk-management/requests';

  /// Get all requests (no user filter)
  static const String cyberSecurityRiskManagementGetAllRequests =
      '/v1/it-service/cyber-security-risk-management/requests/all';

  /// Get approval list (For approvers)
  static const String cyberSecurityRiskManagementGetActionItems =
      '/v1/it-service/cyber-security-risk-management/requests/approval';

  /// Get request by ID
  static String cyberSecurityRiskManagementRequestById(int requestId) =>
      '/v1/it-service/cyber-security-risk-management/requests/$requestId';

  /// ===================== UPDATE REQUEST =====================

  /// Update request
  static String cyberSecurityRiskManagementUpdateRequest(int requestId) =>
      '/v1/it-service/cyber-security-risk-management/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String cyberSecurityRiskManagementApprove =
      '/v1/it-service/cyber-security-risk-management/approve';

  /// ===================== CHAT APIs =====================

  static String cyberSecurityRiskManagementSendChatById(int requestId) =>
      '/v1/it-service/cyber-security-risk-management/requests/$requestId/chat';

  static String cyberSecurityRiskManagementChatsById(int requestId) =>
      '/v1/it-service/cyber-security-risk-management/requests/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String cyberSecurityRiskManagementSendAttachmentById(int requestId) =>
      '/v1/it-service/cyber-security-risk-management/requests/$requestId/attachment';

  /// Get attachments
  static String cyberSecurityRiskManagementAttachmentsById(int requestId) =>
      '/v1/it-service/cyber-security-risk-management/requests/$requestId/attachments';

  /// Delete attachment
  static String cyberSecurityRiskManagementDeleteAttachment(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/it-service/cyber-security-risk-management/request/$requestId/attachment/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String cyberSecurityRiskManagementKpiCards =
      '/v1/it-service/cyber-security-risk-management/analytics/kpi-cards';

  /// Approver KPI cards
  static const String cyberSecurityRiskManagementApprovalKpiCards =
      '/v1/it-service/cyber-security-risk-management/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String cyberSecurityRiskManagementStatusBreakdown =
      '/v1/it-service/cyber-security-risk-management/analytics/status-breakdown';

  /// Approval status breakdown
  static const String cyberSecurityRiskManagementApprovalStatusBreakdown =
      '/v1/it-service/cyber-security-risk-management/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String cyberSecurityRiskManagementTrendBreakdown =
      '/v1/it-service/cyber-security-risk-management/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String cyberSecurityRiskManagementApprovalTrendBreakdown =
      '/v1/it-service/cyber-security-risk-management/analytics/approval/trend-breakdown';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String legalContractReviewSendRequest =
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/requests';

  /// Get my requests
  static const String legalContractReviewGetRequests =
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/requests';

  /// Get all requests (no user filter)
  static const String legalContractReviewGetAllRequests =
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/requests/all';

  /// Get approval list (For approvers)
  static const String legalContractReviewGetActionItems =
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/requests/approval';

  /// Get request by ID
  static String legalContractReviewRequestById(int requestId) =>
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/requests/$requestId';

  /// ===================== UPDATE REQUEST =====================

  /// Update request
  static String legalContractReviewUpdateRequest(int requestId) =>
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String legalContractReviewApprove =
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/approve';

  /// ===================== CHAT APIs =====================

  static String legalContractReviewSendChatById(int requestId) =>
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/requests/$requestId/chat';

  static String legalContractReviewChatsById(int requestId) =>
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/requests/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String legalContractReviewSendAttachmentById(int requestId) =>
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/requests/$requestId/attachment';

  /// Get attachments
  static String legalContractReviewAttachmentsById(int requestId) =>
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/requests/$requestId/attachments';

  /// Delete attachment
  static String legalContractReviewDeleteAttachment(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/request/$requestId/attachment/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String legalContractReviewKpiCards =
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/analytics/kpi-cards';

  /// Approver KPI cards
  static const String legalContractReviewApprovalKpiCards =
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String legalContractReviewStatusBreakdown =
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/analytics/status-breakdown';

  /// Approval status breakdown
  static const String legalContractReviewApprovalStatusBreakdown =
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String legalContractReviewTrendBreakdown =
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String legalContractReviewApprovalTrendBreakdown =
      '/v1/asset-affairs-service/legal-consultation-service/legal-contract-review/analytics/approval/trend-breakdown';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String appealAgainstAdministrativeDecisionsSendRequest =
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/requests';

  /// Get my requests
  static const String appealAgainstAdministrativeDecisionsGetRequests =
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/requests';

  /// Get all requests (no user filter)
  static const String appealAgainstAdministrativeDecisionsGetAllRequests =
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/requests/all';

  /// Get approval list (For approvers)
  static const String appealAgainstAdministrativeDecisionsGetActionItems =
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/requests/approval';

  /// Get request by ID
  static String appealAgainstAdministrativeDecisionsRequestById(
    int requestId,
  ) =>
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/requests/$requestId';

  /// ===================== UPDATE REQUEST =====================

  /// Update request
  static String appealAgainstAdministrativeDecisionsUpdateRequest(
    int requestId,
  ) =>
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String appealAgainstAdministrativeDecisionsApprove =
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/approve';

  /// ===================== CHAT APIs =====================

  static String appealAgainstAdministrativeDecisionsSendChatById(
    int requestId,
  ) =>
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/requests/$requestId/chat';

  static String appealAgainstAdministrativeDecisionsChatsById(int requestId) =>
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/requests/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String appealAgainstAdministrativeDecisionsSendAttachmentById(
    int requestId,
  ) =>
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/requests/$requestId/attachment';

  /// Get attachments
  static String appealAgainstAdministrativeDecisionsAttachmentsById(
    int requestId,
  ) =>
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/requests/$requestId/attachments';

  /// Delete attachment
  static String appealAgainstAdministrativeDecisionsDeleteAttachment(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/request/$requestId/attachment/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String appealAgainstAdministrativeDecisionsKpiCards =
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/analytics/kpi-cards';

  /// Approver KPI cards
  static const String appealAgainstAdministrativeDecisionsApprovalKpiCards =
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String appealAgainstAdministrativeDecisionsStatusBreakdown =
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/analytics/status-breakdown';

  /// Approval status breakdown
  static const String
  appealAgainstAdministrativeDecisionsApprovalStatusBreakdown =
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String appealAgainstAdministrativeDecisionsTrendBreakdown =
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String
  appealAgainstAdministrativeDecisionsApprovalTrendBreakdown =
      '/v1/asset-affairs-service/legal-consultation-service/appeal-against-administrative-decision/analytics/approval/trend-breakdown';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String legalComplaintSendRequest =
      '/v1/asset-affairs-service/legal-complaint-review/request';

  /// Get my requests
  static const String legalComplaintGetRequests =
      '/v1/asset-affairs-service/legal-complaint-review/requests';

  /// Get all requests (no user filter)
  static const String legalComplaintGetAllRequests =
      '/v1/asset-affairs-service/legal-complaint-review/requests/all';

  /// Get approval list (For approvers)
  static const String legalComplaintGetActionItems =
      '/v1/asset-affairs-service/legal-complaint-review/requests/for-approval';

  /// Get request by ID
  static String legalComplaintRequestById(int requestId) =>
      '/v1/asset-affairs-service/legal-complaint-review/request/$requestId';

  /// ===================== UPDATE REQUEST =====================

  /// (⚠️ Not available in Swagger → keep if backend supports)
  static String legalComplaintUpdateRequest(int requestId) =>
      '/v1/asset-affairs-service/legal-complaint-review/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String legalComplaintApprove =
      '/v1/asset-affairs-service/legal-complaint-review/approve';

  /// ===================== CHAT APIs =====================

  static String legalComplaintSendChatById(int requestId) =>
      '/v1/asset-affairs-service/legal-complaint-review/request/$requestId/chat';

  static String legalComplaintChatsById(int requestId) =>
      '/v1/asset-affairs-service/legal-complaint-review/request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String legalComplaintSendAttachmentById(int requestId) =>
      '/v1/asset-affairs-service/legal-complaint-review/request/$requestId/attachment';

  /// Get attachments
  static String legalComplaintAttachmentsById(int requestId) =>
      '/v1/asset-affairs-service/legal-complaint-review/request/$requestId/attachments';

  /// Delete attachment
  static String legalComplaintDeleteAttachment(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/asset-affairs-service/legal-complaint-review/request/$requestId/attachment/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String legalComplaintKpiCards =
      '/v1/asset-affairs-service/legal-complaint-review/analytics/kpi-cards';

  /// Approver KPI cards
  static const String legalComplaintApprovalKpiCards =
      '/v1/asset-affairs-service/legal-complaint-review/analytics/approval-kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String legalComplaintStatusBreakdown =
      '/v1/asset-affairs-service/legal-complaint-review/analytics/status-breakdown';

  /// Approval status breakdown
  static const String legalComplaintApprovalStatusBreakdown =
      '/v1/asset-affairs-service/legal-complaint-review/analytics/approval-status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String legalComplaintTrendBreakdown =
      '/v1/asset-affairs-service/legal-complaint-review/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String legalComplaintApprovalTrendBreakdown =
      '/v1/asset-affairs-service/legal-complaint-review/analytics/approval-trend-breakdown';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String legalConsultationSendRequest =
      '/v1/asset-affairs-service/legal-consultation-review/request';

  static const String legalConsultationAdministrativeApprove =
      '/v1/asset-affairs-service/legal-consultation-review/approve';

  /// Get my requests
  static const String legalConsultationGetRequests =
      '/v1/asset-affairs-service/legal-consultation-review/requests';

  /// Get all requests (no user filter)
  static const String legalConsultationGetAllRequests =
      '/v1/asset-affairs-service/legal-consultation-review/requests/all';

  /// Get approval list (For approvers)
  static const String legalConsultationGetActionItems =
      '/v1/asset-affairs-service/legal-consultation-review/requests/for-approval';

  /// Get request by ID
  static String legalConsultationRequestById(int requestId) =>
      '/v1/asset-affairs-service/legal-consultation-review/request/$requestId';

  /// ===================== UPDATE REQUEST =====================

  /// (⚠️ Not clearly shown in Swagger → optional)
  static String legalConsultationUpdateRequest(int requestId) =>
      '/v1/asset-affairs-service/legal-consultation-review/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String legalConsultationApprove =
      '/v1/asset-affairs-service/legal-consultation-review/approve';

  /// ===================== CHAT APIs =====================

  static String legalConsultationSendChatById(int requestId) =>
      '/v1/asset-affairs-service/legal-consultation-review/request/$requestId/chat';

  static String legalConsultationChatsById(int requestId) =>
      '/v1/asset-affairs-service/legal-consultation-review/request/$requestId/chats';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String legalConsultationSendAttachmentById(int requestId) =>
      '/v1/asset-affairs-service/legal-consultation-review/request/$requestId/attachment';

  /// Get attachments
  static String legalConsultationAttachmentsById(int requestId) =>
      '/v1/asset-affairs-service/legal-consultation-review/request/$requestId/attachments';

  /// Delete attachment
  static String legalConsultationDeleteAttachment(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/asset-affairs-service/legal-consultation-review/request/$requestId/attachment/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String legalConsultationKpiCards =
      '/v1/asset-affairs-service/legal-consultation-review/analytics/kpi-cards';

  /// Approver KPI cards
  static const String legalConsultationApprovalKpiCards =
      '/v1/asset-affairs-service/legal-consultation-review/analytics/approval-kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String legalConsultationStatusBreakdown =
      '/v1/asset-affairs-service/legal-consultation-review/analytics/status-breakdown';

  /// Approval status breakdown
  static const String legalConsultationApprovalStatusBreakdown =
      '/v1/asset-affairs-service/legal-consultation-review/analytics/approval-status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String legalConsultationTrendBreakdown =
      '/v1/asset-affairs-service/legal-consultation-review/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String legalConsultationApprovalTrendBreakdown =
      '/v1/asset-affairs-service/legal-consultation-review/analytics/approval-trend-breakdown';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String eventSupportSendRequest =
      '/v1/it-service/event-support/requests';

  /// Get my requests
  static const String eventSupportGetRequests =
      '/v1/it-service/event-support/requests';

  /// Get approval list (For approvers)
  static const String eventSupportGetActionItems =
      '/v1/it-service/event-support/requests/approval';

  /// Get request by ID
  static String eventSupportRequestById(int requestId) =>
      '/v1/it-service/event-support/requests/$requestId';

  /// ===================== UPDATE REQUEST =====================
  /// (Optional – if backend supports)
  static String eventSupportUpdateRequest(int requestId) =>
      '/v1/it-service/event-support/requests/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String eventSupportApprove =
      '/v1/it-service/event-support/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat
  static String eventSupportSendChatById(int requestId) =>
      '/v1/it-service/event-support/requests/$requestId/chat';

  /// Get chats
  static String eventSupportChatsById(int requestId) =>
      '/v1/it-service/event-support/requests/$requestId/chats';

  /// Update chat
  static String eventSupportUpdateChat(int chatId) =>
      '/v1/it-service/event-support/chats/$chatId';

  /// Delete chat
  static String eventSupportDeleteChat(int chatId) =>
      '/v1/it-service/event-support/chats/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String eventSupportSendAttachmentById(int requestId) =>
      '/v1/it-service/event-support/requests/$requestId/attachment';

  /// Get attachments
  static String eventSupportAttachmentsById(int requestId) =>
      '/v1/it-service/event-support/requests/$requestId/attachments';

  /// Update attachment
  static String eventSupportUpdateAttachment(int attachmentId) =>
      '/v1/it-service/event-support/attachments/$attachmentId';

  /// Delete attachment
  static String eventSupportDeleteAttachment(int attachmentId) =>
      '/v1/it-service/event-support/attachments/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String eventSupportKpiCards =
      '/v1/it-service/event-support/analytics/kpi-cards';

  /// Approver KPI cards
  static const String eventSupportApprovalKpiCards =
      '/v1/it-service/event-support/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String eventSupportStatusBreakdown =
      '/v1/it-service/event-support/analytics/status-breakdown';

  /// Approval status breakdown
  static const String eventSupportApprovalStatusBreakdown =
      '/v1/it-service/event-support/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String eventSupportTrendBreakdown =
      '/v1/it-service/event-support/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String eventSupportApprovalTrendBreakdown =
      '/v1/it-service/event-support/analytics/approval/trend-breakdown';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String cancellationSendRequest =
      '/v1/hr-service/cancellation/cancellation-request';

  /// Get my requests
  static const String cancellationGetRequests =
      '/v1/hr-service/cancellation/cancellation-requests';

  /// Get approval list (For approvers)
  static const String cancellationGetActionItems =
      '/v1/hr-service/cancellation/cancellation-requests-for-approval';

  /// Get request by ID
  static String cancellationRequestById(int requestId) =>
      '/v1/hr-service/cancellation/cancellation-request/$requestId';

  /// ===================== UPDATE REQUEST =====================
  /// (Optional – if backend supports)
  static String cancellationUpdateRequest(int requestId) =>
      '/v1/hr-service/cancellation/cancellation-request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String cancellationApprove =
      '/v1/hr-service/cancellation/cancellation-request/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat
  static String cancellationSendChatById(int requestId) =>
      '/v1/hr-service/cancellation/cancellation-request/$requestId/chat';

  /// Get chats
  static String cancellationChatsById(int requestId) =>
      '/v1/hr-service/cancellation/cancellation-request/$requestId/chats';

  /// Update chat
  static String cancellationUpdateChat(int chatId) =>
      '/v1/hr-service/cancellation/cancellation-request/chat/$chatId';

  /// Delete chat
  static String cancellationDeleteChat(int chatId) =>
      '/v1/hr-service/cancellation/cancellation-request/chat/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String cancellationSendAttachmentById(int requestId) =>
      '/v1/hr-service/cancellation/cancellation-request/$requestId/attachment';

  /// Get attachments
  static String cancellationAttachmentsById(int requestId) =>
      '/v1/hr-service/cancellation/cancellation-request/$requestId/attachments';

  /// Update attachment
  static String cancellationUpdateAttachment(int attachmentId) =>
      '/v1/hr-service/cancellation/cancellation-request/attachment/$attachmentId';

  /// Delete attachment
  static String cancellationDeleteAttachment(int attachmentId) =>
      '/v1/hr-service/cancellation/cancellation-request/attachment/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String cancellationKpiCards =
      '/v1/hr-service/cancellation/cancellation-request/analytics/kpi';

  /// Approver KPI cards
  static const String cancellationApprovalKpiCards =
      '/v1/hr-service/cancellation/cancellation-request/analytics/approvals/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String cancellationStatusBreakdown =
      '/v1/hr-service/cancellation/cancellation-request/analytics/status-breakdown';

  /// Approval status breakdown
  static const String cancellationApprovalStatusBreakdown =
      '/v1/hr-service/cancellation/cancellation-request/analytics/approvals/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String cancellationTrendBreakdown =
      '/v1/hr-service/cancellation/cancellation-request/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String cancellationApprovalTrendBreakdown =
      '/v1/hr-service/cancellation/cancellation-request/analytics/approvals/trend-breakdown';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String respondToEnquiriesSendRequest =
      '/v1/tender-service/respond-to-enquiries/requests';

  /// Get my requests
  static const String respondToEnquiriesGetRequests =
      '/v1/tender-service/respond-to-enquiries/requests';

  /// Get approval list (For approvers)
  static const String respondToEnquiriesGetActionItems =
      '/v1/tender-service/respond-to-enquiries/requests/approval';

  /// Get request by ID
  static String respondToEnquiriesRequestById(int requestId) =>
      '/v1/tender-service/respond-to-enquiries/requests/$requestId';

  /// ===================== UPDATE REQUEST =====================
  /// (Optional – if backend supports)
  static String respondToEnquiriesUpdateRequest(int requestId) =>
      '/v1/tender-service/respond-to-enquiries/requests/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String respondToEnquiriesApprove =
      '/v1/tender-service/respond-to-enquiries/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat
  static String respondToEnquiriesSendChatById(int requestId) =>
      '/v1/tender-service/respond-to-enquiries/requests/$requestId/chat';

  /// Get chats
  static String respondToEnquiriesChatsById(int requestId) =>
      '/v1/tender-service/respond-to-enquiries/requests/$requestId/chats';

  /// Update chat
  static String respondToEnquiriesUpdateChat(int chatId) =>
      '/v1/tender-service/respond-to-enquiries/chats/$chatId';

  /// Delete chat
  static String respondToEnquiriesDeleteChat(int chatId) =>
      '/v1/tender-service/respond-to-enquiries/chats/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String respondToEnquiriesSendAttachmentById(int requestId) =>
      '/v1/tender-service/respond-to-enquiries/requests/$requestId/attachment';

  /// Get attachments
  static String respondToEnquiriesAttachmentsById(int requestId) =>
      '/v1/tender-service/respond-to-enquiries/requests/$requestId/attachments';

  /// Update attachment
  static String respondToEnquiriesUpdateAttachment(int attachmentId) =>
      '/v1/tender-service/respond-to-enquiries/attachments/$attachmentId';

  /// Delete attachment
  static String respondToEnquiriesDeleteAttachment(int attachmentId) =>
      '/v1/tender-service/respond-to-enquiries/attachments/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String respondToEnquiriesKpiCards =
      '/v1/tender-service/respond-to-enquiries/analytics/kpi-cards';

  /// Approver KPI cards
  static const String respondToEnquiriesApprovalKpiCards =
      '/v1/tender-service/respond-to-enquiries/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String respondToEnquiriesStatusBreakdown =
      '/v1/tender-service/respond-to-enquiries/analytics/status-breakdown';

  /// Approval status breakdown
  static const String respondToEnquiriesApprovalStatusBreakdown =
      '/v1/tender-service/respond-to-enquiries/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String respondToEnquiriesTrendBreakdown =
      '/v1/tender-service/respond-to-enquiries/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String respondToEnquiriesApprovalTrendBreakdown =
      '/v1/tender-service/respond-to-enquiries/analytics/approval/trend-breakdown';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String requestTenderServiceSendRequest =
      '/v1/tender-service/request-a-tender/requests';

  /// Get my requests
  static const String requestTenderServiceGetRequests =
      '/v1/tender-service/request-a-tender/requests';

  /// Get approval list (For approvers)
  static const String requestTenderServiceGetActionItems =
      '/v1/tender-service/request-a-tender/requests/approval';

  /// Get request by ID
  static String requestTenderServiceRequestById(int requestId) =>
      '/v1/tender-service/request-a-tender/requests/$requestId';

  /// ===================== UPDATE REQUEST =====================
  /// (Optional – if backend supports)
  static String requestTenderServiceUpdateRequest(int requestId) =>
      '/v1/tender-service/request-a-tender/requests/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String requestTenderServiceApprove =
      '/v1/tender-service/request-a-tender/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat
  static String requestTenderServiceSendChatById(int requestId) =>
      '/v1/tender-service/request-a-tender/requests/$requestId/chat';

  /// Get chats
  static String requestTenderServiceChatsById(int requestId) =>
      '/v1/tender-service/request-a-tender/requests/$requestId/chats';

  /// Update chat
  static String requestTenderServiceUpdateChat(int chatId) =>
      '/v1/tender-service/request-a-tender/chats/$chatId';

  /// Delete chat
  static String requestTenderServiceDeleteChat(int chatId) =>
      '/v1/tender-service/request-a-tender/chats/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String requestTenderServiceSendAttachmentById(int requestId) =>
      '/v1/tender-service/request-a-tender/requests/$requestId/attachment';

  /// Get attachments
  static String requestTenderServiceAttachmentsById(int requestId) =>
      '/v1/tender-service/request-a-tender/requests/$requestId/attachments';

  /// Update attachment
  static String requestTenderServiceUpdateAttachment(int attachmentId) =>
      '/v1/tender-service/request-a-tender/attachments/$attachmentId';

  /// Delete attachment
  static String requestTenderServiceDeleteAttachment(int attachmentId) =>
      '/v1/tender-service/request-a-tender/attachments/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String requestTenderServiceKpiCards =
      '/v1/tender-service/request-a-tender/analytics/kpi-cards';

  /// Approver KPI cards
  static const String requestTenderServiceApprovalKpiCards =
      '/v1/tender-service/request-a-tender/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String requestTenderServiceStatusBreakdown =
      '/v1/tender-service/request-a-tender/analytics/status-breakdown';

  /// Approval status breakdown
  static const String requestTenderServiceApprovalStatusBreakdown =
      '/v1/tender-service/request-a-tender/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String requestTenderServiceTrendBreakdown =
      '/v1/tender-service/request-a-tender/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String requestTenderServiceApprovalTrendBreakdown =
      '/v1/tender-service/request-a-tender/analytics/approval/trend-breakdown';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String requestTenderAnalysisSendRequest =
      '/v1/tender-service/request-tender-analysis/requests';

  /// Get my requests
  static const String requestTenderAnalysisGetRequests =
      '/v1/tender-service/request-tender-analysis/requests';

  /// Get approval list (For approvers)
  static const String requestTenderAnalysisGetActionItems =
      '/v1/tender-service/request-tender-analysis/requests/approval';

  /// Get request by ID
  static String requestTenderAnalysisRequestById(int requestId) =>
      '/v1/tender-service/request-tender-analysis/requests/$requestId';

  /// ===================== UPDATE REQUEST =====================
  /// (Optional – if backend supports)
  static String requestTenderAnalysisUpdateRequest(int requestId) =>
      '/v1/tender-service/request-tender-analysis/requests/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String requestTenderAnalysisApprove =
      '/v1/tender-service/request-tender-analysis/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat
  static String requestTenderAnalysisSendChatById(int requestId) =>
      '/v1/tender-service/request-tender-analysis/requests/$requestId/chat';

  /// Get chats
  static String requestTenderAnalysisChatsById(int requestId) =>
      '/v1/tender-service/request-tender-analysis/requests/$requestId/chats';

  /// Update chat
  static String requestTenderAnalysisUpdateChat(int chatId) =>
      '/v1/tender-service/request-tender-analysis/chats/$chatId';

  /// Delete chat
  static String requestTenderAnalysisDeleteChat(int chatId) =>
      '/v1/tender-service/request-tender-analysis/chats/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String requestTenderAnalysisSendAttachmentById(int requestId) =>
      '/v1/tender-service/request-tender-analysis/requests/$requestId/attachment';

  /// Get attachments
  static String requestTenderAnalysisAttachmentsById(int requestId) =>
      '/v1/tender-service/request-tender-analysis/requests/$requestId/attachments';

  /// Update attachment
  static String requestTenderAnalysisUpdateAttachment(int attachmentId) =>
      '/v1/tender-service/request-tender-analysis/attachments/$attachmentId';

  /// Delete attachment
  static String requestTenderAnalysisDeleteAttachment(int attachmentId) =>
      '/v1/tender-service/request-tender-analysis/attachments/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String requestTenderAnalysisKpiCards =
      '/v1/tender-service/request-tender-analysis/analytics/kpi-cards';

  /// Approver KPI cards
  static const String requestTenderAnalysisApprovalKpiCards =
      '/v1/tender-service/request-tender-analysis/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String requestTenderAnalysisStatusBreakdown =
      '/v1/tender-service/request-tender-analysis/analytics/status-breakdown';

  /// Approval status breakdown
  static const String requestTenderAnalysisApprovalStatusBreakdown =
      '/v1/tender-service/request-tender-analysis/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String requestTenderAnalysisTrendBreakdown =
      '/v1/tender-service/request-tender-analysis/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String requestTenderAnalysisApprovalTrendBreakdown =
      '/v1/tender-service/request-tender-analysis/analytics/approval/trend-breakdown';

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String contractServiceSendRequest =
      '/v1/tender-service/contract-service-request/requests';

  /// Get my requests
  static const String contractServiceGetRequests =
      '/v1/tender-service/contract-service-request/requests';

  /// Get approval list (For approvers)
  static const String contractServiceGetActionItems =
      '/v1/tender-service/contract-service-request/requests/approval';

  /// Get request by ID
  static String contractServiceRequestById(int requestId) =>
      '/v1/tender-service/contract-service-request/requests/$requestId';

  /// ===================== UPDATE REQUEST =====================
  /// (Optional – if backend supports)
  static String contractServiceUpdateRequest(int requestId) =>
      '/v1/tender-service/contract-service-request/requests/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String contractServiceApprove =
      '/v1/tender-service/contract-service-request/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat
  static String contractServiceSendChatById(int requestId) =>
      '/v1/tender-service/contract-service-request/requests/$requestId/chat';

  /// Get chats
  static String contractServiceChatsById(int requestId) =>
      '/v1/tender-service/contract-service-request/requests/$requestId/chats';

  /// Update chat
  static String contractServiceUpdateChat(int chatId) =>
      '/v1/tender-service/contract-service-request/chats/$chatId';

  /// Delete chat
  static String contractServiceDeleteChat(int chatId) =>
      '/v1/tender-service/contract-service-request/chats/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String contractServiceSendAttachmentById(int requestId) =>
      '/v1/tender-service/contract-service-request/requests/$requestId/attachment';

  /// Get attachments
  static String contractServiceAttachmentsById(int requestId) =>
      '/v1/tender-service/contract-service-request/requests/$requestId/attachments';

  /// Update attachment
  static String contractServiceUpdateAttachment(int attachmentId) =>
      '/v1/tender-service/contract-service-request/attachments/$attachmentId';

  /// Delete attachment
  static String contractServiceDeleteAttachment(int attachmentId) =>
      '/v1/tender-service/contract-service-request/attachments/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String contractServiceKpiCards =
      '/v1/tender-service/contract-service-request/analytics/kpi-cards';

  /// Approver KPI cards
  static const String contractServiceApprovalKpiCards =
      '/v1/tender-service/contract-service-request/analytics/approval/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String contractServiceStatusBreakdown =
      '/v1/tender-service/contract-service-request/analytics/status-breakdown';

  /// Approval status breakdown
  static const String contractServiceApprovalStatusBreakdown =
      '/v1/tender-service/contract-service-request/analytics/approval/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String contractServiceTrendBreakdown =
      '/v1/tender-service/contract-service-request/analytics/trend-breakdown';

  /// Approval trend breakdown
  static const String contractServiceApprovalTrendBreakdown =
      '/v1/tender-service/contract-service-request/analytics/approval/trend-breakdown';

  /// Logistics APIs
  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String logisticsRequestVehicleSendRequest =
      '/v1/it-service/logistics/vehicle-request';

  /// Get my requests
  static const String logisticsRequestVehicleGetRequests =
      '/v1/it-service/logistics/requests';

  /// Get approval list (For approvers)
  static const String logisticsRequestVehicleGetActionItems =
      '/v1/it-service/logistics/requests/for-approval';

  /// Get request by ID
  static String logisticsRequestVehicleRequestById(int requestId) =>
      '/v1/it-service/logistics/request/$requestId';

  /// ===================== UPDATE REQUEST =====================
  /// (Optional – if backend supports)

  static String logisticsRequestVehicleUpdateRequest(int requestId) =>
      '/v1/it-service/logistics/vehicle-request/$requestId';

  static String logisticsRequestVehicleActualReturn(int requestId) =>
      '/v1/it-service/logistics/vehicle-request/$requestId/actual-return';

  /// ===================== APPROVE / REJECT =====================

  static const String logisticsRequestVehicleApprove =
      '/v1/it-service/logistics/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat
  static String logisticsRequestVehicleSendChatById(int requestId) =>
      '/v1/it-service/logistics/request/$requestId/chat';

  /// Get chats
  static String logisticsRequestVehicleChatsById(int requestId) =>
      '/v1/it-service/logistics/request/$requestId/chats';

  /// Update chat
  static String logisticsRequestVehicleUpdateChat(int chatId) =>
      '/v1/it-service/logistics/chats/$chatId';

  /// Delete chat
  static String logisticsRequestVehicleDeleteChat(int chatId) =>
      '/v1/it-service/logistics/chats/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String logisticsRequestVehicleSendAttachmentById(int requestId) =>
      '/v1/it-service/logistics/request/$requestId/attachment';

  /// Get attachments
  static String logisticsRequestVehicleAttachmentsById(int requestId) =>
      '/v1/it-service/logistics/request/$requestId/attachments';

  /// Update attachment
  static String logisticsRequestVehicleUpdateAttachment(int attachmentId) =>
      '/v1/it-service/logistics/attachments/$attachmentId';

  /// Delete attachment
  static String logisticsRequestVehicleDeleteAttachment(int attachmentId) =>
      '/v1/it-service/logistics/attachment/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String logisticsRequestVehicleKpiCards =
      '/v1/it-service/logistics/analytics/logistics/kpi-cards';

  /// Approver KPI cards
  static const String logisticsRequestVehicleApprovalKpiCards =
      '/v1/it-service/logistics/analytics/logistics-approvals/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String logisticsRequestVehicleStatusBreakdown =
      '/v1/it-service/logistics/analytics/logistics/status-breakdown';

  /// Approval status breakdown
  static const String logisticsRequestVehicleApprovalStatusBreakdown =
      '/v1/it-service/logistics/analytics/logistics-approvals/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String logisticsRequestVehicleTrendBreakdown =
      '/v1/it-service/logistics/analytics/logistics/trend-breakdown';

  /// Approval trend breakdown
  static const String logisticsRequestVehicleApprovalTrendBreakdown =
      '/v1/it-service/logistics/analytics/logistics-approvals/trend-breakdown';

  static String vehicleAllocate(int requestId) =>
      '/v1/it-service/logistics/vehicle-request/$requestId/details';

  /// Vehicle Maintenance APIs
  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String vehicleMaintenanceSendRequest =
      '/v1/it-service/logistics/vehicle-maintenance/request';

  /// Get my requests
  static const String vehicleMaintenanceGetRequests =
      '/v1/it-service/logistics/vehicle-maintenance/requests';

  /// Get approval list (For approvers)
  static const String vehicleMaintenanceGetActionItems =
      '/v1/it-service/logistics/vehicle-maintenance/requests/for-approval';

  /// Get request by ID
  static String vehicleMaintenanceRequestById(int requestId) =>
      '/v1/it-service/logistics/vehicle-maintenance/request/$requestId';

  /// ===================== UPDATE REQUEST =====================
  /// (Optional – if backend supports)

  static String vehicleMaintenanceUpdateRequest(int requestId) =>
      '/v1/it-service/logistics/vehicle-maintenance/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String vehicleMaintenanceApprove =
      '/v1/it-service/logistics/vehicle-maintenance/approve';

  /// ===================== CHAT APIs =====================

  /// Send chat
  static String vehicleMaintenanceSendChatById(int requestId) =>
      '/v1/it-service/logistics/vehicle-maintenance/request/$requestId/chat';

  /// Get chats
  static String vehicleMaintenanceChatsById(int requestId) =>
      '/v1/it-service/logistics/vehicle-maintenance/request/$requestId/chats';

  /// Update chat
  static String vehicleMaintenanceUpdateChat(int chatId) =>
      '/v1/it-service/logistics/vehicle-maintenance/chats/$chatId';

  /// Delete chat
  static String vehicleMaintenanceDeleteChat(int chatId) =>
      '/v1/it-service/logistics/vehicle-maintenance/chats/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String vehicleMaintenanceSendAttachmentById(int requestId) =>
      '/v1/it-service/logistics/vehicle-maintenance/request/$requestId/attachment';

  /// Get attachments
  static String vehicleMaintenanceAttachmentsById(int requestId) =>
      '/v1/it-service/logistics/vehicle-maintenance/request/$requestId/attachments';

  /// Update attachment
  static String vehicleMaintenanceUpdateAttachment(int attachmentId) =>
      '/v1/it-service/logistics/vehicle-maintenance/attachments/$attachmentId';

  /// Delete attachment
  static String vehicleMaintenanceDeleteAttachment(int attachmentId) =>
      '/v1/it-service/logistics/attachment/$attachmentId';

  /// ===================== KPI APIs =====================

  /// Requester KPI cards
  static const String vehicleMaintenanceKpiCards =
      '/v1/it-service/logistics/analytics/vehicle-maintenance/kpi-cards';

  /// Approver KPI cards
  static const String vehicleMaintenanceApprovalKpiCards =
      '/v1/it-service/logistics/analytics/vehicle-maintenance-approvals/kpi-cards';

  /// ===================== STATUS BREAKDOWN =====================

  /// Request status breakdown
  static const String vehicleMaintenanceStatusBreakdown =
      '/v1/it-service/logistics/analytics/vehicle-maintenance/status-breakdown';

  /// Approval status breakdown
  static const String vehicleMaintenanceApprovalStatusBreakdown =
      '/v1/it-service/logistics/analytics/vehicle-maintenance-approvals/status-breakdown';

  /// ===================== TREND BREAKDOWN =====================

  /// Request trend breakdown
  static const String vehicleMaintenanceTrendBreakdown =
      '/v1/it-service/logistics/analytics/vehicle-maintenance/trend-breakdown';

  /// Approval trend breakdown
  static const String vehicleMaintenanceApprovalTrendBreakdown =
      '/v1/it-service/logistics/analytics/vehicle-maintenance-approvals/trend-breakdown';

  /// Security Threat APIs

  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)

  static const String securityThreatSendRequest =
      '/v1/it-service/security-threat/request';

  /// Get my requests

  static const String securityThreatGetRequests =
      '/v1/it-service/security-threat/requests';

  /// Get approval list (For approvers)

  static const String securityThreatGetActionItems =
      '/v1/it-service/security-threat/requests/for-approval';

  /// Get request by ID

  static String securityThreatRequestById(int requestId) =>
      '/v1/it-service/security-threat/request/$requestId';

  /// ===================== UPDATE REQUEST =====================

  /// Update request

  static String securityThreatUpdateRequest(int requestId) =>
      '/v1/it-service/security-threat/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String securityThreatApprove =
      '/v1/it-service/security-threat/approve';

  /// ===================== ANALYTICS APIs =====================

  /// Status breakdown

  static const String securityThreatStatusBreakdown =
      '/v1/it-service/security-threat/analytics/status-breakdown';
  static const String securityThreatApprovalStatusBreakdown =
      '/v1/it-service/security-threat/analytics/approvals/status-breakdown';
  static const String securityThreatApprovalTrendBreakdown =
      '/v1/it-service/security-threat/analytics/approvals/trend-breakdown';

  /// KPI cards

  static const String securityThreatKpiCards =
      '/v1/it-service/security-threat/analytics/kpi-cards';

  /// Approval KPI cards

  static const String securityThreatApprovalKpiCards =
      '/v1/it-service/security-threat/analytics/approvals/kpi-cards';

  /// Trend breakdown

  static const String securityThreatTrendBreakdown =
      '/v1/it-service/security-threat/analytics/trend-breakdown';

  /// ===================== CHAT APIs =====================

  /// Send chat

  static String securityThreatSendChatById(int requestId) =>
      '/v1/it-service/security-threat/request/$requestId/chat';

  /// Get chats

  static String securityThreatChatsById(int requestId) =>
      '/v1/it-service/security-threat/request/$requestId/chats';

  /// Update chat

  static String securityThreatUpdateChat(int chatId) =>
      '/v1/it-service/security-threat/chats/$chatId';

  /// Delete chat

  static String securityThreatDeleteChat(int chatId) =>
      '/v1/it-service/security-threat/chats/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment

  static String securityThreatSendAttachmentById(int requestId) =>
      '/v1/it-service/security-threat/request/$requestId/attachment';

  /// Get attachments

  static String securityThreatAttachmentsById(int requestId) =>
      '/v1/it-service/security-threat/request/$requestId/attachments';

  /// Update attachment

  static String securityThreatUpdateAttachment(int attachmentId) =>
      '/v1/it-service/security-threat/attachments/$attachmentId';

  /// Delete attachment

  static String securityThreatDeleteAttachment(int attachmentId) =>
      '/v1/it-service/security-threat/attachments/$attachmentId';

  /// Foreign Employee Vehicle APIs
  /// ===================== REQUEST APIs =====================

  /// Send Request (Create Request)
  static const String foreignEmployeeVehicleSendRequest =
      '/v1/it-service/logistics/foreign-vehicle-request';

  /// Get my requests
  static const String foreignEmployeeVehicleGetRequests =
      '/v1/it-service/logistics/foreign-vehicle-requests';

  /// Get approval list (For approvers)
  static const String foreignEmployeeVehicleGetActionItems =
      '/v1/it-service/logistics/foreign-vehicle-requests/for-approval';

  /// Get request by ID
  static String foreignEmployeeVehicleRequestById(int requestId) =>
      '/v1/it-service/logistics/foreign-vehicle-request/$requestId';

  /// ===================== UPDATE REQUEST =====================
  /// (Optional – if backend supports)

  static String foreignEmployeeVehicleUpdateRequest(int requestId) =>
      '/v1/it-service/logistics/foreign-vehicle-request/$requestId';

  static String foreignEmployeeVehicleActualReturn(int requestId) =>
      '/v1/it-service/logistics/foreign-vehicle-request/$requestId/actual-return';

  /// ===================== APPROVE / REJECT =====================

  static const String foreignEmployeeVehicleApprove =
      '/v1/it-service/logistics/approve';

  /// ===================== ANALYTICS APIs =====================

  /// Approval status breakdown
  static const String foreignEmployeeVehicleApprovalStatusBreakdown =
      '/v1/it-service/logistics/analytics/foreign-approvals/status-breakdown';

  /// Vehicle status breakdown
  static const String foreignEmployeeVehicleStatusBreakdown =
      '/v1/it-service/logistics/analytics/foreign-vehicle/status-breakdown';

  /// ===================== CHAT APIs =====================

  /// Send chat
  static String foreignEmployeeVehicleSendChatById(int requestId) =>
      '/v1/it-service/logistics/request/$requestId/chat';

  /// Get chats
  static String foreignEmployeeVehicleChatsById(int requestId) =>
      '/v1/it-service/logistics/request/$requestId/chats';

  /// Update chat
  static String foreignEmployeeVehicleUpdateChat(int chatId) =>
      '/v1/it-service/logistics/chats/$chatId';

  /// Delete chat
  static String foreignEmployeeVehicleDeleteChat(int chatId) =>
      '/v1/it-service/logistics/chats/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  /// Add attachment
  static String foreignEmployeeVehicleSendAttachmentById(int requestId) =>
      '/v1/it-service/logistics/request/$requestId/attachment';

  /// Get attachments
  static String foreignEmployeeVehicleAttachmentsById(int requestId) =>
      '/v1/it-service/logistics/request/$requestId/attachments';

  /// Update attachment
  static String foreignEmployeeVehicleUpdateAttachment(int attachmentId) =>
      '/v1/it-service/logistics/attachments/$attachmentId';

  /// Delete attachment
  static String foreignEmployeeVehicleDeleteAttachment(int attachmentId) =>
      '/v1/it-service/logistics/request/$attachmentId/attachments';

  /// ===================== ANALYTICS APIs =====================

  /// KPI Cards
  static const String foreignEmployeeVehicleKpiCards =
      '/v1/it-service/logistics/analytics/foreign-vehicle/kpi-cards';

  /// Approval Analytics
  static const String foreignEmployeeVehicleApprovalAnalytics =
      '/v1/it-service/logistics/analytics/logistics-approvals';
  static const String foreignEmployeeVehicleTrendBreakdown =
      '/v1/it-service/logistics/analytics/foreign-vehicle/trend-breakdown';
  static const String foreignEmployeeVehicleApprovalTrendBreakdown =
      '/v1/it-service/logistics/analytics/foreign-approvals/trend-breakdown';
  static const String foreignEmployeeVehicleApprovalKpiCards =
      '/v1/it-service/logistics/analytics/foreign-approvals/kpi-cards';
  static String foreignEmployeeVehicleAllocate(int requestId) =>
      '/v1/it-service/logistics/foreign-vehicle-request/$requestId/details';

  /// Maintenance APIs
  /// ===================== SEND REQUEST =====================

  static const String requestMaintenanceSendRequest =
      '/v1/asset-affairs-service/maintenance/request';

  /// ===================== GET REQUESTS =====================

  static const String requestMaintenanceGetRequests =
      '/v1/asset-affairs-service/maintenance/requests';

  static const String requestMaintenanceGetAllRequests =
      '/v1/asset-affairs-service/maintenance/requests/all';

  static const String requestMaintenanceGetActionItems =
      '/v1/asset-affairs-service/maintenance/requests/for-approval';

  /// ===================== REQUEST DETAILS =====================

  static String requestMaintenanceById(int requestId) =>
      '/v1/asset-affairs-service/maintenance/request/$requestId';

  /// ===================== UPDATE REQUEST =====================

  static String requestMaintenanceUpdateRequest(int requestId) =>
      '/v1/asset-affairs-service/maintenance/request/$requestId';

  static String requestMaintenanceRequestById(int requestId) =>
      '/v1/asset-affairs-service/maintenance/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String requestMaintenanceApprove =
      '/v1/asset-affairs-service/maintenance/approve';

  /// ===================== CHAT APIs =====================

  static String requestMaintenanceSendChatById(int requestId) =>
      '/v1/asset-affairs-service/maintenance/request/$requestId/chat';

  static String requestMaintenanceChatsById(int requestId) =>
      '/v1/asset-affairs-service/maintenance/request/$requestId/chats';

  static String requestMaintenanceUpdateChat(int chatId) =>
      '/v1/asset-affairs-service/maintenance/chat/$chatId';

  static String requestMaintenanceDeleteChat(int chatId) =>
      '/v1/asset-affairs-service/maintenance/chat/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  static String requestMaintenanceSendAttachmentById(int requestId) =>
      '/v1/asset-affairs-service/maintenance/request/$requestId/attachment';

  static String requestMaintenanceAttachmentsById(int requestId) =>
      '/v1/asset-affairs-service/maintenance/request/$requestId/attachments';

  static String requestMaintenanceUpdateAttachment(int attachmentId) =>
      '/v1/asset-affairs-service/maintenance/attachment/$attachmentId';

  static String requestMaintenanceDeleteAttachment(int attachmentId) =>
      '/v1/asset-affairs-service/maintenance/attachment/$attachmentId';

  /// ===================== TASK APIs =====================

  static String requestMaintenanceAssignTask(int requestId) =>
      '/v1/asset-affairs-service/maintenance/request/$requestId/assign-task';

  static String requestMaintenanceUpdateTaskStatus(int requestId) =>
      '/v1/asset-affairs-service/maintenance/request/$requestId/task-status';

  static String requestMaintenanceClarification(int requestId) =>
      '/v1/asset-affairs-service/maintenance/request/$requestId/clarification';

  /// ===================== ANALYTICS APIs =====================

  static const String requestMaintenanceKpiCards =
      '/v1/asset-affairs-service/maintenance/analytics/kpi-cards';

  static const String requestMaintenanceStatusBreakdown =
      '/v1/asset-affairs-service/maintenance/analytics/status-breakdown';

  static const String requestMaintenanceTrendBreakdown =
      '/v1/asset-affairs-service/maintenance/analytics/trend-breakdown';

  static const String requestMaintenanceApprovalKpiCards =
      '/v1/asset-affairs-service/maintenance/analytics/approvals/kpi-cards';

  static const String requestMaintenanceApprovalStatusBreakdown =
      '/v1/asset-affairs-service/maintenance/analytics/approvals/status-breakdown';
  static const String requestMaintenanceApprovalTrendBreakdown =
      '/v1/asset-affairs-service/maintenance/analytics/approvals/trend-breakdown';
  static const String requestMaintenanceStations =
      '/v1/user-service/station/all';

  /// Maintenance of External Stations APIs
  static const String externalMaintenanceSendRequest =
      '/v1/asset-affairs-service/maintenance-external-stations/request';
  static const String externalMaintenanceGetRequests =
      '/v1/asset-affairs-service/maintenance-external-stations/requests';
  static const String externalMaintenanceGetAllRequests =
      '/v1/asset-affairs-service/maintenance-external-stations/requests';
  static const String externalMaintenanceGetActionItems =
      '/v1/asset-affairs-service/maintenance-external-stations/requests/for-approval';
  static String externalMaintenanceRequestById(int requestId) =>
      '/v1/asset-affairs-service/maintenance-external-stations/request/$requestId';
  static String externalMaintenanceById(int requestId) =>
      externalMaintenanceRequestById(requestId);
  static String externalMaintenanceUpdateRequest(int requestId) =>
      externalMaintenanceRequestById(requestId);
  static const String externalMaintenanceApprove =
      '/v1/asset-affairs-service/maintenance-external-stations/approve';
  static const String externalMaintenanceReject =
      '/v1/asset-affairs-service/maintenance-external-stations/reject';
  static String externalMaintenanceSendChatById(int requestId) =>
      '/v1/asset-affairs-service/maintenance-external-stations/request/$requestId/chat';
  static String externalMaintenanceChatsById(int requestId) =>
      '/v1/asset-affairs-service/maintenance-external-stations/request/$requestId/chats';
  static String externalMaintenanceUpdateChat(int chatId) =>
      '/v1/asset-affairs-service/maintenance-external-stations/chat/$chatId';
  static String externalMaintenanceDeleteChat(int chatId) =>
      '/v1/asset-affairs-service/maintenance-external-stations/chat/$chatId';
  static String externalMaintenanceSendAttachmentById(int requestId) =>
      '/v1/asset-affairs-service/maintenance-external-stations/request/$requestId/attachment';
  static String externalMaintenanceAttachmentsById(int requestId) =>
      '/v1/asset-affairs-service/maintenance-external-stations/request/$requestId/attachments';
  static String externalMaintenanceUpdateAttachment(int attachmentId) =>
      '/v1/asset-affairs-service/maintenance-external-stations/attachment/$attachmentId';
  static String externalMaintenanceDeleteAttachment(int attachmentId) =>
      '/v1/asset-affairs-service/maintenance-external-stations/attachment/$attachmentId';
  static String externalMaintenanceAssignTask(int requestId) =>
      '/v1/asset-affairs-service/maintenance-external-stations/request/$requestId/assign-task';
  static String externalMaintenanceUpdateTaskStatus(int requestId) =>
      '/v1/asset-affairs-service/maintenance-external-stations/request/$requestId/task-status';
  static String externalMaintenanceClarification(int requestId) =>
      '/v1/asset-affairs-service/maintenance-external-stations/request/$requestId/clarification';
  static const String externalMaintenanceKpiCards =
      '/v1/asset-affairs-service/maintenance-external-stations/analytics/kpi-cards';
  static const String externalMaintenanceStatusBreakdown =
      '/v1/asset-affairs-service/maintenance-external-stations/analytics/status-breakdown';
  static const String externalMaintenanceTrendBreakdown =
      '/v1/asset-affairs-service/maintenance-external-stations/analytics/trend-breakdown';
  static const String externalMaintenanceApprovalKpiCards =
      '/v1/asset-affairs-service/maintenance-external-stations/analytics/approvals/kpi-cards';
  static const String externalMaintenanceApprovalStatusBreakdown =
      '/v1/asset-affairs-service/maintenance-external-stations/analytics/approvals/status-breakdown';
  static const String externalMaintenanceApprovalTrendBreakdown =
      '/v1/asset-affairs-service/maintenance-external-stations/analytics/approvals/trend-breakdown';
  static const String externalMaintenanceStations =
      '/v1/user-service/station/all';

  /// Complaint Lost Property APIs
  /// ===================== SEND REQUEST =====================

  static const String complaintLostPropertySendRequest =
      '/v1/security-access-service/complaint-lost-property-report/request';

  /// ===================== GET REQUESTS =====================

  static const String complaintLostPropertyGetRequests =
      '/v1/security-access-service/complaint-lost-property-report/requests';

  static const String complaintLostPropertyGetActionItems =
      '/v1/security-access-service/complaint-lost-property-report/requests/for-approval';

  /// ===================== REQUEST DETAILS =====================

  static String complaintLostPropertyById(int requestId) =>
      '/v1/security-access-service/complaint-lost-property-report/request/$requestId';

  static String complaintLostPropertyRequestById(int requestId) =>
      '/v1/security-access-service/complaint-lost-property-report/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String complaintLostPropertyApprove =
      '/v1/security-access-service/complaint-lost-property-report/approve';

  /// ===================== CHAT APIs =====================

  static String complaintLostPropertySendChatById(int requestId) =>
      '/v1/security-access-service/complaint-lost-property-report/request/$requestId/chat';

  static String complaintLostPropertyChatsById(int requestId) =>
      '/v1/security-access-service/complaint-lost-property-report/request/$requestId/chats';

  static String complaintLostPropertyChatById(int requestId) =>
      '/v1/security-access-service/complaint-lost-property-report/request/$requestId/chat';

  static String complaintLostPropertyGetChatById(int requestId, int chatId) =>
      '/v1/security-access-service/complaint-lost-property-report/request/$requestId/chat/$chatId';

  static String complaintLostPropertyDeleteChat(int requestId, int chatId) =>
      '/v1/security-access-service/complaint-lost-property-report/request/$requestId/chat/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  static String complaintLostPropertySendAttachmentById(int requestId) =>
      '/v1/security-access-service/complaint-lost-property-report/request/$requestId/attachment';

  static String complaintLostPropertyAttachmentsById(int requestId) =>
      '/v1/security-access-service/complaint-lost-property-report/request/$requestId/attachments';

  static String complaintLostPropertyAttachmentById(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/security-access-service/complaint-lost-property-report/request/$requestId/attachment/$attachmentId';

  static String complaintLostPropertyDeleteAttachment(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/security-access-service/complaint-lost-property-report/request/$requestId/attachment/$attachmentId';

  /// ===================== ANALYTICS APIs =====================

  static const String complaintLostPropertyKpiCards =
      '/v1/security-access-service/complaint-lost-property-report/analytics/kpi-cards';

  static const String complaintLostPropertyApprovalKpiCards =
      '/v1/security-access-service/complaint-lost-property-report/analytics/approval-kpi-cards';

  static const String complaintLostPropertyStatusBreakdown =
      '/v1/security-access-service/complaint-lost-property-report/analytics/status-breakdown';

  static const String complaintLostPropertyTrendBreakdown =
      '/v1/security-access-service/complaint-lost-property-report/analytics/trend-breakdown';

  static const String complaintLostPropertyApprovalStatusBreakdown =
      '/v1/security-access-service/complaint-lost-property-report/analytics/approval-status-breakdown';

  static const String complaintLostPropertyApprovalTrendBreakdown =
      '/v1/security-access-service/complaint-lost-property-report/analytics/approval-trend-breakdown';

  /// Import Export Material APIs
  /// ===================== SEND REQUEST =====================

  static const String importExportMaterialSendRequest =
      '/v1/security-access-service/import-export-material/request';

  /// ===================== GET REQUESTS =====================

  static const String importExportMaterialGetRequests =
      '/v1/security-access-service/import-export-material/requests';

  static const String importExportMaterialGetActionItems =
      '/v1/security-access-service/import-export-material/requests/for-approval';

  /// ===================== REQUEST DETAILS =====================

  static String importExportMaterialById(int requestId) =>
      '/v1/security-access-service/import-export-material/request/$requestId';

  static String importExportMaterialRequestById(int requestId) =>
      '/v1/security-access-service/import-export-material/request/$requestId';

  /// ===================== APPROVE / REJECT =====================

  static const String importExportMaterialApprove =
      '/v1/security-access-service/import-export-material/approve';

  static const String importExportMaterialReject =
      '/v1/security-access-service/import-export-material/reject';

  /// ===================== CHAT APIs =====================

  static String importExportMaterialSendChatById(int requestId) =>
      '/v1/security-access-service/import-export-material/request/$requestId/chat';

  static String importExportMaterialChatsById(int requestId) =>
      '/v1/security-access-service/import-export-material/request/$requestId/chats';

  static String importExportMaterialChatById(int requestId) =>
      '/v1/security-access-service/import-export-material/request/$requestId/chat';

  static String importExportMaterialGetChatById(int requestId, int chatId) =>
      '/v1/security-access-service/import-export-material/request/$requestId/chat/$chatId';

  static String importExportMaterialDeleteChat(int requestId, int chatId) =>
      '/v1/security-access-service/import-export-material/request/$requestId/chat/$chatId';

  /// ===================== ATTACHMENT APIs =====================

  static String importExportMaterialSendAttachmentById(int requestId) =>
      '/v1/security-access-service/import-export-material/request/$requestId/attachment';

  static String importExportMaterialAttachmentsById(int requestId) =>
      '/v1/security-access-service/import-export-material/request/$requestId/attachments';

  static String importExportMaterialAttachmentById(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/security-access-service/import-export-material/request/$requestId/attachment/$attachmentId';

  static String importExportMaterialDeleteAttachment(
    int requestId,
    int attachmentId,
  ) =>
      '/v1/security-access-service/import-export-material/request/$requestId/attachment/$attachmentId';

  /// ===================== ANALYTICS APIs =====================

  static const String importExportMaterialKpiCards =
      '/v1/security-access-service/import-export-material/analytics/kpi-cards';

  static const String importExportMaterialApprovalKpiCards =
      '/v1/security-access-service/import-export-material/analytics/approval-kpi-cards';

  static const String importExportMaterialStatusBreakdown =
      '/v1/security-access-service/import-export-material/analytics/status-breakdown';

  static const String importExportMaterialTrendBreakdown =
      '/v1/security-access-service/import-export-material/analytics/trend-breakdown';

  static const String importExportMaterialApprovalStatusBreakdown =
      '/v1/security-access-service/import-export-material/analytics/approval-status-breakdown';

  static const String importExportMaterialApprovalTrendBreakdown =
      '/v1/security-access-service/import-export-material/analytics/approval-trend-breakdown';
}
