// To parse this JSON data, do
//
//     final locationInCitiesJson = locationInCitiesJsonFromJson(jsonString);

import 'dart:convert';

LocationInCitiesJson locationInCitiesJsonFromJson(String str) => LocationInCitiesJson.fromJson(json.decode(str));

class LocationInCitiesJson {
  List<Datum> data;
  DateTime? date;
  bool? success;
  String? message;

  LocationInCitiesJson({
    required this.data,
    this.date,
    this.success,
    this.message,
  });

  factory LocationInCitiesJson.fromJson(Map<String, dynamic> json) => LocationInCitiesJson(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    date: DateTime.parse(json["date"]),
    success: json["success"],
    message: json["message"],
  );
}

class Datum {
  String id;
  String name;
  String address;
  String image;
  String blockImage;
  String map;
  String transportation;
  String cityId;

  Datum({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.blockImage,
    required this.map,
    required this.transportation,
    required this.cityId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    image: json["image"],
    blockImage: json["blockImage"],
    map: json["map"],
    transportation: json["transportation"],
    cityId: json["cityId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "image": image,
    "blockImage": blockImage,
    "map": map,
    "transportation": transportation,
    "cityId": cityId,
  };
}