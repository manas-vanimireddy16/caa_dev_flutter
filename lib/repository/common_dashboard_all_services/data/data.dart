import 'dart:developer';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/presentation/models/kpi_model.dart';
import 'package:code_setup/presentation/models/status_breakdown_model.dart';
import 'package:code_setup/presentation/models/trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/dashboard_requests_approvals.dart';
import 'package:code_setup/repository/common_dashboard_all_services/domain/domain.dart';
import 'package:code_setup/utils/api_end_point.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/helper/exception_handling.dart';
import 'package:dio/dio.dart';

class CommonDashboardRepositoryImpl implements CommonDashboardRepository {
  @override
  Future<KPIResponse?> getKpiData({
    required List<int> serviceIds,
    required List<int> subServiceIds,
  }) async {
    String url = ApiEndPoint.dashboardKpi;
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final queryParams = {
          'service_ids': serviceIds.join(','),
          'sub_service_ids': subServiceIds.join(','),
        };
        final response = await client.get(url, queryParameters: queryParams);

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

  @override
  Future<KPIResponse?> getApprovalKpiData({
    required List<int> serviceIds,
    required List<int> subServiceIds,
  }) async {
    String url = ApiEndPoint.dashboardApprovalKpi;
    final client = await KAppX.network.secureClient();

    try {
      if (client != null) {
        final queryParams = {
          'service_ids': serviceIds.join(','),
          'sub_service_ids': subServiceIds.join(','),
        };
        final response = await client.get(url, queryParameters: queryParams);

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

  @override
  Future<StatusBreakdownModel> getApprovalStatusBreakdownData({
    required String period,
    required List<int> serviceIds,
    required List<int> subServiceIds,
  }) async {
    try {
      final client = await KAppX.network.secureClient();

      if (client != null) {
        final queryParams = {
          'time_period': period,
          'service_ids': serviceIds.join(','),
          'sub_service_ids': subServiceIds.join(','),
        };

        final response = await client.get(
          ApiEndPoint.dashboardApprovalStatusBreakdown,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return StatusBreakdownModel.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }

      throw ApiException('Client is null');
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching status breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<TrendBreakdownModel> getApprovalTrendBreakdownData({
    required String period,
    required List<int> serviceIds,
    required List<int> subServiceIds,
  }) async {
    try {
      final client = await KAppX.network.secureClient();

      if (client != null) {
        final queryParams = {
          'year': period,
          'service_ids': serviceIds.join(','),
          'sub_service_ids': subServiceIds.join(','),
        };

        final response = await client.get(
          ApiEndPoint.dashboardApprovalTrendBreakdown,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return TrendBreakdownModel.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }

      throw ApiException('Client is null');
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching trend breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<StatusBreakdownModel> getStatusBreakdownData({
    required String period,
    required List<int> serviceIds,
    required List<int> subServiceIds,
  }) async {
    try {
      final client = await KAppX.network.secureClient();

      if (client != null) {
        final queryParams = {
          'time_period': period,
          'service_ids': serviceIds.join(','),
          'sub_service_ids': subServiceIds.join(','),
        };

        final response = await client.get(
          ApiEndPoint.dashboardStatusBreakdown,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return StatusBreakdownModel.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }

      throw ApiException('Client is null');
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching status breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<TrendBreakdownModel> getTrendBreakdownData({
    required String period,
    required List<int> serviceIds,
    required List<int> subServiceIds,
  }) async {
    try {
      final client = await KAppX.network.secureClient();

      if (client != null) {
        final queryParams = {
          'year': period,
          'service_ids': serviceIds.join(','),
          'sub_service_ids': subServiceIds.join(','),
        };

        final response = await client.get(
          ApiEndPoint.dashboardTrendBreakdown,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return TrendBreakdownModel.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }

      throw ApiException('Client is null');
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching trend breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<DashboardRequestModel>> getRequests({
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
  Future<UserRoleResponse> getUserRoles(int id) async {
    try {
      final client = await KAppX.network.secureClient();

      if (client != null) {
        final response = await client.get(ApiEndPoint.userRoles(id));

        if (response.statusCode == 200 && response.data != null) {
          final data = Map<String, dynamic>.from(response.data);
          return UserRoleResponse.fromJson(data);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      } else {
        throw ApiException('Failed to initialize network client');
      }
    } on DioException catch (error) {
      log('Caught Dio error: ${error.message}');
      final message = error.response?.data?['message'] ?? error.message;
      throw ApiException(message ?? 'Network error occurred');
    } catch (e, stack) {
      log('Error fetching user roles: $e', stackTrace: stack);
      throw ApiException(e.toString());
    }
  }
}
