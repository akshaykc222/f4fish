import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery_app/data/remote/routes.dart';
import 'custom_exception.dart';


class ApiProvider {
  late Dio dio;
  ApiProvider() {
    dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return true;
        },
        followRedirects: false,
        baseUrl: AppRemoteRoutes.baseUrl,
        connectTimeout: 30000,
        receiveTimeout: 30000,
      ),
    );
  }

  Future<Map<String, dynamic>> get(
    String endPoint,
  ) async {
    try {
      GetStorage sr = GetStorage();
      String? token = sr.read('token');
      print(token);
      dio.options.headers.addAll({'Authorization': 'Token $token'});
      final Response response = await dio.get(
        endPoint,
      );
      print(dio.options.headers);
      print(dio.options.baseUrl + endPoint);

      final Map<String, dynamic> responseData = classifyResponse(response);
      return responseData;
    } on DioError catch (err) {
      throw FetchDataException("internetError");
    }
  }

  Future<Map<String, dynamic>> post(String endPoint, Map<String, dynamic> body,
      {bool? tokenAvailable}) async {
    print("on post call$body");
    try {
      print("starting dio");
      GetStorage sr = GetStorage();
      String? token = sr.read('token');
      print(token);
      if (token == null || token == "null") {
        dio.options.headers.clear();
      } else {
        print("this is working with token $token");
        dio.options.headers.addAll({'Authorization': 'Token $token'});
        // dio.options.headers.addAll({});
      }
      debugPrint(
          "request \n end point :\t ${dio.options.baseUrl}$endPoint \n headers : ${dio.options.headers}");
      debugPrint("request headers ${body}");
      final Response response = await dio.post(endPoint, data: body);

      print("getting response$response");
      final Map<String, dynamic> responseData = classifyResponse(response);
      print(responseData);
      return responseData;
    } on DioError catch (err) {
      print(err);
      throw FetchDataException("internetError");
    }
  }

  Future<Map<String, dynamic>> delete(String endPoint,
      {bool? tokenAvailable}) async {
    // print("on post call$body");
    try {
      print("starting dio");
      GetStorage sr = GetStorage();
      String? token = sr.read('token');
      print(token);
      if (token == null || token == "null") {
        dio.options.headers.clear();
      } else {
        print("this is working with token $token");
        dio.options.headers.addAll({'Authorization': 'Token $token'});
        // dio.options.headers.addAll({});
      }
      debugPrint(
          "request \n end point :\t ${dio.options.baseUrl}$endPoint \n headers : ${dio.options.headers}");
      // debugPrint("request headers ${dio.interceptors.}");
      final Response response = await dio.delete(
        endPoint,
        // data: body
      );

      print("getting response$response");
      final Map<String, dynamic> responseData = classifyResponse(response);
      print(responseData);
      return responseData;
    } on DioError catch (err) {
      print(err);
      throw FetchDataException("internetError");
    }
  }

  Future<Map<String, dynamic>> put(
      String endPoint, Map<String, dynamic> body) async {
    print("on post call");
    try {
      GetStorage sr = GetStorage();
      String? token = sr.read('token');
      print(token);
      dio.options.headers.addAll({'Authorization': 'Token $token'});
      print("starting dio");
      final Response response = await dio.put(
        endPoint,
        data: body,
      );
      print("getting response${response}");
      final Map<String, dynamic> responseData = classifyResponse(response);
      print(responseData);
      return responseData;
    } on DioError catch (err) {
      print(err);
      throw FetchDataException("internetError");
    }
  }

  Future<Map<String, dynamic>> patch(
      String endPoint, Map<String, dynamic> body) async {
    print("on [patch] call");
    try {
      GetStorage sr = GetStorage();
      String? token = sr.read('token');
      print(token);
      dio.options.headers.addAll({'Authorization': 'Token $token'});
      print("starting dio");
      final Response response = await dio.patch(
        endPoint,
        data: body,
      );
      print("getting response${response}");
      final Map<String, dynamic> responseData = classifyResponse(response);
      print(responseData);
      return responseData;
    } on DioError catch (err) {
      print(err);
      throw FetchDataException("internetError");
    }
  }

  Map<String, dynamic> classifyResponse(Response response) {
    print(response.realUri);
    final Map<String, dynamic> responseData = jsonDecode(response.toString());
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
      case 201:
        return responseData;
      case 400:
        throw BadRequestException(responseData.toString());
      case 401:
        // g.Get.offAllNamed(AppRoutes.register);
        throw UnauthorisedException(responseData.toString());
      case 500:
      default:
        print(responseData.toString());
        throw BadRequestException(responseData["error"]);
    }
  }
}
