import 'package:equatable/equatable.dart';

class GameStatsEntity extends Equatable {
  final int distanceMeters;
  final int speedKmh;
  final int comboMultiplier;
  final int crystalsCollected;
  final int score;
  final double playerHealth;
  final double playerShield;
  final double playerEnergy;
  final int currentLane; // -1: Left, 0: Center, 1: Right
  final bool isSliding;
  final bool isJumping;
  final bool isDashing;
  final bool isWallRunning;
  final bool isZiplining;
  final bool isMagnetActive;
  final bool isShieldActive;
  final bool isDoubleScoreActive;
  final double bossHealth;
  final bool isBossActive;
  final bool isBossQTEActive;
  final int checkpointIndex;
  final bool isGameOver;
  final bool isVictory;

  const GameStatsEntity({
    required this.distanceMeters,
    required this.speedKmh,
    required this.comboMultiplier,
    required this.crystalsCollected,
    required this.score,
    required this.playerHealth,
    required this.playerShield,
    required this.playerEnergy,
    required this.currentLane,
    required this.isSliding,
    required this.isJumping,
    required this.isDashing,
    required this.isWallRunning,
    required this.isZiplining,
    required this.isMagnetActive,
    required this.isShieldActive,
    required this.isDoubleScoreActive,
    required this.bossHealth,
    required this.isBossActive,
    required this.isBossQTEActive,
    required this.checkpointIndex,
    required this.isGameOver,
    required this.isVictory,
  });

  GameStatsEntity copyWith({
    int? distanceMeters,
    int? speedKmh,
    int? comboMultiplier,
    int? crystalsCollected,
    int? score,
    double? playerHealth,
    double? playerShield,
    double? playerEnergy,
    int? currentLane,
    bool? isSliding,
    bool? isJumping,
    bool? isDashing,
    bool? isWallRunning,
    bool? isZiplining,
    bool? isMagnetActive,
    bool? isShieldActive,
    bool? isDoubleScoreActive,
    double? bossHealth,
    bool? isBossActive,
    bool? isBossQTEActive,
    int? checkpointIndex,
    bool? isGameOver,
    bool? isVictory,
  }) {
    return GameStatsEntity(
      distanceMeters: distanceMeters ?? this.distanceMeters,
      speedKmh: speedKmh ?? this.speedKmh,
      comboMultiplier: comboMultiplier ?? this.comboMultiplier,
      crystalsCollected: crystalsCollected ?? this.crystalsCollected,
      score: score ?? this.score,
      playerHealth: playerHealth ?? this.playerHealth,
      playerShield: playerShield ?? this.playerShield,
      playerEnergy: playerEnergy ?? this.playerEnergy,
      currentLane: currentLane ?? this.currentLane,
      isSliding: isSliding ?? this.isSliding,
      isJumping: isJumping ?? this.isJumping,
      isDashing: isDashing ?? this.isDashing,
      isWallRunning: isWallRunning ?? this.isWallRunning,
      isZiplining: isZiplining ?? this.isZiplining,
      isMagnetActive: isMagnetActive ?? this.isMagnetActive,
      isShieldActive: isShieldActive ?? this.isShieldActive,
      isDoubleScoreActive: isDoubleScoreActive ?? this.isDoubleScoreActive,
      bossHealth: bossHealth ?? this.bossHealth,
      isBossActive: isBossActive ?? this.isBossActive,
      isBossQTEActive: isBossQTEActive ?? this.isBossQTEActive,
      checkpointIndex: checkpointIndex ?? this.checkpointIndex,
      isGameOver: isGameOver ?? this.isGameOver,
      isVictory: isVictory ?? this.isVictory,
    );
  }

  @override
  List<Object?> get props => [
        distanceMeters,
        speedKmh,
        comboMultiplier,
        crystalsCollected,
        score,
        playerHealth,
        playerShield,
        playerEnergy,
        currentLane,
        isSliding,
        isJumping,
        isDashing,
        isWallRunning,
        isZiplining,
        isMagnetActive,
        isShieldActive,
        isDoubleScoreActive,
        bossHealth,
        isBossActive,
        isBossQTEActive,
        checkpointIndex,
        isGameOver,
        isVictory,
      ];
}
