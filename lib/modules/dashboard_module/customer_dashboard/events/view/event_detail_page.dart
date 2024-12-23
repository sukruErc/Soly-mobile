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
        title: Obx(() {
          if (controller.isDetailLoading.value || controller.eventDetail.value == null) {
            return const Text("Yükleniyor...");
          }
          return Text(controller.eventDetail.value!.data!.eventName);
        }),
      ),
      body: Obx(() {
        if (controller.isDetailLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final event = controller.eventDetail.value!;

        // Map event data to the required formats
        final persons = List<LabelValueEntity>.generate(
          int.parse(event.data!.numberOfPerson),
          (index) => LabelValueEntity(
            label: "${index + 1} Kişi",
            value: "${index + 1}",
          ),
        );

        final categoryPrices = event.data!.ticketCategory.map((category) {
          return LabelValueEntity(
            label: category.name,
            value: category.price.toString(),
          );
        }).toList();

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
                locationImage: event.data!.location.blockImage ?? "",
                locationName: event.data!.location.name,
                price: event.data!.priceLabel,
                normalizedEventName: event.data!.eventName,
                date: event.data!.date.toString(),
                time: event.data!.time,
                shortCode: event.data!.shortCode,
                highlightsStrings: [event.data!.highlight],
                otherDetailsStrings: [event.data!.desc],
              ),
Obx(() => CreateTourReservation(
  persons: persons,
  categoryPrices: categoryPrices,
  tickets: controller.tickets.value,
)),


              TourPreparations(
                mapUrl: event.data!.location.map,
                address: event.data!.location.address,
                transportation: event.data!.location.transportation,
              ),
            ],
          ),
        );
      }),
    );
  }
}
