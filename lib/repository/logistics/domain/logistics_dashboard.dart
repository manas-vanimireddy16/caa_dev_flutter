import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/activityField.dart';
import 'package:code_setup/presentation/screens/logistics/models/all_request_dashboard.dart';
import 'package:code_setup/presentation/screens/logistics/models/dashBoardRequest.dart';
import 'package:code_setup/presentation/screens/logistics/models/kpi.dart';
import 'package:code_setup/presentation/screens/logistics/models/kpi_employee.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/status_breakdown.dart';
import 'package:code_setup/repository/logistics/data/logistics_dashboard_imple.dart';

abstract class LogisticsDashboardRepository {
  factory LogisticsDashboardRepository() =>
      LogisticsDashboardRepositoryImplementation();

  Future<void> sendVehicleRequest(Map<String, dynamic> payload);
  Future<CombinedKpiLogisticsResponse?> getKpiData();
  Future<CombinedKpiLogisticsResponse?> getKpiDataEmployee();
  Future<CombinedKpiLogisticsResponse?> getKpiDataForeigner();
  Future<List<ActivityFeedData>> getActivityFeed();
  Future<List<RequestData>> getEmployeeRequestData({
    required int offset,
    required int limit,
    String sortBy,
    String sortOrder,
    String status,
    String searchText,
  });
  Future<List<RequestData>> getDashboardRequestData({
    required int offset,
    required int limit,
    String sortBy,
    String sortOrder,
    String status,
    String searchText,
  });
  Future<StatusBreakdownModel> getStatusBreakdown(String period);
  Future<LogisticsTrendBreakdownModel> getTrendBreakdown(String period);
  Future<LogisticsRequestDetailModel?> getRequestDetailsById(int id);
  Future<String> sendChat(Map<String, dynamic> payload, int id, String type);
  Future<List<dynamic>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  );
  Future<List<AllRequestsDashboardData>> getAllRequestData({
    required int offset,
    required int limit,
    String sortBy,
    String sortOrder,
    String status,
    String searchText,
  });
}
