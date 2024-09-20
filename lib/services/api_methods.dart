import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fitforalegend_provider/const/utils.dart';
import 'package:fitforalegend_provider/services/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiMethods {
  static final ApiMethods _apiClient = ApiMethods._internal();
  final dio = Dio();
  factory ApiMethods() {
    return _apiClient;
  }

  ApiMethods._internal();

  static Map<String, String> getHeaderWithoutToken() {
    return {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      "api-access-token": ApiServices.apiAccessToken,
    };
  }

  static Future<Map<String, String>> getHeaderWithToken([
    bool? isMultipart,
  ]) async {
    String? accessToken = await Utility().getAccessToken();
    if (isMultipart ?? false) {
      return {
        'accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
    } else {
      return {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
    }
  }

  Future<String> getMethod({
    required String method,
    required Map<String, dynamic>? body,
    Map<String, String>? header,
  }) async {
    if (await Utility().isInternetConnected()) {
      try {
        /*
        log('Get Request url: $method');

        if (header != null) {
          log('header>>>> ${header.toString()}');
        }
        log('Request body: $body');
        */

        /*
        var request = http.Request(
            'GET',
            Uri.parse(
              method,));
        request.body = body.toString();
        if (header != null) {
          request.headers.addAll(header);
        }
        http.StreamedResponse response = await request.send();
        */

        /// HTTP Code commit
        final response = await http.get(
          Uri.parse(method).replace(queryParameters: body),
          headers: header,
        );
        /*
        log('$method >>>>Response body: ${response.body} <<<<');
         */
        return response.body;
      } catch (e) {
        log('___catch___get Method error---$method>>>>> ${e.toString()}<<<<<<');
        return '';
      }
    } else {
      Utility().getToast('No Internet');
      return '';
    }
  }

  Future<String> postMethod({
    required method,
    required Map<String, dynamic> body,
    Map<String, String>? header,
  }) async {
    if (await Utility().isInternetConnected()) {
      try {
        /*
        log('Post Request url: $method');
        if (header != null) {
          log('Request header:  ${header.toString()}');
        }
        log('Request body: $body');
         */

        /// HTTP Code commit
        final response = await http.post(
          Uri.parse(method),
          body: jsonEncode(body),
          headers: header,
        );
        /*
        log('$method >>>>Response body: ${response.body} <<<<');
         */
        return response.body;
      } catch (e) {
        log('___catch___post Method error---$method>>>>> ${e.toString()}<<<<<<');
        return '';
      }
    } else {
      Utility().getToast('No Internet');
      return '';
    }
  }

  Future<String> postMultipartMethod({
    required String method,
    required Map<String, String> body,
    required List<MultipartFile> files,
    required String mapKeyFile,
    required Map<String, String> header,
  }) async {
    if (await Utility().isInternetConnected()) {
      try {
        final formData = FormData();

        // Add text fields
        body.forEach((key, value) {
          formData.fields.add(MapEntry(key, value));
        });

        // Add file fields
        for (var file in files) {
          if (files.isNotEmpty) {
            formData.files.add(MapEntry(mapKeyFile, file));
            debugPrint('Adding file: ${file.filename}');
          }
        }

        debugPrint('FormData: ${formData.fields.toString()}');
        debugPrint('FormData Files: ${formData.files.toString()}');

        final response = await dio.post(
          method,
          data: formData,
          options: Options(
            headers: {
              ...header,
              'Content-Type': 'multipart/form-data',
            },
          ),
        );
        return jsonEncode(response.data);
      } catch (e) {
        log('postMultipartMethod error---$method>>>>> ${e.toString()}<<<<<<');
        return '';
      }
    } else {
      Utility().getToast('No Internet');
      return '';
    }
  }



  /// HTTP Code commit

  Future<String> postMethodMultipart({
    required http.MultipartRequest request,
  }) async {
    if (await Utility().isInternetConnected()) {
      try {
        /*
        log('PostMultipart Request url: ${request.url.path}');
        log('Request header: ${request.headers}');
        log('Request body: ${request.fields}');
        log('Request files: ${request.files}');
         */
        http.Response result =
        await http.Response.fromStream(await request.send());
        /*
        log('${request.url.path} >>>>Response body: ${result.body} <<<<');
         */
        return result.body;
      } catch (e) {
        log('___catch___postMethodMultipart error---${request.url.path}>>>>> ${e.toString()}<<<<<<');
        return '';
      }
    } else {
      Utility().getToast('No Internet');
      return '';
    }
  }
}
