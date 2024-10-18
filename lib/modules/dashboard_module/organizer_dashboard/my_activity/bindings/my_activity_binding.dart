import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/my_activity/controller/my_activity_controller.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/my_activity/repo/my_activity_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class MyActivityBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(MyActivityController(MyActivityRepo(apiClient: ApiClient())));
  }
}
