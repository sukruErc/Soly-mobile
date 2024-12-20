// To parse this JSON data, do
//
//     final seatSelectionJson = seatSelectionJsonFromJson(jsonString);

import 'dart:convert';

import 'package:book_my_seat/book_my_seat.dart';

SeatSelectionJson seatSelectionJsonFromJson(String str) => SeatSelectionJson.fromJson(json.decode(str));

class SeatSelectionJson {
  bool? success;
  DateTime? date;
  String? message;
  List<Datum>? data;

  SeatSelectionJson({
    this.success,
    this.date,
    this.message,
    required this.data,
  });

  factory SeatSelectionJson.fromJson(Map<String, dynamic> json) => SeatSelectionJson(
    success: json["success"],
    date: DateTime.parse(json["date"]),
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );
}

class Datum {
  String id;
  String name;
  int numOfRows;
  int numOfColumns;
  List<List<Seat>> seats;

  Datum({
    required this.id,
    required this.name,
    required this.numOfRows,
    required this.numOfColumns,
    required this.seats,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    numOfRows: json["numOfRows"],
    numOfColumns: json["numOfColumns"],
    seats: List<List<Seat>>.from(json["seats"].map((x) => List<Seat>.from(x.map((x) => seatValues.map[x]!)))),
  );
}

enum Seat {
  AVAILABLE,
  EMPTY,
  RESERVED
}

final seatValues = EnumValues({
  "available": Seat.AVAILABLE,
  "empty": Seat.EMPTY,
  "reserved": Seat.RESERVED
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
