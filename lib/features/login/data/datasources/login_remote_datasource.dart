import 'dart:async';
import '../models/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> authenticateGoogle();
  Future<UserModel> authenticateApple();
  Future<UserModel> authenticateGuest();
  Future<UserModel> authenticateEmail(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future<UserModel> authenticateGoogle() async {
    await Future.delayed(const Duration(milliseconds: 900));
    return const UserModel(
      uid: 'google_user_992',
      username: 'CyberNinja_99',
      email: 'runner@skyrush.game',
      avatarUrl: '',
      level: 42,
      neonCrystals: 2450,
      loginProvider: 'google',
    );
  }

  @override
  Future<UserModel> authenticateApple() async {
    await Future.delayed(const Duration(milliseconds: 900));
    return const UserModel(
      uid: 'apple_user_771',
      username: 'GhostRunner_01',
      email: 'ghost@apple.com',
      avatarUrl: '',
      level: 18,
      neonCrystals: 1200,
      loginProvider: 'apple',
    );
  }

  @override
  Future<UserModel> authenticateGuest() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return const UserModel(
      uid: 'guest_88491',
      username: 'Guest_NeoRunner',
      email: 'guest@skyrush.local',
      avatarUrl: '',
      level: 1,
      neonCrystals: 500,
      loginProvider: 'guest',
    );
  }

  @override
  Future<UserModel> authenticateEmail(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 900));
    return UserModel(
      uid: 'email_usr_301',
      username: email.split('@').first,
      email: email,
      avatarUrl: '',
      level: 5,
      neonCrystals: 850,
      loginProvider: 'email',
    );
  }
}
