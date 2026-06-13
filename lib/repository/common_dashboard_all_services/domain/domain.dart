import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/dashboard_requests_approvals.dart';
import 'package:code_setup/repository/common_dashboard_all_services/data/data.dart';

abstract class CommonDashboardRepository {
  factory CommonDashboardRepository() => CommonDashboardRepositoryImpl();

  Future<KPIResponse?> getKpiData({
    required List<int> serviceIds,
    required List<int> subServiceIds,
  });
  Future<KPIResponse?> getApprovalKpiData({
    required List<int> serviceIds,
    required List<int> subServiceIds,
  });
  Future<List<DashboardRequestModel>> getRequests({
    required int offset,
    required int limit,
    required List<int> serviceIds,
    required List<int> subServiceIds,
    String searchText = '',
  });
  Future<List<DashboardRequestModel>> getActionItems({
    required int offset,
    required int limit,
    required List<int> serviceIds,
    required List<int> subServiceIds,
    String searchText = '',
  });

  Future<StatusBreakdownModel?> getApprovalStatusBreakdownData({
    required String period,
    required List<int> serviceIds,
    required List<int> subServiceIds,
  });
  Future<TrendBreakdownModel> getApprovalTrendBreakdownData({
    required String period,
    required List<int> serviceIds,
    required List<int> subServiceIds,
  });

  Future<StatusBreakdownModel?> getStatusBreakdownData({
    required String period,
    required List<int> serviceIds,
    required List<int> subServiceIds,
  });
  Future<TrendBreakdownModel> getTrendBreakdownData({
    required String period,
    required List<int> serviceIds,
    required List<int> subServiceIds,
  });
  Future<UserRoleResponse> getUserRoles(int id);
}
