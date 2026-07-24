import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitialState()) {
    on<SubmitLoginEvent>(_onSubmitLogin);
  }

  Future<void> _onSubmitLogin(
    SubmitLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState(event.providerType.name.toUpperCase()));

    try {
      final user = await loginUseCase.execute(
        type: event.providerType,
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccessState(user));
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }
}
