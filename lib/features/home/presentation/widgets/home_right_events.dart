import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class HomeRightEvents extends StatefulWidget {
  const HomeRightEvents({super.key});

  @override
  State<HomeRightEvents> createState() => _HomeRightEventsState();
}

class _HomeRightEventsState extends State<HomeRightEvents> {
  int _activeCardIndex = 0;

  final List<Map<String, String>> _events = [
    {
      'title': 'SEASON 09 BATTLE PASS',
      'tag': 'TIER 45 / 100',
      'subtitle': 'Unlock Cyber Ninja Master Suit',
      'image': AppConstants.imgCoverTitle,
    },
    {
      'title': 'DRAGON CHASE EVENT',
      'tag': 'LIMITED EVENT',
      'subtitle': 'Win 5,000 Crystals & Katana Skin',
      'image': AppConstants.imgMechanicalDragon,
    },
    {
      'title': 'FEATURED STORE BUNDLE',
      'tag': '50% OFF',
      'subtitle': 'Ghost Cyber Wings & Ion Boots',
      'image': AppConstants.imgAntigravityWings,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final activeEvent = _events[_activeCardIndex];

    return Container(
      width: 230,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Event Banner Container
          GestureDetector(
            onTap: () {
              setState(() {
                _activeCardIndex = (_activeCardIndex + 1) % _events.length;
              });
            },
            child: Container(
              height: 95,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.neonPink.withValues(alpha: 0.8), width: 1.0),
                boxShadow: [
                  BoxShadow(color: AppColors.neonPink.withValues(alpha: 0.25), blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      activeEvent['image']!,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0xF2060913)],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppColors.neonPink,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              activeEvent['tag']!,
                              style: const TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 7,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activeEvent['title']!,
                                style: const TextStyle(
                                  fontFamily: 'Orbitron',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                activeEvent['subtitle']!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'SpaceGrotesk',
                                  fontSize: 8,
                                  color: AppColors.textMuted.withValues(alpha: 0.9),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).animate().shimmer(duration: 2.seconds, color: AppColors.neonPink),

          const SizedBox(height: 4),

          // Dots Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(_events.length, (idx) {
              final bool isSelected = idx == _activeCardIndex;
              return Container(
                margin: const EdgeInsets.only(left: 3),
                width: isSelected ? 12 : 5,
                height: 3,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.neonPink : AppColors.borderNeon,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
