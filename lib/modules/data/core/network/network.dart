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
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjk2MCwiaXNfYWRtaW4iOmZhbHNlLCJlbXBsb3llZV9pZCI6IjE0MTI3IiwiZW1wbG95ZWVfbmFtZSI6Ik1yLiBPbWVyIEFobWVkIE9tZXIgQWwgUmF3YXMiLCJlbXBsb3llZV9hcmFiaWNfbmFtZSI6Iti52YXYsSDYqNmGINij2K3ZhdivINio2YYg2LnZhdixINin2YTYsdmI2KfYsyIsInBlcnNvbl90eXBlIjoiQ0FBIiwic2VjdGlvbiI6MzI5LCJzZWN0aW9uX25hbWUiOiJBc3NldHMgQWZmYWlycyBEZXBhcnRtZW50IiwicG9zaXRpb24iOjY1LCJwb3NpdGlvbl9uYW1lIjoiQWNjb3VudGFudCIsImRlcGFydG1lbnQiOjEwNiwiZGVwYXJ0bWVudF9uYW1lIjoiQXNzZXRzIEFmZmFpcnMgRGVwYXJ0bWVudCIsImVtYWlsIjoib21lci5hbHJhd2FzQGNhYS5nb3Yub20iLCJpYXQiOjE3NzQzNjg0NDQsImV4cCI6MTc3Nzk2ODQ0NH0.ZnUajKwcowy_7tLRuk3X6eAW0B71wW_XI9BsL7oyQ4I';
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
