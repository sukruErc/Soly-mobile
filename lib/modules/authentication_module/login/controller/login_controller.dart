import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/model/login_json.dart';
import 'package:solyticket/modules/authentication_module/login/repo/login_repo.dart';
import 'package:solyticket/utills/global.dart';
import 'package:solyticket/utills/snippets.dart';

class LoginController extends GetxController {
  final LoginRepository repo;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  LoginController({required this.repo});

  Future<void> login() async {
    try {
      isLoading.value = true;

      // Giriş verilerini hazırlayın
      Map<String, dynamic> data = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };


      final response = await repo.userLogin(data);

      if (response?.statusCode == 200) {

        final loginResult = response!.data;

        if (loginResult["success"] == true) {
          isLoading.value = false;

          // Kullanıcı bilgilerini modele uygun şekilde kaydet
          var login = LoginJson.fromJson(loginResult);

          GlobalClass().setUserInfo(login);

          // Role göre yönlendirme
          if (login.data.role[0].name == "soly-cust") {
            Get.offAndToNamed("customer-dashboard");
          } else {
            Get.offAndToNamed("organizer-dashboard");
          }
        } else {
          isLoading.value = false;
          _showErrorSnackBar("Giriş Başarısız", "Giriş bilgileri doğrulanamadı.");
        }
      } else {
        isLoading.value = false;
        _showErrorSnackBar("Sunucu Hatası", "Bir sorun oluştu. Lütfen tekrar deneyin.");
      }
    } on DioException catch (ex) {
      isLoading.value = false;

      if (ex.response != null && ex.response!.data != null) {
        String errorMessage = ex.response!.data['message'] ?? "Bir hata oluştu.";
        _showErrorSnackBar("Hata", errorMessage);
      } else {
        _showErrorSnackBar("Bağlantı Hatası", "Sunucuya bağlanılamadı. Lütfen internet bağlantınızı kontrol edin.");
      }
    } catch (ex) {
      isLoading.value = false;

      _showErrorSnackBar("Beklenmeyen Hata", "Bir hata oluştu. Lütfen tekrar deneyin.");
      print("Hata: $ex");
    }
  }

  void _showErrorSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
