import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:test_chart/core.dart';
import 'package:test_chart/services/networking/api_code_to_messages.dart';

import 'package:test_chart/shared/helpers/function_helper.dart';

var flag = 0;

class BaseClient {
  static final Dio _dio = Dio();
  static const int TIME_OUT_DURATION = 30000;

  ///GET
  static get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Function(ApiException)? onError,
    required Function(Response response) onSuccess,
    Function(int value, int progress)? onReceiveProgress,
    Function? onLoading,
  }) async {
    try {
      Map<String, dynamic> customHeaders = {};
      if (headers != null) {
        customHeaders.addAll(headers);
      }
      // 1) indicate loading state
      onLoading?.call();
      // 2) try to perform http request
      var response = await _dio
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
      _handleDioError(error: error, url: url, onError: onError);
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
  static _handleUnexpectedException(
      {Function(ApiException)? onError,
      required String url,
      required Object error}) {
    onError?.call(ApiException(
          message: error.toString(),
          url: url,
        )) ??
        _handleError(error.toString());
  }

  /// handle timeout exception
  static _handleTimeoutException(
      {Function(ApiException)? onError, required String url}) {
    onError?.call(ApiException(
          message: 'server_not_responding'.tr,
          url: url,
        )) ??
        _handleError('server_not_responding'.tr);
  }

  /// handle timeout exception
  static _handleSocketException(
      {Function(ApiException)? onError, required String url}) {
    onError?.call(ApiException(
          message: 'no_internet'.tr,
          url: url,
        )) ??
        _handleError('no_internet'.tr);
  }

  /// handle Dio error
  static _handleDioError(
      {required DioError error,
      Function(ApiException)? onError,
      required String url}) async {
    // no internet connection
    if (error.message!.toLowerCase().contains('socket')) {
      return onError?.call(ApiException(
            message: 'no_internet'.tr,
            url: url,
          )) ??
          _handleError('no_internet'.tr);
    }

    // check if the error is 500/502 (server problem)
    var statusCode = error.response?.statusCode;
    debugPrint('statusCode $statusCode');
    if (statusCode == 500 || statusCode == 502) {
      flag++;
      var exception = ApiException(
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
    var exception = ApiException(
        url: url,
        message: error.message!,
        response: error.response,
        statusCode: statusCode);
    return onError?.call(exception) ?? handleApiError(exception, statusCode);
  }

  static handleApiError(ApiException apiException, [int? statusCode]) {
    String msg = apiException.response?.data?['errorDescription'] ??
        apiException.response?.data?['message'] ??
        apiException.message;
    String? code = apiException.response?.data?['error'];
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
  static _handleError(String msg) {
    CustomSnackbar.snackBar('error', msg);
    FunctionHelper.hideLoading();
  }
}
