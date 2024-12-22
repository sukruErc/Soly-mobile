class TicketJson {
  final bool success;
  final String date;
  final String message;
  final List<TicketData> data;

  TicketJson({
    required this.success,
    required this.date,
    required this.message,
    required this.data,
  });

  factory TicketJson.fromJson(Map<String, dynamic> json) {
    return TicketJson(
      success: json['success'],
      date: json['date'],
      message: json['message'],
      data: (json['data'] as List<dynamic>)
          .map((item) => TicketData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'date': date,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class TicketData {
  final String id;
  final String ticketTypeName;
  final int price;
  final String eventId;
  final int tokenId;
  final String ipfsImage;
  final String ipfsMetadata;
  final String ticketCategoryId;
  final String seatId;
  final String blockId;
  final bool isUsed;
  final bool sold;
  final String heldUntil;
  final String status;
  final String userId;
  final String custId;
  final String createdAt;
  final String updatedAt;
  final SeatData seat; // Added seat data

  TicketData({
    required this.id,
    required this.ticketTypeName,
    required this.price,
    required this.eventId,
    required this.tokenId,
    required this.ipfsImage,
    required this.ipfsMetadata,
    required this.ticketCategoryId,
    required this.seatId,
    required this.blockId,
    required this.isUsed,
    required this.sold,
    required this.heldUntil,
    required this.status,
    required this.userId,
    required this.custId,
    required this.createdAt,
    required this.updatedAt,
    required this.seat, // Required seat data
  });

  factory TicketData.fromJson(Map<String, dynamic> json) {
    return TicketData(
      id: json['id'],
      ticketTypeName: json['ticketTypeName'],
      price: json['price'],
      eventId: json['eventId'],
      tokenId: json['tokenId'],
      ipfsImage: json['ipfsImage'],
      ipfsMetadata: json['ipfsMetadata'],
      ticketCategoryId: json['ticketCategoryId'],
      seatId: json['seatId'],
      blockId: json['blockId'],
      isUsed: json['isUsed'],
      sold: json['sold'],
      heldUntil: json['heldUntil'],
      status: json['status'],
      userId: json['userId'],
      custId: json['custId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      seat: SeatData.fromJson(json['seat']), // Parse seat data
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticketTypeName': ticketTypeName,
      'price': price,
      'eventId': eventId,
      'tokenId': tokenId,
      'ipfsImage': ipfsImage,
      'ipfsMetadata': ipfsMetadata,
      'ticketCategoryId': ticketCategoryId,
      'seatId': seatId,
      'blockId': blockId,
      'isUsed': isUsed,
      'sold': sold,
      'heldUntil': heldUntil,
      'status': status,
      'userId': userId,
      'custId': custId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'seat': seat.toJson(), // Serialize seat data
    };
  }
}

class SeatData {
  final String title;

  SeatData({
    required this.title,
  });

  factory SeatData.fromJson(Map<String, dynamic> json) {
    return SeatData(
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}
