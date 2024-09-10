class EventDetailModel {
  String? eventTitle;
  String? eventSubTitle;
  String? date;
  String? time;
  String? location;
  String? image;
  String? price;
  String? organizer;
  String? memberDate;

  EventDetailModel({
    this.eventTitle,
    this.eventSubTitle,
    this.date,
    this.time,
    this.location,
    this.image,
    this.price,
    this.organizer,
    this.memberDate,
  });

  // Factory constructor to handle null safety while parsing JSON
  factory EventDetailModel.fromJson(Map<String, dynamic> json) {
    return EventDetailModel(
      eventTitle: json['eventTitle'] ?? '',
      eventSubTitle: json['eventSubTitle'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      location: json['location'] as String?,
      image: json['image'] as String?,
      price: json['price'] as String?,
      organizer: json['organizer'] as String?,
      memberDate: json['memberDate'] as String?,
    );
  }

  // Convert the model to JSON while ensuring non-null values
  Map<String, dynamic> toJson() {
    return {
      'eventTitle': eventTitle ?? '',
      'eventSubTitle': eventSubTitle ?? '',
      'date': date ?? '',
      'time': time ?? '',
      'location': location ?? '',
      'image': image ?? '',
      'price': price ?? '',
      'organizer': organizer ?? '',
      'memberDate': memberDate ?? '',
    };
  }
}
