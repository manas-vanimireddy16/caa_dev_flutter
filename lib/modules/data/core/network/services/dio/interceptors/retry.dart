part of '../network.dart';

class DioRetryInterceptor extends Interceptor {
  final DioNetworkingClient client;

  StreamSubscription<ConnectivityStatus>?
      onConnectivityStatusChangedSubscription;

  bool isDisconnected = false;

  DioRetryInterceptor({required this.client});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!err.isRetryRequired) {
      handler.next(err);
      return;
    }

    isDisconnected = true;
    var completed = false;

    void finish(void Function() action) {
      if (completed) return;
      completed = true;
      onConnectivityStatusChangedSubscription?.cancel();
      onConnectivityStatusChangedSubscription = null;
      action();
    }

    onConnectivityStatusChangedSubscription?.cancel();
    onConnectivityStatusChangedSubscription = KConnectivity
        .instance
        .onConnectivityStatusChanged
        .listen((connectivityStatus) async {
          if (connectivityStatus != ConnectivityStatus.connected ||
              !isDisconnected) {
            return;
          }

          log('[QRetryInterceptor.onError] retry initiated');
          isDisconnected = false;

          try {
            final requestOptions = err.requestOptions;

            final retryResponse = await client.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
              onSendProgress: requestOptions.onSendProgress,
              onReceiveProgress: requestOptions.onReceiveProgress,
              options: Options(
                method: requestOptions.method,
                headers: requestOptions.headers,
                extra: requestOptions.extra,
                contentType: requestOptions.contentType,
                responseType: requestOptions.responseType,
              ),
            );

            finish(() => handler.resolve(retryResponse));
          } catch (retryError) {
            finish(() {
              if (retryError is DioException) {
                handler.reject(retryError);
              } else {
                handler.reject(
                  DioException(
                    requestOptions: err.requestOptions,
                    error: retryError,
                  ),
                );
              }
            });
          }
        });

    Future<void>.delayed(const Duration(seconds: 60), () {
      finish(() => handler.reject(err));
    });
  }
}

extension DioErrorX on DioException {
  bool get isRetryRequired {
    return type == DioExceptionType.unknown &&
        error != null &&
        error is SocketException;
  }
}
