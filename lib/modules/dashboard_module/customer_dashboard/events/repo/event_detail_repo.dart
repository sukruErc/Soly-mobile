import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class EventDetailRepo {
  final ApiClient apiClient;

  EventDetailRepo({required this.apiClient});

  Future<Response?> fetchEventDetail(String eventId) async {
    return await apiClient.getData(
      logs: true,
      AppConstants.eventDetail,
      query: {"eventId": eventId},
    );
  }

  Future<Response?> fetchSimilarEvents(String eventId) async {
    return await apiClient.getData(
      logs: true,
      AppConstants.similarEvents,
      query: {"eventId": eventId},
    );
  }

  Future<Response?> fetchTickets(String eventId) async {
    return await apiClient.getData(
      logs: true,
      AppConstants.eventTickets,
      query: {"eventId": eventId},
    );
  }
}
