import 'dart:convert';

FiltersJson filtersJsonFromJson(String str) => FiltersJson.fromJson(json.decode(str));

class FiltersJson {
  Data? data;
  DateTime? date;
  bool? success;
  String? message;

  FiltersJson({
    required this.data,
    this.date,
    this.success,
    this.message,
  });

  factory FiltersJson.fromJson(Map<String, dynamic> json) => FiltersJson(
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        date: json["date"] != null ? DateTime.tryParse(json["date"]) : null,
        success: json["success"],
        message: json["message"],
      );

  @override
  String toString() {
    return 'FiltersJson(success: $success, message: $message, date: $date, data: $data)';
  }
}

class Data {
  List<OrderType> orderTypes;
  List<Category> categories;
  List<Location> locations;
  List<Organizer> organizers;

  Data({
    required this.orderTypes,
    required this.categories,
    required this.locations,
    required this.organizers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderTypes: json["orderTypes"] != null
            ? List<OrderType>.from(json["orderTypes"].map((x) => OrderType.fromJson(x)))
            : [],
        categories: json["categories"] != null
            ? List<Category>.from(json["categories"].map((x) => Category.fromJson(x)))
            : [],
        locations: json["locations"] != null
            ? List<Location>.from(json["locations"].map((x) => Location.fromJson(x)))
            : [],
        organizers: json["organizers"] != null
            ? List<Organizer>.from(json["organizers"].map((x) => Organizer.fromJson(x)))
            : [],
      );

  @override
  String toString() {
    return 'Data(orderTypes: $orderTypes, categories: $categories, locations: $locations, organizers: $organizers)';
  }
}

class Category {
  String id;
  String name;
  String? image;
  List<CategoryType> categoryType;
  bool isSelected;

  Category({
    required this.id,
    required this.name,
    this.image,
    required this.categoryType,
    this.isSelected = false,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        categoryType: json["CategoryType"] != null
            ? List<CategoryType>.from(json["CategoryType"].map((x) => CategoryType.fromJson(x)))
            : [],
        isSelected: false,
      );

  @override
  String toString() {
    return 'Category(id: $id, name: $name, isSelected: $isSelected, categoryType: $categoryType)';
  }
}

class CategoryType {
  String id;
  String name;
  bool isSelected;

  CategoryType({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  factory CategoryType.fromJson(Map<String, dynamic> json) => CategoryType(
        id: json["id"],
        name: json["name"],
        isSelected: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isSelected": isSelected,
      };

  @override
  String toString() {
    return 'CategoryType(id: $id, name: $name, isSelected: $isSelected)';
  }
}

class Location {
  String id;
  String name;
  String address;
  String image;
  String? seoDesc;
  String? seoKeywords;
  String blockImage;
  String map;
  String transportation;
  String cityId;

  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    this.seoDesc,
    this.seoKeywords,
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
        seoDesc: json["seoDesc"],
        seoKeywords: json["seoKeywords"],
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
        "seoDesc": seoDesc,
        "seoKeywords": seoKeywords,
        "blockImage": blockImage,
        "map": map,
        "transportation": transportation,
        "cityId": cityId,
      };

  @override
  String toString() {
    return 'Location(id: $id, name: $name, address: $address)';
  }
}

class OrderType {
  String id;
  String name;

  OrderType({
    required this.id,
    required this.name,
  });

  factory OrderType.fromJson(Map<String, dynamic> json) => OrderType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  String toString() {
    return 'OrderType(id: $id, name: $name)';
  }
}

class Organizer {
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
  DateTime? birthday;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic familyId;

  Organizer({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.subscribeType,
    required this.status,
    required this.bcAddress,
    required this.password,
    this.image,
    this.phone,
    this.birthday,
    required this.createdAt,
    required this.updatedAt,
    this.familyId,
  });

  factory Organizer.fromJson(Map<String, dynamic> json) => Organizer(
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
        birthday: json["birthday"] != null ? DateTime.tryParse(json["birthday"]) : null,
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
        "birthday": birthday?.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "familyId": familyId,
      };

  @override
  String toString() {
    return 'Organizer(id: $id, name: $name, email: $email)';
  }
}
