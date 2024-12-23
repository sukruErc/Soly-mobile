import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/constants/themes.dart';

class DestinationHero extends StatelessWidget {
  final String eventId;
  final String image;
  final String locationImage;
  final String locationName;
  final String price;
  final String normalizedEventName;
  final String date;
  final String time;
  final String shortCode;
  final List<String> highlightsStrings;
  final List<String> otherDetailsStrings;

  const DestinationHero({
    required this.eventId,
    required this.image,
    required this.locationImage,
    required this.locationName,
    required this.price,
    required this.normalizedEventName,
    required this.date,
    required this.time,
    required this.shortCode,
    required this.highlightsStrings,
    required this.otherDetailsStrings,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Purple Background
        Container(
          height: 120,
          color: DefaultTheme().primaryColor, // Primary background color
        ),
        // Content Positioned
        Positioned(
          top: 60, // Adjust to make it halfway overlap
          left: 16,
          right: 16,
          child: PriceCard(
            price: price,
            date: date,
            time: time,
            locationName: locationName,
            eventId: eventId,
          ),
        ),
        // Main Content
        Padding(
          padding: const EdgeInsets.only(top: 270), // Space for PriceCard
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DestinationImage(image: image),
              const SizedBox(height: 16),
              DestinationDetails(
                highlightsStrings: highlightsStrings,
                otherDetailsStrings: otherDetailsStrings,
                image: locationImage,
                shortCode: shortCode,
                normalizedEventName: normalizedEventName,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DestinationImage extends StatelessWidget {
  final String image;

  const DestinationImage({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(
            AppConstants.imageBaseUrl + image,
          ),
          fit: BoxFit.cover,
        ),
      ),
      height: 200,
    );
  }
}

class PriceCard extends StatelessWidget {
  final String price;
  final String date;
  final String time;
  final String locationName;
  final String eventId;

  const PriceCard({
    required this.price,
    required this.date,
    required this.time,
    required this.locationName,
    required this.eventId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color: DefaultTheme().primaryColor),
                const SizedBox(width: 8),
                Text(DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(date),
                              ),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, color: DefaultTheme().primaryColor),
                const SizedBox(width: 8),
                Text(time,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                Icon(Icons.location_on, color: DefaultTheme().primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(locationName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Price: $price',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class DestinationDetails extends StatelessWidget {
  final List<String> highlightsStrings;
  final List<String> otherDetailsStrings;
  final String image; // This will be the location block image
  final String shortCode;
  final String normalizedEventName;

  const DestinationDetails({
    required this.highlightsStrings,
    required this.otherDetailsStrings,
    required this.image, // Location block image
    required this.shortCode,
    required this.normalizedEventName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        Container(
          margin: const EdgeInsets.symmetric(
              horizontal: 16.0), // Added margin for padding in X direction
          decoration: BoxDecoration(
            color: const Color.fromRGBO(78, 67, 241, 0.05),
            borderRadius: BorderRadius.circular(12), // Added border radius
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 16.0), // Padding inside the container
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Öne Çıkanlar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ...highlightsStrings.map((highlight) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• ", style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        highlight,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Details Section
        Container(
           margin: const EdgeInsets.symmetric(
              horizontal: 16.0), // Added margin for padding in X direction
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(12), // Added border radius
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 16.0), // Padding inside the container
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Detaylar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ...otherDetailsStrings.map((detail) {
                print(detail);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• ", style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        detail,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Location Block Image Section
        if (image.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(AppConstants.imageBaseUrl + image),
                fit: BoxFit.contain,
              ),
            ),
            height: 200,
          ),
      ],
    );
  }
}
