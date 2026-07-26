import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'matchmaking_event.dart';
import 'matchmaking_state.dart';

class MatchmakingBloc extends Bloc<MatchmakingEvent, MatchmakingState> {
  Timer? _searchTimer;
  int _elapsed = 0;

  MatchmakingBloc() : super(const MatchmakingConfigState()) {
    on<SelectModeEvent>(_onSelectMode);
    on<SelectMapEvent>(_onSelectMap);
    on<StartSearchingEvent>(_onStartSearching);
    on<TickSearchTimerEvent>(_onTickSearchTimer);
    on<MatchFoundEvent>(_onMatchFound);
  }

  void _onSelectMode(SelectModeEvent event, Emitter<MatchmakingState> emit) {
    emit(MatchmakingConfigState(
      selectedMode: event.mode,
      selectedMap: state.selectedMap,
    ));
  }

  void _onSelectMap(SelectMapEvent event, Emitter<MatchmakingState> emit) {
    emit(MatchmakingConfigState(
      selectedMode: state.selectedMode,
      selectedMap: event.mapName,
    ));
  }

  void _onStartSearching(StartSearchingEvent event, Emitter<MatchmakingState> emit) {
    _elapsed = 0;
    emit(MatchmakingSearchingState(
      selectedMode: state.selectedMode,
      selectedMap: state.selectedMap,
      secondsElapsed: _elapsed,
    ));

    _searchTimer?.cancel();
    _searchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(TickSearchTimerEvent());
    });
  }

  void _onTickSearchTimer(TickSearchTimerEvent event, Emitter<MatchmakingState> emit) {
    _elapsed++;
    if (_elapsed >= 2) {
      _searchTimer?.cancel();
      add(MatchFoundEvent());
    } else {
      emit(MatchmakingSearchingState(
        selectedMode: state.selectedMode,
        selectedMap: state.selectedMap,
        secondsElapsed: _elapsed,
      ));
    }
  }

  void _onMatchFound(MatchFoundEvent event, Emitter<MatchmakingState> emit) {
    emit(MatchmakingFoundState(
      selectedMode: state.selectedMode,
      selectedMap: state.selectedMap,
    ));
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
