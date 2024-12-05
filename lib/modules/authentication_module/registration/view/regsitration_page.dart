import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/authentication_module/registration/controller/registration_controller.dart';
import 'package:solyticket/utills/images.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/strings.dart';
import 'package:solyticket/utills/widget_formats.dart';
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
            backgroundColor: DefaultTheme().backgroundColor,
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                headerImageAndTitle(context),
                verticalGap(40),
                signUpInputs(context),
                verticalGap(50),
                signUpButton(),
                verticalGap(40),
                signUpFooter()
              ]),
            )));
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
          AppStrings.createAccountHeader,
          style: textDesigner(23, DefaultTheme().blackColor,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  signUpInputs(BuildContext context) {
    return Form(
        key: controller.signUpFormKey,
        child: Column(
      children: [
        CustomTextFormField(
          maxLine: 1,
          prefixIcon: Icons.person,
          controller: controller.nameController,
          hintText: AppStrings.txtFldName,
          validator: nameValidator,
          labelText:  AppStrings.txtFldName,
          isLabel: true,
        ),
        verticalGap(20),
        CustomTextFormField(
          maxLine: 1,
          labelText:  AppStrings.email,
          prefixIcon: Icons.email,
          controller: controller.emailController,
          hintText: AppStrings.email,
          validator: emailValidator,
          isLabel: true,
        ),
        verticalGap(20),
        CustomTextFormField(
          maxLine: 1,
          labelText: AppStrings.txtFldTelephone,
          prefixIcon: Icons.phone,
          controller: controller.phoneController,
          hintText: AppStrings.txtFldTelephone,
          validator: phoneValidator,
          inputType: TextInputType.number,
          isLabel: true,
        ),
        verticalGap(20),
        CustomTextFormField(
          maxLine: 1,
          labelText: AppStrings.txtFldDob,
          prefixIcon: Icons.calendar_today,
          controller: controller.dobController,
          hintText: AppStrings.txtFldDob,
          validator: dobValidator,
          readOnly: true,
          inputType: TextInputType.number,
          isLabel: true,
          onTap: () async {
            selectDate(context);
          },
        ),
        verticalGap(20),
        CustomTextFormField(
          maxLine: 1,
          labelText: AppStrings.password,
          prefixIcon: Icons.lock,
          isVisible: true,
          controller: controller.passwordController,
          hintText: AppStrings.password,
          validator: passwordValidator,
          suffixIcon: Icons.visibility,
          suffixIcon2: Icons.visibility_off,
          isLabel: true,
        ),
      ],
    ));
  }

  signUpButton() {
    return Obx(() => CustomLoaderButton(
          btnText: AppStrings.signUp,
          onTap: () async {
            if(controller.signUpFormKey.currentState!
                .validate()){
              controller.register();
            }
          },
          isLoading: controller.isLoading.value,
        ));
  }

  signUpFooter() {
    return RichTextWidget(
        messageText: AppStrings.haveAccount,
        titleText: AppStrings.signLoginTitle,
        onTap: () {
          Get.offAndToNamed("login");
        });
  }

  selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: controller.selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.blue,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      controller.selectedDate = newSelectedDate;
      controller.dobController
        ..text = DateFormat.yMMMd().format(controller.selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: controller.dobController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}
