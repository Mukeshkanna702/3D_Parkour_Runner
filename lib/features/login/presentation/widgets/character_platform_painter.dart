import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CharacterPlatformPainter extends CustomPainter {
  final double animationValue;

  CharacterPlatformPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radiusX = size.width / 2 - 10;
    final radiusY = size.height / 3.2;

    // 1. Floor Reflection & Outer Holographic Glow Oval
    final glowPaint = Paint()
      ..color = AppColors.neonBlue.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    canvas.drawOval(
      Rect.fromCenter(center: center, width: size.width, height: radiusY * 2.2),
      glowPaint,
    );

    // 2. Outer Rotating Cyan Hologram Ring
    final outerRingPaint = Paint()
      ..shader = SweepGradient(
        colors: const [
          AppColors.neonBlue,
          AppColors.neonPurple,
          Colors.transparent,
          AppColors.neonBlue,
        ],
        transform: GradientRotation(animationValue * pi * 2),
      ).createShader(Rect.fromCenter(center: center, width: radiusX * 2, height: radiusY * 2))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawOval(
      Rect.fromCenter(center: center, width: radiusX * 2, height: radiusY * 2),
      outerRingPaint,
    );

    // 3. Inner Counter-Rotating Pink Ring Arc
    final innerRingPaint = Paint()
      ..shader = SweepGradient(
        colors: const [
          AppColors.neonPink,
          Colors.transparent,
          AppColors.neonPink,
        ],
        transform: GradientRotation(-animationValue * pi * 2),
      ).createShader(Rect.fromCenter(center: center, width: radiusX * 1.6, height: radiusY * 1.6))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawOval(
      Rect.fromCenter(center: center, width: radiusX * 1.6, height: radiusY * 1.6),
      innerRingPaint,
    );

    // 4. Energy Node Dots along the platform rim
    final nodePaint = Paint()
      ..color = AppColors.neonBlue
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 8; i++) {
      final angle = (i * (pi / 4)) + (animationValue * pi * 2);
      final dx = center.dx + (cos(angle) * radiusX);
      final dy = center.dy + (sin(angle) * radiusY);

      canvas.drawCircle(Offset(dx, dy), 3.0, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
