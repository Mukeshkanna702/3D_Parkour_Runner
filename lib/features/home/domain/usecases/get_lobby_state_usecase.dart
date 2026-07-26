import '../entities/lobby_state_entity.dart';
import '../repositories/home_repository.dart';

class GetLobbyStateUseCase {
  final HomeRepository repository;
  GetLobbyStateUseCase(this.repository);

  Future<LobbyStateEntity> execute() async {
    return await repository.fetchLobbyData();
  }
}
