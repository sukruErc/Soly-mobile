import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class OrganizerHomeRepo{
  ApiClient apiClient;
  OrganizerHomeRepo({required this.apiClient});
  Future<Response?> getHomeData(dynamic data) async {
    return await apiClient.getData(
        logs: false,
        AppConstants.ORGANIZER_HOME_DATA,
        query: data
    );
  }
}