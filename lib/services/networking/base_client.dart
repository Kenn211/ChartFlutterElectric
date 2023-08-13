import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import '../../core.dart';

import '../../shared/helpers/function_helper.dart';
import 'api_code_to_messages.dart';

int flag = 0;

class BaseClient {
  BaseClient._();
  static final Dio _dio = Dio();
  static const int TIME_OUT_DURATION = 30000;

  ///GET
  static Future<void> get(
    String url, {
    required Function(Response response) onSuccess,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Function(ApiException)? onError,
    Function(int value, int progress)? onReceiveProgress,
    Function? onLoading,
  }) async {
    try {
      final customHeaders = <String, dynamic>{};
      if (headers != null) {
        customHeaders.addAll(headers);
      }
      // 1) indicate loading state
      onLoading?.call();
      // 2) try to perform http request
      final response = await _dio
          .get(
            url,
            onReceiveProgress: onReceiveProgress,
            queryParameters: queryParameters,
            options: Options(
              headers: customHeaders,
            ),
          )
          .timeout(
            const Duration(seconds: TIME_OUT_DURATION),
          );
      // 3) return response (api done successfully)
      await onSuccess(response);
    } on DioError catch (error) {
      // dio error (api reach the server but not performed successfully
      await _handleDioError(error: error, url: url, onError: onError);
    } on SocketException {
      // No internet connection
      _handleSocketException(url: url, onError: onError);
    } on TimeoutException {
      // Api call went out of time
      _handleTimeoutException(url: url, onError: onError);
    } catch (error) {
      // unexpected error for example (parsing json error)
      _handleUnexpectedException(url: url, onError: onError, error: error);
    }
  }

  /// handle unexpected error
  static void _handleUnexpectedException(
      {required String url,
      required Object error,
      Function(ApiException)? onError}) {
    onError?.call(ApiException(
          message: error.toString(),
          url: url,
        )) ??
        _handleError(error.toString());
  }

  /// handle timeout exception
  static void _handleTimeoutException(
      {required String url, Function(ApiException)? onError}) {
    onError?.call(ApiException(
          message: 'server_not_responding'.tr,
          url: url,
        )) ??
        _handleError('server_not_responding'.tr);
  }

  /// handle timeout exception
  static void _handleSocketException(
      {required String url, Function(ApiException)? onError}) {
    onError?.call(ApiException(
          message: 'no_internet'.tr,
          url: url,
        )) ??
        _handleError('no_internet'.tr);
  }

  /// handle Dio error
  static Future _handleDioError(
      {required DioError error,
      required String url,
      Function(ApiException)? onError}) async {
    // no internet connection
    if (error.message!.toLowerCase().contains('socket')) {
      return onError?.call(ApiException(
            message: 'no_internet'.tr,
            url: url,
          )) ??
          _handleError('no_internet'.tr);
    }

    // check if the error is 500/502 (server problem)
    final statusCode = error.response?.statusCode;
    debugPrint('statusCode $statusCode');
    if (statusCode == 500 || statusCode == 502) {
      flag++;
      final exception = ApiException(
        message: 'server_error'.tr,
        url: url,
        statusCode: 500,
      );
      if (flag == 1) {
        return onError?.call(exception) ??
            handleApiError(exception, statusCode);
      }

      return;
    }
    final exception = ApiException(
        url: url,
        message: error.message!,
        response: error.response,
        statusCode: statusCode);
    return onError?.call(exception) ?? handleApiError(exception, statusCode);
  }

  static void handleApiError(ApiException apiException, [int? statusCode]) {
    final String msg = apiException.response?.data?['errorDescription'] ??
        apiException.response?.data?['message'] ??
        apiException.message;
    final code = apiException.response?.data?['error'];
    if (code == 'invalid_grant' ||
        code == 'locked' ||
        code == 'status_locked') {
      CustomSnackbar.snackBar('error', transferCodeToMessages(code));
    } else {
      CustomSnackbar.snackBar('error', msg);
    }
    FunctionHelper.hideLoading();
  }

  /// handle errors without response (500, out of time, no internet,..etc)
  static void _handleError(String msg) {
    CustomSnackbar.snackBar('error', msg);
    FunctionHelper.hideLoading();
  }
}
