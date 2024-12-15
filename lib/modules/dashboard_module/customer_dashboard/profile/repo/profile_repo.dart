import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';
import 'package:solyticket/utills/global.dart';

class ProfileRepo {
  final ApiClient apiClient;

  ProfileRepo({required this.apiClient});

  // Fetch user information
  Future<Response?> getUserInfo(dynamic userId) async {
    try {
    var url = AppConstants.getUserInfo + '/${userId}';

      var response = await apiClient.getData(
        url , 
        logs: true,
      );
      return response;
    } catch (e) {
      print("Error in getUserInfo: $e");
      rethrow;
    }
  }

  Future<Response?> getUserTickets(dynamic userId) async {
    try {
      var response = await apiClient.getData(
        AppConstants.getUserTickets, 
        query: {"userId": userId},
        logs: true,
      );

      return response;
    } catch (e) {
      print("Error in getUserTickets: $e");
      rethrow;
    }
  }

Future<Response?> updateUserInfo(Map<String, dynamic> data) async {
  try {
    var userId = GlobalClass.userId;

    // Check for valid userId
    if (userId == null || userId.isEmpty) {
      throw Exception("User ID is null or empty");
    }

    String endpoint = "${AppConstants.updateUserInfo}/$userId";

    var response = await apiClient.putData(
      endpoint,
      data,
      logs: true,
    );

    if (response?.statusCode != 200) {
      print("API Error: ${response?.statusCode} - ${response?.data}");
      throw Exception("Failed to update user info. Status: ${response?.statusCode}");
    }

    return response;
  } catch (e) {
    print("Error in updateUserInfo: $e");
    rethrow; // Rethrow to allow handling in the calling function
  }
}


}
