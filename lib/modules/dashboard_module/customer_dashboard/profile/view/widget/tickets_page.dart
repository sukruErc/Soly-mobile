import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/profile_controller.dart';

class TicketsPage extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : controller.tickets.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Hiç biletiniz bulunmamaktadır.",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(
                              "/events"); 
                        },
                        child: const Text("Etkinliklere Göz At"),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: controller.tickets.length,
                  itemBuilder: (context, index) {
                    final ticket = controller.tickets[index];

                    final imageUrl = ticket['media']?[0]?['gateway'] ?? '';
                    final title = ticket['title'] ?? "Bilinmeyen Etkinlik";
                    final location =
                        ticket['metadata']?['attributes']?.firstWhere(
                              (attr) => attr['trait_type'] == 'Location',
                              orElse: () => null,
                            )?['value'] ??
                            "Bilinmeyen Konum";
                    final seat = ticket['metadata']?['attributes']?.firstWhere(
                          (attr) => attr['trait_type'] == 'Seat',
                          orElse: () => null,
                        )?['value'] ??
                        "Bilinmeyen Koltuk";

                    final rawDate =
                        ticket['metadata']?['attributes']?.firstWhere(
                              (attr) => attr['trait_type'] == 'Date',
                              orElse: () => null,
                            )?['value'] ??
                            null;
                    final formattedDate = rawDate != null
                        ? DateFormat('dd-MM-yyyy')
                            .format(DateTime.parse(rawDate))
                        : "Bilinmeyen Tarih";

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed("/ticket-detail", arguments: ticket);
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (imageUrl.isNotEmpty)
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: Image.network(
                                  imageUrl,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    height: 150,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.broken_image,
                                        size: 50),
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(
                                        formattedDate,
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on,
                                              size: 14, color: Colors.grey),
                                          const SizedBox(width: 4),
                                          Text(
                                            location,
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.event_seat,
                                              size: 14, color: Colors.grey),
                                          const SizedBox(width: 4),
                                          Text(
                                            seat,
                                            style:
                                                const TextStyle(fontSize: 13),
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
                      ),
                    );
                  },
                ),
    );
  }
}
