import '../../domain/entities/lobby_state_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<LobbyStateEntity> fetchLobbyData() async {
    return await remoteDataSource.getLobbyData();
  }
}
