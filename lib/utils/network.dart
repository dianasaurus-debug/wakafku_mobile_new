import 'package:dio/dio.dart';
import 'package:final_project_mobile/mixins/dialog_mixin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as security;
import 'package:get/route_manager.dart';

import '../utils/constants.dart';

class BaseNetwork extends ChangeNotifier with DialogMixin {
  security.FlutterSecureStorage _storage = const security.FlutterSecureStorage();
  Dio _dio = Dio(
    BaseOptions(
      baseUrl: API_URL,
      headers: <String, dynamic>{
        'Accept': 'application/json',
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      },
    ),
  );
  Future<Response<dynamic>> request(
      String path, {
        String requestMethod = 'get',
        dynamic data,
        required Map<String, dynamic> queryParameter,
        // String acceptHeader = 'application/json',
        String contentTypeHeader = 'application/json',
      }) async {
    late Response<dynamic> resp;
    // _dio.options.headers['Accept'] = acceptHeader;
    _dio.options.headers['Content-Type'] = contentTypeHeader;

    try {
      resp = await _dio.request<dynamic>(
        path,
        data: data,
        queryParameters: queryParameter,
        options: Options(
          method: requestMethod,
          // contentType: 'application/json',
          validateStatus: (int? status) => status! <= 500,
          followRedirects: false,
          // responseType: ResponseType.json,
        ),
      );
    } catch (e) {
      print(e);
    } finally {
      print(resp.data);
      // if (resp.data['message'] != null &&
      //     resp.data['message'] == 'Unauthenticated.') {
      //   showSingleActionDialog(
      //     'Oops! Sesi telah habis!',
      //     'Unauthenticated!',
      //     'Ok',
      //         () => Get.offNamed<void>('/login'),
      //   );
      // }
    }

    return resp;
  }

  Future<void> _setNetworkToken() async {
    _dio.options.headers['Authorization'] = 'Bearer ${await getToken()}';
  }

  Future<void> setToken(String value) async {
    await _storage.write(key: 'token', value: value);
    await _setNetworkToken();
  }

  Future<String?> getToken() async {

    return await _storage.read(key: 'token');
  }

  Future<bool> _hasToken() async {
    final bool hasToken = (await getToken()) != null;

    if (hasToken) {
      await _setNetworkToken();
    }
    return hasToken;
  }


  Future read(String storageName) async {
    return _storage.read(key: storageName);
  }

  Future<void> removeToken() async {
    if (_storage.read(key: 'token') != null) {
      await _storage.delete(key: 'token');

      _dio.options.headers.remove('Authorization');
    }
  }

  Future<bool> validateToken() async {
    if (await _hasToken()) {
      final Response<dynamic> resp = await request('/auth/profile', queryParameter: {});
      final Map<String, dynamic> respData = resp.data as Map<String, dynamic>;
      return respData['success'] != false;
    }
    return false;
  }
}
