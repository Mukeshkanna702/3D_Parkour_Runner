import 'package:flutter/material.dart';
import '../../../../core/widgets/cyber_particles.dart';
import '../../domain/entities/game_stats_entity.dart';
import 'parkour_3d_character_painter.dart';
import 'parkour_3d_track_painter.dart';

class GameplayCanvas extends StatefulWidget {
  final GameStatsEntity stats;

  const GameplayCanvas({super.key, required this.stats});

  @override
  State<GameplayCanvas> createState() => _GameplayCanvasState();
}

class _GameplayCanvasState extends State<GameplayCanvas> with SingleTickerProviderStateMixin {
  late AnimationController _gameLoopController;

  @override
  void initState() {
    super.initState();
    _gameLoopController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat();
  }

  @override
  void dispose() {
    _gameLoopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _gameLoopController,
      builder: (context, child) {
        return Stack(
          fit: StackFit.expand,
          children: [
            // 1. Real-Time 60 FPS 3D Perspective Track, Laser Barriers & Moving Mag-Rails
            CustomPaint(
              painter: Parkour3DTrackPainter(
                animValue: _gameLoopController.value,
                stats: widget.stats,
              ),
            ),

            // 2. Cyber Particle Rain & Speed Lines Overlay
            const CyberParticlesBackground(child: SizedBox.shrink()),

            // 3. Real-Time 60 FPS 3D Cyber Runner Hero with Dynamic Motion & Power-up Effects
            CustomPaint(
              painter: Parkour3DCharacterPainter(
                animValue: _gameLoopController.value,
                stats: widget.stats,
              ),
            ),
          ],
        );
      },
    );
  }
}
