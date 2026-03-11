import 'package:code_setup/repository/request_details/data/request_detail_imple.dart';

abstract class RequestDetailRepository {
  factory RequestDetailRepository() => RequestDetailImple();

  Future<String> sendChat(Map<String, dynamic> payload, int id);
}
