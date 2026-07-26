import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/matchmaking_bloc.dart';
import '../bloc/matchmaking_event.dart';
import '../bloc/matchmaking_state.dart';

class MatchmakingFlowDialog extends StatefulWidget {
  const MatchmakingFlowDialog({super.key});

  @override
  State<MatchmakingFlowDialog> createState() => _MatchmakingFlowDialogState();
}

class _MatchmakingFlowDialogState extends State<MatchmakingFlowDialog> {
  int _step = 1; // 1: Mode, 2: Map, 3: Loadout, 4: Searching/Found

  final List<String> _modes = const [
    'RANKED RUNNER',
    'ENDLESS SURVIVAL',
    'BOSS RUSH',
    'STORY MODE 2099',
  ];

  final List<Map<String, String>> _maps = const [
    {'name': 'NEO TOKYO 2099', 'diff': 'EXTREME', 'weather': 'HEAVY RAIN'},
    {'name': 'SKY DISTRICT', 'diff': 'MEDIUM', 'weather': 'CYBER FOG'},
    {'name': 'CYBER HIGHWAY', 'diff': 'HARD', 'weather': 'NIGHT STORM'},
    {'name': 'QUANTUM LAB', 'diff': 'EXPERT', 'weather': 'VOLUMETRIC FOG'},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MatchmakingBloc>(
      create: (context) => MatchmakingBloc(),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 640),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.bgSecondary.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.neonBlue, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonBlue.withValues(alpha: 0.35),
                blurRadius: 30,
                spreadRadius: 2,
              ),
            ],
          ),
          child: BlocConsumer<MatchmakingBloc, MatchmakingState>(
            listener: (context, state) {
              if (state is MatchmakingFoundState) {
                Future.delayed(const Duration(milliseconds: 600), () {
                  if (context.mounted) {
                    Navigator.of(context, rootNavigator: true).pop();
                    context.go(AppRoutes.loading);
                  }
                });
              }
            },
            builder: (context, state) {
              final bool isSearching = state is MatchmakingSearchingState;
              final bool isFound = state is MatchmakingFoundState;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                            const Icon(Icons.sports_esports, color: AppColors.neonBlue, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              isFound
                                  ? 'MATCH FOUND // READYING SQUAD'
                                  : isSearching
                                      ? 'SEARCHING FOR MATCH...'
                                      : 'MATCHMAKING SETUP (STEP $_step/3)',
                              style: const TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                                color: Colors.white,
                                shadows: [Shadow(color: AppColors.neonBlue, blurRadius: 12)],
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.close, color: AppColors.textMuted, size: 16),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    if (isFound) ...[
                      // Match Found Screen
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.neonBlue.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.neonBlue, width: 1.5),
                        ),
                        child: const Column(
                          children: [
                            Icon(Icons.check_circle_outline, color: AppColors.neonBlue, size: 40),
                            SizedBox(height: 8),
                            Text(
                              'MATCH FOUND!',
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.5,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'CONNECTING TO SERVER // LAUNCHING MISSION...',
                              style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: AppColors.neonBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else if (isSearching) ...[
                      // Searching Radar Screen
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            children: [
                              const CircularProgressIndicator(color: AppColors.neonBlue, strokeWidth: 2.5),
                              const SizedBox(height: 12),
                              Text(
                                'SEARCHING SERVER... (00:0${state.secondsElapsed}s)',
                                style: const TextStyle(
                                  fontFamily: 'Orbitron',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.neonBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else if (_step == 1) ...[
                      // Step 1: Game Mode Selection
                      const Text(
                        'SELECT GAME MODE:',
                        style: TextStyle(fontFamily: 'Orbitron', fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.textMuted),
                      ),
                      const SizedBox(height: 6),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3.8,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _modes.length,
                        itemBuilder: (context, idx) {
                          final mode = _modes[idx];
                          final bool isSelected = mode == state.selectedMode;
                          return GestureDetector(
                            onTap: () {
                              context.read<MatchmakingBloc>().add(SelectModeEvent(mode));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.neonBlue.withValues(alpha: 0.25) : Colors.black.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: isSelected ? AppColors.neonBlue : AppColors.borderNeon),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.flash_on, color: isSelected ? AppColors.neonBlue : AppColors.textMuted, size: 14),
                                  const SizedBox(width: 6),
                                  Text(
                                    mode,
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
                        },
                      ),
                    ] else if (_step == 2) ...[
                      // Step 2: Map Selection
                      const Text(
                        'SELECT MISSION MAP:',
                        style: TextStyle(fontFamily: 'Orbitron', fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.textMuted),
                      ),
                      const SizedBox(height: 6),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3.8,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _maps.length,
                        itemBuilder: (context, idx) {
                          final mapData = _maps[idx];
                          final bool isSelected = mapData['name'] == state.selectedMap;
                          return GestureDetector(
                            onTap: () {
                              context.read<MatchmakingBloc>().add(SelectMapEvent(mapData['name']!));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.neonPink.withValues(alpha: 0.25) : Colors.black.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: isSelected ? AppColors.neonPink : AppColors.borderNeon),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    mapData['name']!,
                                    style: TextStyle(
                                      fontFamily: 'Orbitron',
                                      fontSize: 9,
                                      fontWeight: FontWeight.w900,
                                      color: isSelected ? Colors.white : AppColors.textMuted,
                                    ),
                                  ),
                                  Text(
                                    'DIFF: ${mapData['diff']} | ${mapData['weather']}',
                                    style: TextStyle(
                                      fontFamily: 'SpaceGrotesk',
                                      fontSize: 7,
                                      color: isSelected ? AppColors.neonPink : AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ] else ...[
                      // Step 3: Loadout Confirmation
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.borderNeon),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('MODE: ${state.selectedMode}', style: const TextStyle(fontFamily: 'Orbitron', fontSize: 10, color: AppColors.neonBlue, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 2),
                            Text('MAP: ${state.selectedMap}', style: const TextStyle(fontFamily: 'Orbitron', fontSize: 10, color: AppColors.neonPink, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 2),
                            const Text('CHARACTER: GHOST // NANO-V4 SUIT', style: TextStyle(fontFamily: 'SpaceGrotesk', fontSize: 9, color: Colors.white)),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 12),

                    // Bottom Action Buttons
                    if (!isSearching && !isFound) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_step > 1)
                            OutlinedButton(
                              onPressed: () => setState(() => _step--),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                side: const BorderSide(color: AppColors.neonBlue),
                              ),
                              child: const Text('BACK', style: TextStyle(fontFamily: 'Orbitron', fontSize: 9, color: AppColors.neonBlue)),
                            )
                          else
                            const SizedBox(),

                          ElevatedButton(
                            onPressed: () {
                              if (_step < 3) {
                                setState(() => _step++);
                              } else {
                                context.read<MatchmakingBloc>().add(StartSearchingEvent());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.neonBlue,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            child: Text(
                              _step < 3 ? 'NEXT STEP' : 'FIND MATCH NOW',
                              style: const TextStyle(fontFamily: 'Orbitron', fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.bgPrimary),
                            ),
                          ),
                        ],
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
}
