import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/character_entity.dart';
import 'character_details_modal.dart';
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
  Timer? _autoScrollTimer;
  int _activeCharacterIndex = 0;

  final List<CharacterEntity> _characters = const [
    CharacterEntity(
      id: 'c1',
      name: 'GHOST',
      title: 'THE CYBER NINJA',
      role: 'AGILITY RUNNER',
      imagePath: AppConstants.imgHeroFullBodyLogin,
      primaryAbility: 'ANTI-GRAVITY LEAP & KATANA DASH',
      ultimateAbility: 'SHADOW OVERDRIVE TIME-WARP',
      biography: 'Raised in the high-altitude rooftop spires of Neo-Kyoto, Ghost mastered anti-gravity combat and nano-fiber armor to defy NEXUS AI authority.',
      difficulty: 'MEDIUM',
      powerRating: 94,
      agility: 98,
      velocity: 95,
      armor: 85,
      rarity: 'LEGENDARY',
    ),
    CharacterEntity(
      id: 'c2',
      name: 'SHADOW',
      title: 'STEALTH ASSASSIN',
      role: 'CLOAK RUNNER',
      imagePath: AppConstants.imgAAAHero,
      primaryAbility: 'ACTIVE CLOAKING & PLASMA SLICE',
      ultimateAbility: 'NIGHTMARE MIRAGE SWARM',
      biography: 'A rogue undercover operative equipped with light-bending camouflage panels and thermal optic blades.',
      difficulty: 'HARD',
      powerRating: 91,
      agility: 95,
      velocity: 92,
      armor: 80,
      rarity: 'EPIC',
    ),
    CharacterEntity(
      id: 'c3',
      name: 'NOVA',
      title: 'GRAVITY DIVER',
      role: 'AERIAL GLIDER',
      imagePath: AppConstants.imgAntigravityWings,
      primaryAbility: 'ENERGY WING GLIDE & PULSE SHOCK',
      ultimateAbility: 'ORBITAL GRAVITY DROP',
      biography: 'Former test pilot for NEXUS orbital stations, Nova harnesses jet-boosted anti-gravity wings to soar above city skyscrapers.',
      difficulty: 'EASY',
      powerRating: 89,
      agility: 96,
      velocity: 98,
      armor: 78,
      rarity: 'EPIC',
    ),
    CharacterEntity(
      id: 'c4',
      name: 'TITAN',
      title: 'HEAVY ENFORCER',
      role: 'TANK RUNNER',
      imagePath: AppConstants.imgRoboticSpider,
      primaryAbility: 'KINETIC BARRIER & GROUND SLAM',
      ultimateAbility: 'TITANIUM RAMPAGE OVERLOAD',
      biography: 'Built with reinforced titanium plating, Titan crushes mechanical drone swarms with kinetic shockwaves.',
      difficulty: 'EASY',
      powerRating: 96,
      agility: 80,
      velocity: 85,
      armor: 99,
      rarity: 'LEGENDARY',
    ),
    CharacterEntity(
      id: 'c5',
      name: 'PHANTOM',
      title: 'HOLOGRAPHIC SHIFT',
      role: 'DECOY RUNNER',
      imagePath: AppConstants.imgWallRun,
      primaryAbility: 'DECOY MIRAGE & FASTER RECOVERY',
      ultimateAbility: 'CHRONO DECOY EXPLOSION',
      biography: 'Master of holographic projection, Phantom leaves deceptive light clones behind to baffle automated security turrets.',
      difficulty: 'HARD',
      powerRating: 88,
      agility: 94,
      velocity: 90,
      armor: 82,
      rarity: 'RARE',
    ),
    CharacterEntity(
      id: 'c6',
      name: 'VOLT',
      title: 'LIGHTNING SPEEDSTER',
      role: 'MAX VELOCITY',
      imagePath: AppConstants.imgHoverTrain,
      primaryAbility: 'OVERCHARGE SPRINT & LIGHTNING BLAST',
      ultimateAbility: 'HYPER-IONIC SPEED EMP',
      biography: 'Electrically augmented speedster capable of channeling mag-rail currents directly through shock boots.',
      difficulty: 'MEDIUM',
      powerRating: 95,
      agility: 100,
      velocity: 100,
      armor: 75,
      rarity: 'LEGENDARY',
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

    // Auto-Scroll Character Carousel every 4 seconds
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        final nextPage = (_activeCharacterIndex + 1) % _characters.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
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
        // 1. 60 FPS Rotating Holographic Platform Base
        Positioned(
          bottom: 10,
          left: 30,
          right: 30,
          height: 110,
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

        // 2. Auto-Scrolling Full-Body Character Showcase (No Chevron Buttons)
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
                final double breathingY = isSelected ? sin(_breathingController.value * pi) * 5.0 : 0.0;
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

        // 3. Character Tactical Stats & Selector Pills (Bottom Overlay)
        Positioned(
          left: 10,
          bottom: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Character Selector Pills
              Row(
                children: List.generate(_characters.length, (idx) {
                  final bool isSelected = idx == _activeCharacterIndex;
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        idx,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.neonBlue : AppColors.bgCard.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: isSelected ? AppColors.neonBlue : AppColors.borderNeon,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(color: AppColors.neonBlue.withValues(alpha: 0.6), blurRadius: 8),
                              ]
                            : [],
                      ),
                      child: Text(
                        _characters[idx].name,
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: isSelected ? AppColors.bgPrimary : AppColors.textMuted,
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 6),

              // Character HUD & Inspect Action
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.bgCard.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.6), width: 1.0),
                  boxShadow: [
                    BoxShadow(color: AppColors.neonBlue.withValues(alpha: 0.2), blurRadius: 12),
                  ],
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.shield, color: AppColors.neonBlue, size: 12),
                            const SizedBox(width: 4),
                            Text(
                              '${activeChar.name} // ${activeChar.title}',
                              style: const TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'ABILITY: ${activeChar.primaryAbility}',
                          style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppColors.neonPink.withValues(alpha: 0.9),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _buildStatChip('AGILITY', '${activeChar.agility}%'),
                            const SizedBox(width: 8),
                            _buildStatChip('VELOCITY', '${activeChar.velocity}%'),
                            const SizedBox(width: 8),
                            _buildStatChip('ARMOR', '${activeChar.armor}%'),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(width: 12),

                    // Inspect Button
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => CharacterDetailsModal(character: activeChar),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.neonBlue.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.neonBlue, width: 1.0),
                          boxShadow: [
                            BoxShadow(color: AppColors.neonBlue.withValues(alpha: 0.3), blurRadius: 8),
                          ],
                        ),
                        child: const Column(
                          children: [
                            Icon(Icons.search, color: AppColors.neonBlue, size: 14),
                            SizedBox(height: 2),
                            Text(
                              'INSPECT',
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 7,
                                fontWeight: FontWeight.w900,
                                color: AppColors.neonBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildStatChip(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontFamily: 'Rajdhani',
            fontSize: 8,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted.withValues(alpha: 0.7),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 8,
            fontWeight: FontWeight.w900,
            color: AppColors.neonBlue,
          ),
        ),
      ],
    );
  }
}
