import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SplashLoadingBar extends StatefulWidget {
  final String statusMessage;
  final double progress;

  const SplashLoadingBar({
    super.key,
    required this.statusMessage,
    required this.progress,
  });

  @override
  State<SplashLoadingBar> createState() => _SplashLoadingBarState();
}

class _SplashLoadingBarState extends State<SplashLoadingBar> with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int percentage = (widget.progress * 100).clamp(0, 100).toInt();

    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Rotating Holographic Cyber Reactor Core Indicator
            SizedBox(
              width: 50,
              height: 50,
              child: CustomPaint(
                painter: _HolographicReactorPainter(
                  rotationValue: _rotationController.value,
                  progress: widget.progress,
                ),
              ),
            ),

            const SizedBox(width: 18),

            // 2. High-Tech Telemetry Status & Digital Scan Meter
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Status Header & Percentage Counter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.statusMessage.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.0,
                          color: AppColors.neonBlue,
                          shadows: [
                            Shadow(color: AppColors.neonBlue, blurRadius: 10),
                          ],
                        ),
                      ),
                      Text(
                        '$percentage%',
                        style: const TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: AppColors.neonPink,
                          shadows: [
                            Shadow(color: AppColors.neonPink, blurRadius: 12),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Segmented Cyber Circuit Track
                  SizedBox(
                    height: 6,
                    child: CustomPaint(
                      painter: _CyberCircuitTrackPainter(progress: widget.progress),
                      child: Container(),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Telemetry Sub-Data
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SHADERS: COMPILED // LUMEN GI: ACTIVE',
                        style: TextStyle(
                          fontFamily: 'Rajdhani',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: AppColors.textMuted.withValues(alpha: 0.7),
                        ),
                      ),
                      Text(
                        'LATENCY: 14ms',
                        style: TextStyle(
                          fontFamily: 'Rajdhani',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: AppColors.neonBlue.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// 60 FPS Rotating Holographic Reactor Core Painter
class _HolographicReactorPainter extends CustomPainter {
  final double rotationValue;
  final double progress;

  _HolographicReactorPainter({required this.rotationValue, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    final outerRingPaint = Paint()
      ..color = AppColors.neonBlue.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Outer dashed ring
    canvas.drawCircle(center, radius, outerRingPaint);

    // Inner counter-rotating ring arc
    final innerArcPaint = Paint()
      ..shader = const SweepGradient(
        colors: [AppColors.neonBlue, AppColors.neonPink, Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: radius - 5))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-rotationValue * pi * 2);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 5),
      0,
      pi * 1.5 * progress,
      false,
      innerArcPaint,
    );
    canvas.restore();

    // Central pulsing core dot
    final corePaint = Paint()
      ..color = AppColors.neonBlue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 4 + (sin(rotationValue * pi * 4) * 1.5), corePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Segmented Cyber Circuit Progress Track Painter
class _CyberCircuitTrackPainter extends CustomPainter {
  final double progress;
  _CyberCircuitTrackPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    const int segments = 24;
    final double segmentWidth = (size.width - (segments * 2)) / segments;

    for (int i = 0; i < segments; i++) {
      final double x = i * (segmentWidth + 2);
      final bool isActive = (i / segments) <= progress;

      final paint = Paint()
        ..color = isActive
            ? Color.lerp(AppColors.neonBlue, AppColors.neonPink, i / segments)!
            : Colors.white.withValues(alpha: 0.1)
        ..style = PaintingStyle.fill;

      if (isActive) {
        paint.maskFilter = const MaskFilter.blur(BlurStyle.solid, 3);
      }

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, 0, segmentWidth, size.height),
          const Radius.circular(1.5),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
