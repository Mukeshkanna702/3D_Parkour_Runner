import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/game_stats_entity.dart';
import 'gameplay_event.dart';
import 'gameplay_state.dart';

class GameplayBloc extends Bloc<GameplayEvent, GameplayState> {
  Timer? _tickerTimer;

  GameplayBloc()
      : super(const GameplayRunningState(
          GameStatsEntity(
            distanceMeters: 0,
            speedKmh: 45,
            comboMultiplier: 1,
            crystalsCollected: 0,
            score: 0,
            playerHealth: 1.0,
            playerShield: 1.0,
            playerEnergy: 1.0,
            currentLane: 0,
            isSliding: false,
            isJumping: false,
            isDashing: false,
            isWallRunning: false,
            isZiplining: false,
            isMagnetActive: false,
            isShieldActive: false,
            isDoubleScoreActive: false,
            bossHealth: 1.0,
            isBossActive: false,
            isBossQTEActive: false,
            checkpointIndex: 1,
            isGameOver: false,
            isVictory: false,
          ),
        )) {
    on<StartGameLoopEvent>(_onStartGameLoop);
    on<MoveLaneLeftEvent>(_onMoveLaneLeft);
    on<MoveLaneRightEvent>(_onMoveLaneRight);
    on<TriggerJumpEvent>(_onTriggerJump);
    on<TriggerSlideEvent>(_onTriggerSlide);
    on<TriggerDashEvent>(_onTriggerDash);
    on<TriggerWallRunEvent>(_onTriggerWallRun);
    on<TriggerZiplineEvent>(_onTriggerZipline);
    on<ActivateMagnetEvent>(_onActivateMagnet);
    on<ActivateShieldEvent>(_onActivateShield);
    on<CollectCrystalEvent>(_onCollectCrystal);
    on<StrikeBossCoreEvent>(_onStrikeBossCore);
    on<PassCheckpointEvent>(_onPassCheckpoint);
    on<PlayerHitObstacleEvent>(_onPlayerHitObstacle);
    on<PauseGameEvent>(_onPauseGame);
    on<ResumeGameEvent>(_onResumeGame);
  }

