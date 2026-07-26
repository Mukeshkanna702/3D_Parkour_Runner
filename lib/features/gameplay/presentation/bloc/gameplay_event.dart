import 'package:equatable/equatable.dart';

abstract class GameplayEvent extends Equatable {
  const GameplayEvent();
  @override
  List<Object?> get props => [];
}

class StartGameLoopEvent extends GameplayEvent {}

class MoveLaneLeftEvent extends GameplayEvent {}

class MoveLaneRightEvent extends GameplayEvent {}

class TriggerJumpEvent extends GameplayEvent {}

class TriggerSlideEvent extends GameplayEvent {}

class TriggerDashEvent extends GameplayEvent {}

class TriggerWallRunEvent extends GameplayEvent {}

class TriggerZiplineEvent extends GameplayEvent {}

class ActivateMagnetEvent extends GameplayEvent {}

class ActivateShieldEvent extends GameplayEvent {}

class CollectCrystalEvent extends GameplayEvent {}

class StrikeBossCoreEvent extends GameplayEvent {}

class PassCheckpointEvent extends GameplayEvent {}

class PlayerHitObstacleEvent extends GameplayEvent {}

class PauseGameEvent extends GameplayEvent {}

class ResumeGameEvent extends GameplayEvent {}
