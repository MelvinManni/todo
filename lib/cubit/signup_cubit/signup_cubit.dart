import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/data/repository/repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  AuthRepository _authRepository;
  SignupCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignupInitial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  Future<void> signUpWithCredentials() async {
    if (state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting, error: null));
    try {
      await _authRepository.signUpWithCredentials(
          email: state.email, password: state.password);
      emit(state.copyWith(status: SignupStatus.success, email: '', password: ''));
    } catch (e) {
      emit(state.copyWith(status: SignupStatus.failure, error: e));
    }
  }
}
