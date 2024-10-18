import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/repo/event_detail_repo.dart';

class EventDetailController extends GetxController {
  EventDetailRepo eventDetailRepo;
  String eventId;
  var isDetailLoading = false.obs;

  EventDetailController(this.eventDetailRepo, this.eventId);

  @override
  void onInit() {
    getEventDetail(eventId);
    super.onInit();
  }

  getEventDetail(eventId) {
    try {
      isDetailLoading(true);
      Map<String, dynamic> data = {"eventId": eventId};
      eventDetailRepo.eventDetail(data).then((response) {});
    } catch (e) {
      isDetailLoading(false);
    }
  }
}
