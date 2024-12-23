import 'dart:convert';

EventTicketsResponse eventTicketsResponseFromJson(String str) =>
    EventTicketsResponse.fromJson(json.decode(str));

String eventTicketsResponseToJson(EventTicketsResponse data) =>
    json.encode(data.toJson());

class EventTicketsResponse {
  bool success;
  DateTime date;
  EventTicketsData data;

  EventTicketsResponse({
    required this.success,
    required this.date,
    required this.data,
  });

  factory EventTicketsResponse.fromJson(Map<String, dynamic> json) =>
      EventTicketsResponse(
        success: json["success"],
        date: DateTime.parse(json["date"]),
        data: EventTicketsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "date": date.toIso8601String(),
        "data": data.toJson(),
      };
}

class EventTicketsData {
  List<Ticket> availableTickets;
  List<UserHeldTicket> userHeldTickets;
  List<Ticket> userPurchasedTickets;

  EventTicketsData({
    required this.availableTickets,
    required this.userHeldTickets,
    required this.userPurchasedTickets,
  });

  factory EventTicketsData.fromJson(Map<String, dynamic> json) {
    return EventTicketsData(
      availableTickets: List<Ticket>.from(
        json["availableTickets"].map((x) => Ticket.fromJson(x)),
      ),
      userHeldTickets: List<UserHeldTicket>.from(
        json["userHeldTickets"].map((x) => UserHeldTicket.fromJson(x)),
      ),
      userPurchasedTickets: List<Ticket>.from(
        json["userPurchasedTickets"].map((x) => Ticket.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "availableTickets":
            List<dynamic>.from(availableTickets.map((x) => x.toJson())),
        "userHeldTickets":
            List<dynamic>.from(userHeldTickets.map((x) => x.toJson())),
        "userPurchasedTickets":
            List<dynamic>.from(userPurchasedTickets.map((x) => x.toJson())),
      };
}


class Ticket {
  String id;
  int price;
  String ipfsMetadata;
  String ipfsImage;

  Ticket({
    required this.id,
    required this.price,
    required this.ipfsMetadata,
    required this.ipfsImage,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        price: json["price"],
        ipfsMetadata: json["ipfsMetadata"],
        ipfsImage: json["ipfsImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "ipfsMetadata": ipfsMetadata,
        "ipfsImage": ipfsImage,
      };
}

class UserHeldTicket {
  String id;
  DateTime heldUntil;
  String seatTitle;

  UserHeldTicket({
    required this.id,
    required this.heldUntil,
    required this.seatTitle,
  });

  factory UserHeldTicket.fromJson(Map<String, dynamic> json) => UserHeldTicket(
        id: json["id"],
        heldUntil: DateTime.parse(json["heldUntil"]),
        seatTitle: json["seatTitle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "heldUntil": heldUntil.toIso8601String(),
        "seatTitle": seatTitle,
      };
}
