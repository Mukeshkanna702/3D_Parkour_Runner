import 'package:equatable/equatable.dart';
import '../../domain/entities/game_stats_entity.dart';

abstract class GameplayState extends Equatable {
  final GameStatsEntity stats;
  const GameplayState(this.stats);

  @override
  List<Object?> get props => [stats];
}

class GameplayRunningState extends GameplayState {
  const GameplayRunningState(super.stats);
}

class GameplayPausedState extends GameplayState {
  const GameplayPausedState(super.stats);
}

class GameplayOverState extends GameplayState {
  const GameplayOverState(super.stats);
}
