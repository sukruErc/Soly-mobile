import 'package:flutter/material.dart';

class TopBarWidget extends StatelessWidget {
  final String title;
  final String price;
  final String eventId;

  const TopBarWidget({
    Key? key,
    required this.title,
    required this.price,
    required this.eventId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle event purchase
            },
            child: const Text("Buy Now"),
          ),
        ],
      ),
    );
  }
}
