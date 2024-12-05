import 'dart:convert';

import 'package:get/get.dart';
import 'package:solyticket/model/event_detail_json.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/repo/event_detail_repo.dart';

class EventDetailController extends GetxController {
  var eventDetail = EventDetailJson(data: null).obs;
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
      eventDetailRepo.eventDetail(data).then((response) {
        var detail = jsonDecode(response!.data);
        if(detail["success"]==true){
          eventDetail.value = EventDetailJson.fromJson(detail);
        }else{
          isDetailLoading(false);
        }
      });
    } catch (e) {
      isDetailLoading(false);
    }
  }
}
