import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/hotel_reservation/models/request_data.dart';
import 'package:code_setup/presentation/screens/security_access/models/request_model.dart';
import 'package:code_setup/repository/common/data/data.dart';
import 'package:code_setup/repository/housing_accommodation_service/hotel_reservation/data/data.dart';
import 'package:flutter/foundation.dart';

abstract class CommonRepoistory {
  factory CommonRepoistory() => CommonRepositoryImpl();
  Future<dynamic> downloadFile(String id);
  Future<Uint8List> downloadAttachment({required String fileUrl});
}
