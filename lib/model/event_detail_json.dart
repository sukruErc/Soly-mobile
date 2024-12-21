import 'dart:convert';

EventDetailJson eventDetailJsonFromJson(String str) =>
    EventDetailJson.fromJson(json.decode(str));

String eventDetailJsonToJson(EventDetailJson data) => json.encode(data.toJson());

class EventDetailJson {
  bool? success;
  DateTime? date;
  EventDetail? data;

  EventDetailJson({
    this.success,
    this.date,
    this.data,
  });

  factory EventDetailJson.fromJson(Map<String, dynamic> json) => EventDetailJson(
        success: json["success"],
        date: DateTime.parse(json["date"]),
        data: EventDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "date": date?.toIso8601String(),
        "data": data?.toJson(),
      };
}

class EventDetail {
  String id;
  DateTime date;
  String desc;
  String? seoDesc;
  String? seoKeywords;
  String highlight;
  String normalizedEventName;
  String numberOfPerson;
  String shortCode;
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
  List<Collection> collections;
  List<TicketCategory> ticketCategory;
  CreatorId creatorId;

  EventDetail({
    required this.id,
    required this.date,
    required this.desc,
    this.seoDesc,
    this.seoKeywords,
    required this.highlight,
    required this.normalizedEventName,
    required this.numberOfPerson,
    required this.shortCode,
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
    this.organizerId,
    required this.location,
    required this.eventCategory,
    required this.eventCategoryType,
    required this.collections,
    required this.ticketCategory,
    required this.creatorId,
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) => EventDetail(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        desc: json["desc"],
        seoDesc: json["seoDesc"],
        seoKeywords: json["seoKeywords"],
        highlight: json["highlight"],
        normalizedEventName: json["normalizedEventName"],
        numberOfPerson: json["numberOfPerson"],
        shortCode: json["shortCode"],
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
        collections: List<Collection>.from(
            json["collections"].map((x) => Collection.fromJson(x))),
        ticketCategory: List<TicketCategory>.from(
            json["TicketCategory"].map((x) => TicketCategory.fromJson(x))),
        creatorId: CreatorId.fromJson(json["creatorId"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "desc": desc,
        "seoDesc": seoDesc,
        "seoKeywords": seoKeywords,
        "highlight": highlight,
        "normalizedEventName": normalizedEventName,
        "numberOfPerson": numberOfPerson,
        "shortCode": shortCode,
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
        "collections": List<dynamic>.from(collections.map((x) => x.toJson())),
        "TicketCategory":
            List<dynamic>.from(ticketCategory.map((x) => x.toJson())),
        "creatorId": creatorId.toJson(),
      };
}

class Collection {
  String id;
  String name;
  dynamic organizerId;
  String image;
  int discountPercentage;
  DateTime expireAt;
  DateTime createdAt;
  DateTime updatedAt;

  Collection({
    required this.id,
    required this.name,
    this.organizerId,
    required this.image,
    required this.discountPercentage,
    required this.expireAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json["id"],
        name: json["name"],
        organizerId: json["organizerId"],
        image: json["image"],
        discountPercentage: json["discountPercentage"],
        expireAt: DateTime.parse(json["expireAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "organizerId": organizerId,
        "image": image,
        "discountPercentage": discountPercentage,
        "expireAt": expireAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class TicketCategory {
  String id;
  String eventId;
  String pendingId;
  String name;
  int price;
  int quantity;

  TicketCategory({
    required this.id,
    required this.eventId,
    required this.pendingId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory TicketCategory.fromJson(Map<String, dynamic> json) => TicketCategory(
        id: json["id"],
        eventId: json["eventId"],
        pendingId: json["pendingId"],
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "eventId": eventId,
        "pendingId": pendingId,
        "name": name,
        "price": price,
        "quantity": quantity,
      };
}

// Other classes like `Location`, `CreatorId`, `EventCategory`, and `EventCategoryType` remain unchanged.


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
  String blockImage;
  String map;
  String transportation;

  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.cityId,
    required this.blockImage,
    required this.map,
    required this.transportation
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    image: json["image"],
    cityId: json["cityId"],
    blockImage: json["blockImage"],
    map: json["map"],
    transportation: json["transportation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "image": image,
    "cityId": cityId,
     "blockImage": blockImage,
    "map": map,
    "transportation": transportation,
  };
}
