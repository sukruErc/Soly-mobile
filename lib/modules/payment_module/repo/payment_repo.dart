import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class PaymentRepo{
  late ApiClient apiClient;
  PaymentRepo({required this.apiClient});

  Future<Response?> holdTickets(dynamic data) async {
    return await apiClient.postData(
        AppConstants.holdTicket,
        data,
        logs: false,
    );
  }

  Future<Response?> unholdTickets(dynamic data) async {
    return await apiClient.postData(
        AppConstants.unholdTicket,
        data,
        logs: false,
    );
  }

    Future<Response?> sellTickets(dynamic data) async {
    return await apiClient.postData(
        AppConstants.sellTicket,
        data,
        logs: false,
    );
  }


    Future<Response?> applyCoupon(dynamic data) async {
    return await apiClient.postData(
        AppConstants.applyCoupon,
        data,
        logs: false,
    );
  }


}