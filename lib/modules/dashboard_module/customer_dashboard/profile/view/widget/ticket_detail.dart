import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketDetailPage extends StatelessWidget {
  final Map<String, dynamic> ticket;

  TicketDetailPage({required this.ticket});

  @override
  Widget build(BuildContext context) {
    // Extract necessary data
    final imageUrl = ticket['media']?[0]?['gateway'] ?? '';
    final title = ticket['title'] ?? "Bilinmeyen Etkinlik";
    final description = ticket['description'] ?? "Açıklama bulunamadı";
    final attributes = ticket['metadata']?['attributes'] ?? [];
    final date = attributes.firstWhere(
          (attr) => attr['trait_type'] == 'Date',
          orElse: () => {'value': 'Bilinmeyen Tarih'},
        )['value'];
    final location = attributes.firstWhere(
          (attr) => attr['trait_type'] == 'Location',
          orElse: () => {'value': 'Bilinmeyen Konum'},
        )['value'];
    final artist = attributes.firstWhere(
          (attr) => attr['trait_type'] == 'Artist',
          orElse: () => {'value': 'Bilinmeyen Sanatçı'},
        )['value'];
    final block = attributes.firstWhere(
          (attr) => attr['trait_type'] == 'Block',
          orElse: () => {'value': 'Bilinmeyen Blok'},
        )['value'];
    final seat = attributes.firstWhere(
          (attr) => attr['trait_type'] == 'Seat',
          orElse: () => {'value': 'Bilinmeyen Koltuk'},
        )['value'];

    // Collection/Contract Info
    final contractAddress = ticket['contract']?['address'] ?? "Sözleşme adresi bulunamadı";
    final collectionName = ticket['contractMetadata']?['name'] ?? "Koleksiyon bilgisi yok";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Image with border radius and padding
              if (imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),

              // Event Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Information Rows
              _buildInfoRow(Icons.person, "Sanatçı", artist),
              _buildInfoRow(Icons.location_on, "Konum", location),
              _buildInfoRow(Icons.calendar_today, "Tarih",
                  DateTime.tryParse(date) != null
                      ? DateFormat('dd-MM-yyyy').format(DateTime.parse(date))
                      : date),
              _buildInfoRow(Icons.category, "Blok", block),
              _buildInfoRow(Icons.event_seat, "Koltuk", seat),

              const SizedBox(height: 16),

              // Collection/Contract Info in a styled card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Koleksiyon Bilgileri",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.collections, "Koleksiyon Adı", collectionName),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.code, size: 20, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            contractAddress,
                            style: const TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Description with a light purple background card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Açıklama",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to display info row
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
