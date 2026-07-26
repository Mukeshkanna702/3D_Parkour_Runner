import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../matchmaking/presentation/widgets/matchmaking_flow_dialog.dart';

class HomePlayButton extends StatefulWidget {
  const HomePlayButton({super.key});

  @override
  State<HomePlayButton> createState() => _HomePlayButtonState();
}

class _HomePlayButtonState extends State<HomePlayButton> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Mode Selector Badge
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const MatchmakingFlowDialog(),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.6), width: 0.8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.workspace_premium, color: AppColors.neonYellow, size: 10),
                SizedBox(width: 4),
                Text(
                  'RANKED // 3D PARKOUR RUNNER',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: AppColors.neonBlue,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_drop_down, color: AppColors.neonBlue, size: 12),
              ],
            ),
          ),
        ),

        const SizedBox(height: 4),

        // Glowing AAA PLAY Button
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            final double glowSpread = 2.0 + (_pulseController.value * 6.0);

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const MatchmakingFlowDialog(),
                );
              },
              child: Container(
                height: 42,
                width: 220,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.neonBlue, Color(0xFF00B2FF)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonBlue.withValues(alpha: 0.6),
                      blurRadius: 20,
                      spreadRadius: glowSpread,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow_rounded, color: AppColors.bgPrimary, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'START MATCH',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.5,
                        color: AppColors.bgPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
