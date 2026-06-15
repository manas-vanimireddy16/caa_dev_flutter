import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/hc_service/models/request_data_model.dart';
import 'package:code_setup/presentation/screens/media_services/models/request_data_model.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/presentation/screens/task_management/models/request_data_model.dart';
import 'package:code_setup/repository/media_coverage/request_for_coverage/data/data.dart';
import 'package:code_setup/repository/task_management/assign_a_task_to_employee/data/data.dart';
import 'package:flutter/foundation.dart';

abstract class RequestForCoverageRepository {
  factory RequestForCoverageRepository() => RequestForCoverageRepositoryImple();

  Future<List<EmployeeList>> getUsers(int departmentId);

  Future<void> sendRequestForCoverageRequest(Map<String, dynamic> payload);
  Future<List<Map<String, dynamic>>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  );
  Future<RequestDetailData?> getRequestsById({
    required int id,
    required int serviceId,
    required int subServiceId,
  });
  Future<KPIResponse?> getKpiData(int service_id, int sub_service_id);

  Future<List<MediaRequestModel>> getRequests({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });

  Future<List<MediaRequestModel>> getActionItems({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
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
  Future<StatusBreakdownModel?> getApprovalStatusBreakdownData(String period);
  Future<TrendBreakdownModel> getApprovalTrendBreakdownData(String period);

  Future<StatusBreakdownModel?> getStatusBreakdownData(String period);
  Future<TrendBreakdownModel> getTrendBreakdownData(String period);
}
