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
        width: MediaQuery.of(context).size.width - 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Group: Essential Links
            Row(
              children: [
                _buildLink('TERMS OF SERVICE'),
                const SizedBox(width: 12),
                _buildLink('PRIVACY POLICY'),
                const SizedBox(width: 12),
                _buildLink('CUSTOMER SUPPORT'),
              ],
            ),

            // Right Group: Version & Copyright
            Text(
              'v2.0.99-AAA  |  © 2099 SKYRUSH INTERACTIVE',
              style: TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 8,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(String label) {
    return InkWell(
      onTap: () {},
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 8,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: AppColors.neonBlue,
        ),
      ),
    );
  }
}
