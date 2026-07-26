import 'dart:math';
import 'package:flutter/material.dart';

class BossDragonPainter extends CustomPainter {
  final double animValue;
  final double bossHealth;

  BossDragonPainter({required this.animValue, required this.bossHealth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.7, size.height * 0.35);
    final wingSpan = sin(animValue * pi * 2) * 20;

    final paintDragon = Paint()
      ..color = const Color(0xFFFF1E42)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final glowPaint = Paint()
      ..color = const Color(0xFFFF1E42).withValues(alpha: 0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    // 1. Dragon Core Glow Aura
    canvas.drawCircle(center, 40 + wingSpan, glowPaint);

    // 2. Dragon Mechanical Wings
    final wingPathLeft = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(center.dx - 120, center.dy - 60 - wingSpan)
      ..lineTo(center.dx - 70, center.dy + 20);

    final wingPathRight = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(center.dx + 120, center.dy - 60 - wingSpan)
      ..lineTo(center.dx + 70, center.dy + 20);

    canvas.drawPath(wingPathLeft, paintDragon);
    canvas.drawPath(wingPathRight, paintDragon);

    // 3. Dragon Plasma Core
    canvas.drawCircle(center, 14, Paint()..color = const Color(0xFFFFD700));
  }

  @override
  bool shouldRepaint(covariant BossDragonPainter oldDelegate) {
    return oldDelegate.animValue != animValue || oldDelegate.bossHealth != bossHealth;
  }
}
