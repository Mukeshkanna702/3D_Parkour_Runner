import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {
  final String providerName;
  const LoginLoadingState(this.providerName);

  @override
  List<Object?> get props => [providerName];
}

class LoginSuccessState extends LoginState {
  final UserEntity user;
  const LoginSuccessState(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginFailureState extends LoginState {
  final String errorMessage;
  const LoginFailureState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
