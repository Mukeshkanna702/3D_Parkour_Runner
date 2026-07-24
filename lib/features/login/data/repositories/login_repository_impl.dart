import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> loginWithGoogle() async {
    return await remoteDataSource.authenticateGoogle();
  }

  @override
  Future<UserEntity> loginWithApple() async {
    return await remoteDataSource.authenticateApple();
  }

  @override
  Future<UserEntity> loginAsGuest() async {
    return await remoteDataSource.authenticateGuest();
  }

  @override
  Future<UserEntity> loginWithEmail(String email, String password) async {
    return await remoteDataSource.authenticateEmail(email, password);
  }
}
