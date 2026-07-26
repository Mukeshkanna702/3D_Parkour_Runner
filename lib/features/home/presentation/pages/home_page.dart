import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locator.dart';
import '../../../splash/presentation/widgets/splash_background_canvas.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/home_bottom_dock.dart';
import '../widgets/home_center_character.dart';
import '../widgets/home_left_missions.dart';
import '../widgets/home_play_button.dart';
import '../widgets/home_right_events.dart';
import '../widgets/home_top_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => sl<HomeBloc>()..add(LoadLobbyEvent()),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060913),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState || state is HomeInitialState) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF00F0FF)),
            );
          }

          if (state is HomeErrorState) {
            return Center(
              child: Text(
                'LOBBY ERROR: ${state.message}',
                style: const TextStyle(color: Colors.red, fontFamily: 'Orbitron'),
              ),
            );
          }

          final lobbyData = (state as HomeLoadedState).lobbyData;

          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Continuous 3D Rainy Megacity Background & Camera Motion (Full Bleed Edge-to-Edge)
              const SplashBackgroundCanvas(),

              // 2. AAA Console Game Lobby Layout (16:9 Landscape)
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                  child: Column(
                    children: [
                      // Top Bar Navigation
                      HomeTopBar(lobbyData: lobbyData),

                      const SizedBox(height: 4),

                      // Main Lobby Center Area
                      const Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Left Side: Daily Missions & Challenges
                            Align(
                              alignment: Alignment.centerLeft,
                              child: HomeLeftMissions(),
                            ),

                            // Center: 3D Full-Body Hero & Holographic Platform Base
                            Expanded(
                              child: HomeCenterCharacter(),
                            ),

                            // Right Side: Featured Event Cards & Battle Pass
                            Align(
                              alignment: Alignment.centerRight,
                              child: HomeRightEvents(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 2),

                      // Center Bottom: Giant START MATCH PLAY Button & Holographic Dock
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HomePlayButton(),
                          SizedBox(height: 4),
                          HomeBottomDock(),
                        ],
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
