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
      constraints: const BoxConstraints(maxWidth: 380, maxHeight: 320),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.bgCard.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderNeon, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonBlue.withValues(alpha: 0.15),
            blurRadius: 25,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 30,
            spreadRadius: 3,
          ),
        ],
      ),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final bool isLoading = state is LoginLoadingState;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Panel Title Header
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
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.5,
                            color: Colors.white,
                            shadows: [Shadow(color: AppColors.neonBlue, blurRadius: 12)],
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'SELECT ACCESS PROTOCOL',
                          style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
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

                const SizedBox(height: 12),

                if (isLoading) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.0),
                    child: Column(
                      children: [
                        CircularProgressIndicator(color: AppColors.neonBlue, strokeWidth: 2.5),
                        SizedBox(height: 12),
                        Text(
                          'AUTHENTICATING IDENTITY...',
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.neonBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else if (!_showEmailForm) ...[
                  // 1. Primary Action: QUICK START / CONTINUE
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
                  // Email / Password Direct Form Fields
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
                  const SizedBox(height: 4),

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
                          fontSize: 9,
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
        duration: const Duration(milliseconds: 200),
        height: 40,
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
                    blurRadius: 15,
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
        fontSize: 12,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.neonBlue, size: 16),
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 10,
          color: AppColors.textMuted.withValues(alpha: 0.6),
        ),
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.4),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
