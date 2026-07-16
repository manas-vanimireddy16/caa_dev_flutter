import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/foundation.dart';

/// In-memory cache for department/section name lookups used by workflow UI.
///
/// When request/workflow payloads only include scalar IDs (`int`/`String`)
/// for department/section, resolve display names from:
/// - `GET /v1/user-service/admin/departments`
/// - `GET /v1/user-service/master/sections/listing`
abstract final class OrgDirectoryCache {
  OrgDirectoryCache._();

  static List<DepartmentModel> _departments = const [];
  static List<SectionModel> _sections = const [];
  static Future<void>? _loading;
  static bool _loaded = false;

  static List<DepartmentModel> get departments => _departments;
  static List<SectionModel> get sections => _sections;
  static bool get isLoaded => _loaded;

  static Future<void> ensureLoaded() {
    if (_loaded) return Future.value();
    return _loading ??= _load();
  }

  static Future<void> _load() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client == null) {
        _departments = const [];
        _sections = const [];
        _loaded = true;
        return;
      }

      final results = await Future.wait([
        client.get(ApiEndPoint.departments),
        client.get(
          ApiEndPoint.sections,
          queryParameters: const {'offset': 1, 'limit': 10000},
        ),
      ]);

      final deptResponse = results[0];
      final sectionResponse = results[1];

      if (deptResponse.statusCode == 200 &&
          deptResponse.data is Map<String, dynamic>) {
        final data = deptResponse.data['data'];
        if (data is List) {
          _departments = data
              .whereType<Map>()
              .map(
                (e) => DepartmentModel.fromJson(
                  Map<String, dynamic>.from(e),
                ),
              )
              .toList();
        }
      }

      if (sectionResponse.statusCode == 200 &&
          sectionResponse.data is Map<String, dynamic>) {
        final data = sectionResponse.data['data'];
        if (data is List) {
          _sections = data
              .whereType<Map>()
              .map(
                (e) => SectionModel.fromJson(
                  Map<String, dynamic>.from(e),
                ),
              )
              .toList();
        }
      }
    } catch (e, st) {
      debugPrint('OrgDirectoryCache load failed: $e');
      debugPrintStack(stackTrace: st);
      _departments = const [];
      _sections = const [];
    } finally {
      _loaded = true;
      _loading = null;
    }
  }

  static DepartmentModel? departmentById(int? id) {
    if (id == null || id <= 0) return null;
    for (final department in _departments) {
      if (department.id == id) {
        final name = department.displayName(isArabic: false).trim();
        if (name.isNotEmpty) return department;
      }
    }
    return null;
  }

  static SectionModel? sectionById(int? id) {
    if (id == null || id <= 0) return null;
    for (final section in _sections) {
      if (section.id == id) {
        final name = section.displayName(isArabic: false).trim();
        if (name.isNotEmpty) return section;
      }
    }
    return null;
  }
}
