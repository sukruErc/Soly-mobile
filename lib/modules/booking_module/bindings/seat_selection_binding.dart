import 'package:get/get.dart';
import 'package:solyticket/modules/booking_module/controller/seat_selection_controller.dart';
import 'package:solyticket/modules/booking_module/repo/booking_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class SeatSelectionBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SeatSelectionController(repo: BookingRepo(apiClient: ApiClient())));
  }
}
