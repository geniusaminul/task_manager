import 'dart:convert';

import 'package:http/http.dart';
import 'package:task_manager_assignment/ui/controller/auth_controller.dart';

import '../model/network_response.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url),
          headers: {'token': AuthController.accessToken});
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        AuthController.redirectToLogin();
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      Response response = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {
            'content-type': 'Application/json',
            'token': AuthController.accessToken
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodeData);
      } else if (response.statusCode == 401) {
        AuthController.redirectToLogin();
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }
}
