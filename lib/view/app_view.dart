import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/app_bloc.dart';
import 'package:todo/view/screens/home.dart';
import 'package:todo/view/screens/login.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.unauthenticated) {
          Navigator.of(context).pushAndRemoveUntil(LoginScreen.route(), (route) => false);
        } else if (state.authStatus == AuthStatus.authenticated) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<AppBloc>(context),
                        child: const HomeScreen(),
                      )),
              (route) => false);
        }
      },
      child: Material(
        color: Colors.primaries[0],
        child: const Center(
          child: SizedBox(
              width: 40, height: 40, child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
