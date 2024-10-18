// To parse this JSON data, do
//
//     final registrationJson = registrationJsonFromJson(jsonString);

import 'dart:convert';

RegistrationJson registrationJsonFromJson(String str) => RegistrationJson.fromJson(json.decode(str));

String registrationJsonToJson(RegistrationJson data) => json.encode(data.toJson());

class RegistrationJson {
  bool success;
  DateTime date;
  String message;
  RegisterUser data;

  RegistrationJson({
    required this.success,
    required this.date,
    required this.message,
    required this.data,
  });

  factory RegistrationJson.fromJson(Map<String, dynamic> json) => RegistrationJson(
    success: json["success"],
    date: DateTime.parse(json["date"]),
    message: json["message"],
    data: RegisterUser.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "date": date.toIso8601String(),
    "message": message,
    "data": data.toJson(),
  };
}

class RegisterUser {
  String userId;

  RegisterUser({
    required this.userId,
  });

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
  };
}