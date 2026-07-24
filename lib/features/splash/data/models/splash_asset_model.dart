import '../../domain/entities/splash_state_entity.dart';

class SplashAssetModel extends SplashStateEntity {
  const SplashAssetModel({
    required super.isInitialized,
    required super.statusMessage,
    required super.progress,
  });

  factory SplashAssetModel.fromStep(int step, int totalSteps, String message) {
    final double progress = step / totalSteps;
    return SplashAssetModel(
      isInitialized: step >= totalSteps,
      statusMessage: message,
      progress: progress,
    );
  }
}
