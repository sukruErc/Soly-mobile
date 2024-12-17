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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.offAllNamed("registration");
          },
        ),
        title: Text(
          "Hesap Doğrulama",
          style: GoogleFonts.poppins(
            color: DefaultTheme().black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "6 Haneli Doğrulama Kodunu Girin",
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: DefaultTheme().primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Kayıtlı e-posta adresinize doğrulama kodu gönderildi.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: controller.formOTPKey,
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      autoFocus: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        activeColor: DefaultTheme().primaryColor,
                        inactiveColor: Colors.grey.shade300,
                        selectedColor: DefaultTheme().primaryColor,
                      ),
                      cursorColor: DefaultTheme().primaryColor,
                      enableActiveFill: true,
                      controller: controller.edtOTP,
                      onCompleted: (pin) async {
                        controller.otpValue.value = int.parse(pin);
                        if (pin.length == 6) {
                          await controller
                              .startOtpConfirmation(userId, password)
                              .catchError((error) {
                            snack(error?.message, isError: true);
                            Future.delayed(const Duration(seconds: 2), () {
                              Get.offAllNamed("registration");
                            });
                          });
                        } else {
                          snack("Doğrulama Kodu 6 haneli olmalıdır.",
                              isError: true);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    controller.start.value > 0
                        ? "Süre: ${controller.start.value} saniye"
                        : "Süre doldu. Lütfen yeniden deneyin.",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: controller.start.value > 0
                          ? DefaultTheme().redColor
                          : Colors.redAccent,
                    ),
                  ),
                  if (controller.start.value == 0)
                    TextButton(
                      onPressed: () {
                        Get.offAllNamed("registration");
                      },
                      child: const Text(
                        "Kayıt sayfasına geri dön",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (controller.isLoading.value)
                    const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.blue,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
