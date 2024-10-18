import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class EventDetailRepo{
  final ApiClient apiClient;
  EventDetailRepo({required this.apiClient});

  Future<Response?> eventDetail(dynamic data) async {
    return await apiClient.getData(
        logs: false,
        AppConstants.EVENT_DETAIL,
        query: data
    );
  }
}