import 'package:equatable/equatable.dart';
import '../../domain/usecases/login_usecase.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class SubmitLoginEvent extends LoginEvent {
  final LoginProviderType providerType;
  final String? email;
  final String? password;

  const SubmitLoginEvent({
    required this.providerType,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [providerType, email, password];
}
