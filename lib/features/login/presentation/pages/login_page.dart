import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/services/service_locator.dart';
import '../../../splash/presentation/widgets/splash_background_canvas.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import '../widgets/character_showcase_carousel.dart';
import '../widgets/event_banners_carousel.dart';
import '../widgets/floating_lobby_widgets.dart';
import '../widgets/login_bottom_footer.dart';
import '../widgets/login_glass_panel.dart';
import '../widgets/login_top_header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => sl<LoginBloc>(),
      child: const LoginPageView(),
    );
  }
}

class LoginPageView extends StatelessWidget {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060913),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'WELCOME, ${state.user.username.toUpperCase()}! AUTHENTICATION SUCCESSFUL.',
                  style: const TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.w800),
                ),
                backgroundColor: const Color(0xFF00F0FF),
                duration: const Duration(seconds: 2),
              ),
            );
            // Navigate to Main Menu / Home
            Future.delayed(const Duration(milliseconds: 600), () {
              if (context.mounted) {
                context.go(AppRoutes.home);
              }
            });
          } else if (state is LoginFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('AUTH ERROR: ${state.errorMessage}'),
                backgroundColor: const Color(0xFFFF1E42),
              ),
            );
          }
        },
        child: const Stack(
          fit: StackFit.expand,
          children: [
            // 1. Continuous 3D Rainy Megacity Background & Camera Motion (Full Bleed Edge to Edge)
            SplashBackgroundCanvas(),

            // 2. Floating Lobby Live Notifications & Weather Status
            FloatingLobbyWidgets(),

            // 3. AAA Console Game Lobby Layout (Edge-to-Edge 16:9 Landscape)
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                child: Column(
                  children: [
                    // Top Navigation Bar Header
                    LoginTopHeader(),

                    SizedBox(height: 4),

                    // Main Center Area: Character Showcase (Left) + Events & Glass Panel (Right)
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Left Side: Interactive Character Showcase Carousel & Holographic Platform
                          Expanded(
                            flex: 6,
                            child: CharacterShowcaseCarousel(),
                          ),

                          SizedBox(width: 6),

                          // Right Side: Event Cards & Glass Panel Stacked Vertically (Full Edge Alignment)
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Rotating Event Cards Banner
                                EventBannersCarousel(),

                                SizedBox(height: 4),

                                // Holographic Authentication Control Panel
                                Expanded(
                                  child: LoginGlassPanel(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 2),

                    // Bottom Bar Footer
                    LoginBottomFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
