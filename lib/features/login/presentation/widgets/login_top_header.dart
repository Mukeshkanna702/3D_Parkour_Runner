import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class LoginTopHeader extends StatelessWidget {
  const LoginTopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Group: Logo & Season Badge
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [AppColors.neonBlue, AppColors.neonPurple]),
                    boxShadow: [
                      BoxShadow(color: AppColors.neonBlue, blurRadius: 8),
                    ],
                  ),
                  child: const Icon(Icons.bolt, color: Colors.white, size: 14),
                ),
                const SizedBox(width: 5),
                const Text(
                  'SKYRUSH',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                    color: Colors.white,
                    shadows: [Shadow(color: AppColors.neonBlue, blurRadius: 12)],
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.neonPink.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: AppColors.neonPink.withValues(alpha: 0.8)),
                  ),
                  child: const Text(
                    'NEON ESCAPE',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 7,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                      color: AppColors.neonPink,
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Season 09 Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: AppColors.neonOrange.withValues(alpha: 0.7)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.local_fire_department, color: AppColors.neonOrange, size: 9),
                      SizedBox(width: 2),
                      Text(
                        'SEASON 09',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 7,
                          fontWeight: FontWeight.w800,
                          color: AppColors.neonOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Right Group: Ping, Avatar, Settings
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ping Status
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.borderNeon, width: 0.8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.wifi, color: Color(0xFF00FF66), size: 9),
                      SizedBox(width: 3),
                      Text(
                        '14ms',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF00FF66),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 4),

                // Player Profile Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.neonBlue, width: 0.8),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: AppColors.neonPurple,
                        child: Icon(Icons.person, size: 10, color: Colors.white),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'LVL 42',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 4),
                _buildIconButton(Icons.volume_up),
                const SizedBox(width: 3),
                _buildIconButton(Icons.settings),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.bgCard.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.borderNeon, width: 0.8),
      ),
      child: Icon(icon, color: AppColors.neonBlue, size: 11),
    );
  }
}
