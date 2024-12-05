import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class RegistrationRepository {
  final ApiClient apiClient;

  RegistrationRepository({required this.apiClient});

  Future<Response?> userRegistration(dynamic data) async {
    return await apiClient.postData(
      AppConstants.registerUser,
      data,
      logs: false,
    );
  }
}
