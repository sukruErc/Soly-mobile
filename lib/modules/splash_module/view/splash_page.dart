import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/splash_module/controller/splash_controller.dart';
import 'package:solyticket/utills/images.dart';

class SplashPage extends GetView<SplashController> {
   const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: DefaultTheme().backgroundColor,
      body: Center(
        child: Image.asset(
          AppImages.logo,
          height: 120,
          width: 120,
        ),
      ),
    );
  }
}
