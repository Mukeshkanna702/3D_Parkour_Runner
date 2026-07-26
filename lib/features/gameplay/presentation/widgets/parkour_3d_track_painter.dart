import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/entities/game_stats_entity.dart';

class Parkour3DTrackPainter extends CustomPainter {
  final double animValue;
  final GameStatsEntity stats;

  Parkour3DTrackPainter({required this.animValue, required this.stats});

  @override
  void paint(Canvas canvas, Size size) {
    final horizonY = size.height * 0.35;
    final bottomY = size.height;

    // 1. Cyberpunk Megacity Background Gradient & Stars
    final bgGradient = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF03050B),
          Color(0xFF060913),
          Color(0xFF0D1427),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgGradient);

    // 2. Perspective 3D Track Mag-Rails (-1: Left, 0: Center, 1: Right)
    final double trackWidthBottom = size.width * 0.7;
    final double trackWidthTop = size.width * 0.08;

    final double leftBottomX = (size.width - trackWidthBottom) / 2;
    final double rightBottomX = leftBottomX + trackWidthBottom;
    final double leftTopX = (size.width - trackWidthTop) / 2;
    final double rightTopX = leftTopX + trackWidthTop;

    // Main 3D Track Floor
    final trackPath = Path()
      ..moveTo(leftTopX, horizonY)
      ..lineTo(rightTopX, horizonY)
      ..lineTo(rightBottomX, bottomY)
      ..lineTo(leftBottomX, bottomY)
      ..close();

    final trackPaint = Paint()
      ..color = const Color(0xFF0F172A).withValues(alpha: 0.95);
    canvas.drawPath(trackPath, trackPaint);

    // 3. Glowing Neon Mag-Rail Lane Dividers
    final railPaint = Paint()
      ..color = const Color(0xFF00F0FF)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final glowRailPaint = Paint()
      ..color = const Color(0xFF00F0FF).withValues(alpha: 0.4)
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Render 4 lane lines (Left boundary, Lane 1/2, Lane 2/3, Right boundary)
    for (int i = 0; i <= 3; i++) {
      final double fraction = i / 3.0;
      final double topX = leftTopX + (rightTopX - leftTopX) * fraction;
      final double bottomX = leftBottomX + (rightBottomX - leftBottomX) * fraction;

      canvas.drawLine(Offset(topX, horizonY), Offset(bottomX, bottomY), glowRailPaint);
      canvas.drawLine(Offset(topX, horizonY), Offset(bottomX, bottomY), railPaint);
    }

    // 4. Moving Horizontal Perspective Speed Lines (Simulates 60 FPS forward running)
    final gridPaint = Paint()
      ..color = const Color(0xFF00F0FF).withValues(alpha: 0.35)
      ..strokeWidth = 1.2;

    final double speedScroll = (animValue * 1.0) % 1.0;
    for (int j = 0; j < 12; j++) {
      final double lineProgress = (j / 12.0 + speedScroll) % 1.0;
      final double y = horizonY + (bottomY - horizonY) * pow(lineProgress, 2.5);

      final double startX = leftTopX + (leftBottomX - leftTopX) * lineProgress;
      final double endX = rightTopX + (rightBottomX - rightTopX) * lineProgress;

      canvas.drawLine(Offset(startX, y), Offset(endX, y), gridPaint);
    }

    // 5. 3D Floating Collectible Crystals moving down the track
    final crystalPaint = Paint()
      ..color = stats.isMagnetActive ? const Color(0xFFFFD700) : const Color(0xFF00F0FF)
      ..style = PaintingStyle.fill;

    for (int k = 0; k < 3; k++) {
      final double progress = ((animValue + k * 0.33) % 1.0);
      if (progress > 0.15) {
        final double cy = horizonY + (bottomY - horizonY) * pow(progress, 2.0);
        final int targetLane = (k % 3) - 1;
        final double laneFrac = (targetLane + 1.5) / 3.0;

        final double cx = (leftTopX + (leftBottomX - leftTopX) * progress) +
            ((rightTopX - leftTopX) + (rightBottomX - rightTopX - (rightTopX - leftTopX)) * progress) * laneFrac * 0.5;

        final double sizeRadius = 6.0 + progress * 14.0;

        final crystalPath = Path()
          ..moveTo(cx, cy - sizeRadius)
          ..lineTo(cx + sizeRadius * 0.7, cy)
          ..lineTo(cx, cy + sizeRadius)
          ..lineTo(cx - sizeRadius * 0.7, cy)
          ..close();

        canvas.drawPath(crystalPath, crystalPaint);
      }
    }

    // 6. 3D Obstacle Barriers (Red Laser Barriers)
    final barrierProgress = (animValue * 0.8) % 1.0;
    if (barrierProgress > 0.2) {
      final double barrierY = horizonY + (bottomY - horizonY) * pow(barrierProgress, 2.0);
      final double bLeftX = leftTopX + (leftBottomX - leftTopX) * barrierProgress;
      final double bRightX = rightTopX + (rightBottomX - rightTopX) * barrierProgress;

      final laserPaint = Paint()
        ..color = const Color(0xFFFF1E42)
        ..strokeWidth = 3.0 + barrierProgress * 4.0;

      final laserGlow = Paint()
        ..color = const Color(0xFFFF1E42).withValues(alpha: 0.6)
        ..strokeWidth = 8.0 + barrierProgress * 6.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawLine(Offset(bLeftX, barrierY), Offset(bRightX, barrierY), laserGlow);
      canvas.drawLine(Offset(bLeftX, barrierY), Offset(bRightX, barrierY), laserPaint);
    }
  }

  @override
  bool shouldRepaint(covariant Parkour3DTrackPainter oldDelegate) {
    return oldDelegate.animValue != animValue || oldDelegate.stats != stats;
  }
}
