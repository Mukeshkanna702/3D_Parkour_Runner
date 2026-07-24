import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/initialize_app_usecase.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final InitializeAppUseCase initializeAppUseCase;

  SplashBloc({required this.initializeAppUseCase}) : super(SplashInitialState()) {
    on<StartSplashInitialization>(_onStartInitialization);
  }

  Future<void> _onStartInitialization(
    StartSplashInitialization event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoadingState(
      statusMessage: 'INITIALIZING NEXUS NEON CORE...',
      progress: 0.0,
    ));

    await emit.forEach(
      initializeAppUseCase.execute(),
      onData: (splashEntity) {
        if (splashEntity.isInitialized) {
          return SplashCompletedState();
        } else {
          return SplashLoadingState(
            statusMessage: splashEntity.statusMessage,
            progress: splashEntity.progress,
          );
        }
      },
    );
  }
}
