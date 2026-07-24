import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class LoginTopHeader extends StatelessWidget {
  const LoginTopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: constraints.maxWidth > 0 ? constraints.maxWidth : MediaQuery.of(context).size.width - 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Group: Logo, Season Banner & Reward Badge
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [AppColors.neonBlue, AppColors.neonPurple]),
                        boxShadow: [
                          BoxShadow(color: AppColors.neonBlue, blurRadius: 10),
                        ],
                      ),
                      child: const Icon(Icons.bolt, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'SKYRUSH',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.5,
                        color: Colors.white,
                        shadows: [Shadow(color: AppColors.neonBlue, blurRadius: 15)],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.neonPink.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.neonPink.withValues(alpha: 0.8)),
                      ),
                      child: const Text(
                        'NEON ESCAPE',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                          color: AppColors.neonPink,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Season 09 Overdrive Badge
                    _buildHeaderBadge(
                      icon: Icons.local_fire_department,
                      iconColor: AppColors.neonOrange,
                      text: 'SEASON 09',
                      borderColor: AppColors.neonOrange,
                    ),

                    const SizedBox(width: 6),

                    // Daily Reward Claim Badge
                    _buildHeaderBadge(
                      icon: Icons.card_giftcard,
                      iconColor: AppColors.neonYellow,
                      text: 'REWARD (1)',
                      borderColor: AppColors.neonYellow,
                    ),
                  ],
                ),

                // Right Group: Ping, Avatar, Notifications, Settings
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Ping & Server Status
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.bgCard.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.borderNeon, width: 0.8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.wifi, color: Color(0xFF00FF66), size: 10),
                          SizedBox(width: 4),
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

                    const SizedBox(width: 6),

                    // Player Profile Avatar Preview Widget
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.bgCard.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.neonBlue, width: 0.8),
                      ),
                      child: const Row(
                        children: [
                          CircleAvatar(
                            radius: 9,
                            backgroundColor: AppColors.neonPurple,
                            child: Icon(Icons.person, size: 11, color: Colors.white),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'GHOST',
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

                    const SizedBox(width: 6),

                    // Notifications Icon (with badge count 3)
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _buildIconButton(Icons.notifications_none, null),
                        Positioned(
                          right: -1,
                          top: -1,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: AppColors.neonRed,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              '3',
                              style: TextStyle(
                                fontSize: 6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 4),
                    _buildIconButton(Icons.language, 'EN'),
                    const SizedBox(width: 4),
                    _buildIconButton(Icons.volume_up, null),
                    const SizedBox(width: 4),
                    _buildIconButton(Icons.settings, null),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderBadge({
    required IconData icon,
    required Color iconColor,
    required String text,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor.withValues(alpha: 0.7)),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 10),
          const SizedBox(width: 3),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Orbitron',
              fontSize: 8,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
              color: borderColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String? label) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.bgCard.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.borderNeon, width: 0.8),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.neonBlue, size: 12),
          if (label != null) ...[
            const SizedBox(width: 3),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 8,
                fontWeight: FontWeight.w800,
                color: AppColors.textMain,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
