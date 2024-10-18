import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/profile/controller/profile_controller.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/widget_formats.dart';
import 'package:solyticket/widgets/custom_text_form_field.dart';
import 'package:solyticket/widgets/select_image_widget.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultTheme().backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectImageWidget(
                circularImg: controller.imageController.image.value == null
                    ? CircleAvatar(
                        radius: 58,
                        backgroundColor: DefaultTheme().whiteColor,
                        backgroundImage:
                            const AssetImage('assets/images/profile.png'),
                      )
                    : CircleAvatar(
                        backgroundImage:
                            FileImage(File(controller.imageController.image.value!.path)),
                        radius: 58,
                      ),
              ),
              verticalGap(15),
              Text(
                'Shijra Hassan',
                style:
                    textDesigner(23, DefaultTheme().blackColor, fontWeight: FontWeight.bold),
              ),
              verticalGap(30),
              CustomTextFormField(
                maxLine: 1,
                labelText: 'Name',
                hintText: 'Name',
                controller: controller.emailController,
                prefixIcon: Icons.email,
                validator: emailValidator,
                isLabel: true,
              ),
              verticalGap(30),
              CustomTextFormField(
                maxLine: 1,
                labelText: 'Email Address',
                hintText: 'Email Address',
                controller: controller.emailController,
                prefixIcon: Icons.email,
                validator: emailValidator,
                isLabel: true,
              ),
              verticalGap(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: Media.height()*0.050,
                    width: Media.width()*0.4,
                    decoration: BoxDecoration(
                      color: DefaultTheme().whiteColor,
                      border: Border.all(color: DefaultTheme().primaryColor),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Center(
                      child: Text(
                        'Change Password',
                        style: textDesigner(14, DefaultTheme().primaryColor),
                      ),
                    ),
                  ),
                  Container(
                  height: Media.height()*0.050,
                    width: Media.width()*0.4,
                  decoration: BoxDecoration(
                    color: DefaultTheme().primaryColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Center(
                    child: Text(
                      'Save Changes',
                      style: textDesigner(14, DefaultTheme().whiteColor),
                    ),
                  ),
                )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
