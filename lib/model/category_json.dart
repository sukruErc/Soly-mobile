// To parse this JSON data, do
//
//     final categoryJson = categoryJsonFromJson(jsonString);

import 'dart:convert';

CategoryJson categoryJsonFromJson(String str) => CategoryJson.fromJson(json.decode(str));

String categoryJsonToJson(CategoryJson data) => json.encode(data.toJson());

class CategoryJson {
  DateTime date;
  bool success;
  String message;
  List<Category> data;

  CategoryJson({
    required this.date,
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoryJson.fromJson(Map<String, dynamic> json) => CategoryJson(
    date: DateTime.parse(json["date"]),
    success: json["success"],
    message: json["message"],
    data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Category {
  String id;
  String categoryName;
  int count;

  Category({
    required this.id,
    required this.categoryName,
    required this.count,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    categoryName: json["categoryName"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryName": categoryName,
    "count": count,
  };
}
