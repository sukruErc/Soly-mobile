import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class LoginRepository {
  final ApiClient apiClient;

  LoginRepository({
    required this.apiClient,
  });

  Future<Response?> userLogin(dynamic data) async {
    return await apiClient
        .postData(AppConstants.loginUrl,data, logs: false);
  }
}
