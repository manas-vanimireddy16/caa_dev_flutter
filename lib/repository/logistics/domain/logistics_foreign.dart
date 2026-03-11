import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/foreign_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_detail_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_foreign_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/logistics_trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/logistics/models/status_breakdown.dart';
import 'package:code_setup/repository/logistics/data/logistics_foreign_implementation.dart';

abstract class LogisticsForeignRepository {
  factory LogisticsForeignRepository() =>
      LogisticsForeignRepositoryImplementation();

  Future<void> sendForeignRequest(Map<String, dynamic> payload);
  Future<List<ForeignData>> getForeignRequestData();
  Future<StatusBreakdownModel> getStatusBreakdown(String period);
  Future<LogisticsTrendBreakdownModel> getForeignTrendBreakdown(String period);
  Future<LogisticsForeignDetailModel?> getRequestDetailsById(int id);
  Future<String> sendChat(Map<String, dynamic> payload, int id);
  // Future<CombinedKpiLogisticsResponse?> getKpiData();
  // Future<CombinedKpiLogisticsResponse?> getKpiDataEmployee();
  // Future<CombinedKpiLogisticsResponse?> getKpiDataForeigner();
}
