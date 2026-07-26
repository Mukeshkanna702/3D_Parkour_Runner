import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/gameplay_bloc.dart';
import '../bloc/gameplay_event.dart';
import '../bloc/gameplay_state.dart';
import '../widgets/game_over_modal.dart';
import '../widgets/gameplay_canvas.dart';
import '../widgets/gameplay_hud.dart';

class GameplayPage extends StatelessWidget {
  const GameplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameplayBloc>(
      create: (context) => GameplayBloc()..add(StartGameLoopEvent()),
      child: const GameplayPageView(),
    );
  }
}

class GameplayPageView extends StatelessWidget {
  const GameplayPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060913),
      body: BlocConsumer<GameplayBloc, GameplayState>(
        listener: (context, state) {
          if (state is GameplayOverState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => GameOverModal(stats: state.stats),
            );
          }
        },
        builder: (context, state) {
          final stats = state.stats;

          return GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity != null) {
                if (details.primaryVelocity! < 0) {
                  // Swipe Left
                  context.read<GameplayBloc>().add(MoveLaneLeftEvent());
                } else if (details.primaryVelocity! > 0) {
                  // Swipe Right
                  context.read<GameplayBloc>().add(MoveLaneRightEvent());
                }
              }
            },
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity != null) {
                if (details.primaryVelocity! < 0) {
                  // Swipe Up -> Jump
                  context.read<GameplayBloc>().add(TriggerJumpEvent());
                } else if (details.primaryVelocity! > 0) {
                  // Swipe Down -> Slide
                  context.read<GameplayBloc>().add(TriggerSlideEvent());
                }
              }
            },
            onDoubleTap: () {
              context.read<GameplayBloc>().add(TriggerDashEvent());
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 1. Real-Time 3D Parkour Runner Canvas
                GameplayCanvas(stats: stats),

                // 2. AAA Game Telemetry HUD & Virtual Action Controls
                GameplayHUD(stats: stats),
              ],
            ),
          );
        },
      ),
    );
  }
}
