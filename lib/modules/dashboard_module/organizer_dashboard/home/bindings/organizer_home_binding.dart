import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/home/controller/organizer_home_controller.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/home/repo/organizer_home_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class OrganizerHomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(OrganizerHomeController(OrganizerHomeRepo(apiClient: ApiClient())));
  }
}
