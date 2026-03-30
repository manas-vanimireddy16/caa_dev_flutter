import 'package:code_setup/presentation/screens/hr_service/models/duty_mission_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/position_model.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/repository/hr_service/annual_duty_mission/data/data.dart';
import 'package:code_setup/repository/hr_service/service_transfer/data/data.dart';
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

abstract class AnnualDutyMissionRepoistry {
  factory AnnualDutyMissionRepoistry() => AnnualDutyMissionRepoistryImple();

  /// ===================== MASTER DATA =====================
  Future<List<Position>> getPositions();
  Future<List<EmployeeList>> getUsers();

  /// ===================== REQUEST =====================
  Future<void> sendAnnualDutyMissionRequest(Map<String, dynamic> payload);

  Future<RequestDetailData?> getRequestsById(int id);

  /// ===================== ATTACHMENTS =====================
  Future<List<Map<String, dynamic>>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  );

  /// ===================== REQUEST LIST =====================
  Future<List<DutyMissionModel>> getRequests({
    required int offset,
    required int limit,
    required String tripType,
    String status = '',
    String searchText = '',
  });
  Future<List<DutyMissionModel>> getMissionIdDropDownValues({
    required String tripType,
  });

  Future<List<DutyMissionModel>> getActionItems({
    required int offset,
    required int limit,
    required String tripType,
    String status = '',
    String searchText = '',
  });

  Future<List<ThreatRequestDetail>> getCombinedActionItems({
    required int offset,
    required int limit,
    required String tripType,
    String status = '',
    String searchText = '',
  });

  /// ===================== KPI =====================
  Future<KPIResponse?> getKpiData(
    int serviceId,
    int subServiceId,
    String tripType,
  );

  Future<KPIResponse?> getApprovalKpiData(
    int serviceId,
    int subServiceId,
    String tripType,
  );

  Future<KPIResponse?> getCombinedKpiData(String tripType);

  Future<KPIResponse?> getCombinedApprovalKpiData(String tripType);

  /// ===================== APPROVAL ACTIONS =====================
  Future<void> onApprove(Map<String, dynamic> payload);
  Future<void> onReject(Map<String, dynamic> payload);

  Future<void> onEventChange(int requestId, Map<String, dynamic> payload);

  /// ===================== CHAT =====================
  Future<String> sendChat(Map<String, dynamic> payload, int requestId);

  Future<List<ChatMessageModel>> getchatById(int requestId);

  /// ===================== ASSIGN / REPLACE =====================
  Future<List<PendingApprovalUser>> getEngineersList(int requestId);
  Future<List<MasterRolesModel>> getRolesList();

  Future<void> onAssignEngineer(Map<String, dynamic> payload);
  Future<void> onAssignEmployee(Map<String, dynamic> payload);
  Future<void> onReplaceEmployee(Map<String, dynamic> payload);

  /// ===================== EMPLOYEE =====================
  Future<List<EmployeeSummary>> getEmployeeList({
    required int departmentId,
    required int sectionId,
    required String roleId,
  });

  /// ===================== ANALYTICS =====================
  Future<StatusBreakdownModel?> getApprovalStatusBreakdownData(
    String period,
    String tripType,
  );

  Future<TrendBreakdownModel> getApprovalTrendBreakdownData(
    String period,
    String tripType,
  );

  Future<StatusBreakdownModel?> getStatusBreakdownData(
    String period,
    String tripType,
  );

  Future<TrendBreakdownModel> getTrendBreakdownData(
    String period,
    String tripType,
  );
}
