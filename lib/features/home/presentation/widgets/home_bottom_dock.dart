import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HomeBottomDock extends StatefulWidget {
  const HomeBottomDock({super.key});

  @override
  State<HomeBottomDock> createState() => _HomeBottomDockState();
}

class _HomeBottomDockState extends State<HomeBottomDock> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _dockItems = const [
    {'label': 'HOME', 'icon': Icons.home},
    {'label': 'CHARACTERS', 'icon': Icons.people},
    {'label': 'INVENTORY', 'icon': Icons.backpack},
    {'label': 'WEAPONS', 'icon': Icons.shield},
    {'label': 'STORE', 'icon': Icons.shopping_bag},
    {'label': 'CLAN', 'icon': Icons.groups},
    {'label': 'LEADERBOARD', 'icon': Icons.leaderboard},
    {'label': 'NEWS', 'icon': Icons.newspaper},
    {'label': 'SETTINGS', 'icon': Icons.settings},
  ];

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.bgCard.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderNeon, width: 0.8),
          boxShadow: [
            BoxShadow(color: AppColors.neonBlue.withValues(alpha: 0.2), blurRadius: 15),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_dockItems.length, (idx) {
            final item = _dockItems[idx];
            final bool isSelected = idx == _selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = idx;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.neonBlue.withValues(alpha: 0.25) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppColors.neonBlue : Colors.transparent,
                    width: 0.8,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: isSelected ? AppColors.neonBlue : AppColors.textMuted,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        color: isSelected ? Colors.white : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
