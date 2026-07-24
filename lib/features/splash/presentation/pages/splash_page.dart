import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/services/service_locator.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';
import '../widgets/splash_background_canvas.dart';
import '../widgets/splash_loading_bar.dart';
import '../widgets/splash_logo_reveal.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => sl<SplashBloc>()..add(StartSplashInitialization()),
      child: const SplashPageView(),
    );
  }
}

class SplashPageView extends StatelessWidget {
  const SplashPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060913),
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashCompletedState) {
            Future.delayed(const Duration(milliseconds: 800), () {
              if (context.mounted) {
                context.go(AppRoutes.login);
              }
            });
          }
        },
        builder: (context, state) {
          String statusMessage = 'INITIALIZING LUMEN GI & RAY TRACING...';
          double progress = 0.0;

          if (state is SplashLoadingState) {
            statusMessage = state.statusMessage;
            progress = state.progress;
          } else if (state is SplashCompletedState) {
            statusMessage = 'SYSTEM READY — LAUNCHING SKYRUSH...';
            progress = 1.0;
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Photorealistic 8K AAA Protagonist & Rainy Megacity Parallax Canvas
              const SplashBackgroundCanvas(),

              // 2. AAA Game Launcher Console UI Layout (Landscape 16:9)
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),

                      // Top-left AAA Logo & Tagline Reveal
                      const SplashLogoReveal(),

                      const Spacer(),

                      // Bottom-left Custom Holographic Reactor Core & Cyber Circuit Meter
                      SizedBox(
                        width: 520,
                        child: SplashLoadingBar(
                          statusMessage: statusMessage,
                          progress: progress,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
