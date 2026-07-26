import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_lobby_state_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetLobbyStateUseCase getLobbyStateUseCase;

  HomeBloc({required this.getLobbyStateUseCase}) : super(HomeInitialState()) {
    on<LoadLobbyEvent>(_onLoadLobby);
  }

  Future<void> _onLoadLobby(
    LoadLobbyEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      final lobbyData = await getLobbyStateUseCase.execute();
      emit(HomeLoadedState(lobbyData));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }
}
