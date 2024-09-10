import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/components/custom_loader_button.dart';
import 'package:solyticket/components/custom_text_form_field.dart';
import 'package:solyticket/constants/color_constant.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/widget_formats.dart';
import 'package:solyticket/view/auth/components/forget_bottom_sheet.dart';
import 'package:solyticket/view/auth/components/rich_text.dart';
import 'package:solyticket/view/auth/regsiter_view.dart';


class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  height: Media.screenHeight(context) * 0.240,
                  width: Media.screenWidth(context) * 0.240,
                  image: const AssetImage('assets/images/logo.png'),
                ),
                Text(
                  'Login',
                  style:
                      textDesigner(23, blackColor, fontWeight: FontWeight.bold),
                ),
                verticalGap(30),
                CustomTextFormField(
                  maxLine: 1,
                  labelText: 'Email',
                  hintText: 'Email',
                  controller: emailController,
                  prefixIcon: Icons.email,
                  validator: emailValidator,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  maxLine: 1,
                  labelText: 'Password',
                  hintText: 'Password',
                  controller: passwordController,
                  prefixIcon: Icons.lock,
                  suffixIcon: Icons.visibility,
                  suffixIcon2: Icons.visibility_off,
                  validator: passwordValidator,
                  isVisible: true,
                ),
                const ForgetPasswordWidget(),
                const SizedBox(height: 50),
                CustomLoaderButton(
                  btnText: 'Login',
                  onTap: () async {},
                ),
                const SizedBox(height: 100),
                RichTextWidget(
                    messageText: """Don't have an account?""",
                    titleText: '  Sign Up',
                    onTap: () {
                      Get.off(() => const RegisterView());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
