// To parse this JSON data, do
//
//     final locationJson = locationJsonFromJson(jsonString);

import 'dart:convert';

LocationJson locationJsonFromJson(String str) => LocationJson.fromJson(json.decode(str));

String locationJsonToJson(LocationJson data) => json.encode(data.toJson());

class LocationJson {
  DateTime? date;
  bool? success;
  String? message;
  List<Location> data;

  LocationJson({
    this.date,
    this.success,
    this.message,
    required this.data,
  });

  factory LocationJson.fromJson(Map<String, dynamic> json) => LocationJson(
    date: DateTime.parse(json["date"]),
    success: json["success"],
    message: json["message"],
    data: List<Location>.from(json["data"].map((x) => Location.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date.toString(),
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Location {
  String id;
  String locationName;
  String locationAddress;

  Location({
    required this.id,
    required this.locationName,
    required this.locationAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    locationName: json["locationName"],
    locationAddress: json["locationAddress"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "locationName": locationName,
    "locationAddress": locationAddress,
  };
}
