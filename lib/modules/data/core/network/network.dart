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
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjk4OSwiaXNfYWRtaW4iOmZhbHNlLCJlbXBsb3llZV9pZCI6IjE0MjMzIiwiZW1wbG95ZWVfbmFtZSI6Ik1yLiBBbCBIdXNhaW4gQWxpIE1hcmhvb24gQWwgR2hhZnJpIiwiZW1wbG95ZWVfYXJhYmljX25hbWUiOiLYp9mE2K3Ys9mK2YYg2KjZhiDYudmE2Yog2KjZhiDZhdix2YfZiNmGINin2YTYutin2YHYsdmKIiwicGVyc29uX3R5cGUiOiJDQUEiLCJzZWN0aW9uIjoxNTYsInNlY3Rpb25fbmFtZSI6IkNvbXBldGVuY3kgTWFuYWdlbWVudCBTZWMiLCJwb3NpdGlvbiI6MzYsInBvc2l0aW9uX25hbWUiOiJFbGVjdHJvbmljcyBUZWNobmljaWFuIiwiZGVwYXJ0bWVudCI6NjcsImRlcGFydG1lbnRfbmFtZSI6Ikh1bWFuIENhcGl0YWwgRGVwYXJ0bWVudCIsImVtYWlsIjoiYWxodXNhaW4uYWxnaGFmcmlAY2FhLmdvdi5vbSIsImlhdCI6MTc3Mzc0NTI4NSwiZXhwIjoxNzc3MzQ1Mjg1fQ.65T8Tbbg-ojiKjHiW1UqnTOsbl4Fq4jIE6pZ3rVDu4k';
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
