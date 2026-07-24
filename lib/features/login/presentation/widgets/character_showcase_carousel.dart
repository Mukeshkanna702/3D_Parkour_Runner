import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/character_entity.dart';
import 'character_platform_painter.dart';

class CharacterShowcaseCarousel extends StatefulWidget {
  const CharacterShowcaseCarousel({super.key});

  @override
  State<CharacterShowcaseCarousel> createState() => _CharacterShowcaseCarouselState();
}

class _CharacterShowcaseCarouselState extends State<CharacterShowcaseCarousel> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _platformController;
  late AnimationController _breathingController;
  int _activeCharacterIndex = 0;

  final List<CharacterEntity> _characters = const [
    CharacterEntity(
      id: 'c1',
      name: 'GHOST',
      title: 'THE CYBER NINJA',
      role: 'AGILITY RUNNER',
      imagePath: AppConstants.imgHeroFullBodyLogin,
      primaryAbility: 'ANTI-GRAVITY LEAP & KATANA DASH',
      agility: 98,
      velocity: 95,
      armor: 85,
    ),
    CharacterEntity(
      id: 'c2',
      name: 'SHADOW',
      title: 'STEALTH ASSASSIN',
      role: 'CLOAK RUNNER',
      imagePath: AppConstants.imgAAAHero,
      primaryAbility: 'ACTIVE CLOAKING & PLASMA SLICE',
      agility: 95,
      velocity: 92,
      armor: 80,
    ),
    CharacterEntity(
      id: 'c3',
      name: 'NOVA',
      title: 'GRAVITY DIVER',
      role: 'AERIAL GLIDER',
      imagePath: AppConstants.imgAntigravityWings,
      primaryAbility: 'ENERGY WING GLIDE & PULSE SHOCK',
      agility: 96,
      velocity: 98,
      armor: 78,
    ),
    CharacterEntity(
      id: 'c4',
      name: 'TITAN',
      title: 'HEAVY ENFORCER',
      role: 'TANK RUNNER',
      imagePath: AppConstants.imgRoboticSpider,
      primaryAbility: 'KINETIC BARRIER & GROUND SLAM',
      agility: 80,
      velocity: 85,
      armor: 99,
    ),
    CharacterEntity(
      id: 'c5',
      name: 'PHANTOM',
      title: 'HOLOGRAPHIC SHIFT',
      role: 'DECOY RUNNER',
      imagePath: AppConstants.imgWallRun,
      primaryAbility: 'DECOY MIRAGE & FASTER RECOVERY',
      agility: 94,
      velocity: 90,
      armor: 82,
    ),
    CharacterEntity(
      id: 'c6',
      name: 'VOLT',
      title: 'LIGHTNING SPEEDSTER',
      role: 'MAX VELOCITY',
      imagePath: AppConstants.imgHoverTrain,
      primaryAbility: 'OVERCHARGE SPRINT & LIGHTNING BLAST',
      agility: 100,
      velocity: 100,
      armor: 75,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _platformController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _platformController.dispose();
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeChar = _characters[_activeCharacterIndex];

    return Stack(
      alignment: Alignment.center,
      children: [
        // 1. 60 FPS Rotating Holographic Platform Base (Floor Elevation)
        Positioned(
          bottom: 15,
          left: 40,
          right: 40,
          height: 120,
          child: AnimatedBuilder(
            animation: _platformController,
            builder: (context, child) {
              return CustomPaint(
                painter: CharacterPlatformPainter(
                  animationValue: _platformController.value,
                ),
              );
            },
          ),
        ),

        // 2. Swipable Full-Body Character Carousel (PUBG Mobile Lobby Style)
        PageView.builder(
          controller: _pageController,
          itemCount: _characters.length,
          onPageChanged: (index) {
            setState(() {
              _activeCharacterIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final char = _characters[index];
            final bool isSelected = index == _activeCharacterIndex;

            return AnimatedBuilder(
              animation: _breathingController,
              builder: (context, child) {
                final double breathingY = isSelected ? sin(_breathingController.value * pi) * 6.0 : 0.0;
                final double charScale = isSelected ? 1.0 : 0.85;

                return Transform.translate(
                  offset: Offset(0, breathingY),
                  child: Transform.scale(
                    scale: charScale,
                    child: Opacity(
                      opacity: isSelected ? 1.0 : 0.45,
                      child: Image.asset(
                        char.imagePath,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),

        // 3. Left/Right Navigation Arrows
        Positioned(
          left: 10,
          child: _buildArrowBtn(Icons.chevron_left, () {
            if (_activeCharacterIndex > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeOutCubic,
              );
            }
          }),
        ),
        Positioned(
          right: 10,
          child: _buildArrowBtn(Icons.chevron_right, () {
            if (_activeCharacterIndex < _characters.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeOutCubic,
              );
            }
          }),
        ),

        // 4. Character Tactical Stats & Selector Pills (Bottom Overlay)
        Positioned(
          left: 20,
          bottom: 25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Character Pills Selector
              Row(
                children: List.generate(_characters.length, (idx) {
                  final bool isSelected = idx == _activeCharacterIndex;
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        idx,
                        duration: const Duration(milliseconds: 450),
                        curve: Curves.easeOutCubic,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.only(right: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.neonBlue : AppColors.bgCard.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: isSelected ? AppColors.neonBlue : AppColors.borderNeon,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(color: AppColors.neonBlue.withValues(alpha: 0.6), blurRadius: 10),
                              ]
                            : [],
                      ),
                      child: Text(
                        _characters[idx].name,
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: isSelected ? AppColors.bgPrimary : AppColors.textMuted,
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 8),

              // Character Stats & Primary Ability HUD
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.bgCard.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.6), width: 1.0),
                  boxShadow: [
                    BoxShadow(color: AppColors.neonBlue.withValues(alpha: 0.2), blurRadius: 15),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.shield, color: AppColors.neonBlue, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          '${activeChar.name} // ${activeChar.title}',
                          style: const TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ABILITY: ${activeChar.primaryAbility}',
                      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: AppColors.neonPink.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _buildStatChip('AGILITY', '${activeChar.agility}%'),
                        const SizedBox(width: 10),
                        _buildStatChip('VELOCITY', '${activeChar.velocity}%'),
                        const SizedBox(width: 10),
                        _buildStatChip('ARMOR', '${activeChar.armor}%'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildArrowBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.bgCard.withValues(alpha: 0.8),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.6)),
          boxShadow: [
            BoxShadow(color: AppColors.neonBlue.withValues(alpha: 0.3), blurRadius: 12),
          ],
        ),
        child: Icon(icon, color: AppColors.neonBlue, size: 22),
      ),
    );
  }

  Widget _buildStatChip(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontFamily: 'Rajdhani',
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted.withValues(alpha: 0.7),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 9,
            fontWeight: FontWeight.w900,
            color: AppColors.neonBlue,
          ),
        ),
      ],
    );
  }
}
