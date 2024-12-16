import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/model/login_json.dart';
import 'package:solyticket/modules/authentication_module/login/repo/login_repo.dart';
import 'package:solyticket/utills/global.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/strings.dart';
class LoginController extends GetxController{
  LoginRepository repo;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  LoginController({required this.repo});


login() async {
  try {
    isLoading.value = true;
    var data = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    await repo.userLogin(data).then((response) {
      if (response?.statusCode == 200) {
        var loginResult = jsonDecode(response!.data);;
        if (loginResult["success"] == true) {
          isLoading.value = false;
          var login = LoginJson.fromJson(loginResult);
          GlobalClass().setUserInfo(login);
          if (login.data.role[0].name == "soly-cust") {
            Get.offAndToNamed("customer-dashboard");
          } else {
            Get.offAndToNamed("organizer-dashboard");
          }
        } else {
          isLoading.value = false;
          snack(AppStrings.loginFailed, isError: true);
        }
      }
    });
  } on DioException catch (ex) {

    isLoading.value = false;

    if (ex.response != null && ex.response!.data != null) {

      String errorMessage = ex.response!.data['message'] ?? AppStrings.someThingWrong;
      snack(errorMessage, isError: true);
    } else {

      snack(AppStrings.someThingWrong, isError: true);
    }
  } catch (ex) {

    isLoading.value = false;
    snack(AppStrings.someThingWrong, isError: true);
    print(ex);
  }
}

}