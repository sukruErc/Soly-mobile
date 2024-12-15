class EventModel {
  final String id;
  final String eventName;
  final String image;
  final String date;
  final String time;
  final bool attended;
  final LocationModel location;

  EventModel({
    required this.id,
    required this.eventName,
    required this.image,
    required this.date,
    required this.time,
    required this.attended,
    required this.location,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? '',
      eventName: json['eventName'] ?? '',
      image: json['image'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      attended: json['attended'] ?? false,
      location: LocationModel.fromJson(json['location'] ?? {}),
    );
  }
}

class LocationModel {
  final String id;
  final String name;
  final String address;
  final String image;
  final String map;

  LocationModel({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.map,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      image: json['image'] ?? '',
      map: json['map'] ?? '',
    );
  }
}
