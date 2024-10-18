import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/widgets/custom_loader_button.dart';
import 'package:solyticket/widgets/custom_text_form_field.dart';


class ForgetPasswordWidget extends StatefulWidget {
  const ForgetPasswordWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgetPasswordWidget> createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends State<ForgetPasswordWidget> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: DefaultTheme().backgroundColor,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15.0))),
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      color: DefaultTheme().backgroundColor,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Reset Password',
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            labelText: 'Enter Email',
                            prefixIcon: Icons.email,
                            controller: emailController,
                            hintText: "Enter Email",
                            isLabel: true,
                          ),
                          const SizedBox(height: 20),
                          // CustomLoaderButton(
                          //     radius: 20,
                          //     btnText: 'Send Email Link',
                          //     controller: ,
                          //     onTap: () async {
                          //       if (emailController.text.isEmpty) {
                          //         QuickAlert.show(
                          //           context: context,
                          //           type: QuickAlertType.error,
                          //           confirmBtnColor: DefaultTheme().primaryColor,
                          //           text: 'Please Enter Email',
                          //         );
                          //       } else {
                          //         try {
                          //
                          //         } catch (e) {
                          //           QuickAlert.show(
                          //               context: context,
                          //               type: QuickAlertType.error,
                          //               confirmBtnColor: DefaultTheme().primaryColor,
                          //               text: 'Email is not found');
                          //         }
                          //         if (mounted) {
                          //           setState(() {
                          //             emailController.clear();
                          //           });
                          //         }
                          //       }
                          //     }),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: Text(
          'Forget Password?',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w500, color: DefaultTheme().primaryColor),
        ),
      ),
    );
  }
}
