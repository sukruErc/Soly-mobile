import 'dart:convert';

import 'package:get/get.dart';
import 'package:solyticket/model/event_detail_json.dart';
import 'package:solyticket/model/ticket_detail_json.dart';

import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/repo/event_detail_repo.dart';
import 'package:solyticket/utills/global.dart';

class EventDetailController extends GetxController {
  final EventDetailRepo eventDetailRepo;
  final String eventId;

  var eventDetail = EventDetailJson(data: null).obs;
  var similarEvents = <EventDetailJson>[].obs;
  var tickets = Rxn<EventTicketsResponse>();
  var isDetailLoading = false.obs;

  EventDetailController(this.eventDetailRepo, this.eventId);

  @override
  Future<void> onInit() async {
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
        var detail = jsonDecode(response.data);
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
            (similar["data"] as List)
                .map((e) => EventDetailJson.fromJson(e))
                .toList(),
          );
        }
      }
    } catch (e) {
      print("Error fetching similar events: $e");
    }
  }

  void fetchTickets() async {
  try {
    var response = await eventDetailRepo.fetchTickets(eventId);
    if (response != null && response.statusCode == 200) {
      var ticketData = jsonDecode(response.data);
      if (ticketData["success"] == true) {
        tickets.value = EventTicketsResponse.fromJson(ticketData);

        // Debugging to confirm ticket values
        print("Available Tickets: ${tickets.value?.data.availableTickets}");
        print("Held Tickets: ${tickets.value?.data.userHeldTickets}");
        print("Purchased Tickets: ${tickets.value?.data.userPurchasedTickets}");
      }
    }
  } catch (e) {
    print("Error fetching tickets: $e");
  }
}

}
