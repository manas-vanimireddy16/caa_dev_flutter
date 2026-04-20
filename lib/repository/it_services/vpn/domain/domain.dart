import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/it_services/vpn/models/technician.dart';
import 'package:code_setup/presentation/screens/it_services/vpn/models/vpn_request.dart';
import 'package:code_setup/presentation/screens/it_services/vpn/models/vpn_request_by_id.dart';
import 'package:code_setup/repository/it_services/vpn/data/data.dart';

abstract class VPNRepository {
  factory VPNRepository() => VPNRepoistoryImple();

  Future<List<VpnRequestData>> getVpnRequests({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });
  Future<List<VpnRequestData>> getVpnActionItems({
    required int offset,
    required int limit,
    // String sortBy = 'created_at',
    // String sortOrder = 'DESC',
    String status = '', // 👈 changed to List
    String searchText = '',
  });
  Future<VpnRequestByIdModel> getVpnRequestById({required int id});
  Future<KPIResponse> getKpiData();
  Future<TrendBreakdownModel> getTrendBreakdownData(String period);
  Future<StatusBreakdownModel> getStatusBreakdownData(String period);
  Future<List<dynamic>> uploadAttachments(
    List<Map<String, dynamic>> attachments,
  );
  Future<void> sendVPNTicket(Map<String, dynamic> payload);
  Future<TechniciansResponse> getTechnicianData({
    required int id,
    required int sectionId,
  });
  Future<void> sendAssign(Map<String, dynamic> payload);
  Future<void> approveorReject(Map<String, dynamic> payload);
  Future<void> sendChat(Map<String, dynamic> payload, int id);
  Future<void> sendAttachment(Map<String, dynamic> payload, int id);
}
