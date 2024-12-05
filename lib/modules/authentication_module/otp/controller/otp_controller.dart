import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/modules/authentication_module/otp/repo/otp_repo.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/strings.dart';

class OtpController extends GetxController{
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
  onInit(){
    formOTPKey = GlobalKey<FormState>();
    edtOTP = TextEditingController();
    startTimer();
    super.onInit();
  }

  startOtpConfirmation(String id,String pass) async {
    try{
      isLoading.value = true;
      var data = {
        "userId": id,
        "code": otpValue.toString(),
        "password": pass,
      };
      await repo.confirmOtp(data).then((response) {
        if(response!.statusCode==200){
          var otpResult = response.data;
          if(otpResult["success"]==true){
            isLoading.value = false;
            snack(AppStrings.otpVerSucc);
            Future.delayed(
                const Duration(seconds: 3), () => Get.offAndToNamed("login"));
          }else{
            isLoading.value = false;
            snack(AppStrings.otpFailed, isError: true);
          }
        }
      });
    }catch(ex){
      isLoading.value = false;
      snack(AppStrings.someThingWrong, isError: true);
    }
  }

  void startTimer() {
    start.value = 150;
    // isShowResend.value = false;
    try{
      const oneSec = Duration(seconds: 1);
      timer = Timer.periodic(
        oneSec,
            (Timer timer) {
          if (start.value == 0) {
            timer.cancel();
            isShowResend.value = true;
          } else {
            start.value--;
          }
        },
      );
    }catch(e){
      //isShowResend.value = true;
    }
  }
}