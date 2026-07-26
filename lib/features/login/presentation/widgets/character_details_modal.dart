import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/character_entity.dart';

class CharacterDetailsModal extends StatelessWidget {
  final CharacterEntity character;

  const CharacterDetailsModal({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.bgSecondary.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.neonBlue, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonBlue.withValues(alpha: 0.3),
              blurRadius: 35,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modal Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.neonPink,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        character.rarity.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${character.name} // ${character.title}',
                      style: const TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                        color: Colors.white,
                        shadows: [Shadow(color: AppColors.neonBlue, blurRadius: 15)],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textMuted),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Character Image Preview
                Container(
                  width: 220,
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderNeon, width: 1.0),
                    image: DecorationImage(
                      image: AssetImage(character.imagePath),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                // Character Story & Stats Breakdown
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BIOGRAPHY',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          color: AppColors.neonBlue.withValues(alpha: 0.9),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        character.biography,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 11,
                          height: 1.4,
                          color: AppColors.textMain.withValues(alpha: 0.9),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Abilities
                      _buildAbilityTile('TACTICAL ABILITY', character.primaryAbility, AppColors.neonBlue),
                      const SizedBox(height: 6),
                      _buildAbilityTile('ULTIMATE ABILITY', character.ultimateAbility, AppColors.neonPink),

                      const SizedBox(height: 12),

                      // Stat Bars
                      _buildStatBar('POWER RATING', character.powerRating / 100, AppColors.neonOrange),
                      const SizedBox(height: 4),
                      _buildStatBar('AGILITY', character.agility / 100, AppColors.neonBlue),
                      const SizedBox(height: 4),
                      _buildStatBar('VELOCITY', character.velocity / 100, AppColors.neonGreen),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Bottom Actions: Voice Preview & Upgrade
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🔊 VOICE LINE: "I AM THE GHOST OF NEO-KYOTO."'),
                        backgroundColor: AppColors.neonPurple,
                      ),
                    );
                  },
                  icon: const Icon(Icons.record_voice_over, size: 16, color: Colors.white),
                  label: const Text(
                    'PLAY VOICE SAMPLE',
                    style: TextStyle(fontFamily: 'Orbitron', fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonPurple.withValues(alpha: 0.3),
                    side: const BorderSide(color: AppColors.neonPurple),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.flash_on, size: 16, color: AppColors.bgPrimary),
                  label: const Text(
                    'EQUIP CHARACTER',
                    style: TextStyle(fontFamily: 'Orbitron', fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.bgPrimary),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonBlue,
                    elevation: 10,
                    shadowColor: AppColors.neonBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAbilityTile(String title, String ability, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          color: color,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              Text(
                ability,
                style: const TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatBar(String label, double progress, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Orbitron',
              fontSize: 8,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Stack(
              children: [
                Container(
                  width: 250 * progress,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [BoxShadow(color: color, blurRadius: 8)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
