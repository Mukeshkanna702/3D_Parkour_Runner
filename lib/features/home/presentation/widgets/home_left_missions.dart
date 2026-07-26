import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HomeLeftMissions extends StatelessWidget {
  const HomeLeftMissions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.bgCard.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderNeon, width: 0.8),
        boxShadow: [
          BoxShadow(color: AppColors.neonBlue.withValues(alpha: 0.15), blurRadius: 15),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Title
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.assignment, color: AppColors.neonBlue, size: 12),
                  SizedBox(width: 4),
                  Text(
                    'DAILY MISSIONS',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                '2/3',
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: AppColors.neonBlue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Mission 1
          _buildMissionTile(
            title: 'PARKOUR 5,000M',
            progress: 3400 / 5000,
            progressText: '3.4K / 5K',
            rewardText: '+200 💎',
            rewardColor: AppColors.neonBlue,
          ),

          const SizedBox(height: 6),

          // Mission 2
          _buildMissionTile(
            title: 'SLAY 10 DRONES',
            progress: 8 / 10,
            progressText: '8 / 10',
            rewardText: '+500 🪙',
            rewardColor: AppColors.neonYellow,
          ),

          const SizedBox(height: 6),

          // Mission 3: Weekly Challenge
          _buildMissionTile(
            title: '5 SPEED RUNS',
            progress: 4 / 5,
            progressText: '4 / 5',
            rewardText: '+1,000 XP',
            rewardColor: AppColors.neonPink,
          ),

          const SizedBox(height: 8),

          // Quick Claim Button
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🎁 REWARDS CLAIMED! +200 CRYSTALS & +500 COINS ADDED.'),
                  backgroundColor: AppColors.neonBlue,
                ),
              );
            },
            child: Container(
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.neonBlue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.neonBlue, width: 0.8),
              ),
              child: const Text(
                'CLAIM ALL REWARDS',
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                  color: AppColors.neonBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionTile({
    required String title,
    required double progress,
    required String progressText,
    required String rewardText,
    required Color rewardColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 8,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            Text(
              rewardText,
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 7,
                fontWeight: FontWeight.w900,
                color: rewardColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  backgroundColor: Colors.black.withValues(alpha: 0.5),
                  color: AppColors.neonBlue,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              progressText,
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 7,
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
