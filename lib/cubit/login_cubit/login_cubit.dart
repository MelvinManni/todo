import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/data/repository/repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginInitial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  Future<void> logInWithCredentials() async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.signInWithCredentials(
          email: state.email, password: state.password);
      emit(state.copyWith(status: LoginStatus.success, email: '', password: ''));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, error: e));
    }
  }
}
