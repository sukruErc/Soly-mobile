import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:get/get.dart' hide Response;
import 'package:solyticket/constants/app_constant.dart';

class ApiClient {
  static final _dio = DioClient.instance.getDioClient();

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query,
      Map<String, String>? headers,
      bool logs = true}) async {
    return await _dio.get(
      AppConstants.BASE_URL + uri,
      queryParameters: query,
      options: Options(responseType: ResponseType.plain, headers: headers),
    );
  }

  Future<Response> postData(String? uri, dynamic body,
      {Map<String, String>? headers,
      Map<String, dynamic>? query,
      bool ignoreExceptions = false,
      bool logs = true}) async {
    return await _dio.post(AppConstants.BASE_URL + uri!,
        data: body, options: Options(method: "POST", headers: headers));
  }
}

class DioClient {
  //flutter run --no-sound-null-safety -d chrome --web-port=1234

  static final DioClient _instance = DioClient._();

  DioClient._();

  static DioClient get instance => _instance;

  Dio getDioClient() {
    final Dio dio = Dio(BaseOptions(
        baseUrl: '',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        maxRedirects: 3));
    // onHTTPCreate(dio);
    return dio;
  }
}
