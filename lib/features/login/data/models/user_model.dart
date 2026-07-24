import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.username,
    required super.email,
    required super.avatarUrl,
    required super.level,
    required super.neonCrystals,
    required super.loginProvider,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String? ?? '',
      level: json['level'] as int? ?? 1,
      neonCrystals: json['neon_crystals'] as int? ?? 500,
      loginProvider: json['login_provider'] as String? ?? 'guest',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'avatar_url': avatarUrl,
      'level': level,
      'neon_crystals': neonCrystals,
      'login_provider': loginProvider,
    };
  }
}
