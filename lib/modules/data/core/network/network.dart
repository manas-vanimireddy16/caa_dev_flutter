import 'dart:developer';

import 'package:code_setup/modules/data/core/network/services/dio/network.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';

import '../../../domain/core/network/network.dart';

part 'services/network_service.dart';

//It was time consuming to create implement complete client, for now directly type casted clients from dio service, still plug and play
class KNetworkingBoxImpl
    implements KNetworkingBox<DioNetworkingClient, DioNetworkingOptions> {
  late final KNetworkingBoxService<DioNetworkingClient, DioNetworkingOptions>
  _networkingBoxService;

  KNetworkingBoxImpl() {
    _networkingBoxService = DioNetworkingBox(
      defaultOptions: DioNetworkingOptions(
        baseUrl: KNetworkingBox.defaults.baseUrl,
        headers: KNetworkingBox.defaults.defaultHeaders,
      ),
    );
  }

  @override
  void bootDown() {
    log('[NetworkingBox.bootDown]');
    // TODO: implement bootDown
  }

  @override
  Future bootUp() {
    log('[NetworkingBox.bootUp]');
    // TODO: implement bootUp
    throw UnimplementedError();
  }

  @override
  void onBootUp() {
    // TODO: implement onBootUp
  }

  @override
  Future<DioNetworkingClient?> secureClient({
    DioNetworkingOptions? options,
    bool loggingEnabled = true,
    bool includeRoleCookies = true,
  }) async {
    DioNetworkingClient? client;

    final user = await KAuthCred().getProfileData();
    final role = await KAuthCred().getSelectedRole();
    final userInfo = await KAuthCred().getUserInfoData();

    final authToken = user?.accessToken ?? '';
    final userId =
        user?.userId?.toString() ?? userInfo?.data?.id?.toString() ?? '';
    final roleName = role?.roleName ?? '';

    if (authToken.isEmpty) {
      log('[secureClient] Client could not be created');
      return null;
    }

    final mergedHeaders = <String, String>{
      ...?options?.headers,
    };

    if (includeRoleCookies) {
      final cookieParts = <String>[
        if (userId.isNotEmpty) 'userId=$userId',
        'authToken=$authToken',
        if (roleName.isNotEmpty) 'roleName=${Uri.encodeComponent(roleName)}',
      ];
      mergedHeaders['Cookie'] = cookieParts.join('; ');
    }

    client = await _networkingBoxService.client(
      options: DioNetworkingOptions(
        baseUrl: options?.baseUrl,
        headers: mergedHeaders,
      ),
      accessToken: authToken,
      loggingEnabled: loggingEnabled,
    );

    return client;
  }

  @override
  Future<DioNetworkingClient?> unsecureClient({
    DioNetworkingOptions? options,
    bool loggingEnabled = true,
  }) async {
    final client = await _networkingBoxService.client(
      options: options,
      loggingEnabled: loggingEnabled,
    );

    return client;
  }
}
