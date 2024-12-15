import 'package:flutter/material.dart';
import 'package:solyticket/model/event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(event.image),
        title: Text(event.eventName),
        subtitle: Text("${event.date} | ${event.time}"),
      ),
    );
  }
}
