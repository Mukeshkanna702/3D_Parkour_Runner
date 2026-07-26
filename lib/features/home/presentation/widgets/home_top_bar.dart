import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/lobby_state_entity.dart';

class HomeTopBar extends StatelessWidget {
  final LobbyStateEntity lobbyData;

  const HomeTopBar({super.key, required this.lobbyData});

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
            // Left Group: Player Avatar, Level, XP Bar & Currencies
            Row(
              children: [
                // Player Avatar Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.neonBlue, width: 1.0),
                    boxShadow: [
                      BoxShadow(color: AppColors.neonBlue.withValues(alpha: 0.3), blurRadius: 8),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 9,
                        backgroundColor: AppColors.neonPurple,
                        child: Icon(Icons.person, size: 11, color: Colors.white),
                      ),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LVL ${lobbyData.playerLevel}  |  ${lobbyData.playerName}',
                            style: const TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 8,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 1),
                          SizedBox(
                            width: 50,
                            height: 2,
                            child: LinearProgressIndicator(
                              value: lobbyData.xpProgress,
                              backgroundColor: Colors.black,
                              color: AppColors.neonBlue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Currency 1: Neon Crystals
                _buildCurrencyCounter(Icons.diamond_outlined, AppColors.neonBlue, '${lobbyData.neonCrystals}'),

                const SizedBox(width: 5),

                // Currency 2: Cyber Coins
                _buildCurrencyCounter(Icons.monetization_on_outlined, AppColors.neonYellow, '${lobbyData.cyberCoins}'),

                const SizedBox(width: 5),

                // Currency 3: Energy Points
                _buildCurrencyCounter(Icons.bolt, AppColors.neonGreen, '${lobbyData.energyPoints}/100'),
              ],
            ),

            // Right Group: Friends, Mail, Notifications, Ping, Settings
            Row(
              children: [
                // Online Friends Indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.borderNeon, width: 0.8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.group, color: AppColors.neonBlue, size: 10),
                      const SizedBox(width: 4),
                      Text(
                        'FRIENDS (${lobbyData.onlineFriendsCount})',
                        style: const TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          color: AppColors.neonBlue,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 5),

                // Ping & FPS Counter
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

                // Mail Badge
                _buildBadgeIcon(Icons.mail_outline, '${lobbyData.unreadMailCount}', AppColors.neonBlue),

                const SizedBox(width: 3),

                // Notifications Badge
                _buildBadgeIcon(Icons.notifications_none, '${lobbyData.unreadNotificationsCount}', AppColors.neonRed),

                const SizedBox(width: 3),
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

  Widget _buildCurrencyCounter(IconData icon, Color color, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.7)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 10),
          const SizedBox(width: 3),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Orbitron',
              fontSize: 8,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeIcon(IconData icon, String count, Color badgeColor) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildIconButton(icon),
        Positioned(
          right: -1,
          top: -1,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: badgeColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              count,
              style: const TextStyle(
                fontSize: 5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
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
      child: Icon(icon, color: AppColors.neonBlue, size: 10),
    );
  }
}
