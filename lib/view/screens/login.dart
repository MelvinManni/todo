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
      body: const Center(
          child: Column(
        children: [
          _EmailField(),
          _PasswordField(),
        ],
      )),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
      ),
    );
  }
}
