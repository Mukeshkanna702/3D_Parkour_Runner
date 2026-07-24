import '../entities/splash_state_entity.dart';
import '../repositories/splash_repository.dart';

class InitializeAppUseCase {
  final SplashRepository repository;
  InitializeAppUseCase(this.repository);

  Stream<SplashStateEntity> execute() {
    return repository.initializeAppAssets();
  }
}
