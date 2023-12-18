part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  const SignupState({
    required this.email,
    required this.password,
    required this.status,
  });

  final String email;
  final String password;
  final SignupStatus status;

  SignupState copyWith({
    String? email,
    String? password,
    SignupStatus? status,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        status,
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
