import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/master_roles.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/chat_model.dart';
import 'package:code_setup/presentation/screens/security_self/models/security_awareness_request_data.dart';
import 'package:code_setup/presentation/screens/security_self/models/security_threat_request_data.dart'
    hide ChatMessageModel;
import 'package:code_setup/presentation/screens/security_self/models/security_threat_reassign.dart';
import 'package:code_setup/repository/aviation_security_facilitation/airport_entry/data/data.dart';

abstract class AviationSecurityFacilitationRepoistory {
  factory AviationSecurityFacilitationRepoistory() =>
      AviationSecurityFacilitationRepoistoryImple();

  Future<void> sendAirportEntryRequest(Map<String, dynamic> payload);
  Future<List<Map<String, dynamic>>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  );
  Future<RequestDetailData?> getRequestsById(int id);
  Future<KPIResponse?> getKpiData();
  Future<StatusBreakdownModel?> getStatusBreakdownData(String period);
  Future<TrendBreakdownModel> getTrendBreakdownData(String period);
  Future<List<OrganizeSecurityAwarenessRequestData>> getRequests({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });
  Future<List<OrganizeSecurityAwarenessRequestData>> getCombinedRequests({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });
  Future<List<OrganizeSecurityAwarenessRequestData>> getActionItems({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });
  Future<List<ThreatRequestDetail>> getCombinedActionItems({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });

  Future<KPIResponse?> getApprovalKpiData();
  Future<KPIResponse?> getCombinedKpiData();
  Future<KPIResponse?> getCombinedApprovalKpiData();
  Future<StatusBreakdownModel?> getApprovalStatusBreakdownData(String period);
  Future<TrendBreakdownModel> getApprovalTrendBreakdownData(String period);

  Future<StatusBreakdownModel?> getCombinedStatusBreakdownData(String period);
  Future<TrendBreakdownModel> getCombinedTrendBreakdownData(String period);

  Future<StatusBreakdownModel?> getCombinedApprovalStatusBreakdownData(
    String period,
  );
  Future<TrendBreakdownModel> getCombinedApprovalTrendBreakdownData(
    String period,
  );

  Future<void> onAssignRejectClose(Map<String, dynamic> payload);
  Future<void> onEventChange(int requestId, Map<String, dynamic> payload);

  Future<String> sendChat(Map<String, dynamic> payload, int id);
  Future<List<PendingApprovalUser>> getEngineersList(int id);
  Future<List<MasterRolesModel>> getRolesList();
  Future<void> onAssignEngineer(Map<String, dynamic> payload);
  Future<List<ChatMessageModel>> getchatById(int id);
}
