import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';

import 'api_interceptor.dart';

@singleton
class ApiManager {
  Dio? dio;
  final Duration _connectionTimeout = const Duration(seconds: 30);
  final Duration _receiveTimeout = const Duration(seconds: 50);

  ApiManager() {
    final options = BaseOptions(
        baseUrl: "",
        connectTimeout: _connectionTimeout,
        receiveTimeout: _receiveTimeout,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        }
    );

    dio = Dio(options);
    dio!.interceptors.add(
      ApiInterceptor(dioInstance: dio),
    );


    (dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
}
