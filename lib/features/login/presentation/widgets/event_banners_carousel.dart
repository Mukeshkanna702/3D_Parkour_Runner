import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/event_banner_entity.dart';

class EventBannersCarousel extends StatefulWidget {
  const EventBannersCarousel({super.key});

  @override
  State<EventBannersCarousel> createState() => _EventBannersCarouselState();
}

class _EventBannersCarouselState extends State<EventBannersCarousel> {
  int _activeBannerIndex = 0;

  final List<EventBannerEntity> _banners = const [
    EventBannerEntity(
      id: 'e1',
      title: 'SEASON 09: OVERDRIVE',
      subtitle: 'Unlock Cyber Ninja Master Skin & Battle Pass',
      tag: 'BATTLE PASS',
      imagePath: AppConstants.imgCoverTitle,
      expiryText: 'ENDS IN 12 DAYS',
    ),
    EventBannerEntity(
      id: 'e2',
      title: 'DRAGON CHASE EVENT',
      subtitle: 'Slay the Mechanical Dragon for 5,000 Crystals',
      tag: 'LIMITED EVENT',
      imagePath: AppConstants.imgMechanicalDragon,
      expiryText: 'ENDS IN 4 DAYS',
    ),
    EventBannerEntity(
      id: 'e3',
      title: 'DAILY REWARD CHEST',
      subtitle: 'Claim Free 500 Energy Crystals & XP Booster',
      tag: 'DAILY CLAIM',
      imagePath: AppConstants.imgHoverTrain,
      expiryText: 'READY NOW',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final activeBanner = _banners[_activeBannerIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Active Event Card Container (Compact Height)
        GestureDetector(
          onTap: () {
            setState(() {
              _activeBannerIndex = (_activeBannerIndex + 1) % _banners.length;
            });
          },
          child: Container(
            height: 75,
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
                    activeBanner.imagePath,
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
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
                            activeBanner.tag,
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
                              activeBanner.title,
                              style: const TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              activeBanner.subtitle,
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

        // Banner Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(_banners.length, (idx) {
            final bool isSelected = idx == _activeBannerIndex;
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
    );
  }
}
