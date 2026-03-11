import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/models.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/action_item_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/chat.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/it_technician.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestData.dart'
    hide Department;
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestDetail.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/service_dropdown_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/status_break_down.dart';
import 'package:code_setup/repository/salalah/data/dashboardImplementation.dart';

abstract class DashboardRepository {
  factory DashboardRepository() => DashboardRepositoryImpl();

  Future<void> sendRequest(Map<String, dynamic> payload);
  Future<void> selfAssign(Map<String, dynamic> payload);
  Future<void> onClose(Map<String, dynamic> payload);
  Future<List<Map<String, dynamic>>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  );
  Future<List<ServiceData>> getServices();
  Future<List<DepartmentModel>> getDepartments();
  Future<List<RequestsData>> getRequests({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });
  Future<List<SalalahActionItem>> getActionItems({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });
  Future<RequestDetailData?> getRequestsById(int id);
  Future<KPIResponse?> getKpiData();
  Future<StatusBreakdownModel?> getStatusBreakdownData(String period);
  Future<TrendBreakdownModel> getTrendBreakdownData(String period);
  Future<ITTechnicianListModel> getItTechnicianDetails();
  Future<List<RequestMessageData>> getChats();
  Future<List<SectionModel>> getSections(int id);
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
}
