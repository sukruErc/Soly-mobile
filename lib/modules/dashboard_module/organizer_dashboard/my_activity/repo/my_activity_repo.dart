import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class MyActivityRepo{
  ApiClient apiClient;
  MyActivityRepo({required this.apiClient});

  Future<Response?> getMyActivities(dynamic data) async {
    return await apiClient.getData(
        logs: false,
        AppConstants.myActivity,
        query: data
    );
  }
}