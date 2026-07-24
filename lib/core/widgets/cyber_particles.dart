import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CyberParticlesBackground extends StatefulWidget {
  final Widget child;
  const CyberParticlesBackground({super.key, required this.child});

  @override
  State<CyberParticlesBackground> createState() => _CyberParticlesBackgroundState();
}

class _CyberParticlesBackgroundState extends State<CyberParticlesBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    for (int i = 0; i < 70; i++) {
      _particles.add(
        Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          speed: _random.nextDouble() * 0.008 + 0.003,
          size: _random.nextDouble() * 3 + 1,
          color: _random.nextBool() ? AppColors.neonBlue : AppColors.neonPink,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _ParticlePainter(_particles),
          child: widget.child,
        );
      },
    );
  }
}

class Particle {
  double x;
  double y;
  double speed;
  double size;
  Color color;

  Particle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.color,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      particle.y += particle.speed;
      if (particle.y > 1.0) {
        particle.y = 0.0;
        particle.x = Random().nextDouble();
      }

      final paint = Paint()
        ..color = particle.color.withValues(alpha: 0.6)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(particle.x * size.width, particle.y * size.height),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
