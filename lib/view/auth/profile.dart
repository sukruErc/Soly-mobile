import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/components/custom_text_form_field.dart';
import 'package:solyticket/components/select_image_widget.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/widget_formats.dart';
import '../../constants/color_constant.dart';
import '../../controllers/image_picker_controller.dart';
import '../../utills/snippets.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  ImagePickerController imageController = Get.put(ImagePickerController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectImageWidget(
                circularImg: imageController.image.value == null
                    ? const CircleAvatar(
                        radius: 58,
                        backgroundColor: whiteColor,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      )
                    : CircleAvatar(
                        backgroundImage:
                            FileImage(File(imageController.image.value!.path)),
                        radius: 58,
                      ),
              ),
              verticalGap(15),
              Text(
                'Shijra Hassan',
                style:
                    textDesigner(23, blackColor, fontWeight: FontWeight.bold),
              ),
              verticalGap(30),
              CustomTextFormField(
                maxLine: 1,
                labelText: 'Name',
                hintText: 'Name',
                controller: emailController,
                prefixIcon: Icons.email,
                validator: emailValidator,
              ),
              verticalGap(30),
              CustomTextFormField(
                maxLine: 1,
                labelText: 'Email Address',
                hintText: 'Email Address',
                controller: emailController,
                prefixIcon: Icons.email,
                validator: emailValidator,
              ),
              verticalGap(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: Media.screenHeight(context)*0.050,
                    width: Media.screenWidth(context)*0.4,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Center(
                      child: Text(
                        'Change Password',
                        style: textDesigner(14, primaryColor),
                      ),
                    ),
                  ),
                  Container(
                  height: Media.screenHeight(context)*0.050,
                    width: Media.screenWidth(context)*0.4,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Center(
                    child: Text(
                      'Save Changes',
                      style: textDesigner(14, whiteColor),
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

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
