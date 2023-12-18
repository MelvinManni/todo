import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:todo/cubit/login_cubit/login_cubit.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/view/screens/signup.dart';

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
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Column(
              children: [
                const _EmailField(),
                const _PasswordField(),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      context.read<LoginCubit>().logInWithCredentials();
                    },
                    child: const Text("Login")),
                const SizedBox(height: 10),
                RichText(
                    text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          text: "Sign Up",
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(SignUpScreen.route());
                            })
                    ]))
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
