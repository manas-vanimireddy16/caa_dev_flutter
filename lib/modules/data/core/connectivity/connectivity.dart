import 'dart:async';
import 'dart:developer';
import 'dart:io'; // Import dart:io for InternetAddress

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../domain/core/connectivity/connectivity.dart';

class KConnectivityImpl implements KConnectivity {
  late StreamSubscription<ConnectivityResult>
  _connectivityResultStreamSubscription;

  final StreamController<ConnectivityStatus>
  _connectivityStatusStreamController =
      StreamController<ConnectivityStatus>.broadcast();

  void bootDown() {
    log('[ConnectivityStatus.bootDown]');

    _connectivityResultStreamSubscription.cancel();
    _connectivityStatusStreamController.close();
  }

  Future<void> bootUp() async {
    log('[ConnectivityStatus.bootUp]');

    final connectivity = Connectivity();

    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
          // Received changes in available connectivity types!
          if (result.contains(ConnectivityResult.none)) {
            // No available network types
            _connectivityStatusStreamController.add(
              ConnectivityStatus.disconnected,
            );
          } else {
            _connectivityStatusStreamController.add(
              ConnectivityStatus.connected,
            );
          }
        });
  }

  @override
  void onBootUp() {
    // TODO: implement onBootUp
  }

  @override
  Future<ConnectivityStatus> get currentConnectivityStatus async {
    var connectivityStatus = ConnectivityStatus.connected;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        connectivityStatus = ConnectivityStatus.disconnected;
      }
    } catch (e) {
      connectivityStatus = ConnectivityStatus.disconnected;
    }

    return connectivityStatus;
  }

  @override
  Stream<ConnectivityStatus> get onConnectivityStatusChanged =>
      _connectivityStatusStreamController.stream;
}
