import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/collection/repo/collection_repo.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/collection/view/widget/collection_card.dart';
import 'package:solyticket/providers/api_client.dart';
import '../controller/collection_controller.dart';

class CollectionPage extends StatelessWidget {
  final CollectionController controller = Get.put(
    CollectionController(
      repo: CollectionRepo(apiClient: ApiClient()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Soly Koleksiyon"),
      ),
      body: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.collections.isEmpty) {
              return const Center(child: Text("Şuanda Koleksiyon Bulunmamakta."));
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: controller.collections.length,
              itemBuilder: (context, index) {
                final collection = controller.collections[index];
                return CollectionCard(
                  collection: collection,
                  onOpenModal: () => controller.openModal(collection),
                  onRedeemCoupon: () => controller.onRedeemCoupon(collection),
                );
              },
            );
          }),

          // Modal
          Obx(() {
            final selectedCollection = controller.selectedCollection.value;
            if (selectedCollection == null) return const SizedBox.shrink();

            return GestureDetector(
              onTap: controller.closeModal,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Modal Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedCollection.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: controller.closeModal,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Gerekli Etkinlikler Section
                          buildEventSection(
                            title: "Gerekli Etkinlikler",
                            events: selectedCollection.events,
                            applyBlur: true, // Apply blur only to this section
                          ),
                          const SizedBox(height: 16),

                          // Kuponun Geçerli Olacağı Etkinlikler Section
                          buildEventSection(
                            title: "Kuponun Geçerli Olacağı Etkinlikler",
                            events: selectedCollection.applicableEvents,
                            applyBlur: false, // No blur for this section
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Reusable method for event sections
  Widget buildEventSection({
    required String title,
    required List events,
    required bool applyBlur,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return buildEventCard(event, applyBlur);
          },
        ),
      ],
    );
  }

  // Reusable method for event cards with conditional blur
  Widget buildEventCard(dynamic event, bool applyBlur) {
    final isBlurred = applyBlur && !event.attended; 

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image with Conditional Blur
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              children: [
                // Background Image
                Image.network(
                  "https://ipfs.io/ipfs/${event.image}",
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 50),
                    );
                  },
                ),

                // Blur Overlay for Inactive Events in "Gerekli Etkinlikler"
                if (isBlurred)
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                      child: Container(
                        color: Colors.white.withOpacity(0.3),
                        alignment: Alignment.center,
                        child: const Text(
                          "Etkinlik Katılınmadı",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Event Details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Title
                Text(
                  event.eventName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // Event Date and Location
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('dd-MM-yyyy').format(DateTime.parse(event.date)),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        event.location.name,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
