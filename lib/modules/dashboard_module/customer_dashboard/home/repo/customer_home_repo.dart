import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class CustomerHomeRepo{
  final ApiClient apiClient;
  CustomerHomeRepo({required this.apiClient});

  Future<Response?> getUpcomingEvents(dynamic data) async {
    return await apiClient.getData(
      logs: false,
      AppConstants.getHomeUpcomingEvents,
      // query: data
    );
  }

  Future<Response?> getEvents(dynamic data) async {
    return await apiClient.getData(
        logs: false,
        AppConstants.getHomeRecentEvents,
        // query: data
    );
  }

  Future<Response?> getLocations(dynamic data) async {
    return await apiClient.getData(
        logs: false,
        AppConstants.getHomeLocation,
        // query: data
    );
  }

  Future<Response?> getCategoryCount(dynamic data) async {
    return await apiClient.getData(
        logs: false,
        AppConstants.getHomeCategoryWithCount,
        // query: data
    );
  }
}