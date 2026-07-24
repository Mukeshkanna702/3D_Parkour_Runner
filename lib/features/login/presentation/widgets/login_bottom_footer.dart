import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class LoginBottomFooter extends StatelessWidget {
  const LoginBottomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Group: Holographic Navigation Links
            Row(
              children: [
                _buildHolographicIcon(Icons.newspaper, 'NEWS'),
                const SizedBox(width: 14),
                _buildHolographicIcon(Icons.headset_mic, 'SUPPORT'),
                const SizedBox(width: 14),
                _buildHolographicIcon(Icons.gavel, 'TERMS'),
                const SizedBox(width: 14),
                _buildHolographicIcon(Icons.lock, 'PRIVACY'),
                const SizedBox(width: 14),
                _buildHolographicIcon(Icons.groups, 'COMMUNITY'),
              ],
            ),

            // Right Group: Social Media Glowing Icons & Copyright
            Row(
              children: [
                // Social Media Badges
                _buildSocialIcon('DISCORD', AppColors.neonPurple),
                const SizedBox(width: 8),
                _buildSocialIcon('INSTAGRAM', AppColors.neonPink),
                const SizedBox(width: 8),
                _buildSocialIcon('X / TWITTER', AppColors.neonBlue),

                const SizedBox(width: 15),

                Text(
                  'v2.0.99-AAA  |  © 2099 SKYRUSH INTERACTIVE',
                  style: TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMuted.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHolographicIcon(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, color: AppColors.neonBlue, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: AppColors.neonBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String label, Color glowColor) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: glowColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: glowColor.withValues(alpha: 0.6), width: 0.8),
          boxShadow: [
            BoxShadow(color: glowColor.withValues(alpha: 0.3), blurRadius: 8),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 8,
            fontWeight: FontWeight.w900,
            color: glowColor,
          ),
        ),
      ),
    );
  }
}
