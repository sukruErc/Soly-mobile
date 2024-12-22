class LoginJson {
  final bool success;
  final String date;
  final String message;
  final LoginData data;

  LoginJson({
    required this.success,
    required this.date,
    required this.message,
    required this.data,
  });

  factory LoginJson.fromJson(Map<String, dynamic> json) {
    return LoginJson(
      success: json['success'],
      date: json['date'],
      message: json['message'],
      data: LoginData.fromJson(json['data']),
    );
  }
}

class LoginData {
  final String accessToken;
  final int expiresIn;
  final int refreshExpiresIn;
  final String refreshToken;
  final String tokenType;
  final int notBeforePolicy;
  final String sessionState;
  final String scope;
  final List<Role> roles;
  final List<Role> role; // Bazı durumlarda `roles` yerine `role` kullanıldığı için.
  final String name;
  final String userId;

  LoginData({
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

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      accessToken: json['access_token'],
      expiresIn: json['expires_in'],
      refreshExpiresIn: json['refresh_expires_in'],
      refreshToken: json['refresh_token'],
      tokenType: json['token_type'],
      notBeforePolicy: json['not-before-policy'],
      sessionState: json['session_state'],
      scope: json['scope'],
      roles: List<Role>.from(json['roles'].map((x) => Role.fromJson(x))),
      role: List<Role>.from(json['role'].map((x) => Role.fromJson(x))),
      name: json['name'],
      userId: json['userId'],
    );
  }
}

class Role {
  final String id;
  final String name;
  final String description;
  final bool composite;
  final bool clientRole;
  final String containerId;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.composite,
    required this.clientRole,
    required this.containerId,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      composite: json['composite'],
      clientRole: json['clientRole'],
      containerId: json['containerId'],
    );
  }
}
