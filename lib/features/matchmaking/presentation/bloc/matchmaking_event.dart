import 'package:equatable/equatable.dart';

abstract class MatchmakingEvent extends Equatable {
  const MatchmakingEvent();
  @override
  List<Object?> get props => [];
}

class SelectModeEvent extends MatchmakingEvent {
  final String mode;
  const SelectModeEvent(this.mode);
  @override
  List<Object?> get props => [mode];
}

class SelectMapEvent extends MatchmakingEvent {
  final String mapName;
  const SelectMapEvent(this.mapName);
  @override
  List<Object?> get props => [mapName];
}

class StartSearchingEvent extends MatchmakingEvent {}

class TickSearchTimerEvent extends MatchmakingEvent {}

class MatchFoundEvent extends MatchmakingEvent {}
