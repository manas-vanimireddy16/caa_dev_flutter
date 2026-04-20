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
    // authCred =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE2MiwiaXNfYWRtaW4iOmZhbHNlLCJlbXBsb3llZV9pZCI6IjEyNzU3IiwiZW1wbG95ZWVfbmFtZSI6Ik1yLiBIdXNzYWluIFNhbGltIEFobWVkIEFsIEhhZGRhZCIsImVtcGxveWVlX2FyYWJpY19uYW1lIjoi2K3Ys9mK2YYg2KjZhiDYs9in2YTZhSDYqNmGINij2K3ZhdivINin2YTYrdiv2KfYryIsInBlcnNvbl90eXBlIjoiQ0FBIiwic2VjdGlvbiI6MzMyLCJzZWN0aW9uX25hbWUiOiJMZWdhbCBTdHVkaWVzIFNlY3Rpb24iLCJwb3NpdGlvbiI6MjUsInBvc2l0aW9uX25hbWUiOiJBZXJvZHJvbWUgU2VjdXJpdHkgT2ZmaWNlciIsImRlcGFydG1lbnQiOjIxMCwiZGVwYXJ0bWVudF9uYW1lIjoiTGVnYWwgRGVwYXJ0bWVudCAiLCJlbWFpbCI6Imh1c3NhaW4uaGFkZGFkQGNhYS5nb3Yub20iLCJpYXQiOjE3NzU3MjA1NzAsImV4cCI6MTc3OTMyMDU3MH0.648BsDlPklgPZhFd-6-C2Rs5ndxI0J0M8k2Rp_6yQjM';
    if (user != null) {
      authCred = user.accessToken ?? '';
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
