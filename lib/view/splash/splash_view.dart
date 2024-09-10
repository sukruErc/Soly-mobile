import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/color_constant.dart';
import 'package:solyticket/view/customer/custom_dashboard_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
   
    Future.delayed(const Duration(seconds: 3), () {
      
      Get.to(() => const CustomerDashboardView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
