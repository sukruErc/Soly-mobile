import 'event_model.dart';
import 'coupon_model.dart';

class CollectionModel {
  final String id;
  final String name;
  final String image;
  final int discountPercentage;
  final DateTime expireAt;
  final List<CouponModel> coupons;
  final List<EventModel> events;
  final List<EventModel> applicableEvents;

  CollectionModel({
    required this.id,
    required this.name,
    required this.image,
    required this.discountPercentage,
    required this.expireAt,
    required this.coupons,
    required this.events,
    required this.applicableEvents,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      discountPercentage: json['discountPercentage'] ?? 0,
      expireAt: DateTime.parse(json['expireAt']),
      coupons: (json['coupons'] as List)
          .map((c) => CouponModel.fromJson(c as Map<String, dynamic>))
          .toList(),
      events: (json['events'] as List)
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
          applicableEvents: (json['applicableEvents'] as List)
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
