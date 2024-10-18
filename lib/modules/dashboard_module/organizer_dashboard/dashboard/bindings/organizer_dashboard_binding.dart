import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/dashboard/controller/organizer_dashboard_controller.dart';

class OrganizerDashboardBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(OrganizerDashboardController());
  }
}
