import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/usecases/login_usecase.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginGlassPanel extends StatefulWidget {
  const LoginGlassPanel({super.key});

  @override
  State<LoginGlassPanel> createState() => _LoginGlassPanelState();
}

class _LoginGlassPanelState extends State<LoginGlassPanel> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showEmailForm = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgCard.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderNeon, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonBlue.withValues(alpha: 0.2),
            blurRadius: 25,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              final bool isLoading = state is LoginLoadingState;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Panel Header Title & Toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AUTHENTICATION',
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.0,
                                color: Colors.white,
                                shadows: [Shadow(color: AppColors.neonBlue, blurRadius: 10)],
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              'SELECT ACCESS PROTOCOL',
                              style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                                color: AppColors.neonBlue,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            _showEmailForm ? Icons.grid_view : Icons.email_outlined,
                            color: AppColors.neonBlue,
                            size: 18,
                          ),
                          onPressed: () {
                            setState(() {
                              _showEmailForm = !_showEmailForm;
                            });
                          },
                          tooltip: _showEmailForm ? 'Social Login' : 'Email Login',
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    if (isLoading) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          children: [
                            CircularProgressIndicator(color: AppColors.neonBlue, strokeWidth: 2),
                            SizedBox(height: 10),
                            Text(
                              'AUTHENTICATING IDENTITY...',
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: AppColors.neonBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else if (!_showEmailForm) ...[
                      // 1. Primary Action: CONTINUE GAME
                      _buildActionButton(
                        text: 'CONTINUE GAME',
                        icon: Icons.play_arrow_rounded,
                        color: AppColors.neonBlue,
                        isPrimary: true,
                        onTap: () {
                          context.read<LoginBloc>().add(
                            const SubmitLoginEvent(providerType: LoginProviderType.guest),
                          );
                        },
                      ),

                      const SizedBox(height: 8),

                      // 2. Google Login Button
                      _buildActionButton(
                        text: 'SIGN IN WITH GOOGLE',
                        icon: Icons.g_mobiledata,
                        color: Colors.white,
                        isPrimary: false,
                        onTap: () {
                          context.read<LoginBloc>().add(
                            const SubmitLoginEvent(providerType: LoginProviderType.google),
                          );
                        },
                      ),

                      const SizedBox(height: 8),

                      // 3. Apple Login Button
                      _buildActionButton(
                        text: 'SIGN IN WITH APPLE',
                        icon: Icons.apple,
                        color: Colors.white,
                        isPrimary: false,
                        onTap: () {
                          context.read<LoginBloc>().add(
                            const SubmitLoginEvent(providerType: LoginProviderType.apple),
                          );
                        },
                      ),

                      const SizedBox(height: 8),

                      // 4. Guest Mode Button
                      _buildActionButton(
                        text: 'PLAY AS GUEST',
                        icon: Icons.person_outline,
                        color: AppColors.neonPink,
                        isPrimary: false,
                        onTap: () {
                          context.read<LoginBloc>().add(
                            const SubmitLoginEvent(providerType: LoginProviderType.guest),
                          );
                        },
                      ),
                    ] else ...[
                      // Direct Email/Password Login Form
                      _buildTextField(
                        controller: _emailController,
                        hint: 'ENTER CYBER EMAIL',
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _passwordController,
                        hint: 'ENTER ACCESS CODE',
                        icon: Icons.lock,
                        isObscure: true,
                      ),
                      const SizedBox(height: 2),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          child: const Text(
                            'FORGOT ACCESS CODE?',
                            style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: AppColors.neonPink,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      _buildActionButton(
                        text: 'AUTHENTICATE EMAIL',
                        icon: Icons.login,
                        color: AppColors.neonBlue,
                        isPrimary: true,
                        onTap: () {
                          context.read<LoginBloc>().add(
                            SubmitLoginEvent(
                              providerType: LoginProviderType.email,
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required Color color,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 38,
        decoration: BoxDecoration(
          color: isPrimary ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isPrimary ? Colors.transparent : color.withValues(alpha: 0.6),
            width: 1.0,
          ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.5),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isPrimary ? AppColors.bgPrimary : color, size: 18),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                color: isPrimary ? AppColors.bgPrimary : color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isObscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: const TextStyle(
        fontFamily: 'SpaceGrotesk',
        fontSize: 11,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.neonBlue, size: 14),
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 9,
          color: AppColors.textMuted.withValues(alpha: 0.6),
        ),
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.4),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: AppColors.borderNeon.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.neonBlue, width: 1.2),
        ),
      ),
    );
  }
}
