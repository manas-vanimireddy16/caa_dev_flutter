import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/hotel_reservation/models/request_data.dart';
import 'package:code_setup/presentation/screens/security_access/models/request_model.dart';
import 'package:code_setup/repository/housing_accommodation_service/hotel_reservation/data/data.dart';

abstract class HotelReservationRepoistory {
  factory HotelReservationRepoistory() => HotelReservationRepoistoryImple();

  Future<void> sendHotelReservationRequest(Map<String, dynamic> payload);
  Future<List<Map<String, dynamic>>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  );
  Future<RequestDetailData?> getRequestsById(int id);
  Future<KPIResponse?> getKpiData();
  Future<StatusBreakdownModel?> getStatusBreakdownData(String period);
  Future<TrendBreakdownModel> getTrendBreakdownData(String period);
  Future<List<HotelReservationRequestModel>> getRequests({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });
  Future<List<HotelReservationRequestModel>> getActionItems({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });

  Future<KPIResponse?> getApprovalKpiData();
  Future<StatusBreakdownModel?> getApprovalStatusBreakdownData(String period);
  Future<TrendBreakdownModel> getApprovalTrendBreakdownData(String period);

  Future<void> onClose(Map<String, dynamic> payload);
  Future<String> sendChat(Map<String, dynamic> payload, int id, String type);

  Future<List<DepartmentModel>> getDepartments();
}
