import 'package:get/get.dart';
import 'package:solyticket/common_controllers/InternetConnectivityController.dart';

class InternetConnectivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InternetConnectivityController>(
        () => InternetConnectivityController());
  }
}
