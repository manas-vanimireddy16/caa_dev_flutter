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
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjk3MCwiaXNfYWRtaW4iOmZhbHNlLCJlbXBsb3llZV9pZCI6IjE0MTY0IiwiZW1wbG95ZWVfbmFtZSI6Ik1yLiBGYWhhZCBBaG1lZCBTYWlkIEFsIHNodWthaWxpIiwiZW1wbG95ZWVfYXJhYmljX25hbWUiOiLZgdmH2K8g2KjZhiDYs9i52YrYryDYqNmGINij2K3ZhdivINin2YTYtNmD2YrZhNmKIiwicGVyc29uX3R5cGUiOiJDQUEiLCJzZWN0aW9uIjozMzksInNlY3Rpb25fbmFtZSI6IkFsbCBTZWN0aW9ucyIsInBvc2l0aW9uIjoxNTYsInBvc2l0aW9uX25hbWUiOiJDb29yZGluYXRpb24gYW5kIEZvbGxvdy1VcCBTcGVjaWFsaXN0IiwiZGVwYXJ0bWVudCI6MjA5LCJkZXBhcnRtZW50X25hbWUiOiJBc3NldCBEZXBhcnRtZW50IiwiZW1haWwiOiJGYWhhZC5hbHNodWthaWxpQGNhYS5nb3Yub20iLCJpYXQiOjE3NzQ0NTc2NDcsImV4cCI6MTc3ODA1NzY0N30.CKM_ByznYGR2Z0Gal4sG6b5Mz51n8IduENq1ilXkMfI';
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
