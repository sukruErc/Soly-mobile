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
      if (GlobalClass.userId != "") {
        isLoading.value = true;
        var response = await repo.getUserInfo(GlobalClass.userId);

        if (response?.data != null) {
          userInfo.value = jsonDecode(response!.data);
        }
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

      if (GlobalClass.userId != "") {
        var response = await repo.getUserTickets(GlobalClass.userId);

        if (response?.data != null) {
          final responseData = jsonDecode(response?.data);
          if (responseData['success'] == true && responseData['data'] is List) {
            tickets.value = responseData['data'].cast<Map<String, dynamic>>();
          } else {
            throw Exception("Unexpected response format: ${response?.data}");
          }
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

      Map<String, dynamic> data = {"email": email};

      var response = await repo.updateUserInfo(data);

      if (response != null && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

        userInfo.update(
            "email", (currentEmail) => responseData['data']['email']);

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
