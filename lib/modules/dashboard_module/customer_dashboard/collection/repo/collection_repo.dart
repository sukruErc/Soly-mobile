import 'package:dio/dio.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/providers/api_client.dart';

class CollectionRepo {
  final ApiClient apiClient;
  CollectionRepo({required this.apiClient});

Future<Response?> getCollections(dynamic userId) async {
  try {
    var response = await apiClient.getData(
      AppConstants.collectionList,
      query: {"userId": userId},
      logs: true,
    );
    return response;
  } catch (e) {
    print("Error in getCollections: $e");
    rethrow;
  }
}


Future<Response?> redeemCoupon(dynamic data) async {
  return await apiClient.postData(
    AppConstants.redeemCoupon, 
    data, 
    logs: false,
  );
}

}
