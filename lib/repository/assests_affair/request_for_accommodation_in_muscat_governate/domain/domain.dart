import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/asset_affairs/models/accommodation_in_muscat_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/employee_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/grade_list_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/human_resource_annual_plan.dart';
import 'package:code_setup/presentation/screens/hr_service/models/payment_of_cash_allowance_for_leave_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/required_new_resource_model.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/presentation/screens/training_and_development/models/location_model.dart';
import 'package:code_setup/repository/assests_affair/request_for_accommodation_in_muscat_governate/data/data.dart';
import 'package:code_setup/repository/hr_service/payment_of_cash_allowance_for_leave/data/data.dart';
import 'package:code_setup/repository/hr_service/request_for_human_resource_annual_planning/data/data.dart';
import 'package:code_setup/repository/hr_service/required_new_resource/data/data.dart';

abstract class RequestForAccommodationInMuscatGovernateRepository {
  factory RequestForAccommodationInMuscatGovernateRepository() =>
      RequestForAccommodationInMuscatGovernateRepositoryImple();

  Future<List<EmployeeList>> getUsers(int departmentId);

  Future<Map<String, dynamic>>
  sendRequestForAccommodationInMuscatGovernateRequest(
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
  Future<LocationListResponseModel>? getLocations();

  Future<List<AccommodationRequestModel>> getRequests({
    required int offset,
    required int limit,
    required int serviceId,
    required int subServiceId,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });

  Future<List<AccommodationRequestModel>> getActionItems({
    required int offset,
    required int limit,
    required int serviceId,
    required int subServiceId,
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
  Future<void> onAssignEmployee(Map<String, dynamic> payload);
  Future<List<EmployeeSummary>> getEmployeeList({
    required int departmentId,
    required int sectionId,
    required String roleId,
  });
  Future<List<Grade>> getGradeList();
}
