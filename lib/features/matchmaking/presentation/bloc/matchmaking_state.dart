import 'package:equatable/equatable.dart';

abstract class MatchmakingState extends Equatable {
  final String selectedMode;
  final String selectedMap;

  const MatchmakingState({
    required this.selectedMode,
    required this.selectedMap,
  });

  @override
  List<Object?> get props => [selectedMode, selectedMap];
}

class MatchmakingConfigState extends MatchmakingState {
  const MatchmakingConfigState({
    super.selectedMode = 'RANKED RUNNER',
    super.selectedMap = 'NEO TOKYO 2099',
  });
}

class MatchmakingSearchingState extends MatchmakingState {
  final int secondsElapsed;

  const MatchmakingSearchingState({
    required super.selectedMode,
    required super.selectedMap,
    required this.secondsElapsed,
  });

  @override
  List<Object?> get props => [selectedMode, selectedMap, secondsElapsed];
}

class MatchmakingFoundState extends MatchmakingState {
  const MatchmakingFoundState({
    required super.selectedMode,
    required super.selectedMap,
  });
}
