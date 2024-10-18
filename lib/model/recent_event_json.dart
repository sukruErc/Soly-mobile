// To parse this JSON data, do
//
//     final recentEventJson = recentEventJsonFromJson(jsonString);

import 'dart:convert';

RecentEventJson recentEventJsonFromJson(String str) =>
    RecentEventJson.fromJson(json.decode(str));

String recentEventJsonToJson(RecentEventJson data) =>
    json.encode(data.toJson());

class RecentEventJson {
  DateTime? date;
  bool? success;
  String? message;
  List<Event> data;

  RecentEventJson({
    this.date,
    this.success,
    this.message,
    required this.data,
  });

  factory RecentEventJson.fromJson(Map<String, dynamic> json) =>
      RecentEventJson(
        date: DateTime.parse(json["date"]),
        success: json["success"],
        message: json["message"],
        data: List<Event>.from(json["data"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date.toString(),
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Event {
  String id;
  DateTime date;
  String desc;
  dynamic highlight;
  String numberOfPerson;
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
  EventCategory eventCategoryType;
  CreatorId creatorId;

  Event({
    required this.id,
    required this.date,
    required this.desc,
    required this.highlight,
    required this.numberOfPerson,
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
    required this.creatorId,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        desc: json["desc"],
        highlight: json["highlight"],
        numberOfPerson: json["numberOfPerson"],
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
        eventCategoryType: EventCategory.fromJson(json["eventCategoryType"]),
        creatorId: CreatorId.fromJson(json["creatorId"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "desc": desc,
        "highlight": highlight,
        "numberOfPerson": numberOfPerson,
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
        "creatorId": creatorId.toJson(),
      };
}

class CreatorId {
  String id;
  String name;
  String email;
  String type;
  String subscribeType;
  bool status;
  String bcAddress;
  String password;
  String? image;
  String? phone;
  DateTime birthday;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic familyId;

  CreatorId({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.subscribeType,
    required this.status,
    required this.bcAddress,
    required this.password,
    required this.image,
    required this.phone,
    required this.birthday,
    required this.createdAt,
    required this.updatedAt,
    required this.familyId,
  });

  factory CreatorId.fromJson(Map<String, dynamic> json) => CreatorId(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        type: json["type"],
        subscribeType: json["subscribeType"],
        status: json["status"],
        bcAddress: json["bcAddress"],
        password: json["password"],
        image: json["image"],
        phone: json["phone"],
        birthday: DateTime.parse(json["birthday"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        familyId: json["familyId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "type": type,
        "subscribeType": subscribeType,
        "status": status,
        "bcAddress": bcAddress,
        "password": password,
        "image": image,
        "phone": phone,
        "birthday": birthday.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "familyId": familyId,
      };
}

class EventCategory {
  String id;
  String name;
  String? image;
  String? categoryId;

  EventCategory({
    required this.id,
    required this.name,
    required this.image,
    this.categoryId,
  });

  factory EventCategory.fromJson(Map<String, dynamic> json) => EventCategory(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        categoryId: json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "categoryId": categoryId,
      };
}

class Location {
  String id;
  String name;
  String address;
  String image;
  String blockImage;
  String map;
  String transportation;
  String cityId;

  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.blockImage,
    required this.map,
    required this.transportation,
    required this.cityId,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
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
