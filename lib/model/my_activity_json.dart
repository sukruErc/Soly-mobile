// To parse this JSON data, do
//
//     final myActivityJson = myActivityJsonFromJson(jsonString);

import 'dart:convert';

MyActivityJson myActivityJsonFromJson(String str) => MyActivityJson.fromJson(json.decode(str));

// String myActivityJsonToJson(MyActivityJson data) => json.encode(data.toJson());

class MyActivityJson {
  bool success;
  DateTime? date;
  List<MyActivity> data;

  MyActivityJson({
    required this.success,
    required this.date,
    required this.data,
  });

  factory MyActivityJson.fromJson(Map<String, dynamic> json) => MyActivityJson(
    success: json["success"],
    date: DateTime.parse(json["date"]),
    data: List<MyActivity>.from(json["data"].map((x) => MyActivity.fromJson(x))),
  );

  // Map<String, dynamic> toJson() => {
  //   "success": success,
  //   "date": date.toIso8601String(),
  //   "data": List<dynamic>.from(data.map((x) => x.toJson())),
  // };
}

class MyActivity {
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
  EventCategory eventCategory;
  EventCategoryType eventCategoryType;
  Location location;
  List<Ticket> tickets;
  int totalTickets;
  int soldTickets;

  MyActivity({
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
    required this.eventCategory,
    required this.eventCategoryType,
    required this.location,
    required this.tickets,
    required this.totalTickets,
    required this.soldTickets,
  });

  factory MyActivity.fromJson(Map<String, dynamic> json) => MyActivity(
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
    eventCategory: EventCategory.fromJson(json["eventCategory"]),
    eventCategoryType: EventCategoryType.fromJson(json["eventCategoryType"]),
    location: Location.fromJson(json["location"]),
    tickets: List<Ticket>.from(json["Tickets"].map((x) => Ticket.fromJson(x))),
    totalTickets: json["totalTickets"],
    soldTickets: json["soldTickets"],
  );
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
    image: json["image"]!,
  );
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
    name: json["name"]!,
    address: json["address"]!,
    image: json["image"]!,
    cityId: json["cityId"],
  );
}
class Ticket {
  bool isUsed;
  bool sold;

  Ticket({
    required this.isUsed,
    required this.sold,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    isUsed: json["isUsed"],
    sold: json["sold"],
  );

  Map<String, dynamic> toJson() => {
    "isUsed": isUsed,
    "sold": sold,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}