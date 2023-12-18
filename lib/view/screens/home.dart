import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/app_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (context) => BlocProvider.value(
            value: BlocProvider.of<AppBloc>(context),
            child: const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: const Center(
            child: Text('Home'),
          ),
        ));
  }
}
