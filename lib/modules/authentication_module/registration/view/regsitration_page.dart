import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/authentication_module/registration/controller/registration_controller.dart';
import 'package:solyticket/utills/images.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/strings.dart';
import 'package:solyticket/widgets/custom_loader_button.dart';
import 'package:solyticket/widgets/custom_text_form_field.dart';
import 'package:solyticket/widgets/rich_text.dart';

class RegistrationPage extends GetView<RegistrationController> {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.offAllNamed('/customer-dashboard'); // Back to dashboard
            },
          ),
        ),
        backgroundColor: DefaultTheme().backgroundColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              headerImageAndTitle(context),
              const SizedBox(height: 30),
              signUpInputs(context),
              const SizedBox(height: 40),
              signUpButton(),
              const SizedBox(height: 40),
              signUpFooter()
            ],
          ),
        ),
      ),
    );
  }

  headerImageAndTitle(BuildContext context) {
    return Column(
      children: [
        Image(
          height: Media.height() * 0.240,
          width: Media.width() * 0.240,
          image: const AssetImage(AppImages.logo),
        ),
        const Text(
          "Hesabınızı Oluşturun",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  signUpInputs(BuildContext context) {
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          // Ad Soyad
          CustomTextFormField(
            labelText: "Ad Soyad",
            hintText: "Ad Soyad",
            prefixIcon: Icons.person,
            controller: controller.nameController,
            isLabel: true,
            validator: (value) =>
                value!.isEmpty ? "Ad Soyad zorunludur." : null,
          ),
          const SizedBox(height: 20),

          // E-posta
          CustomTextFormField(
            labelText: "E-posta",
            hintText: "E-posta",
            prefixIcon: Icons.email,
            controller: controller.emailController,
            isLabel: true,
            validator: emailValidator,
          ),
          const SizedBox(height: 20),

          // Telefon
          CustomTextFormField(
            labelText: "Telefon",
            hintText: "(5XX) XXX XX XX",
            prefixIcon: Icons.phone,
            controller: controller.phoneController,
            inputType: TextInputType.phone,
            isLabel: true,
            inputFormatters: [PhoneInputFormatter()],
            validator: (value) {
              final phone = value?.replaceAll(RegExp(r'\D'), '') ?? '';
              if (phone.length != 10) {
                return "Telefon numarası geçerli değil.";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Doğum Tarihi
          CustomTextFormField(
            labelText: "Doğum Tarihi",
            hintText: "Doğum Tarihi",
            prefixIcon: Icons.calendar_today,
            controller: controller.dobController,
            isLabel: true,
            readOnly: true,
            onTap: () => selectDate(context),
            validator: (value) =>
                value!.isEmpty ? "Doğum Tarihi zorunludur." : null,
          ),
          const SizedBox(height: 20),

          // Şifre
          CustomTextFormField(
            maxLine: 1,
            labelText: "Şifre",
            prefixIcon: Icons.lock,
            isVisible: true,
            controller: controller.passwordController,
            hintText: "Şifre",
            validator: validatePassword,
            suffixIcon: Icons.visibility,
            suffixIcon2: Icons.visibility_off,
            isLabel: true,
          ),
          const SizedBox(height: 20),

          // Şifre Onayı
          CustomTextFormField(
            maxLine: 1,
            labelText: "Şifre Onayı",
            prefixIcon: Icons.lock,
            isVisible: true,
            controller: controller.confirmPasswordController,
            hintText: "Şifre Onayı",
            validator: (value) {
              if (value != controller.passwordController.text) {
                return "Şifreler eşleşmiyor";
              }
              return null;
            },
            suffixIcon: Icons.visibility,
            suffixIcon2: Icons.visibility_off,
            isLabel: true,
          ),
        ],
      ),
    );
  }

  signUpButton() {
    return Obx(() => CustomLoaderButton(
          btnText: "Kaydol",
          onTap: () async {
            if (controller.signUpFormKey.currentState!.validate()) {
              controller.register();
            } else {
              snack("Lütfen tüm alanları doldurun ve sözleşmeyi kabul edin.",
                  isError: true);
            }
          },
          isLoading: controller.isLoading.value,
        ));
  }

  signUpFooter() {
    return RichTextWidget(
      messageText: "Zaten hesabınız var mı?",
      titleText: "Giriş Yap",
      onTap: () => Get.offAndToNamed("login"),
    );
  }

  selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (newSelectedDate != null) {
      controller.dobController.text =
          DateFormat('yyyy-MM-dd').format(newSelectedDate);
    }
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'\D'), ''); // Only digits
    String formatted = '';

    if (digits.length >= 1) {
      formatted += '(${digits.substring(0, 3)}'; // First 3 digits (area code)
    }
    if (digits.length >= 4) {
      formatted += ') ${digits.substring(3, 6)}'; // Next 3 digits
    }
    if (digits.length >= 7) {
      formatted += ' ${digits.substring(6, 8)}'; // Next 2 digits
    }
    if (digits.length >= 9) {
      formatted += ' ${digits.substring(8, 10)}'; // Final 2 digits
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return "Şifre zorunludur.";
  if (value.length < 8) return "Şifre en az 8 karakter olmalıdır.";
  if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).+$')
      .hasMatch(value)) {
    return "Şifre en az bir büyük harf, bir küçük harf, bir rakam ve özel karakter içermelidir.";
  }
  return null;
}
