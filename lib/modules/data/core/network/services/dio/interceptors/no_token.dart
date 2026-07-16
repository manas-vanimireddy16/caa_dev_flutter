part of '../network.dart';

class DioTokenInvalidInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //Deep link url interception issues can be fixed here

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    ///401 is for authentication
    if (response.statusCode == 401) {
      unawaited(_handleUnauthorized());
    } else if (response.statusCode == 403) {
      ///403 is for authorization
    }

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('status code : ${err.response?.statusCode}');
    if (err.response?.statusCode == 401) {
      unawaited(_handleUnauthorized());
    }

    return super.onError(err, handler);
  }

  Future<void> _handleUnauthorized() async {
    await KAuthCred().logoutToLogin();
  }
}
