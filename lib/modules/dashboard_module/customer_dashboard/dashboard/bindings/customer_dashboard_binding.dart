import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/dashboard/controller/customer_dashboard_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/profile/controller/profile_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/profile/repo/profile_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class CustomerDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomerDashboardController());

    // Provide the repo dependency for ProfileController
    Get.lazyPut<ProfileController>(
      () => ProfileController(repo: ProfileRepo(apiClient: ApiClient())),
    );
  }
}
