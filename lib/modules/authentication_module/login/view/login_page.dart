import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/authentication_module/login/controller/login_controller.dart';
import 'package:solyticket/utills/images.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/strings.dart';
import 'package:solyticket/utills/widget_formats.dart';
import 'package:solyticket/widgets/app_layout.dart';
import 'package:solyticket/widgets/custom_loader_button.dart';
import 'package:solyticket/widgets/custom_text_form_field.dart';
import 'package:solyticket/widgets/forget_bottom_sheet.dart';
import 'package:solyticket/widgets/rich_text.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultAppLayout(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              headerImageAndTitle(context),
              verticalGap(30),
              loginInputs(),
              const ForgetPasswordWidget(),
              verticalGap(50),
              loginButton(),
              verticalGap(100),
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
        Text(
          AppStrings.login,
          style: textDesigner(23, DefaultTheme().blackColor,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  loginInputs() {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            maxLine: 1,
            labelText: AppStrings.email,
            hintText: AppStrings.email,
            controller: controller.emailController,
            prefixIcon: Icons.email,
            validator: emailValidator,
            isLabel: true,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            maxLine: 1,
            labelText: AppStrings.password,
            hintText: AppStrings.password,
            controller: controller.passwordController,
            prefixIcon: Icons.lock,
            suffixIcon: Icons.visibility,
            suffixIcon2: Icons.visibility_off,
            // validator: passwordValidator,
            isVisible: true,
            isLabel: true,
          ),
        ],
      ),
    );
  }

  loginButton() {
    return Obx(() => CustomLoaderButton(
          btnText: AppStrings.login,
          onTap: () async {
            if(controller.formKey.currentState!
                .validate()){
              controller.login();
            }
          },
          isLoading: controller.isLoading.value,
        ));
  }

  signUpFooter() {
    return RichTextWidget(
        messageText: AppStrings.donthaveAccount,
        titleText: AppStrings.signUp,
        onTap: () {
          Get.toNamed("registration");
        });
  }
}
