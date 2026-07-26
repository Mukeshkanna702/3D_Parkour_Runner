import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../login/presentation/widgets/character_platform_painter.dart';

class HomeCenterCharacter extends StatefulWidget {
  const HomeCenterCharacter({super.key});

  @override
  State<HomeCenterCharacter> createState() => _HomeCenterCharacterState();
}

class _HomeCenterCharacterState extends State<HomeCenterCharacter> with TickerProviderStateMixin {
  late AnimationController _platformController;
  late AnimationController _breathingController;

  @override
  void initState() {
    super.initState();
    _platformController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _platformController.dispose();
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 1. 60 FPS Rotating Holographic Platform Base
        Positioned(
          bottom: 25,
          left: 40,
          right: 40,
          height: 120,
          child: AnimatedBuilder(
            animation: _platformController,
            builder: (context, child) {
              return CustomPaint(
                painter: CharacterPlatformPainter(
                  animationValue: _platformController.value,
                ),
              );
            },
          ),
        ),

        // 2. Full-Body Hero Character Render with Idle Breathing
        AnimatedBuilder(
          animation: _breathingController,
          builder: (context, child) {
            final double breathingY = sin(_breathingController.value * pi) * 6.0;

            return Transform.translate(
              offset: Offset(0, breathingY),
              child: Image.asset(
                AppConstants.imgHeroFullBodyLogin,
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            );
          },
        ),

        // 3. Interactive Character Action Buttons (Left side overlay)
        Positioned(
          left: 10,
          bottom: 50,
          child: Column(
            children: [
              _buildActionButton(Icons.emoji_emotions, 'EMOTES', () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('💃 EMOTE: GHOST PERFORMED CYBER DANCE!'), backgroundColor: AppColors.neonPurple),
                );
              }),
              const SizedBox(height: 8),
              _buildActionButton(Icons.checkroom, 'SKINS', () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('👕 SKINS: NANO-V4 CARBON SKIN EQUIPPED.'), backgroundColor: AppColors.neonBlue),
                );
              }),
              const SizedBox(height: 8),
              _buildActionButton(Icons.search, 'INSPECT', () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('🔍 INSPECTING GHOST // POWER 94%'), backgroundColor: AppColors.neonPink),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.bgCard.withValues(alpha: 0.8),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.6), width: 1.0),
          boxShadow: [
            BoxShadow(color: AppColors.neonBlue.withValues(alpha: 0.25), blurRadius: 10),
          ],
        ),
        child: Icon(icon, color: AppColors.neonBlue, size: 16),
      ),
    );
  }
}
