import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String username;
  final String email;
  final String avatarUrl;
  final int level;
  final int neonCrystals;
  final String loginProvider;

  const UserEntity({
    required this.uid,
    required this.username,
    required this.email,
    required this.avatarUrl,
    required this.level,
    required this.neonCrystals,
    required this.loginProvider,
  });

  @override
  List<Object?> get props => [uid, username, email, avatarUrl, level, neonCrystals, loginProvider];
}
