import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/repository/hr_service/temporary_assignment_decision/data/data.dart';
import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/master_roles.dart';
import 'package:code_setup/presentation/screens/hr_service/models/employee_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/request_data_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/user_model.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_reassign.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/security_threat_request_data.dart'
    hide ChatMessageModel;

import '../../../../presentation/screens/hr_service/models/position_model.dart';

abstract class TemporaryAssignmentDecisionRepoistry {
  factory TemporaryAssignmentDecisionRepoistry() =>
      TemporaryAssignmentDecisionRepoistryImple();

  Future<List<Position>> getPositions();
  Future<List<Employee>> getUsers();

  Future<void> sendAssignmentDecisionRequest(Map<String, dynamic> payload);
  Future<List<Map<String, dynamic>>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  );
  Future<RequestDetailData?> getRequestsById(int id);
  Future<KPIResponse?> getKpiData(int service_id, int sub_service_id);

  Future<List<AssignmentDecision>> getRequests({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });

  Future<List<AssignmentDecision>> getActionItems({
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

  Future<KPIResponse?> getApprovalKpiData(int service_id, int sub_service_id);
  Future<KPIResponse?> getCombinedKpiData();
  Future<KPIResponse?> getCombinedApprovalKpiData();

  Future<void> onAssignRejectClose(Map<String, dynamic> payload);
  Future<void> onEventChange(int requestId, Map<String, dynamic> payload);

  Future<String> sendChat(Map<String, dynamic> payload, int id);
  Future<List<PendingApprovalUser>> getEngineersList(int id);
  Future<List<MasterRolesModel>> getRolesList();
  Future<void> onAssignEngineer(Map<String, dynamic> payload);
  Future<List<ChatMessageModel>> getchatById(int id);
  Future<List<EmployeeSummary>> getEmployeeList({
    required int departmentId,
    required int sectionId,
    required String roleId,
  });
  Future<void> onAssignEmployee(Map<String, dynamic> payload);
  Future<void> onReplaceEmployee(Map<String, dynamic> payload);

  Future<StatusBreakdownModel?> getApprovalStatusBreakdownData(String period);
  Future<TrendBreakdownModel> getApprovalTrendBreakdownData(String period);

  Future<StatusBreakdownModel?> getStatusBreakdownData(String period);
  Future<TrendBreakdownModel> getTrendBreakdownData(String period);
}
