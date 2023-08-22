import 'package:dartz/dartz.dart';
import 'package:di_sample/core/di/injectable.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../state/failure_state.dart';
import 'api_manager.dart';

enum ApiMethods { get, post, delete }

abstract class ApiRequest {
  Future<Either<dynamic, Failure>> decodeHttpRequestResponse(
    Response? response, {
    String message = "",
  });

  Future<Either<dynamic, Failure>> getResponse({
    required String endPoint,
    required ApiMethods apiMethods,
    Map<String, dynamic>? queryParams,
    dynamic body,
    Options? options,
    String? errorMessage,
  });
}

@LazySingleton(as: ApiRequest)
class ApiRequestImpl implements ApiRequest {
  ApiManager _apiManager = getIt<ApiManager>();

  @override
  Future<Either<dynamic, Failure>> decodeHttpRequestResponse(Response? response,
      {String message = ""}) async {
    List<int> successStatusCode = [200, 201];
    if (successStatusCode.contains(response?.statusCode)) {
      return Left({'data': response?.data, 'message': message});
    } else if (response?.statusCode == 500) {
      // toastHelper.showToast(message: 'Server Error', isSuccess: false);
      return Left(response?.data);
    } else if (response?.statusCode == 401) {
      // toastHelper.showToast(message: 'Unauthorized', isSuccess: false);
    } else if (response?.statusCode == 400) {
      return Right(Failure.fromJson(response!.data));
    } else if (response?.statusCode == 422) {
      return Right(Failure.fromJson(response!.data));
    } else if (response?.data == null) {
      return Right(response?.data);
    } else {
      return Right(Failure(message: 'Something went wrong'));
    }
    return response?.data;
  }

  @override
  ApiManager get apiManager => _apiManager;

  @override
  Future<Either<dynamic, Failure>> getResponse(
      {required String endPoint,
      required ApiMethods apiMethods,
      Map<String, dynamic>? queryParams,
      body,
      Options? options,
      String? errorMessage}) async {
    Response? response;
    if (apiMethods == ApiMethods.post) {
      response = await apiManager.dio!.post(
        endPoint,
        data: body,
        queryParameters: queryParams,
        options: options,
      );
    } else if (apiMethods == ApiMethods.delete) {
      response = await apiManager.dio!.delete(
        endPoint,
        data: body,
        queryParameters: queryParams,
        options: options,
      );
    } else {
      response = await apiManager.dio!
          .get(endPoint, queryParameters: queryParams, options: options);
    }

    return decodeHttpRequestResponse(
      response,
      message: errorMessage ?? "",
    );
  }

  @override
  void setApiManager(ApiManager apiManager) {
    _apiManager = apiManager;
  }
}
