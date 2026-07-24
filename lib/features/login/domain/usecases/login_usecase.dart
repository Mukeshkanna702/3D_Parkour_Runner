import '../entities/user_entity.dart';
import '../repositories/login_repository.dart';

enum LoginProviderType { google, apple, guest, email }

class LoginUseCase {
  final LoginRepository repository;
  LoginUseCase(this.repository);

  Future<UserEntity> execute({
    required LoginProviderType type,
    String? email,
    String? password,
  }) async {
    switch (type) {
      case LoginProviderType.google:
        return await repository.loginWithGoogle();
      case LoginProviderType.apple:
        return await repository.loginWithApple();
      case LoginProviderType.guest:
        return await repository.loginAsGuest();
      case LoginProviderType.email:
        if (email == null || password == null) {
          throw Exception('Email and password required for email login.');
        }
        return await repository.loginWithEmail(email, password);
    }
  }
}
