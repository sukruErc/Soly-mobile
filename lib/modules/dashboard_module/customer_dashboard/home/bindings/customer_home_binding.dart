import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/home/controller/customer_home_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/home/repo/customer_home_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class CustomerHomeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CustomerHomeController(CustomerHomeRepo(apiClient: ApiClient())));
  }
}