import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class EventRepo{
  final ApiClient apiClient;
  EventRepo({required this.apiClient});
  Future<Response?> eventSearch(dynamic data) async {
    return await apiClient.getData(
        logs: false,
        AppConstants.EVENT_SEARCH,
        query: data
    );
  }

  Future<Response?> eventFilter(dynamic data) async {
    return await apiClient.getData(
        logs: false,
        AppConstants.EVENT_FILTER,
        query: data
    );
  }
}