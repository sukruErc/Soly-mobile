import 'package:get/get.dart';
import 'package:solyticket/utills/global.dart';
class SplashController extends GetxController {
  @override
  void onInit() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);
    // TODO: implement onInit
    super.onInit();
    GlobalClass().checkLoginStatus();
    GlobalClass().getUserId();
    GlobalClass().getRoleType();
    GlobalClass().getName();
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed("customer-dashboard");
    });
  }
}
