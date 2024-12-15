import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/profile/controller/profile_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/profile/repo/profile_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController(
          repo: ProfileRepo(apiClient: ApiClient()),
        ));
  }
}
