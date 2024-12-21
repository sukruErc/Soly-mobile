import 'dart:convert';

HighlightEventJson highlightEventJsonFromJson(String str) =>
    HighlightEventJson.fromJson(json.decode(str));

String highlightEventJsonToJson(HighlightEventJson data) =>
    json.encode(data.toJson());

class HighlightEventJson {
  List<HighlightEvent> data;

  HighlightEventJson({
    required this.data,
  });

  factory HighlightEventJson.fromJson(Map<String, dynamic> json) =>
      HighlightEventJson(
        data: List<HighlightEvent>.from(
            json["data"].map((x) => HighlightEvent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class HighlightEvent {
  String id;
  String eventName;
  DateTime date;
  String image;
  Location location;
  EventCategory eventCategory;
  EventCategoryType eventCategoryType;
  String priceLabel;
  String time;

  HighlightEvent({
    required this.id,
    required this.eventName,
    required this.date,
    required this.image,
    required this.location,
    required this.eventCategory,
    required this.eventCategoryType,
    required this.priceLabel,
    required this.time,
  });

  factory HighlightEvent.fromJson(Map<String, dynamic> json) => HighlightEvent(
        id: json["id"],
        eventName: json["eventName"],
        date: DateTime.parse(json["date"]),
        image: json["image"],
        location: Location.fromJson(json["location"]),
        eventCategory: EventCategory.fromJson(json["eventCategory"]),
        eventCategoryType:
            EventCategoryType.fromJson(json["eventCategoryType"]),
        priceLabel: json["priceLabel"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "eventName": eventName,
        "date": date.toIso8601String(),
        "image": image,
        "location": location.toJson(),
        "eventCategory": eventCategory.toJson(),
        "eventCategoryType": eventCategoryType.toJson(),
        "time": time,
      };
}

class Location {
  String id;
  String name;
  String address;
  String image;

  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "image": image,
      };
}

class EventCategory {
  String id;
  String name;

  EventCategory({
    required this.id,
    required this.name,
  });

  factory EventCategory.fromJson(Map<String, dynamic> json) => EventCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class EventCategoryType {
  String id;
  String name;

  EventCategoryType({
    required this.id,
    required this.name,
  });

  factory EventCategoryType.fromJson(Map<String, dynamic> json) =>
      EventCategoryType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
