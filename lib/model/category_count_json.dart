// To parse this JSON data, do
//
//     final categoryCountJson = categoryCountJsonFromJson(jsonString);

import 'dart:convert';

CategoryCountJson categoryCountJsonFromJson(String str) => CategoryCountJson.fromJson(json.decode(str));

String categoryCountJsonToJson(CategoryCountJson data) => json.encode(data.toJson());

class CategoryCountJson {
  DateTime? date;
  bool? success;
  String? message;
  List<CategoryCount> data;

  CategoryCountJson({
    this.date,
    this.success,
    this.message,
    required this.data,
  });

  factory CategoryCountJson.fromJson(Map<String, dynamic> json) => CategoryCountJson(
    date: DateTime.parse(json["date"]),
    success: json["success"],
    message: json["message"],
    data: List<CategoryCount>.from(json["data"].map((x) => CategoryCount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date.toString(),
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategoryCount {
  String id;
  String categoryName;
  int count;

  CategoryCount({
    required this.id,
    required this.categoryName,
    required this.count,
  });

  factory CategoryCount.fromJson(Map<String, dynamic> json) => CategoryCount(
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
