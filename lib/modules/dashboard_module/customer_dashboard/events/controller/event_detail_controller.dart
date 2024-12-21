import 'dart:convert';

import 'package:get/get.dart';
import 'package:solyticket/model/event_detail_json.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/repo/event_detail_repo.dart';

class EventDetailController extends GetxController {
  final EventDetailRepo eventDetailRepo;
  final String eventId;

  var eventDetail = EventDetailJson(data: null).obs;
  var similarEvents = <EventDetailJson>[].obs;
  var tickets = Rxn<dynamic>();
  var isDetailLoading = false.obs;

  EventDetailController(this.eventDetailRepo, this.eventId);

  @override
  void onInit() {
    super.onInit();
    fetchEventDetail();
    fetchSimilarEvents();
    fetchTickets();
  }

  void fetchEventDetail() async {
    try {
      isDetailLoading(true);
      final response = await eventDetailRepo.fetchEventDetail(eventId);
      if (response != null && response.statusCode == 200) {
        print(response.data);
        var detail = jsonDecode(response.data);
        print(detail);
        if (detail["success"] == true) {
          eventDetail.value = EventDetailJson.fromJson(detail);
        }
      }
    } catch (e) {
      print("Error fetching event details: $e");
    } finally {
      isDetailLoading(false);
    }
  }

  void fetchSimilarEvents() async {
    try {
      final response = await eventDetailRepo.fetchSimilarEvents(eventId);
      if (response != null && response.statusCode == 200) {
        var similar = jsonDecode(response.data);
        if (similar["success"] == true) {
          similarEvents.assignAll(
              (similar["data"] as List).map((e) => EventDetailJson.fromJson(e)));
        }
      }
    } catch (e) {
      print("Error fetching similar events: $e");
    }
  }

  void fetchTickets() async {
    try {
      final response = await eventDetailRepo.fetchTickets(eventId);
      if (response != null && response.statusCode == 200) {
        var ticketData = jsonDecode(response.data);
        if (ticketData["success"] == true) {
          tickets.value = ticketData["data"];
        }
      }
    } catch (e) {
      print("Error fetching tickets: $e");
    }
  }
}
