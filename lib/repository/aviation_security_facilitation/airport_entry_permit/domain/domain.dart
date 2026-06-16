import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/airport_entry_request_model.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/nationality_list_model.dart';
import 'package:code_setup/presentation/screens/it_services/models/event_support_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/request_vehicle_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/vehicle_maintenance_model.dart';
import 'package:code_setup/presentation/screens/task_management/models/employee_model.dart';
import 'package:code_setup/presentation/screens/tender_service/models/respond_to_enquiry.dart';
import 'package:code_setup/presentation/screens/training_and_development/models/cancel_request_model.dart';
import 'package:code_setup/repository/aviation_security_facilitation/airport_entry_permit/data/data.dart';
import 'package:code_setup/repository/logistics/request_a_vehicle/data/data.dart';
import 'package:code_setup/repository/logistics/vehicle_maintenance/data/data.dart';
import 'package:code_setup/repository/tender_services/request_a_service_to_respond_to_enquiries/data/data.dart';

abstract class AirportEntryPermitRepository {
  factory AirportEntryPermitRepository() => AirportEntryPermitRepositoryImpl();

  Future<List<EmployeeList>> getUsers(int departmentId);

  Future<Map<String, dynamic>> airportEntryCreateRequest(
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

  Future<List<AirportPermitRequestModel>> getRequests({
    required int offset,
    required int limit,
    required int serviceId,
    required int subServiceId,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });

  Future<List<AirportPermitRequestModel>> getActionItems({
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
  Future<List<ChatMessageModel>> getchatById({
    required int id,
    required int serviceId,
    required int subServiceId,
  });
  Future<List<AttachmentModel>> getAttachmentsById({
    required int id,
    required int serviceId,
    required int subServiceId,
  });
  Future<void> deleteAttachment(int attachmentId, {int? requestId});

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
  Future<void> onAllocateVehicle(Map<String, dynamic> payload, int requestId);
  Future<List<NationalityData>> getNationalityList();
}
