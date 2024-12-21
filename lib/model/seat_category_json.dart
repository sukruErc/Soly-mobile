import 'dart:convert';

SeatCategoryJson seatCategoryJsonFromJson(String str) => SeatCategoryJson.fromJson(json.decode(str));

class SeatCategoryJson {
  bool? success;
  DateTime? date;
  String? message;
  Data? data;

  SeatCategoryJson({
    this.success,
    this.date,
    this.message,
    required this.data,
  });

  factory SeatCategoryJson.fromJson(Map<String, dynamic> json) => SeatCategoryJson(
    success: json["success"],
    date: DateTime.parse(json["date"]),
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  List<NumberOfPerson> numberOfPerson;
  List<Category> categories;

  Data({
    required this.numberOfPerson,
    required this.categories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    numberOfPerson: List<NumberOfPerson>.from(json["numberOfPerson"].map((x) => NumberOfPerson.fromJson(x))),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "numberOfPerson": List<dynamic>.from(numberOfPerson.map((x) => x.toJson())),
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  String id;
  String label;
  Block block;

  Category({
    required this.id,
    required this.label,
    required this.block,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    label: json["label"],
    block: Block.fromJson(json["block"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "block": block.toJson(),
  };
}

class Block {
  String id;
  String label;

  Block({
    required this.id,
    required this.label,
  });

  factory Block.fromJson(Map<String, dynamic> json) => Block(
    id: json["id"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
  };
}

class NumberOfPerson {
  String id;
  String name;

  NumberOfPerson({
    required this.id,
    required this.name,
  });

  factory NumberOfPerson.fromJson(Map<String, dynamic> json) => NumberOfPerson(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}