import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/entities/game_stats_entity.dart';

class Parkour3DCharacterPainter extends CustomPainter {
  final double animValue;
  final GameStatsEntity stats;

  Parkour3DCharacterPainter({required this.animValue, required this.stats});

  @override
  void paint(Canvas canvas, Size size) {
    // Determine player X position based on current lane (-1: Left, 0: Center, 1: Right)
    final double laneOffset = stats.currentLane * (size.width * 0.22);
    final double centerX = (size.width * 0.5) + laneOffset;

    // Y position & jump/slide physics height adjustments
    final double jumpY = stats.isJumping
        ? -80.0
        : stats.isZiplining
            ? -110.0
            : 0.0;
    final double slideScale = stats.isSliding ? 0.5 : 1.0;
    final double runBobbing = sin(animValue * pi * 2) * 8.0;

    final double headY = size.height * 0.65 + jumpY + runBobbing;
    final double hipY = headY + (45.0 * slideScale);
    final double feetY = headY + (90.0 * slideScale);

    // 1. Dash Energy Speed Trail
    if (stats.isDashing || stats.isWallRunning) {
      final trailPaint = Paint()
        ..color = (stats.isDashing ? const Color(0xFFFF007F) : const Color(0xFFFF9900)).withValues(alpha: 0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
      canvas.drawCircle(Offset(centerX, headY + 30), 45, trailPaint);
    }

    // 2. Shield Bubble (if active)
    if (stats.isShieldActive) {
      final shieldPaint = Paint()
        ..color = const Color(0xFF00FF66).withValues(alpha: 0.25)
        ..style = PaintingStyle.fill;
      final shieldBorder = Paint()
        ..color = const Color(0xFF00FF66)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawCircle(Offset(centerX, headY + 35), 55, shieldPaint);
      canvas.drawCircle(Offset(centerX, headY + 35), 55, shieldBorder);
    }

    // 3. Cybernetic Armor Body Lines
    final suitPaint = Paint()
      ..color = const Color(0xFF0F172A)
      ..style = PaintingStyle.fill;

    final neonCircuitPaint = Paint()
      ..color = const Color(0xFF00F0FF)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final coreGlowPaint = Paint()
      ..color = const Color(0xFF00F0FF)
      ..style = PaintingStyle.fill;

    // Head / Helmet
    canvas.drawCircle(Offset(centerX, headY), 14, suitPaint);
    canvas.drawCircle(Offset(centerX, headY), 14, neonCircuitPaint);
    // Helmet Visor
    canvas.drawRect(Rect.fromLTWH(centerX - 8, headY - 3, 16, 6), Paint()..color = const Color(0xFF00F0FF));

    // Torso / Chest Armor
    final torsoPath = Path()
      ..moveTo(centerX - 16, headY + 14)
      ..lineTo(centerX + 16, headY + 14)
      ..lineTo(centerX + 12, hipY)
      ..lineTo(centerX - 12, hipY)
      ..close();

    canvas.drawPath(torsoPath, suitPaint);
    canvas.drawPath(torsoPath, neonCircuitPaint);

    // Glowing Arc Core Reactor in Chest
    canvas.drawCircle(Offset(centerX, headY + 26), 5, coreGlowPaint);

    // Legs / Anti-Gravity Boots
    final legPaint = Paint()
      ..color = const Color(0xFF00F0FF)
      ..strokeWidth = 4.0;

    final legAnimLeft = sin(animValue * pi * 2) * 15.0;
    final legAnimRight = -legAnimLeft;

    canvas.drawLine(Offset(centerX - 8, hipY), Offset(centerX - 12 + legAnimLeft, feetY), legPaint);
    canvas.drawLine(Offset(centerX + 8, hipY), Offset(centerX + 12 + legAnimRight, feetY), legPaint);

    // Anti-Gravity Boot Glow Sparks
    canvas.drawCircle(Offset(centerX - 12 + legAnimLeft, feetY), 6, coreGlowPaint);
    canvas.drawCircle(Offset(centerX + 12 + legAnimRight, feetY), 6, coreGlowPaint);
  }

  @override
  bool shouldRepaint(covariant Parkour3DCharacterPainter oldDelegate) {
    return oldDelegate.animValue != animValue || oldDelegate.stats != stats;
  }
}
