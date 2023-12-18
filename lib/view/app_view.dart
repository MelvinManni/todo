import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/app_bloc.dart';
import 'package:todo/view/screens/home.dart';
import 'package:todo/view/screens/login.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListenForAuthStatusChange(
      child: Material(
        color: Colors.blue,
        child: Center(
          child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}

class ListenForAuthStatusChange extends StatelessWidget {
  const ListenForAuthStatusChange({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (prev, curr) => prev.authStatus != curr.authStatus,
      listener: (context, state) {
        if (state.authStatus == AuthStatus.unauthenticated) {
          Navigator.of(context)
              .pushAndRemoveUntil(LoginScreen.route(), (route) => false);
        } else if (state.authStatus == AuthStatus.authenticated) {
          Navigator.of(context)
              .pushAndRemoveUntil(HomeScreen.route(), (route) => false);
        }
      },
      child: child,
    );
  }
}
