import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/authentication_module/otp/controller/otp_controller.dart';
import 'package:solyticket/utills/snippets.dart';


class OtpPage extends GetView<OtpController> {
  OtpPage({super.key});
  final userId = Get.arguments[0];
  final password = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(() =>
          SingleChildScrollView(
            child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top:Get.height*0.15),
                      child: Text(
                        "OTP",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 32,
                              color: DefaultTheme().black,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                    verticalGap(20),
                    Flexible(
                      child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: controller.formOTPKey,
                          child: Column(
                            children: [
                              PinCodeTextField(
                                appContext: context,
                                pastedTextStyle: const TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 6,
                                obscureText: false,
                                blinkWhenObscuring: true,
                                autoFocus: true,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 42,
                                  fieldWidth: 42,
                                  activeFillColor: Colors.white,
                                  inactiveFillColor: Colors.white,
                                  selectedFillColor: Colors.white,
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.white,
                                  selectedColor: Theme
                                      .of(context)
                                      .primaryColor,
                                ),
                                cursorColor: Colors.grey.shade600,
                                animationDuration: Duration(milliseconds: 300),
                                enableActiveFill: true,
                                // errorAnimationController: errorController,
                                controller: controller.edtOTP,
                                keyboardType: TextInputType.number,
                                onCompleted: (pin) {
                                  controller.otpValue.value =
                                      int.parse(pin);
                                  String lenth = controller
                                      .otpValue.value
                                      .toString();
                                  if (lenth.length.isEqual(6)) {
                                      controller.startOtpConfirmation(userId,password);
                                  } else {
                                    Get.snackbar("","OTP should be Atleast 6 Digit").show();
                                  }
                                },
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                              ),
                              Column(children: [
                                verticalGap(10),
                                Text(
                                  "${controller.start.value}s",
                                  style: TextStyle(
                                      fontSize: 14, color: DefaultTheme().redColor),
                                  textAlign: TextAlign.center,
                                ),
                                verticalGap(10),
                                Text(
                                  "We have sent a 6-digit OTP on your registered e-mail.",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[400]),
                                    textAlign: TextAlign.center
                                ),
                                Column(
                                  children: [
                                    verticalGap(15),
                                    controller.isLoading.value
                                        ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          backgroundColor: DefaultTheme()
                                              .primaryColor,
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ))
                                        : Container(),
                                    verticalGap(15),
                                  ],
                                ),
                                // controller.isShowResend.value
                                //     ? InkWell(
                                //   onTap: () {
                                //     // controller.resendOTP();
                                //   },
                                //   child: Container(
                                //     margin: const EdgeInsets.only(bottom: 10),
                                //     child: Text(
                                //       AppStrings.resendOtp,
                                //       style: const TextStyle(
                                //           fontSize: 13,
                                //           color: Colors.green,
                                //           decoration: TextDecoration.underline),
                                //     ),
                                //   ),
                                // )
                                //     : Container(),
                              ],),
                            ],
                          )),
                    ),
                    verticalGap(20)
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
