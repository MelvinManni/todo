part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, failure }

class LoginState extends Equatable {
  const LoginState({
    required this.email,
    required this.password,
    required this.status,
    this.error,
  });

  final String email;
  final String password;
  final LoginStatus status;
  final Object? error;

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    Object? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        status,
        error ?? '',
      ];
}

final class LoginInitial extends LoginState {
  const LoginInitial()
      : super(
          email: '',
          password: '',
          status: LoginStatus.initial,
        );
}
