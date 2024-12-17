import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/modules/authentication_module/registration/repo/registration_repository.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/strings.dart';

class RegistrationController extends GetxController {
  RegistrationRepository repo;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController(); // Add this line
  final dobController = TextEditingController();

  final signUpFormKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  var isLoading = false.obs;

  RegistrationController({required this.repo});

  register() async {
    isLoading.value = true;
    try {
      var data = {
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
        "birthday": dobController.text,
        "role": "CUSTOMER",
      };
      await repo.userRegistration(data).then((response) {
        if (response!.statusCode == 200 || response.statusCode == 201) {
          var registerResult = response.data;

          if (registerResult["success"] == true) {
            isLoading.value = false;
            var userId = registerResult["data"]["userId"];

            Get.toNamed("otp", arguments: [userId, passwordController.text]);
          } else {
            isLoading.value = false;
            snack(AppStrings.signUpFailed, isError: true);
          }
        }
      });
    } catch (e) {
      isLoading.value = false;
      snack(AppStrings.someThingWrong, isError: true);
    }
  }
}
