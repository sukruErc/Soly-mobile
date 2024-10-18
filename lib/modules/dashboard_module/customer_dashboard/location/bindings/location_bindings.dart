import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/location/controller/location_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/location/repo/location_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class LocationBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(LocationController(LocationRepo(apiClient: ApiClient())));
  }
}