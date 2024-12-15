class CouponModel {
  final String id;
  final String code;
  final String customerId;
  final String collectionId;
  final bool isRedeemed;
  final int discountPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;

  CouponModel({
    required this.id,
    required this.code,
    required this.customerId,
    required this.collectionId,
    required this.isRedeemed,
    required this.discountPercentage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] ?? '', 
      code: json['code'] ?? '',
      customerId: json['customerId'] ?? '',
      collectionId: json['collectionId'] ?? '',
      isRedeemed: json['isRedeemed'] ?? false,
      discountPercentage: json['discountPercentage'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
