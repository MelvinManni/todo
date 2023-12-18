import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/signup_cubit/signup_cubit.dart';
import 'package:todo/data/repository/repository.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => RepositoryProvider(
              create: (context) => AuthRepository(),
              child: BlocProvider(
                create: (context) => SignupCubit(
                  authRepository: context.read<AuthRepository>(),
                ),
                child: const SignUpScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Column(
                  children: [
                    const _EmailField(),
                    const _PasswordField(),
                    TextButton(
                        onPressed: () {
                          context.read<SignupCubit>().signUpWithCredentials();
                        },
                        child: const Text("Sign Up"))
                  ],
                )),
          ),
        ));
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    final password =
        context.select((SignupCubit cubit) => cubit.state.password);
    return TextFormField(
      obscureText: true,
      initialValue: password,
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: 'Enter your password',
      ),
      onChanged: (value) => context.read<SignupCubit>().passwordChanged(value),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    final email = context.select((SignupCubit cubit) => cubit.state.email);
    return TextFormField(
      initialValue: email,
      decoration: const InputDecoration(
        labelText: "Email Address",
        hintText: 'Enter your email',
      ),
      onChanged: (value) => context.read<SignupCubit>().emailChanged(value),
    );
  }
}
