import 'package:flutter/services.dart';
import 'package:get/get.dart';
class SplashController extends GetxController {
  @override
  void onInit() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      // Get.to(() => const OrganizerDashboardPage());
      // Get.to(() => const CustomerDashboardPage());
      Get.toNamed("customer-dashboard");
      // Get.toNamed("login");
      // Get.to(EventDetailPage());

      // Get.toNamed("login");
    });
  }
}
