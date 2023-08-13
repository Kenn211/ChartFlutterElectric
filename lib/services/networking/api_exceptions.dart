import 'package:dio/dio.dart';

class ApiException implements Exception {
  ApiException({
    required this.url,
    required this.message,
    this.response,
    this.statusCode,
  });
  final String url;
  final String message;
  final int? statusCode;
  final Response? response;
}
