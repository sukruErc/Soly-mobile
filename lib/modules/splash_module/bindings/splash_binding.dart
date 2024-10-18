import 'package:get/get.dart';
import 'package:solyticket/modules/splash_module/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SplashController());
  }
}
