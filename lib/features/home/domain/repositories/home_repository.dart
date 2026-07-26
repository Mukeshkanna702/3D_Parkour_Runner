import '../entities/lobby_state_entity.dart';

abstract class HomeRepository {
  Future<LobbyStateEntity> fetchLobbyData();
}
