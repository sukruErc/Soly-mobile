import 'package:get/get.dart';
import 'package:solyticket/modules/booking_module/controller/seat_category_controller.dart';
import 'package:solyticket/modules/booking_module/repo/booking_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class SeatCategoryBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SeatCategoryController(repo: BookingRepo(apiClient: ApiClient())));
  }
}
