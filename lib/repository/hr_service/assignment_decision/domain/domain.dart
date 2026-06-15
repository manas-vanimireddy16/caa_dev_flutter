import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/master_roles.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/employee_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/position_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/request_data_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/temporary_decision.dart';
import 'package:code_setup/presentation/screens/hc_service/models/user_model.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_awareness_request_data.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_request_data.dart'
    hide ChatMessageModel;
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_reassign.dart';
import 'package:code_setup/repository/hr_service/assignment_decision/data/data.dart';

abstract class AssignmentDecisionRepoistory {
  factory AssignmentDecisionRepoistory() => AssignmentDecisionRepoistoryImple();
  Future<List<EmployeeSummary>> getEmployeeList({
    required int departmentId,
    required int sectionId,
    required String roleId,
  });

  Future<List<PendingApprovalUser>> getEngineersList(int id);
  Future<List<MasterRolesModel>> getRolesList();
  Future<List<Position>> getPositions();
  Future<List<Employee>> getUsers();

  Future<void> sendAssignmentDecisionRequest(Map<String, dynamic> payload);
  Future<List<Map<String, dynamic>>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  );
  Future<RequestDetailData?> getRequestsById(int id);
  Future<KPIResponse?> getKpiData({
    required int serviceId,
    required int subServiceId,
  });

  Future<List<TemporaryDecision>> getRequests({
    required int offset,
    required int limit,
    required int serviceId,
    required int subServiceId,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });
  // Future<List<OrganizeSecurityAwarenessRequestData>> getCombinedRequests({
  //   required int offset,
  //   required int limit,
  //   // String sortBy = 'created_at',
  //   // String sortOrder = 'DESC',
  //   String status = '', // 👈 changed to List
  //   String searchText = '',
  // });
  Future<List<TemporaryDecision>> getActionItems({
    required int offset,
    required int limit,
    required int serviceId,
    required int subServiceId,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });
  // Future<List<ThreatRequestDetail>> getCombinedActionItems({
  //   required int offset,
  //   required int limit,
  //   // String sortBy = 'created_at',
  //   // String sortOrder = 'DESC',
  //   String status = '', // 👈 changed to List
  //   String searchText = '',
  // });

  Future<KPIResponse?> getApprovalKpiData({
    required int serviceId,
    required int subServiceId,
  });
  Future<StatusBreakdownModel?> getApprovalStatusBreakdownData({
    required String period,
    required int serviceId,
    required int subServiceId,
  });
  Future<TrendBreakdownModel> getApprovalTrendBreakdownData({
    required String period,
    required int serviceId,
    required int subServiceId,
  });

  Future<StatusBreakdownModel?> getStatusBreakdownData({
    required String period,
    required int serviceId,
    required int subServiceId,
  });
  Future<TrendBreakdownModel> getTrendBreakdownData({
    required String period,
    required int serviceId,
    required int subServiceId,
  });
  // Future<KPIResponse?> getCombinedKpiData();
  // Future<KPIResponse?> getCombinedApprovalKpiData();

  Future<void> onApprove(Map<String, dynamic> payload);
  Future<void> onReject(Map<String, dynamic> payload);
  Future<void> onEventChange(int requestId, Map<String, dynamic> payload);

  Future<String> sendChat(Map<String, dynamic> payload, int id);
  Future<void> onAssignEngineer(Map<String, dynamic> payload);
  Future<List<ChatMessageModel>> getchatById(int id);

  Future<void> onAssignEmployee(Map<String, dynamic> payload);
  Future<void> onReplaceEmployee(Map<String, dynamic> payload);

  Future<String> sendAttachment(Map<String, dynamic> payload, int id);
  Future<List<AttachmentModel>> getAttachmentsById({required int id});
}
