import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} ${response.data}',
    );
    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    await FirebaseCrashlytics.instance.recordError(err, StackTrace.current,
        reason: 'DIO error' + err.response.toString());
    Clipboard.setData(ClipboardData(text: err.response?.toString()));
    print(
      'ERROR[${err.response?.toString()}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
