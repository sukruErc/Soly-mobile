// To parse this JSON data, do
//
//     final eventFilterJson = eventFilterJsonFromJson(jsonString);

import 'dart:convert';

EventFilterJson eventFilterJsonFromJson(String str) => EventFilterJson.fromJson(json.decode(str));

class EventFilterJson {
  bool? success;
  DateTime? date;
  List<SearchFilter> data;

  EventFilterJson({
    this.success,
    this.date,
    required this.data,
  });

  factory EventFilterJson.fromJson(Map<String, dynamic> json) => EventFilterJson(
    success: json["success"],
    date: DateTime.parse(json["date"]),
    data: List<SearchFilter>.from(json["data"].map((x) => SearchFilter.fromJson(x))),
  );
}

class SearchFilter {
  String id;
  DateTime date;
  String desc;
  String? highlight;
  String numberOfPerson;
  String name;
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
  // EventCategory eventCategoryType;
  // CreatorId creatorId;

  SearchFilter({
    required this.id,
    required this.date,
    required this.desc,
    required this.highlight,
    required this.numberOfPerson,
    required this.name,
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
     // this.eventCategoryType,
     // this.creatorId,
  });

  factory SearchFilter.fromJson(Map<String, dynamic> json) => SearchFilter(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    desc: json["desc"],
    highlight: json["highlight"],
    numberOfPerson: json["numberOfPerson"],
    name: json["eventName"],
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
    // eventCategoryType: EventCategory.fromJson(json["eventCategoryType"]),
    // creatorId: CreatorId.fromJson(json["creatorId"]),
  );
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
  String image;
  String phone;
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
  Image? image;
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
    image: imageValues.map[json["image"]]!,
    // categoryId: json["categoryId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": imageValues.reverse[image],
    "categoryId": categoryId,
  };
}

enum Image {
  QM_VG8_YA1_CUG_BY_NQ_APENT3_C_HQIN_ZB2_X_MD_DM_HG_EZA_MZ_BOM_CP
}

final imageValues = EnumValues({
  "QmVG8YA1cugByNqAPENT3CHqinZb2XMdDMHgEZAMzBomCP": Image.QM_VG8_YA1_CUG_BY_NQ_APENT3_C_HQIN_ZB2_X_MD_DM_HG_EZA_MZ_BOM_CP
});

class Location {
  String id;
  String name;
  String address;
  Image image;
  String blockImage;
  String map;
  String transportation;
  String cityId;
  EventCategory city;

  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.blockImage,
    required this.map,
    required this.transportation,
    required this.cityId,
    required this.city,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    image: imageValues.map[json["image"]]!,
    blockImage: json["blockImage"],
    map: json["map"],
    transportation: json["transportation"],
    cityId: json["cityId"],
    city: EventCategory.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "image": imageValues.reverse[image],
    "blockImage": blockImage,
    "map": map,
    "transportation": transportation,
    "cityId": cityId,
    "city": city.toJson(),
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