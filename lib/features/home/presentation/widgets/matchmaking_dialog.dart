import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class MatchmakingDialog extends StatefulWidget {
  const MatchmakingDialog({super.key});

  @override
  State<MatchmakingDialog> createState() => _MatchmakingDialogState();
}

class _MatchmakingDialogState extends State<MatchmakingDialog> with SingleTickerProviderStateMixin {
  late AnimationController _radarController;
  String _selectedMode = 'RANKED RUNNER';
  String _selectedTeam = 'SOLO';

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _radarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 620),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.bgSecondary.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.neonBlue, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonBlue.withValues(alpha: 0.35),
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
                const Row(
                  children: [
                    Icon(Icons.sports_esports, color: AppColors.neonBlue, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'MATCHMAKING // PROTOCOL 2099',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                        color: Colors.white,
                        shadows: [Shadow(color: AppColors.neonBlue, blurRadius: 15)],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textMuted, size: 18),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Mode Selector Options
            Row(
              children: [
                Expanded(child: _buildModeChip('RANKED RUNNER', Icons.workspace_premium)),
                const SizedBox(width: 8),
                Expanded(child: _buildModeChip('ENDLESS SURVIVAL', Icons.all_inclusive)),
                const SizedBox(width: 8),
                Expanded(child: _buildModeChip('BOSS RUSH', Icons.local_fire_department)),
              ],
            ),

            const SizedBox(height: 12),

            // Team Mode Chips
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTeamChip('SOLO', Icons.person),
                const SizedBox(width: 10),
                _buildTeamChip('DUO', Icons.group),
                const SizedBox(width: 10),
                _buildTeamChip('SQUAD (4P)', Icons.groups),
              ],
            ),

            const SizedBox(height: 16),

            // Radar Scanning Indicator
            Center(
              child: AnimatedBuilder(
                animation: _radarController,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.4), width: 1.0),
                        ),
                      ),
                      Transform.rotate(
                        angle: _radarController.value * 6.28,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: SweepGradient(
                              colors: [
                                AppColors.neonBlue.withValues(alpha: 0.8),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.wifi_tethering, color: AppColors.neonBlue, size: 22),
                          SizedBox(height: 2),
                          Text(
                            '00:04s',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Bottom Actions: Start & Cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.neonRed),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'CANCEL SEARCH',
                    style: TextStyle(fontFamily: 'Orbitron', fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.neonRed),
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🚀 MATCH FOUND! ENTERING 3D NEON MEGACITY RUN...'),
                        backgroundColor: AppColors.neonBlue,
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow_rounded, color: AppColors.bgPrimary),
                  label: const Text(
                    'ENTER MATCH NOW',
                    style: TextStyle(fontFamily: 'Orbitron', fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.bgPrimary),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonBlue,
                    elevation: 12,
                    shadowColor: AppColors.neonBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeChip(String title, IconData icon) {
    final bool isSelected = title == _selectedMode;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMode = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.neonBlue.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? AppColors.neonBlue : AppColors.borderNeon),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? AppColors.neonBlue : AppColors.textMuted, size: 18),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: isSelected ? Colors.white : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamChip(String title, IconData icon) {
    final bool isSelected = title == _selectedTeam;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTeam = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.neonPink : Colors.black.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.neonPink : AppColors.borderNeon),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : AppColors.textMuted, size: 14),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: isSelected ? Colors.white : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
