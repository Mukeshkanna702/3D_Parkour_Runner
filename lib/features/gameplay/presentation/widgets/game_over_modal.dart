import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/game_stats_entity.dart';

class GameOverModal extends StatelessWidget {
  final GameStatsEntity stats;

  const GameOverModal({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 580),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.bgSecondary.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.neonPink, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonPink.withValues(alpha: 0.35),
              blurRadius: 35,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Status Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.neonPink,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'MISSION SUMMARY',
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              stats.isVictory ? 'MISSION ACCOMPLISHED!' : 'MISSION EXFIL FAILED',
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.5,
                color: stats.isVictory ? AppColors.neonGreen : AppColors.neonRed,
                shadows: [Shadow(color: stats.isVictory ? AppColors.neonGreen : AppColors.neonRed, blurRadius: 20)],
              ),
            ),

            const SizedBox(height: 16),

            // Summary Telemetry Grid
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.borderNeon, width: 0.8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryStat('FINAL SCORE', '${stats.score}', AppColors.neonBlue),
                      _buildSummaryStat('DISTANCE', '${stats.distanceMeters}m', AppColors.neonYellow),
                      _buildSummaryStat('CRYSTALS', '${stats.crystalsCollected}', AppColors.neonGreen),
                      _buildSummaryStat('MAX COMBO', 'x${stats.comboMultiplier}', AppColors.neonOrange),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: AppColors.borderNeon, height: 1),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'REWARD: +1,500 XP  |  +120 CRYSTALS',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: AppColors.neonBlue,
                        ),
                      ),
                      Text(
                        'LEVEL 42 (85%)',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    context.go(AppRoutes.home);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.neonBlue),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'RETURN TO LOBBY',
                    style: TextStyle(fontFamily: 'Orbitron', fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.neonBlue),
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    context.go(AppRoutes.loading);
                  },
                  icon: const Icon(Icons.refresh, color: AppColors.bgPrimary),
                  label: const Text(
                    'PLAY AGAIN',
                    style: TextStyle(fontFamily: 'Orbitron', fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.bgPrimary),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonBlue,
                    elevation: 10,
                    shadowColor: AppColors.neonBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontSize: 8,
            fontWeight: FontWeight.w700,
            color: AppColors.textMuted.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
