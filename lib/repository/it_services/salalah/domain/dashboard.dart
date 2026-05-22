import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/models.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/it_services/models/muscat_roles_model.dart';
import 'package:code_setup/presentation/screens/it_services/models/muscat_user_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/action_item_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/chat.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/it_technician.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestData.dart'
    hide Department;
import 'package:code_setup/presentation/screens/it_services/salalah/models/requestDetail.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/salalah_action_items_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/salalah_data_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/service_dropdown_model.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/models/status_break_down.dart';
import 'package:code_setup/repository/it_services/salalah/data/dashboardImplementation.dart';

abstract class DashboardRepository {
  factory DashboardRepository() => DashboardRepositoryImpl();

  Future<Map<String, dynamic>> sendRequest(Map<String, dynamic> payload);
  Future<void> selfAssign(Map<String, dynamic> payload);
  Future<void> onClose(Map<String, dynamic> payload);
  Future<List<Map<String, dynamic>>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  );
  Future<List<ServiceData>> getServices({
    required int serviceId,
    required int subServiceId,
  });
  Future<List<DepartmentModel>> getDepartments();
  Future<List<SalalahRequestModel>> getRequests({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',

    required int serviceId,
    required int subServiceId,
  });
  Future<List<ApprovalData>> getActionItems({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
    required int serviceId,
    required int subServiceId,
  });
  Future<String> sendChat(Map<String, dynamic> payload, int id);
  Future<String> sendAttachment(Map<String, dynamic> payload, int id);
  Future<List<ChatMessageModel>> getchatById(int id);
  Future<List<AttachmentModel>> getAttachmentsById(int id);

  Future<KPIResponse?> getApprovalKpiData({
    required int serviceId,
    required int subServiceId,
  });
  Future<RequestDetailData?> getRequestsById(int id);
  Future<KPIResponse?> getKpiData({
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
  Future<ITTechnicianListModel> getItTechnicianDetails({
    required int departmentId,
    required int sectionId,
  });
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
  Future<UsersResponseModel?> getUsers({
    required int departmentId,
    required int sectionId,
    required int roleId,
  });
  Future<RolesResponseModel?> getRoles({
    required int departmentId,
    required int sectionId,
  });
  Future<void> muscatAssign(Map<String, dynamic> payload);
}
