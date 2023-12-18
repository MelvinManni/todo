import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/app_bloc.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/view/app_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = const AppBlocObserver();
  runApp(const MainApp());
}

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => TodoRepository(),
        ),
      ],
      child: BlocProvider(
          create: (context) => AppBloc(
                authRepository: context.read<AuthRepository>(),
                todoRepository: context.read<TodoRepository>(),
              ),
          child: MaterialApp(
            title: 'Todo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: const AppView(),
            ),
          )),
    );
  }
}
