import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  @override
  List<Object?> get props => [];
}

class SplashInitialState extends SplashState {}

class SplashLoadingState extends SplashState {
  final String statusMessage;
  final double progress;

  const SplashLoadingState({
    required this.statusMessage,
    required this.progress,
  });

  @override
  List<Object?> get props => [statusMessage, progress];
}

class SplashCompletedState extends SplashState {}
