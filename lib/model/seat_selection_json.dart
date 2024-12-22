import 'dart:convert';

class SeatSelectionJson {
  bool? success;
  DateTime? date;
  String? message;
  Block? data;

  SeatSelectionJson({
    this.success,
    this.date,
    this.message,
    this.data,
  });

  factory SeatSelectionJson.fromJson(Map<String, dynamic> json) => SeatSelectionJson(
        success: json["success"],
        date: DateTime.parse(json["date"]),
        message: json["message"],
        data: json["data"] != null ? Block.fromJson(json["data"]) : null,
      );
}

class Block {
  String? id;
  int? numOfRows;
  int? numOfColumns;
  String? name;
  String? locationId;
    String? eventName;
  DateTime? createdAt;
  DateTime? updatedAt;
  
  List<List<Seat>>? seats;

  Block({
    this.id,
    this.numOfRows,
    this.numOfColumns,
    this.name,
    this.locationId,
    this.eventName,
    this.createdAt,
    this.updatedAt,
    this.seats,
  });

  factory Block.fromJson(Map<String, dynamic> json) => Block(
        id: json["id"],
        numOfRows: int.tryParse(json["numOfRows"] ?? "0"),
        numOfColumns: int.tryParse(json["numOfColumns"] ?? "0"),
        name: json["name"],
        locationId: json["locationId"],
        eventName: json["eventName"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        seats: json["seats"] != null
            ? List<List<Seat>>.from(
                json["seats"].map((row) => List<Seat>.from(row.map((seat) => Seat.fromJson(seat)))))
            : null,
      );
}

class Seat {
  String? id;
  int? seatNumber;
  String? title;
  bool empty;
  int? row;
  int? column;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? seatingBlockId;
  String status;

  Seat({
    this.id,
    this.seatNumber,
    this.title,
    required this.empty,
    this.row,
    this.column,
    this.createdAt,
    this.updatedAt,
    this.seatingBlockId,
    required this.status,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        id: json["id"],
        seatNumber: json["seatNumber"],
        title: json["title"],
        empty: json["empty"] ?? false,
        row: json["row"],
        column: json["column"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        seatingBlockId: json["seatingBlockId"],
        status: json["status"],
      );
}
