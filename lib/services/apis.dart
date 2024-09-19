import 'dart:convert';
import 'dart:developer';

import 'package:fitforalegend_provider/services/api_methods.dart';
import 'package:fitforalegend_provider/services/api_urls.dart';

class Api {
  static final ApiMethods _apiClient = ApiMethods();

  static final Api _api = Api._internal();

  factory Api() {
    return _api;
  }

  Api._internal();

  static Future<Map<String, dynamic>> loginApi(
      Map<String, dynamic> body) async {
    var header = ApiMethods.getHeaderWithoutToken();

    String res = await _apiClient.postMethod(
      method: ApiServices.login,
      body: body,
      header: header,
    );

    if (res.isNotEmpty) {
      try {
        return jsonDecode(res);
      } catch (e) {
        return {};
      }
    } else {
      return {};
    }
  }

  static Future<Map<String, dynamic>> sendOtpToRegister(
      Map<String, dynamic> body) async {
    var header = ApiMethods.getHeaderWithoutToken();

    String res = await _apiClient.postMethod(
      method: ApiServices.registerOtp,
      body: body,
      header: header,
    );

    if (res.isNotEmpty) {
      try {
        return jsonDecode(res);
      } catch (e) {
        return {};
      }
    } else {
      return {};
    }
  }

  static Future<Map<String, dynamic>> verifyEmailOtp(
      Map<String, dynamic> body) async {
    var header = ApiMethods.getHeaderWithoutToken();

    String res = await _apiClient.postMethod(
      method: ApiServices.verifyOtpEmail,
      body: body,
      header: header,
    );

    if (res.isNotEmpty) {
      try {
        return jsonDecode(res);
      } catch (e) {
        return {};
      }
    } else {
      return {};
    }
  }

  static Future<Map<String, dynamic>> verifyMobileOtp(
      Map<String, dynamic> body) async {
    var header = ApiMethods.getHeaderWithoutToken();

    String res = await _apiClient.postMethod(
      method: ApiServices.verifyOtpMobile,
      body: body,
      header: header,
    );

    if (res.isNotEmpty) {
      try {
        return jsonDecode(res);
      } catch (e) {
        return {};
      }
    } else {
      return {};
    }
  }

  static Future<Map<String, dynamic>> registerUser(
      Map<String, dynamic> body) async {
    var header = ApiMethods.getHeaderWithoutToken();

    String res = await _apiClient.postMethod(
      method: ApiServices.registration,
      body: body,
      header: header,
    );

    if (res.isNotEmpty) {
      try {
        return jsonDecode(res);
      } catch (e) {
        return {};
      }
    } else {
      return {};
    }
  }


}
