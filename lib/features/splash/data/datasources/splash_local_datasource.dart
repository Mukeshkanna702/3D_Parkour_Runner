import 'dart:async';
import '../models/splash_asset_model.dart';

abstract class SplashLocalDataSource {
  Stream<SplashAssetModel> loadInitialAssets();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  @override
  Stream<SplashAssetModel> loadInitialAssets() async* {
    const steps = [
      'CONNECTING TO NEXUS SERVERS...',
      'INITIALIZING LUMEN & RAY TRACING PIPELINE...',
      'PRELOADING CYBER NINJA GHOST ASSETS...',
      'PREPARING 60 FPS MOTION ENGINE...',
      'SYSTEM READY — LAUNCHING SKYRUSH...'
    ];

    for (int i = 0; i < steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 650));
      yield SplashAssetModel.fromStep(i + 1, steps.length, steps[i]);
    }
  }
}
