import '../../../data/core/connectivity/connectivity.dart';

enum ConnectivityStatus { connected, disconnected }

abstract class KConnectivity {
  static final KConnectivity instance = KConnectivityImpl();

  Future<ConnectivityStatus> get currentConnectivityStatus;

  Stream<ConnectivityStatus> get onConnectivityStatusChanged;
}
