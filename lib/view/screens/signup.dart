import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/signup_cubit/signup_cubit.dart';
import 'package:todo/view/app_view.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<SignupCubit>(context),
        child: const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final status = context.select((SignupCubit cubit) => cubit.state.status);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.status == SignupStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error.toString()),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: ListenForAuthStatusChange(
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Column(
                    children: [
                      const _EmailField(),
                      const _PasswordField(),
                      TextButton(
                          onPressed: () {
                            context.read<SignupCubit>().signUpWithCredentials();
                          },
                          child: Text(status == SignupStatus.submitting
                              ? "Submitting..."
                              : "Sign Up"))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
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
