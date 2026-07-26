import 'package:equatable/equatable.dart';
import '../../domain/entities/lobby_state_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final LobbyStateEntity lobbyData;
  const HomeLoadedState(this.lobbyData);

  @override
  List<Object?> get props => [lobbyData];
}

class HomeErrorState extends HomeState {
  final String message;
  const HomeErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
