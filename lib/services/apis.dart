import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fitforalegend_provider/const/utils.dart';
import 'package:fitforalegend_provider/models/response_categories.dart';
import 'package:fitforalegend_provider/models/response_get_user_profile.dart';
import 'package:fitforalegend_provider/models/response_home.dart';
import 'package:fitforalegend_provider/services/api_methods.dart';
import 'package:fitforalegend_provider/services/api_urls.dart';
import 'package:flutter/cupertino.dart';

class Api {
  static final ApiMethods _apiClient = ApiMethods();

  static final Api _api = Api._internal();

  factory Api() {
    return _api;
  }

  Api._internal();

  static Future<Map<String, dynamic>> login(
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
        Utility().getToast('exception>> $e');
        return {};
      }
    } else {
      Utility().getToast('FAILED');
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
    log('JSON response: $res');
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

  static Future<GetProfileResponse> getUserProfile() async {
    var header = await ApiMethods.getHeaderWithToken();

    String res = await _apiClient.getMethod(
      method: ApiServices.getProfile,
      body: {},
      header: header,
    );
    debugPrint('token is>>${header.toString()}');
    log('JSON response: $res');

    if (res.isNotEmpty) {
      try {
        return GetProfileResponse.fromJson(json.decode(res));
      } catch (e) {
        return GetProfileResponse(
            status: false, message: 'Something went wrong');
      }
    } else {
      return GetProfileResponse(status: false, message: 'Something went wrong');
    }
  }

  static Future<Map<String, dynamic>> updateUserProfile({
    required Map<String, String> body,
    required List<MultipartFile> files,
    required String mapKeyFile,
  }) async {
    var header = await ApiMethods.getHeaderWithToken();

    String res = await _apiClient.postMultipartMethod(
      method: ApiServices.updateProfile,
      body: body,
      files: files,
      mapKeyFile: mapKeyFile,
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

  static Future<HomeResponse> home({
    required Map<String, String> body,
  }) async {
    var header = ApiMethods.getHeaderWithoutToken();

    String res = await _apiClient.getMethod(
      method: ApiServices.homeApi,
      body: body,
      header: header,
    );
    debugPrint('token is>>${header.toString()}');
    log('JSON response: $res');

    if (res.isNotEmpty) {
      try {
        return HomeResponse.fromJson(json.decode(res));
      } catch (e) {
        return HomeResponse(status: false, message: 'Something went wrong');
      }
    } else {
      return HomeResponse(status: false, message: 'Something went wrong');
    }
  }

  static Future<Map<String, dynamic>> favoriteProduct({
    required Map<String, String> body,
  }) async {
    var header = await ApiMethods.getHeaderWithToken();

    String res = await _apiClient.postMethod(
      method: ApiServices.addToWishlist,
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


  static Future<CategoryResponse> getCategories() async {
    var header = ApiMethods.getHeaderWithoutToken();

    String res = await _apiClient.getMethod(
      method: ApiServices.categoryApi,
      body: {},
      header: header,
    );
    debugPrint('token is>>${header.toString()}');
    log('getCategories response: $res');

    if (res.isNotEmpty) {
      try {
        return CategoryResponse.fromJson(json.decode(res));
      } catch (e) {
        return CategoryResponse(status: false, message: 'Something went wrong');
      }
    } else {
      return CategoryResponse(status: false, message: 'Something went wrong');
    }
  }

}
