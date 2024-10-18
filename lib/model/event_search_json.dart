// To parse this JSON data, do
//
//     final eventSearchJson = eventSearchJsonFromJson(jsonString);

import 'dart:convert';

EventSearchJson eventSearchJsonFromJson(String str) => EventSearchJson.fromJson(json.decode(str));

String eventSearchJsonToJson(EventSearchJson data) => json.encode(data.toJson());

class EventSearchJson {
  List<Datum> data;
  DateTime? date;
  bool? success;
  String? message;

  EventSearchJson({
    required this.data,
    this.date,
    this.success,
    this.message,
  });

  factory EventSearchJson.fromJson(Map<String, dynamic> json) => EventSearchJson(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    date: DateTime.parse(json["date"]),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "date": date,
    "success": success,
    "message": message,
  };
}

class Datum {
  String id;
  String image;
  String name;
  String type;

  Datum({
    required this.id,
    required this.image,
    required this.name,
    required this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "type": type,
  };
}
