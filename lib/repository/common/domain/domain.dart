import 'dart:typed_data';

import 'package:code_setup/repository/common/data/data.dart';

abstract class CommonRepository {
  factory CommonRepository() => CommonRepositoryImpl();

  /// Downloads attachment bytes using the authenticated API client.
  Future<Uint8List> downloadAttachment({required String fileUrl});

  /// Resolves a relative document id or path into a request path/URL.
  String resolveDownloadPath(String fileUrl);
}
