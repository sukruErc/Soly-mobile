import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class CustomerHomeRepo {
  final ApiClient apiClient;
  CustomerHomeRepo({required this.apiClient});

  Future<Response?> getNewlySales(dynamic data) async {
    return await apiClient.getData(
      logs: false,
      AppConstants.getNewlySales,
      // query: data
    );
  }

  Future<Response?> getRecentEvents(dynamic data) async {
    return await apiClient.getData(
      logs: false,
      AppConstants.getRecentEvents,
      // query: data
    );
  }

  Future<Response?> getHotTickets(dynamic data) async {
    return await apiClient.getData(
      logs: false,
      AppConstants.getHotTickets,
      // query: data
    );
  }

  Future<Response?> getSolyAdvice(dynamic data) async {
    return await apiClient.getData(
      logs: false,
      AppConstants.getSolyAdvice,
      // query: data
    );
  }

  Future<Response?> gethighlightedEvent(dynamic data) async {
    return await apiClient.getData(
      logs: false,
      AppConstants.gethighlightedEvent,
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
