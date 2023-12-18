import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/login_cubit/login_cubit.dart';
import 'package:todo/data/repository/repository.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => RepositoryProvider(
              create: (context) => AuthRepository(),
              child: BlocProvider(
                create: (context) => LoginCubit(
                  authRepository: context.read<AuthRepository>(),
                ),
                child: const LoginScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: const SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Column(
              children: [
                _EmailField(),
                _PasswordField(),
              ],
            ),
          )),
        ));
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    final password = context.select((LoginCubit cubit) => cubit.state.password);
    return TextFormField(
      obscureText: true,
      onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
      initialValue: password,
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: 'Enter your password',
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    final email = context.select((LoginCubit cubit) => cubit.state.email);
    return TextFormField(
      onChanged: (value) => context.read<LoginCubit>().emailChanged(value),
      initialValue: email,
      decoration: const InputDecoration(
        labelText: "Email Address",
        hintText: 'Enter your email',
      ),
    );
  }
}
