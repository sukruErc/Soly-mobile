import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/controller/event_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/repo/event_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(EventController(EventRepo(apiClient: ApiClient())));
  }
}
