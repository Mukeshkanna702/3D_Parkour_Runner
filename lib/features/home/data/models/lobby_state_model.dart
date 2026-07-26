import '../../domain/entities/lobby_state_entity.dart';

class LobbyStateModel extends LobbyStateEntity {
  const LobbyStateModel({
    required super.playerName,
    required super.playerLevel,
    required super.xpProgress,
    required super.neonCrystals,
    required super.cyberCoins,
    required super.energyPoints,
    required super.battlePassTier,
    required super.currentSeason,
    required super.onlineFriendsCount,
    required super.unreadMailCount,
    required super.unreadNotificationsCount,
  });

  factory LobbyStateModel.fromJson(Map<String, dynamic> json) {
    return LobbyStateModel(
      playerName: json['player_name'] as String? ?? 'GHOST',
      playerLevel: json['player_level'] as int? ?? 42,
      xpProgress: (json['xp_progress'] as num?)?.toDouble() ?? 0.75,
      neonCrystals: json['neon_crystals'] as int? ?? 2450,
      cyberCoins: json['cyber_coins'] as int? ?? 15800,
      energyPoints: json['energy_points'] as int? ?? 100,
      battlePassTier: json['battle_pass_tier'] as int? ?? 45,
      currentSeason: json['current_season'] as String? ?? 'SEASON 09: OVERDRIVE',
      onlineFriendsCount: json['online_friends_count'] as int? ?? 4,
      unreadMailCount: json['unread_mail_count'] as int? ?? 2,
      unreadNotificationsCount: json['unread_notifications_count'] as int? ?? 3,
    );
  }
}
