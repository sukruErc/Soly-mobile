// To parse this JSON data, do
//
//     final organizerHomeJson = organizerHomeJsonFromJson(jsonString);

import 'dart:convert';

OrganizerHomeJson organizerHomeJsonFromJson(String str) => OrganizerHomeJson.fromJson(json.decode(str));

String organizerHomeJsonToJson(OrganizerHomeJson data) => json.encode(data.toJson());

class OrganizerHomeJson {
  bool? success;
  DateTime? date;
  String? message;
  Organizer? data;

  OrganizerHomeJson({
    this.success,
    this.date,
    this.message,
    this.data,
  });

  factory OrganizerHomeJson.fromJson(Map<String, dynamic> json) => OrganizerHomeJson(
    success: json["success"],
    date: DateTime.parse(json["date"]),
    message: json["message"],
    data: Organizer.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "date": date!.toIso8601String(),
    "message": message,
    "data": data!.toJson(),
  };
}

class Organizer {
  Profile profile;
  int totalEvents;
  int totalEarnings;
  int activeAds;
  MostRecentEvent mostRecentEvent;

  Organizer({
    required this.profile,
    required this.totalEvents,
    required this.totalEarnings,
    required this.activeAds,
    required this.mostRecentEvent,
  });

  factory Organizer.fromJson(Map<String, dynamic> json) => Organizer(
    profile: Profile.fromJson(json["profile"]),
    totalEvents: json["totalEvents"],
    totalEarnings: json["totalEarnings"],
    activeAds: json["activeAds"],
    mostRecentEvent: MostRecentEvent.fromJson(json["mostRecentEvent"]),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile.toJson(),
    "totalEvents": totalEvents,
    "totalEarnings": totalEarnings,
    "activeAds": activeAds,
    "mostRecentEvent": mostRecentEvent.toJson(),
  };
}

class MostRecentEvent {
  String id;
  String eventName;
  DateTime date;

  MostRecentEvent({
    required this.id,
    required this.eventName,
    required this.date,
  });

  factory MostRecentEvent.fromJson(Map<String, dynamic> json) => MostRecentEvent(
    id: json["id"],
    eventName: json["eventName"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "eventName": eventName,
    "date": date.toIso8601String(),
  };
}

class Profile {
  String name;
  String email;
  String phone;
  String iban;
  String hesapAdi;

  Profile({
    required this.name,
    required this.email,
    required this.phone,
    required this.iban,
    required this.hesapAdi,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    iban: json["iban"],
    hesapAdi: json["hesapAdi"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "iban": iban,
    "hesapAdi": hesapAdi,
  };
}
