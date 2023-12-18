import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/data/models/todo_item_model.dart';
import 'package:todo/data/models/user_model.dart';
import 'package:todo/data/repository/repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  final TodoRepository _todoRepository;

  AppBloc(
      {required AuthRepository authRepository,
      required TodoRepository todoRepository})
      : _authRepository = authRepository,
        _todoRepository = todoRepository,
        super(const AppInitial()) {
    _authRepository.user.listen((user) {
      if (user == null) {
        add(const AppLoggedOut());
      } else {
        add(AppTodoItemsRequested(user.id));
        add(AppLoggedIn(user));
      }
    });

    on<AppLoggedIn>((event, emit) {
      event.user.isEmpty
          ? emit(const AppState(authStatus: AuthStatus.unauthenticated))
          : emit(
              AppState(authStatus: AuthStatus.authenticated, user: event.user));
    });
    on<AppLoggedOut>((event, emit) {
      unawaited(_authRepository.signOut());
      emit(const AppState(authStatus: AuthStatus.unauthenticated));
    });
    on<AppTodoItemsRequested>((event, emit) async {
      emit(state.copyWith(status: Status.loading, error: null));

      await _todoRepository
          .todos(userId: event.user)
          .then((value) =>
              {emit(state.copyWith(status: Status.success, todos: value))})
          .onError((error, stackTrace) =>
              {emit(state.copyWith(status: Status.failure, error: error))});
    });
    on<AppTodoItemAdded>((event, emit) {
      emit(state.copyWith(
          status: Status.success, todos: [...state.todoItems, event.todoItem]));
    });

    on<AppTodoItemDeleted>((event, emit) async {
      emit(state.copyWith(status: Status.loading, error: null));
      await _todoRepository
          .delete(userId: event.todoItem.user, todoId: event.todoItem.id)
          .then((value) => {
                emit(state.copyWith(
                    status: Status.success,
                    todos: state.todoItems
                        .where((element) => element.id != event.todoItem.id)
                        .toList()))
              })
          .onError((error, stackTrace) =>
              {emit(state.copyWith(status: Status.failure, error: error))});
    });
  }
}
