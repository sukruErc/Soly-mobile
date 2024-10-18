import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class CustomerHomeRepo{
  final ApiClient apiClient;
  CustomerHomeRepo({required this.apiClient});

  Future<Response?> getUpcomingEvents(dynamic data) async {
    return await apiClient.getData(
      logs: false,
      AppConstants.GET_HOME_UPCOMING_EVENTS,
      // query: data
    );
  }

  Future<Response?> getEvents(dynamic data) async {
    return await apiClient.getData(
        logs: false,
        AppConstants.GET_HOME_RECENT_EVENTS,
        // query: data
    );
  }

  Future<Response?> getLocations(dynamic data) async {
    return await apiClient.getData(
        logs: false,
        AppConstants.GET_HOME_LOCATION,
        // query: data
    );
  }

  Future<Response?> getCategoryCount(dynamic data) async {
    return await apiClient.getData(
        logs: false,
        AppConstants.GET_HOME_CATEGORY_WITH_COUNT,
        // query: data
    );
  }
}