import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class LocationRepo{
  final ApiClient apiClient;
  LocationRepo({required this.apiClient});
  Future<Response?> getLocationsFromServer()async{
    return await apiClient.getData(AppConstants.getLocations);
  }
}