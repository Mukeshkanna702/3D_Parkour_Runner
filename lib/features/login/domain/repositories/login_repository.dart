import '../entities/user_entity.dart';

abstract class LoginRepository {
  Future<UserEntity> loginWithGoogle();
  Future<UserEntity> loginWithApple();
  Future<UserEntity> loginAsGuest();
  Future<UserEntity> loginWithEmail(String email, String password);
}
