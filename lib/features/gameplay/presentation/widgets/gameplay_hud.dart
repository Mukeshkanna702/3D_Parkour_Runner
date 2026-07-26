import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/game_stats_entity.dart';
import '../bloc/gameplay_bloc.dart';
import '../bloc/gameplay_event.dart';

class GameplayHUD extends StatelessWidget {
  final GameStatsEntity stats;

  const GameplayHUD({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Stack(
          children: [
            // 1. Top HUD Telemetry Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Left: Objective & Checkpoint
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.borderNeon, width: 0.8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.flag, color: AppColors.neonBlue, size: 12),
                          SizedBox(width: 4),
                          Text(
                            'OBJECTIVE: EXTRACTION POINT',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'CHECKPOINT ${stats.checkpointIndex} / 5',
                        style: const TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: AppColors.neonPink,
                        ),
                      ),
                    ],
                  ),
                ),

                // Top Center: Boss Health Bar or Telemetry Meters
                if (stats.isBossActive)
                  Container(
                    width: 240,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.neonRed, width: 1.2),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '🐉 MECHANICAL CYBER DRAGON',
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                color: AppColors.neonRed,
                              ),
                            ),
                            Text(
                              'BOSS ENCOUNTER',
                              style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 7,
                                color: AppColors.neonYellow,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: stats.bossHealth,
                            minHeight: 6,
                            backgroundColor: Colors.black,
                            color: AppColors.neonRed,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.neonBlue, width: 1.0),
                      boxShadow: [
                        BoxShadow(color: AppColors.neonBlue.withValues(alpha: 0.3), blurRadius: 10),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${stats.distanceMeters}m',
                          style: const TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${stats.speedKmh} km/h',
                          style: const TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.neonBlue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'COMBO x${stats.comboMultiplier}',
                          style: const TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: AppColors.neonOrange,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Top Right: Health, Shield & Pause Menu Button
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.bgCard.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.borderNeon, width: 0.8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.favorite, color: AppColors.neonRed, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            '${(stats.playerHealth * 100).toInt()}%',
                            style: const TextStyle(fontFamily: 'Orbitron', fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.diamond_outlined, color: AppColors.neonBlue, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            '${stats.crystalsCollected}',
                            style: const TextStyle(fontFamily: 'Orbitron', fontSize: 9, color: AppColors.neonBlue, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.pause_circle_filled, color: AppColors.neonBlue, size: 26),
                      onPressed: () {
                        context.read<GameplayBloc>().add(PauseGameEvent());
                      },
                    ),
                  ],
                ),
              ],
            ),

            // 2. Boss QTE Katana Strike Button (if QTE Active)
            if (stats.isBossQTEActive)
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<GameplayBloc>().add(StrikeBossCoreEvent());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🗡️ KATANA STRIKE DEALT 5,000 CRITICAL DAMAGE TO DRAGON!'),
                        backgroundColor: AppColors.neonPink,
                        duration: Duration(milliseconds: 800),
                      ),
                    );
                  },
                  icon: const Icon(Icons.flash_on, color: Colors.white, size: 20),
                  label: const Text(
                    'STRIKE DRAGON CORE!',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonRed,
                    elevation: 15,
                    shadowColor: AppColors.neonRed,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ),

            // 3. Bottom Left Controls: Lane Switching & Power-ups
            Positioned(
              left: 10,
              bottom: 10,
              child: Row(
                children: [
                  _buildControlButton('LEFT', Icons.arrow_back, AppColors.neonBlue, () {
                    context.read<GameplayBloc>().add(MoveLaneLeftEvent());
                  }),
                  const SizedBox(width: 6),
                  _buildControlButton('RIGHT', Icons.arrow_forward, AppColors.neonBlue, () {
                    context.read<GameplayBloc>().add(MoveLaneRightEvent());
                  }),
                  const SizedBox(width: 6),
                  _buildControlButton('MAGNET', Icons.explore, AppColors.neonYellow, () {
                    context.read<GameplayBloc>().add(ActivateMagnetEvent());
                  }),
                  const SizedBox(width: 6),
                  _buildControlButton('SHIELD', Icons.security, AppColors.neonGreen, () {
                    context.read<GameplayBloc>().add(ActivateShieldEvent());
                  }),
                ],
              ),
            ),

            // 4. Bottom Right Controls: Jump, Slide, Wall-Run, Zipline
            Positioned(
              right: 10,
              bottom: 10,
              child: Row(
                children: [
                  _buildControlButton('WALL-RUN', Icons.directions_run, AppColors.neonOrange, () {
                    context.read<GameplayBloc>().add(TriggerWallRunEvent());
                  }),
                  const SizedBox(width: 6),
                  _buildControlButton('ZIPLINE', Icons.cable, AppColors.neonYellow, () {
                    context.read<GameplayBloc>().add(TriggerZiplineEvent());
                  }),
                  const SizedBox(width: 6),
                  _buildControlButton('SLIDE', Icons.south, AppColors.neonPurple, () {
                    context.read<GameplayBloc>().add(TriggerSlideEvent());
                  }),
                  const SizedBox(width: 6),
                  _buildControlButton('JUMP', Icons.north, AppColors.neonBlue, () {
                    context.read<GameplayBloc>().add(TriggerJumpEvent());
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.3),
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 1.2),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 8),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 14),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 6,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
