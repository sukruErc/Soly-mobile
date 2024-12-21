import 'package:flutter/material.dart';

class HighlightWidget extends StatelessWidget {
  final List<String> highlights;
  final List<String> details;

  const HighlightWidget({
    Key? key,
    required this.highlights,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (highlights.isNotEmpty)
          Column(
            children: [
              Text("Highlights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...highlights.map((item) => Text(item)).toList(),
            ],
          ),
        if (details.isNotEmpty)
          Column(
            children: [
              Text("Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...details.map((item) => Text(item)).toList(),
            ],
          ),
      ],
    );
  }
}
