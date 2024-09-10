import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/components/custom_loader_button.dart';
import 'package:solyticket/components/custom_text_form_field.dart';
import 'package:solyticket/constants/color_constant.dart';
import 'package:solyticket/controllers/image_picker_controller.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/widget_formats.dart';
import 'package:solyticket/view/auth/components/rich_text.dart';
import 'package:solyticket/view/auth/login_view.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  ImagePickerController imageController = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Column(children: [
                  Image(
                    height: Media.screenHeight(context) * 0.240,
                    width: Media.screenWidth(context) * 0.240,
                    image: const AssetImage('assets/images/logo.png'),
                  ),
                  Text(
                    'Create Your Account',
                    style: textDesigner(23, blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  verticalGap(40),
                  CustomTextFormField(
                    maxLine: 1,
                    prefixIcon: Icons.person,
                    controller: nameController,
                    hintText: "Ad Soyad",
                    validator: mandatoryValidator,
                    labelText: 'Ad Soyad',
                  ),
                  verticalGap(20),
                  CustomTextFormField(
                    maxLine: 1,
                    labelText: 'E-mail',
                    prefixIcon: Icons.email,
                    controller: emailController,
                    hintText: "E-mail",
                    validator: emailValidator,
                  ),
                  verticalGap(20),
                  CustomTextFormField(
                    maxLine: 1,
                    labelText: 'Telephone',
                    prefixIcon: Icons.phone,
                    controller: phoneController,
                    hintText: "Telephone",
                    validator: numberValidator,
                    inputType: TextInputType.number,
                  ),
                  verticalGap(20),
                  CustomTextFormField(
                    maxLine: 1,
                    labelText: 'Date of birth',
                    prefixIcon: Icons.calendar_today,
                    controller: dobController,
                    hintText: "Date of birth",
                    validator: numberValidator,
                    readOnly: true,
                    inputType: TextInputType.number,
                    onTap: () async {
                      // picker.NepaliDateTime? selectedDateTime =
                      //     await picker.showMaterialDatePicker(
                      //   context: context,
                      //   initialDate: NepaliDateTime.now(),
                      //   firstDate: NepaliDateTime(2000),
                      //   lastDate: NepaliDateTime(2090),
                      //   initialDatePickerMode: DatePickerMode.day,
                      // );
                      // dobController.text = selectedDateTime.toString();
                    },
                  ),
                  verticalGap(20),
                  CustomTextFormField(
                    maxLine: 1,
                    labelText: 'Password',
                    prefixIcon: Icons.lock,
                    isVisible: true,
                    controller: passwordController,
                    hintText: 'Password',
                    validator: passwordValidator,
                    suffixIcon: Icons.visibility,
                    suffixIcon2: Icons.visibility_off,
                  ),
                  verticalGap(50),
                  CustomLoaderButton(
                    btnText: 'Sign up',
                    onTap: () async {},
                    // onTap: () async {
                    //   try {
                    //     UserModel userModel = UserModel(
                    //       uid: '',
                    //       name: nameController.text,
                    //       email: emailController.text,
                    //       phone: phoneController.text,
                    //       type: authController.selectedTypeValue.value,
                    //       currentLocation: mapControllerValue.text,
                    //       imageUrl: '',
                    //     );

                    //     bool isRegister = await authController.register(
                    //         userModel, passwordController.text);
                    //     if (isRegister) {
                    //       Get.off(() => const LoginView());
                    //     }
                    //   } catch (e) {
                    //     print(e);
                    //   }
                    // },
                  ),
                  verticalGap(40),
                  RichTextWidget(
                      messageText: 'Do you have an account?',
                      titleText: '  Log in',
                      onTap: () {
                        Get.off(() => const LoginView());
                      })
                ]),
              ),
            )));
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dobController.dispose();
  }
}
