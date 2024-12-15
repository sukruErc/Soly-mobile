import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/profile_controller.dart';

class TicketsPage extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: controller.tickets.length,
              itemBuilder: (context, index) {
                final ticket = controller.tickets[index];

                // Extract ticket information safely
                final imageUrl = ticket['media']?[0]?['gateway'] ?? '';
                final title = ticket['title'] ?? "Bilinmeyen Etkinlik";
                final location = ticket['metadata']?['attributes']?.firstWhere(
                      (attr) => attr['trait_type'] == 'Location',
                      orElse: () => null,
                    )?['value'] ??
                    "Bilinmeyen Konum";
                final seat = ticket['metadata']?['attributes']?.firstWhere(
                      (attr) => attr['trait_type'] == 'Seat',
                      orElse: () => null,
                    )?['value'] ??
                    "Bilinmeyen Koltuk";
                final date = ticket['metadata']?['attributes']?.firstWhere(
                      (attr) => attr['trait_type'] == 'Date',
                      orElse: () => null,
                    )?['value'] ??
                    "Bilinmeyen Tarih";

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Image
                      if (imageUrl.isNotEmpty)
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(
                            imageUrl,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Date
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  date,
                                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Location and Seat in the same row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      location,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.event_seat, size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      seat,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
