import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class OtpRepo{
  late ApiClient apiClient;
  OtpRepo({required this.apiClient});

  Future<Response?> confirmOtp(var data) async {
   return await apiClient.postData(AppConstants.userVerify,data, logs: false);
  }
}