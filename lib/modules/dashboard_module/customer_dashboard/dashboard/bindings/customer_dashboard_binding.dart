import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/dashboard/controller/customer_dashboard_controller.dart';


class CustomerDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomerDashboardController());

  }
}
