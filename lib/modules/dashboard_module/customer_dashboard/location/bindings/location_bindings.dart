import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/location/controller/location_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/location/repo/location_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class LocationBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    final LocationController controller = Get.put(LocationController(locationRepo: LocationRepo(apiClient: ApiClient())));
  }
}