import '../entities/splash_state_entity.dart';

abstract class SplashRepository {
  Stream<SplashStateEntity> initializeAppAssets();
}
