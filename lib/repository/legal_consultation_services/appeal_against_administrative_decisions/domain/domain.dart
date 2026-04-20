import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/legal_consultation_services/models/appeal_against_administrative_model.dart';
import 'package:code_setup/presentation/screens/legal_consultation_services/models/legal_contract_review_model.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/repository/legal_consultation_services/appeal_against_administrative_decisions/data/data.dart';

abstract class AppealAgainstAdministrativeDecisionsRepository {
  factory AppealAgainstAdministrativeDecisionsRepository() =>
      AppealAgainstAdministrativeDecisionsRepositoryImple();

  Future<List<EmployeeList>> getUsers(int departmentId);

  Future<Map<String, dynamic>>
  sendAppealAgainstAdministrativeDecisionsNewRequest(
    Map<String, dynamic> payload,
  );
  Future<List<Map<String, dynamic>>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  );
  Future<RequestDetailData?> getRequestsById({
    required int id,
    required int serviceId,
    required int subServiceId,
  });
  Future<KPIResponse?> getKpiData(int serviceId, int subServiceId);

  Future<List<AppealAgainstAdministrativeModel>> getRequests({
    required int offset,
    required int limit,
    required int serviceId,
    required int subServiceId,
    String status = '',
    String searchText = '',
  });

  Future<List<AppealAgainstAdministrativeModel>> getActionItems({
    required int offset,
    required int limit,
    required int serviceId,
    required int subServiceId,
    String status = '',
    String searchText = '',
  });
  Future<KPIResponse?> getApprovalKpiData({
    required int serviceId,
    required int subServiceId,
  });
  Future<void> onApprove(Map<String, dynamic> payload);

  Future<String> sendChat(Map<String, dynamic> payload, int id);
  Future<String> sendAttachment(Map<String, dynamic> payload, int id);
  Future<List<ChatMessageModel>> getchatById(int id);
  Future<List<AttachmentModel>> getAttachmentsById(int id);

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
  Future<List<DepartmentModel>> getDepartments();
  Future<List<SectionModel>> getSections({required String? userDepartmentId});
}
