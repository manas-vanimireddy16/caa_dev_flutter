import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/hotel_reservation/models/request_data.dart';
import 'package:code_setup/presentation/screens/security_access/models/request_model.dart';
import 'package:code_setup/repository/housing_accommodation_service/dashboard/data/data.dart';
import 'package:code_setup/repository/housing_accommodation_service/hotel_reservation/data/data.dart';

abstract class HotelReservationDashboardRepoistory {
  factory HotelReservationDashboardRepoistory() =>
      HotelReservationDashboardRepoistoryImple();

  Future<RequestDetailData?> getRequestsById(int id);
  Future<KPIResponse?> getKpiData();
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

  Future<void> onClose(Map<String, dynamic> payload);
  Future<String> sendChat(Map<String, dynamic> payload, int id, String type);
}
