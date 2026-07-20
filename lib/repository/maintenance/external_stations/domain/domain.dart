import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/maintenance/models/request_maintenance.dart';
import 'package:code_setup/presentation/screens/maintenance/models/station_model.dart';
import 'package:code_setup/repository/maintenance/external_stations/data/data.dart';

abstract class ExternalMaintenanceRepository {
  factory ExternalMaintenanceRepository() =>
      ExternalMaintenanceRepositoryImpl();

  Future<Map<String, dynamic>> externalMaintenanceCreateRequest(
    Map<String, dynamic> payload,
  );
  Future<Map<String, dynamic>> externalMaintenanceUpdateRequest(
    int requestId,
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

  Future<List<MaintenanceRequestModel>> getRequests({
    required int offset,
    required int limit,
    required int serviceId,
    required int subServiceId,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });

  Future<List<MaintenanceRequestModel>> getActionItems({
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
  Future<List<StationModel>> getStations();
}
