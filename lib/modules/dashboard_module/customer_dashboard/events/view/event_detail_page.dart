import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/controller/event_detail_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/repo/event_detail_repo.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/view/widgets/create_reservation_widget.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/view/widgets/tour_preparations_widget.dart';
import 'package:solyticket/providers/api_client.dart';
import 'widgets/top_bar_widget.dart';
import 'widgets/destination_hero_widget.dart';

class EventDetailPage extends StatelessWidget {
  // final EventDetailController controller = Get.find<EventDetailController>();
final EventDetailController controller = Get.put(
    EventDetailController(
      EventDetailRepo(apiClient: ApiClient()),
      Get.arguments, // Pass arguments here
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details"),
      ),
      body: Obx(() {
        if (controller.isDetailLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final event = controller.eventDetail.value!;
        return SingleChildScrollView(
          child: Column(
            children: [
              TopBarWidget(
                title: event.data!.eventName,
                price: event.data!.priceLabel,
                eventId: event.data!.id,
              ),
               DestinationHero(
                eventId: event.data!.id,
                image: event.data!.image,
                locationImage: event.data!.location.blockImage ?? "", // Handle nullable
                locationName: event.data!.location.name ?? "Unknown Location",
                price: event.data!.priceLabel ?? "Free",
                normalizedEventName: event.data!.eventName ?? "Event",
                date: event.data!.date.toString(),
                time: event.data!.time ?? "N/A",
                shortCode: event.data!.shortCode ?? "N/A",
                highlightsStrings: [event.data!.highlight] ?? [],
                otherDetailsStrings: [event.data!.desc ]?? [],
                // persons: [event.data!.numberOfPerson] ?? [],
                // categoryPrices: event.data!.ca ?? [],
                // tickets: event.data!.tickets,
              ),
              CreateTourReservation(
          persons: [
            LabelValueEntity(label: "1 Person", value: "1"),
            LabelValueEntity(label: "2 Persons", value: "2"),
            LabelValueEntity(label: "3 Persons", value: "3"),
          ],
          categoryPrices: [
            LabelValueEntity(label: "Category A", value: "A"),
            LabelValueEntity(label: "Category B", value: "B"),
            LabelValueEntity(label: "Category C", value: "C"),
          ],
          // tickets: TicketsInCreate(
          //   availableTickets: [],
          //   userHeldTickets: [],
          //   userPurchasedTickets: [],
          // ),
        ),

              TourPreparations(
                // locationInfo: LocationInfo(
                  mapUrl: event.data!.location.map,
                  address: event.data!.location.address,
                  transportation: event.data!.location.transportation
                // ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
