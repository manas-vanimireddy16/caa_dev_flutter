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
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEwMTgsImlzX2FkbWluIjpmYWxzZSwiZW1wbG95ZWVfaWQiOiIxNDA0MiIsImVtcGxveWVlX25hbWUiOiJNYW5hcyIsImVtcGxveWVlX2FyYWJpY19uYW1lIjoi2YXZhtmK2LEg2KjZhiDYtdiv2YrZgiDYqNmGINi52YTZiiDYp9mE2KjZhNmI2LTZiiIsInBlcnNvbl90eXBlIjoiQ0FBIiwic2VjdGlvbiI6MTU0LCJzZWN0aW9uX25hbWUiOiJFeHBlbmRpdHVyZSBTZWN0aW9uIiwicG9zaXRpb24iOjIyNSwicG9zaXRpb25fbmFtZSI6IkNvbXB1dGVyIE5ldHdvcmsgRW5naW5lZXIiLCJkZXBhcnRtZW50Ijo2NiwiZGVwYXJ0bWVudF9uYW1lIjoiRmluYW5jZSBEZXBhcnRtZW50IiwiZW1haWwiOiJtYW5hcy52YW5pbWlyZWRkeUBhbW5ldGRpZ2l0YWwuY29tIiwiaWF0IjoxNzc1MjIyMjQ0LCJleHAiOjE3Nzg4MjIyNDR9.VmHuMlP9g0KfVrg3EiFYabHBHfWqRLpe8KptfzcPvWE';
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
