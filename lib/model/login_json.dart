// To parse this JSON data, do
//
//     final loginJson = loginJsonFromJson(jsonString);

import 'dart:convert';

LoginJson loginJsonFromJson(String str) => LoginJson.fromJson(json.decode(str));

String loginJsonToJson(LoginJson data) => json.encode(data.toJson());

class LoginJson {
  bool success;
  DateTime date;
  String message;
  Data data;

  LoginJson({
    required this.success,
    required this.date,
    required this.message,
    required this.data,
  });

  factory LoginJson.fromJson(Map<String, dynamic> json) => LoginJson(
    success: json["success"],
    date: DateTime.parse(json["date"]),
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "date": date.toIso8601String(),
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String accessToken;
  int expiresIn;
  int refreshExpiresIn;
  String refreshToken;
  String tokenType;
  int notBeforePolicy;
  String sessionState;
  String scope;
  List<Role> roles;
  List<Role> role;
  String name;
  String userId;

  Data({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshExpiresIn,
    required this.refreshToken,
    required this.tokenType,
    required this.notBeforePolicy,
    required this.sessionState,
    required this.scope,
    required this.roles,
    required this.role,
    required this.name,
    required this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["access_token"],
    expiresIn: json["expires_in"],
    refreshExpiresIn: json["refresh_expires_in"],
    refreshToken: json["refresh_token"],
    tokenType: json["token_type"],
    notBeforePolicy: json["not-before-policy"],
    sessionState: json["session_state"],
    scope: json["scope"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    role: List<Role>.from(json["role"].map((x) => Role.fromJson(x))),
    name: json["name"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "expires_in": expiresIn,
    "refresh_expires_in": refreshExpiresIn,
    "refresh_token": refreshToken,
    "token_type": tokenType,
    "not-before-policy": notBeforePolicy,
    "session_state": sessionState,
    "scope": scope,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    "role": List<dynamic>.from(role.map((x) => x.toJson())),
    "name": name,
    "userId": userId,
  };
}

class Role {
  String id;
  String name;
  String description;
  bool composite;
  bool clientRole;
  String containerId;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.composite,
    required this.clientRole,
    required this.containerId,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    composite: json["composite"],
    clientRole: json["clientRole"],
    containerId: json["containerId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "composite": composite,
    "clientRole": clientRole,
    "containerId": containerId,
  };
}