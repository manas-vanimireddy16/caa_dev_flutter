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
  }) async {
    DioNetworkingClient? client;
    dynamic user = await KAuthCred().getProfileData();

    dynamic role = await KAuthCred().getSelectedRole();
    dynamic userInfo = await KAuthCred().getUserInfoData();

    String authCred = '';
    authCred =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjk1MywiaXNfYWRtaW4iOmZhbHNlLCJlbXBsb3llZV9pZCI6IjE0MTE5IiwiZW1wbG95ZWVfbmFtZSI6Ik1yLiDZkEFiZHVheml6IEtoYWxmYW4gQWxpIEFsc2tpdGkiLCJlbXBsb3llZV9hcmFiaWNfbmFtZSI6Iti52KjYr9in2YTYudiy2YrYsiDYqNmGINiu2YTZgdin2YYg2KjZhiDYudmE2Yog2KfZhNiz2YPZitiq2YoiLCJwZXJzb25fdHlwZSI6IkNBQSIsInNlY3Rpb24iOjI4Mywic2VjdGlvbl9uYW1lIjoiQ3liZXIgU2VjdXJpdHkgU2VjdGlvbiIsInBvc2l0aW9uIjoyMTMsInBvc2l0aW9uX25hbWUiOiJBdmlhdGlvbiBTYWZldHkgU3lzdGVtcyBTcGVjaWFsaXN0IiwiZGVwYXJ0bWVudCI6MTE1LCJkZXBhcnRtZW50X25hbWUiOiJQcmVzaWRlbnQncyBPZmZpY2UiLCJlbWFpbCI6ImFiZGFsYXppei5hbHNha2l0aUBjYWEuZ292Lm9tIiwiaWF0IjoxNzc1MDUzNTI0LCJleHAiOjE3Nzg2NTM1MjR9.t6tc04Zx7nMStrv348T7vr9l1P9wgB26UDXkDrJeOIc';
    if (user != null) {
      // authCred = user.accessToken ?? '';
    }

    if (authCred.isNotEmpty) {
      client = await _networkingBoxService.client(
        options: options,
        accessToken: authCred,
        loggingEnabled: loggingEnabled,
      );
    } else {
      log('[secureClient] Client could not be created');
    }

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
