part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, failure }

class SignupState extends Equatable {
  const SignupState({
    required this.email,
    required this.password,
    required this.status,
    this.error,
  });

  final String email;
  final String password;
  final SignupStatus status;
  final Object? error;

  SignupState copyWith({
    String? email,
    String? password,
    SignupStatus? status,
    Object? error,
  }) {
    return SignupState(
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

final class SignupInitial extends SignupState {
  const SignupInitial()
      : super(
          email: '',
          password: '',
          status: SignupStatus.initial,
        );
}
