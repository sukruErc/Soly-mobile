import 'dart:convert';

import 'package:get/get.dart';
import 'package:solyticket/utills/global.dart';
import '../repo/profile_repo.dart';

class ProfileController extends GetxController {
  final ProfileRepo repo;

  ProfileController({required this.repo});

  var userInfo = {}.obs;
  var tickets = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
    fetchUserTickets();
  }

  Future<void> fetchUserInfo() async {
    try {
      isLoading.value = true;
      var response = await repo.getUserInfo(GlobalClass.userId);

      if (response?.data != null) {
        userInfo.value = jsonDecode(response!.data);

      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user information");
    } finally {
      isLoading.value = false;
    }
  }

Future<void> fetchUserTickets() async {
  try {
    isLoading.value = true;

    // Fetch the tickets from the repository
    var response = await repo.getUserTickets(GlobalClass.userId);

    if (response?.data != null) {
      // Decode the response data and extract ticket details
      final responseData = jsonDecode(response?.data);
      if (responseData['success'] == true && responseData['data'] is List) {
        tickets.value = responseData['data'].cast<Map<String, dynamic>>();
      } else {
        throw Exception("Unexpected response format: ${response?.data}");
      }
    }
  } catch (e) {
    print("Error in fetchUserTickets: $e");
    Get.snackbar("Error", "Failed to fetch tickets");
  } finally {
    isLoading.value = false;
  }
}



Future<void> updateEmail(String email) async {
  try {
    isLoading.value = true;

    // Prepare the data payload
    Map<String, dynamic> data = {"email": email};

    // Call the API to update the email
    var response = await repo.updateUserInfo(data);

    if (response != null && response.data != null) {
      // Directly use the response.data as a Map
      final Map<String, dynamic> responseData = response.data;

      // Update the userInfo observable map
      userInfo.update("email", (currentEmail) => responseData['data']['email']);

      Get.snackbar("Başarılı", "E-posta başarıyla güncellendi");
    }
  } catch (e) {
    Get.snackbar("Hata", "E-posta güncellenemedi: $e");
    print("Error in updateEmail: $e");
  } finally {
    isLoading.value = false;
  }
}

  Future<void> updatePassword(String password) async {
    try {
      isLoading.value = true;
      await repo.updateUserInfo({"password": password});
      Get.snackbar("Success", "Password updated successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to update password");
    } finally {
      isLoading.value = false;
    }
  }
}