  void _onStartGameLoop(StartGameLoopEvent event, Emitter<GameplayState> emit) {
    _tickerTimer?.cancel();
    _tickerTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (state is GameplayRunningState) {
        final current = state.stats;
        final updatedDistance = current.distanceMeters + 3;
        final updatedScore = current.score + (10 * current.comboMultiplier);

        // Spawn Boss Encounter at 1,000m
        final bool shouldActivateBoss = updatedDistance >= 1000 && !current.isBossActive && current.bossHealth > 0.0;
        final bool qteActive = shouldActivateBoss || (current.isBossActive && current.distanceMeters % 150 == 0);

        emit(GameplayRunningState(
          current.copyWith(
            distanceMeters: updatedDistance,
            score: updatedScore,
            isBossActive: current.isBossActive || shouldActivateBoss,
            isBossQTEActive: qteActive,
          ),
        ));
      }
    });
  }

  void _onMoveLaneLeft(MoveLaneLeftEvent event, Emitter<GameplayState> emit) {
    if (state.stats.currentLane > -1) {
      emit(GameplayRunningState(
        state.stats.copyWith(currentLane: state.stats.currentLane - 1),
      ));
    }
  }

  void _onMoveLaneRight(MoveLaneRightEvent event, Emitter<GameplayState> emit) {
    if (state.stats.currentLane < 1) {
      emit(GameplayRunningState(
        state.stats.copyWith(currentLane: state.stats.currentLane + 1),
      ));
    }
  }

  void _onTriggerJump(TriggerJumpEvent event, Emitter<GameplayState> emit) {
    emit(GameplayRunningState(state.stats.copyWith(isJumping: true, isSliding: false)));
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!isClosed) {
        emit(GameplayRunningState(state.stats.copyWith(isJumping: false)));
      }
    });
  }

  void _onTriggerSlide(TriggerSlideEvent event, Emitter<GameplayState> emit) {
    emit(GameplayRunningState(state.stats.copyWith(isSliding: true, isJumping: false)));
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!isClosed) {
        emit(GameplayRunningState(state.stats.copyWith(isSliding: false)));
      }
    });
  }

  void _onTriggerDash(TriggerDashEvent event, Emitter<GameplayState> emit) {
    emit(GameplayRunningState(state.stats.copyWith(isDashing: true, speedKmh: 95)));
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!isClosed) {
        emit(GameplayRunningState(state.stats.copyWith(isDashing: false, speedKmh: 45)));
      }
    });
  }

  void _onTriggerWallRun(TriggerWallRunEvent event, Emitter<GameplayState> emit) {
    emit(GameplayRunningState(state.stats.copyWith(isWallRunning: true, speedKmh: 80)));
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!isClosed) {
        emit(GameplayRunningState(state.stats.copyWith(isWallRunning: false, speedKmh: 45)));
      }
    });
  }

  void _onTriggerZipline(TriggerZiplineEvent event, Emitter<GameplayState> emit) {
    emit(GameplayRunningState(state.stats.copyWith(isZiplining: true, speedKmh: 110)));
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!isClosed) {
        emit(GameplayRunningState(state.stats.copyWith(isZiplining: false, speedKmh: 45)));
      }
    });
  }

  void _onActivateMagnet(ActivateMagnetEvent event, Emitter<GameplayState> emit) {
    emit(GameplayRunningState(state.stats.copyWith(isMagnetActive: true)));
    Future.delayed(const Duration(seconds: 8), () {
      if (!isClosed) {
        emit(GameplayRunningState(state.stats.copyWith(isMagnetActive: false)));
      }
    });
  }

  void _onActivateShield(ActivateShieldEvent event, Emitter<GameplayState> emit) {
    emit(GameplayRunningState(state.stats.copyWith(isShieldActive: true)));
  }

  void _onCollectCrystal(CollectCrystalEvent event, Emitter<GameplayState> emit) {
    final int amount = state.stats.isMagnetActive ? 3 : 1;
    final int crystals = state.stats.crystalsCollected + amount;
    final int combo = (crystals % 5 == 0) ? state.stats.comboMultiplier + 1 : state.stats.comboMultiplier;
    emit(GameplayRunningState(state.stats.copyWith(
      crystalsCollected: crystals,
      comboMultiplier: combo,
      score: state.stats.score + (500 * amount),
    )));
  }

  void _onStrikeBossCore(StrikeBossCoreEvent event, Emitter<GameplayState> emit) {
    if (state.stats.isBossActive) {
      final double newBossHealth = (state.stats.bossHealth - 0.35).clamp(0.0, 1.0);
      final bool bossDefeated = newBossHealth <= 0.0;
      emit(GameplayRunningState(state.stats.copyWith(
        bossHealth: newBossHealth,
        isBossActive: !bossDefeated,
        isBossQTEActive: false,
        score: state.stats.score + 5000,
        isVictory: bossDefeated,
      )));
    }
  }

  void _onPassCheckpoint(PassCheckpointEvent event, Emitter<GameplayState> emit) {
    emit(GameplayRunningState(state.stats.copyWith(
      checkpointIndex: state.stats.checkpointIndex + 1,
      playerHealth: 1.0, // Auto-heal at checkpoint
      score: state.stats.score + 2000,
    )));
  }

  void _onPlayerHitObstacle(PlayerHitObstacleEvent event, Emitter<GameplayState> emit) {
    if (state.stats.isShieldActive) {
      // Shield absorbs collision
      emit(GameplayRunningState(state.stats.copyWith(isShieldActive: false)));
      return;
    }

    final double newHealth = (state.stats.playerHealth - 0.35).clamp(0.0, 1.0);
    if (newHealth <= 0.0) {
      _tickerTimer?.cancel();
      emit(GameplayOverState(state.stats.copyWith(
        playerHealth: 0.0,
        isGameOver: true,
      )));
    } else {
      emit(GameplayRunningState(state.stats.copyWith(
        playerHealth: newHealth,
        comboMultiplier: 1,
      )));
    }
  }

  void _onPauseGame(PauseGameEvent event, Emitter<GameplayState> emit) {
    emit(GameplayPausedState(state.stats));
  }

  void _onResumeGame(ResumeGameEvent event, Emitter<GameplayState> emit) {
    emit(GameplayRunningState(state.stats));
  }

  @override
  Future<void> close() {
    _tickerTimer?.cancel();
    return super.close();
  }
}
