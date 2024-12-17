import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/modules/authentication_module/otp/repo/otp_repo.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/strings.dart';

class OtpController extends GetxController {
  late GlobalKey<FormState> formOTPKey;
  late TextEditingController edtOTP;
  late OtpRepo repo;
  var isLoading = false.obs;
  var isShowResend = false.obs;
  var otpValue = 0.obs;
  late Timer timer;
  var start = 0.obs;

  OtpController({required this.repo});

  @override
  onInit() {
    formOTPKey = GlobalKey<FormState>();
    edtOTP = TextEditingController();
    startTimer();
    super.onInit();
  }

  // OTP Confirmation Logic
  startOtpConfirmation(String id, String pass) async {
    try {
      isLoading.value = true;
      var data = {
        "userId": id,
        "code": otpValue.toString(),
        "password": pass,
      };
      await repo.confirmOtp(data).then((response) {
        if (response!.statusCode == 200) {
          var otpResult = response.data;
          if (otpResult["success"] == true) {
            isLoading.value = false;
            snack(AppStrings.otpVerSucc);
            Future.delayed(
                const Duration(seconds: 2), () => Get.offAndToNamed("login"));
          } else {
            isLoading.value = false;
            redirectToRegistration(
                otpResult["message"] ?? AppStrings.otpFailed);
          }
        }
      });
    } on DioException catch (ex) {
      isLoading.value = false;
      if (ex.response != null && ex.response!.data != null) {
        String errorMessage =
            ex.response!.data['message'] ?? AppStrings.someThingWrong;
        redirectToRegistration(errorMessage);
      } else {
        redirectToRegistration(AppStrings.someThingWrong);
      }
    } catch (ex) {
      isLoading.value = false;
      redirectToRegistration(AppStrings.someThingWrong);
    }
  }

  void redirectToRegistration(String errorMessage) {
    snack(errorMessage, isError: true);
    Future.delayed(
        const Duration(seconds: 2), () => Get.offAllNamed("/registration"));
  }

  // Timer Logic
  void startTimer() {
    start.value = 150;
    try {
      const oneSec = Duration(seconds: 1);
      timer = Timer.periodic(
        oneSec,
        (Timer timer) {
          if (start.value == 0) {
            timer.cancel();
            redirectToRegistration("Süre doldu, lütfen yeniden kaydolun.");
          } else {
            start.value--;
          }
        },
      );
    } catch (e) {
      redirectToRegistration(AppStrings.someThingWrong);
    }
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}
