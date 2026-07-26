import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color bgPrimary = Color(0xFF060913);
  static const Color bgSecondary = Color(0xFF0B1021);
  static const Color bgCard = Color(0xBF0F172A);
  
  static const Color neonBlue = Color(0xFF00F0FF);
  static const Color neonPurple = Color(0xFF9D00FF);
  static const Color neonPink = Color(0xFFFF007F);
  static const Color neonOrange = Color(0xFFFF5500);
  static const Color neonRed = Color(0xFFFF1E42);
  static const Color neonYellow = Color(0xFFFFEE00);
  static const Color neonGreen = Color(0xFF00FF66);
  
  static const Color textMain = Color(0xFFF1F5F9);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color borderNeon = Color(0x4D00F0FF);
  static const Color glassBorder = Color(0x1AFFFFFF);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgPrimary,
      primaryColor: AppColors.neonBlue,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonBlue,
        secondary: AppColors.neonPurple,
        tertiary: AppColors.neonPink,
        surface: AppColors.bgSecondary,
        error: AppColors.neonRed,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.orbitron(
          fontSize: 36,
          fontWeight: FontWeight.w900,
          color: AppColors.textMain,
          letterSpacing: 3.0,
        ),
        displayMedium: GoogleFonts.orbitron(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: AppColors.textMain,
          letterSpacing: 2.0,
        ),
        displaySmall: GoogleFonts.orbitron(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.neonBlue,
          letterSpacing: 1.5,
        ),
        titleLarge: GoogleFonts.spaceGrotesk(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textMain,
          letterSpacing: 1.2,
        ),
        bodyLarge: GoogleFonts.rajdhani(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textMain,
        ),
        bodyMedium: GoogleFonts.rajdhani(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}
