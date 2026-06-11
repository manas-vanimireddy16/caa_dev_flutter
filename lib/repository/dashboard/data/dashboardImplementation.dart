import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/core/network/network.dart';
import 'package:code_setup/presentation/models/models.dart';
import 'package:code_setup/presentation/models/sections.dart';
import 'package:code_setup/presentation/models/userIdModel.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/model/actionItems.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/announcementsModels.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/bookmarksModel.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/userModel.dart';
import 'package:code_setup/repository/dashboard/domain/dashboard.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DashboardRepositoryImplementation implements DashboardRepository {
  final token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEwMTgsImlzX2FkbWluIjpmYWxzZSwiZW1wbG95ZWVfaWQiOiIxNDA0MiIsImVtcGxveWVlX25hbWUiOiJNYW5hcyIsImVtcGxveWVlX2FyYWJpY19uYW1lIjoi2YXZhtmK2LEg2KjZhiDYtdiv2YrZgiDYqNmGINi52YTZiiDYp9mE2KjZhNmI2LTZiiIsInBlcnNvbl90eXBlIjoiQ0FBIiwic2VjdGlvbiI6NjYsInNlY3Rpb25fbmFtZSI6IklUIFN1cHBvcnQiLCJwb3NpdGlvbiI6MjI1LCJwb3NpdGlvbl9uYW1lIjoiQ29tcHV0ZXIgTmV0d29yayBFbmdpbmVlciIsImRlcGFydG1lbnQiOjI1LCJkZXBhcnRtZW50X25hbWUiOiJJbmZvcm1hdGlvbiBUZWNobm9sb2d5IiwiZW1haWwiOiJtYW5hcy52YW5pbWlyZWRkeUBhbW5ldGRpZ2l0YWwuY29tIiwiaWF0IjoxNzU5OTk3Njc5LCJleHAiOjE3NjM1OTc2Nzl9.aMuGbNRTDag8C8IsmPHzgax96e7LQs1w6Ft6z8vm-vs';

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
      final url =
          'https://caa.altomouhit.com/v1/user-service/department/users/count';
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
      final url = 'https://caa.altomouhit.com/v1/user-service/departments';
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
      final url =
          'https://caa.altomouhit.com/v1/user-service/department/users/count';
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
      final url =
          'https://caa.altomouhit.com/v1/user-service/department/users/count';
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
  Future<List<ActionItemData>> getActionItems({required int userId}) async {
    final client = Dio();

    try {
      final url =
          'https://caa.altomouhit.com/v1/it-service/helpdesk/manager/requests/$userId';
      final response = await client.get(
        url,
        options: Options(
          headers: {'jwt': token, 'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return (data['data'] as List)
            .map((e) => ActionItemData.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in getActionItems: $e');
    }
  }
}
