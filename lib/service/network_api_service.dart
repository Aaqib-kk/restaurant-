import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_menu/service/base_api_service.dart';
import 'package:restaurant_menu/widgets/app_exception.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future get(String url, {required Map<String, String> headers}) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  @override
  Future post(String url, dynamic body,
      {required Map<String, String> headers}) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: body, headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  @override
  Future delete(String url, {required Map<String, String> headers}) async {
    dynamic responseJson;
    try {
      print(url);
      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  @override
  Future put(String url, dynamic body,
      {required Map<String, String> headers}) async {
    dynamic responseJson;
    try {
      final response = await http
          .put(Uri.parse(url), body: body, headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  @override
  Future patch(String url, dynamic body,
      {required Map<String, String> headers}) async {
    dynamic responseJson;
    try {
      final response = await http
          .patch(Uri.parse(url), body: body, headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.body;
        return responseJson;
      case 201:
        var responseJson = response.body;
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
      case 500:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
