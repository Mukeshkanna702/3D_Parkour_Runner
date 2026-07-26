import 'package:equatable/equatable.dart';

class LobbyStateEntity extends Equatable {
  final String playerName;
  final int playerLevel;
  final double xpProgress;
  final int neonCrystals;
  final int cyberCoins;
  final int energyPoints;
  final int battlePassTier;
  final String currentSeason;
  final int onlineFriendsCount;
  final int unreadMailCount;
  final int unreadNotificationsCount;

  const LobbyStateEntity({
    required this.playerName,
    required this.playerLevel,
    required this.xpProgress,
    required this.neonCrystals,
    required this.cyberCoins,
    required this.energyPoints,
    required this.battlePassTier,
    required this.currentSeason,
    required this.onlineFriendsCount,
    required this.unreadMailCount,
    required this.unreadNotificationsCount,
  });

  @override
  List<Object?> get props => [
        playerName,
        playerLevel,
        xpProgress,
        neonCrystals,
        cyberCoins,
        energyPoints,
        battlePassTier,
        currentSeason,
        onlineFriendsCount,
        unreadMailCount,
        unreadNotificationsCount,
      ];
}
