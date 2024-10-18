// To parse this JSON data, do
//
//     final eventDetailJson = eventDetailJsonFromJson(jsonString);

import 'dart:convert';

EventDetailJson eventDetailJsonFromJson(String str) => EventDetailJson.fromJson(json.decode(str));

String eventDetailJsonToJson(EventDetailJson data) => json.encode(data.toJson());

class EventDetailJson {
  bool success;
  DateTime date;
  EventDetail data;

  EventDetailJson({
    required this.success,
    required this.date,
    required this.data,
  });

  factory EventDetailJson.fromJson(Map<String, dynamic> json) => EventDetailJson(
    success: json["success"],
    date: DateTime.parse(json["date"]),
    data: EventDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "date": date.toIso8601String(),
    "data": data.toJson(),
  };
}

class EventDetail {
  String id;
  DateTime date;
  String desc;
  String eventName;
  String image;
  String time;
  String userId;
  String contractAddress;
  String categoryId;
  String categoryTypeId;
  String locationId;
  String priceLabel;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic organizerId;
  Location location;
  EventCategory eventCategory;
  EventCategoryType eventCategoryType;
  List<dynamic> collections;
  CreatorId creatorId;

  EventDetail({
    required this.id,
    required this.date,
    required this.desc,
    required this.eventName,
    required this.image,
    required this.time,
    required this.userId,
    required this.contractAddress,
    required this.categoryId,
    required this.categoryTypeId,
    required this.locationId,
    required this.priceLabel,
    required this.createdAt,
    required this.updatedAt,
    required this.organizerId,
    required this.location,
    required this.eventCategory,
    required this.eventCategoryType,
    required this.collections,
    required this.creatorId,
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) => EventDetail(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    desc: json["desc"],
    eventName: json["eventName"],
    image: json["image"],
    time: json["time"],
    userId: json["userId"],
    contractAddress: json["contractAddress"],
    categoryId: json["categoryId"],
    categoryTypeId: json["categoryTypeId"],
    locationId: json["locationId"],
    priceLabel: json["priceLabel"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    organizerId: json["organizerId"],
    location: Location.fromJson(json["location"]),
    eventCategory: EventCategory.fromJson(json["eventCategory"]),
    eventCategoryType: EventCategoryType.fromJson(json["eventCategoryType"]),
    collections: List<dynamic>.from(json["collections"].map((x) => x)),
    creatorId: CreatorId.fromJson(json["creatorId"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date.toIso8601String(),
    "desc": desc,
    "eventName": eventName,
    "image": image,
    "time": time,
    "userId": userId,
    "contractAddress": contractAddress,
    "categoryId": categoryId,
    "categoryTypeId": categoryTypeId,
    "locationId": locationId,
    "priceLabel": priceLabel,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "organizerId": organizerId,
    "location": location.toJson(),
    "eventCategory": eventCategory.toJson(),
    "eventCategoryType": eventCategoryType.toJson(),
    "collections": List<dynamic>.from(collections.map((x) => x)),
    "creatorId": creatorId.toJson(),
  };
}

class CreatorId {
  String id;
  String name;
  DateTime createdAt;

  CreatorId({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory CreatorId.fromJson(Map<String, dynamic> json) => CreatorId(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "createdAt": createdAt.toIso8601String(),
  };
}

class EventCategory {
  String id;
  String name;
  String image;

  EventCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  factory EventCategory.fromJson(Map<String, dynamic> json) => EventCategory(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}

class EventCategoryType {
  String id;
  String name;
  String categoryId;

  EventCategoryType({
    required this.id,
    required this.name,
    required this.categoryId,
  });

  factory EventCategoryType.fromJson(Map<String, dynamic> json) => EventCategoryType(
    id: json["id"],
    name: json["name"],
    categoryId: json["categoryId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "categoryId": categoryId,
  };
}

class Location {
  String id;
  String name;
  String address;
  String image;
  String cityId;

  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.cityId,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    image: json["image"],
    cityId: json["cityId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "image": image,
    "cityId": cityId,
  };
}
