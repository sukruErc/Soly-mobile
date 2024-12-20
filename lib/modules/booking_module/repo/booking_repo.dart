import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class BookingRepo{
  late ApiClient apiClient;
  BookingRepo({required this.apiClient});

  Future<Response?> getSeatBookingCategory(dynamic data) async {
    return await apiClient.getData(
        logs: false,
        AppConstants.getSeatCategories,
        query: data
    );
  }

  Future<Response?> getSeats(dynamic data) async {
    return await apiClient.getData(
        logs: false,
        AppConstants.getSeats,
        query: data
    );
  }
}