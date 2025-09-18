import 'dart:convert';
class UserEntity {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? userId;
  UserEntity({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userId,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserCredentials {
  UserEntity user;
  String token;
  UserCredentials({
    required this.user,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'token': token,
    };
  }

  factory UserCredentials.fromMap(Map<String, dynamic> map) {
    return UserCredentials(
      user: UserEntity.fromMap(map['user'] as Map<String, dynamic>),
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCredentials.fromJson(String source) =>
      UserCredentials.fromMap(json.decode(source) as Map<String, dynamic>);
}
