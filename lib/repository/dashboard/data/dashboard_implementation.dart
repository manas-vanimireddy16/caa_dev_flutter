import 'dart:developer';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/models.dart';
import 'package:code_setup/presentation/models/sections.dart';
import 'package:code_setup/presentation/models/userIdModel.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/announcementsModels.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/bookmarksModel.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/dashboard_requests_approvals.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/important_links_model.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/userModel.dart';
import 'package:code_setup/repository/dashboard/domain/dashboard.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DashboardRepositoryImplementation implements DashboardRepository {
  @override
  Future<List<Bookmarksmodel>> getBookmarks() async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final userInfo = KAppX.globalProvider.read(userInfoProvider);
        final String userId = userInfo?.data?.id ?? '0';
        final String url = ApiEndPoint.getBookmarks(userId);

        final response = await client.get(url);

        if (response.statusCode == 200 && response.data != null) {
          debugPrint('✅ Bookmarks fetched successfully');

          final data = Map<String, dynamic>.from(response.data);

          final list = data['data'] as List<dynamic>? ?? [];

          return list
              .map<Bookmarksmodel>(
                (item) => Bookmarksmodel.fromJson(item as Map<String, dynamic>),
              )
              .toList();
        } else {
          debugPrint('⚠️ Failed to fetch bookmarks: ${response.statusCode}');

          throw ApiException(
            response.data?['message'] ?? 'Something went wrong',
          );
        }
      } else {
        debugPrint('❌ Client is null — cannot fetch bookmarks');

        return [];
      }
    } on DioException catch (e) {
      debugPrint('❌ Dio error: ${e.response?.data ?? e.message}');

      final message = e.response?.data['message'] ?? e.message;

      throw ApiException(message);
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');

      throw ApiException('Error fetching bookmarks: $e');
    }
  }
  // @override
  // Future<ServiceModel> getServices() async {
  //   final client = Dio();

  //   try {
  //     final url = 'https://caa.altomouhit.com/v1/user-service/services';
  //     final response = await client.get(
  //       url,
  //       options: Options(
  //         headers: {'jwt': token, 'Content-Type': 'application/json'},
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = response.data as Map<String, dynamic>;
  //       return ServiceModel.fromJson(data); // ✅ single response
  //     } else {
  //       throw Exception('Failed with status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error in getServices: $e');
  //   }
  // }

  @override
  Future<List<DepartmentResponse>> getDepartmentsUsersCount() async {
    final client = Dio();

    try {
      final url = ApiEndPoint.getSections;
      //      'https://caa.altomouhit.com/v1/user-service/department/users/count';
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        if (data['status'] == 'success' && data['data'] is List) {
          return (data['data'] as List)
              .map(
                (e) => DepartmentResponse.fromJson(e as Map<String, dynamic>),
              )
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in getBookmarks: $e');
    }
  }

  @override
  Future<List<DepartmentListResponse>> getDepartments() async {
    final client = Dio();

    try {
      final url = ApiEndPoint.getDepartments;
      //'https://caa.altomouhit.com/v1/user-service/departments';
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        if (data['status'] == 'success' && data['data'] is List) {
          return (data['data'] as List)
              .map(
                (e) =>
                    DepartmentListResponse.fromJson(e as Map<String, dynamic>),
              )
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in getBookmarks: $e');
    }
  }

  @override
  Future<UserModel> getUser(int id) async {
    try {
      final client = await KAppX.network.secureClient();

      // ❌ secureClient returned null → token missing or expired
      if (client == null) {
        throw Exception("Auth client is null. Token missing or expired.");
      }

      final url = ApiEndPoint.userInfo(id);
      final response = await client.get(url);

      // ✅ success case
      if (response.statusCode == 200) {
        final data = response.data;

        if (data is! Map<String, dynamic>) {
          throw Exception("Invalid user response format.");
        }

        return UserModel.fromJson(data);
      }

      // ❌ non-200 code
      throw Exception(
        "Failed to fetch user. Status: ${response.statusCode}, Message: ${response.statusMessage}",
      );
    } catch (e) {
      // 🔥 Catch DioException separately for clarity
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          throw Exception("Unauthorized (401). Token expired or invalid.");
        }
        throw Exception("Dio error: ${e.message}");
      }

      throw Exception("Error in getUser: $e");
    }
  }

  @override
  Future<List<EmployeesResponse>> getUserById() async {
    final client = Dio();

    try {
      final url = ApiEndPoint.getSections;
      //  'https://caa.altomouhit.com/v1/user-service/department/users/count';
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        if (data['status'] == 'success' && data['data'] is List) {
          return (data['data'] as List)
              .map((e) => EmployeesResponse.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in getUserbyId: $e');
    }
  }

  @override
  Future<List<SectionResponse>> getSections() async {
    final client = Dio();

    try {
      final url = ApiEndPoint.getSections;
      // 'https://caa.altomouhit.com/v1/user-service/department/users/count';
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        if (data['status'] == 'success' && data['data'] is List) {
          return (data['data'] as List)
              .map((e) => SectionResponse.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in getBookmarks: $e');
    }
  }

  @override
  Future<List<AnnouncementModel>> getModels() async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final url = ApiEndPoint.caaDrupal;
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final data = response.data as List;
          return data
              .map((e) => AnnouncementModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Failed with status code: ${response.statusCode}');
        }
      } else
        return [];
    } catch (e) {
      throw Exception('Error in getModels: $e');
    }
  }

  @override
  Future<void> updateBookmark({required int serviceId}) async {
    final client = await KAppX.network.secureClient();

    final userInfo = KAppX.globalProvider.read(userInfoProvider);
    final String userId = userInfo?.data?.id ?? '0';
    final String url = ApiEndPoint.updateBookmark;

    final payload = {"user_id": userId, "service_id": serviceId};

    try {
      if (client != null) {
        final response = await client.post(url, data: payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('✅ Bookmark updated successfully');

          debugPrint(response.data.toString());

          // ShowFlutterToast().showFlutterToastSuccess(
          //   response.data['message'] ??
          //       'Bookmark updated successfully',
          // );
        } else {
          debugPrint('⚠️ Failed to update bookmark: ${response.statusCode}');

          throw ApiException(
            response.data?['message'] ?? 'Something went wrong',
          );
        }
      } else {
        debugPrint('❌ Client is null — cannot update bookmark');

        throw ApiException('Client is null');
      }
    } on DioException catch (e) {
      debugPrint('❌ Dio error: ${e.response?.data ?? e.message}');

      final message = e.response?.data['message'] ?? e.message;

      throw ApiException(message);
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');

      throw ApiException('Error updating bookmark: $e');
    }
  }

  @override
  Future<List<DashboardRequestModel>> getRequestsData({
    required int offset,
    required int limit,
    required List<int> serviceIds,
    required List<int> subServiceIds,
    String searchText = '',
  }) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final Map<String, dynamic> queryParams = {
          'service_ids': serviceIds.join(','),
          'sub_service_ids': subServiceIds.join(','),

          'offset': offset,
          'limit': limit,
        };

        if (searchText.isNotEmpty) {
          queryParams['search_text'] = searchText;
        }

        final url = ApiEndPoint.dashboardMyRequests;
        final response = await client.get(url, queryParameters: queryParams);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          final List<dynamic> list = data['data'];

          return list
              .map(
                (e) =>
                    DashboardRequestModel.fromJson(e as Map<String, dynamic>),
              )
              .toList();
        } else {
          throw Exception(
            'Failed to fetch Accommodation Muscat request: ${response.statusCode}',
          );
        }
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching Accommodation Muscat request: $e");
    }
  }

  @override
  Future<List<DashboardRequestModel>> getActionItems({
    required int offset,
    required int limit,
    required List<int> serviceIds,
    required List<int> subServiceIds,
    String searchText = '',
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final queryParams = {
          'offset': offset.toString(),
          'limit': limit.toString(),
          'service_ids': serviceIds.join(','),
          'sub_service_ids': subServiceIds.join(','),
        };

        if (searchText.isNotEmpty) {
          queryParams['search_text'] = searchText;
        }

        final response = await client.get(
          ApiEndPoint.dashboardActionItems,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);

          final List<dynamic> list = data['data'] ?? [];

          /// Parse each Action Item
          final actionItems = list
              .map(
                (item) => DashboardRequestModel.fromJson(
                  item as Map<String, dynamic>,
                ),
              )
              .toList();

          return actionItems;
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }

      /// If client is null
      return [];
    } on DioException catch (error) {
      final message =
          '${error.response?.data['message']} Accommodation Muscat request';
      throw ApiException(message);
    } catch (e) {
      throw ApiException('${e.toString()} Accommodation Muscat request');
    }
  }

  @override
  Future<ImportantLinksResponse> getImportantLinks({
    String searchText = '',
    int offset = 1,
    int limit = 10,
  }) async {
    final client = await KAppX.network.secureClient();

    try {
      if (client == null) {
        return const ImportantLinksResponse(data: [], totalCount: 0);
      }

      final response = await client.get(
        ApiEndPoint.importantLinks,
        queryParameters: {
          'search_text': searchText,
          'offset': offset.toString(),
          'limit': limit.toString(),
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = Map<String, dynamic>.from(response.data);
        return ImportantLinksResponse.fromJson(data);
      }

      throw ApiException(
        response.data?['message'] ?? 'Failed to fetch important links',
      );
    } on DioException catch (error) {
      final message = error.response?.data?['message'] ?? error.message;
      throw ApiException(message ?? 'Failed to fetch important links');
    } catch (e) {
      throw ApiException('Error fetching important links: $e');
    }
  }

  @override
  Future<KPIResponse?> getApprovalKpiData({
    required List<int> serviceIds,
    required List<int> subServiceIds,
  }) async {
    String url = ApiEndPoint.dashboardApprovalKpi;
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        // final queryParams = {
        //   'service_id': serviceId,
        //   'sub_service_id': subServiceId,
        // };
        final response = await client.get(url);

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          return KPIResponse.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return null;
    } on DioException catch (error) {
      log('caught dio error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching KPI data $e');
      throw ApiException(e.toString());
    }
  }
}
