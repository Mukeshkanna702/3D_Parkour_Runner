import '../../domain/entities/splash_state_entity.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasources/splash_local_datasource.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource localDataSource;
  SplashRepositoryImpl({required this.localDataSource});

  @override
  Stream<SplashStateEntity> initializeAppAssets() {
    return localDataSource.loadInitialAssets();
  }
}
