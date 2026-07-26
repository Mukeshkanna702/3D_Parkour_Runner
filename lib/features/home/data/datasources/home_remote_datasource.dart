import 'dart:async';
import '../models/lobby_state_model.dart';

abstract class HomeRemoteDataSource {
  Future<LobbyStateModel> getLobbyData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<LobbyStateModel> getLobbyData() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const LobbyStateModel(
      playerName: 'GHOST',
      playerLevel: 42,
      xpProgress: 0.75,
      neonCrystals: 2450,
      cyberCoins: 15800,
      energyPoints: 100,
      battlePassTier: 45,
      currentSeason: 'SEASON 09: OVERDRIVE',
      onlineFriendsCount: 4,
      unreadMailCount: 2,
      unreadNotificationsCount: 3,
    );
  }
}
