import 'package:equatable/equatable.dart';

class SplashStateEntity extends Equatable {
  final bool isInitialized;
  final String statusMessage;
  final double progress;

  const SplashStateEntity({
    required this.isInitialized,
    required this.statusMessage,
    required this.progress,
  });

  @override
  List<Object?> get props => [isInitialized, statusMessage, progress];
}
