import 'package:flutter/material.dart';

class TourPreparations extends StatelessWidget {
  final String mapUrl; // Google Maps Embed URL
  final String address;
  final String transportation;

  const TourPreparations({
    required this.mapUrl,
    required this.address,
    required this.transportation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: const Color.fromRGBO(78, 67, 241, 0.05), // Light background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Sizin İçin Her Detay Hazır",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Lokasyon Bilgileri",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Google Maps Embed
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: SizedBox(
                    height: 200,
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: HtmlElementView(
                          viewType: 'iframe-map',
                          onPlatformViewCreated: (int viewId) {
                            // Handle iframe map view
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Timeline Indicator
                      Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 3,
                            height: 100,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Location Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Text(
                                "Varış",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Adres: $address",
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Metro: $transportation",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
