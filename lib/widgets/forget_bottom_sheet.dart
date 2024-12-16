import 'package:flutter/material.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/widgets/custom_text_form_field.dart';

class ForgetPasswordWidget extends StatefulWidget {
  const ForgetPasswordWidget({super.key});

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
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            ),
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    color: DefaultTheme().backgroundColor,
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title
                        Text(
                          'Şifre Sıfırla',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        // Email Input Field
                        CustomTextFormField(
                          labelText: 'E-posta Adresi',
                          prefixIcon: Icons.email,
                          controller: emailController,
                          hintText: "E-posta adresinizi girin",
                          isLabel: true,
                        ),
                        const SizedBox(height: 20),
                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DefaultTheme().primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              if (emailController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        const Text('Lütfen e-posta adresinizi girin.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                // TODO: Add password reset API call here
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'Şifre sıfırlama bağlantısı gönderildi.'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                emailController.clear();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              "E-posta Bağlantısı Gönder",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Text(
          'Şifremi Unuttum?',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500, color: DefaultTheme().primaryColor),
        ),
      ),
    );
  }
}
