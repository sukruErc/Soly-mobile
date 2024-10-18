import 'dart:convert';
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
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  login() async {
    try{
      isLoading.value = true;
      var data = {
        "email": emailController.text,
        "password": passwordController.text,
      };
      await repo.userLogin(data).then((response) {
        if(response!.statusCode==200){
          var loginResult = response.data;
          if(loginResult["success"]==true){
            isLoading.value = false;
            var login = LoginJson.fromJson(loginResult);
            if(login.data.role[0].name=="soly-cust"){
              GlobalClass.userRoleType = "soly-cust";
              Get.offAndToNamed("customer-dashboard");
            }else{
              GlobalClass.userRoleType = "soly-org";
            }
          }else{
            isLoading.value = false;
            snack(AppStrings.loginFailed, isError: true);
          }
        }
      });
    }catch(ex){
      isLoading.value = false;
      snack(AppStrings.someThingWrong, isError: true);
    }
  }
}