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
    on<AppLoggedIn>((event, emit) {
      emit(AppState(authStatus: AuthStatus.authenticated, user: event.user));
    });
    on<AppLoggedOut>((event, emit) {
      unawaited(_authRepository.signOut());
      emit(const AppState(authStatus: AuthStatus.unauthenticated));
    });
    on<AppTodoItemsRequested>((event, emit) {
      emit(state.copyWith(status: Status.loading));
      _todoRepository.todos(userId: state.user.id).listen((todos) {
        emit(state.copyWith(status: Status.success, todos: todos));
      });
    });
    on<AppTodoItemAdded>((event, emit) {
      emit(state.copyWith(status: Status.loading));
      _todoRepository
          .add(userId: state.user.id, todo: event.task)
          .then((value) => {
                emit(state.copyWith(
                    status: Status.success, todos: [...state.todoItems, value]))
              });
    });
    on<AppTodoItemDeleted>((event, emit) {
      emit(state.copyWith(status: Status.loading));
      _todoRepository
          .delete(userId: state.user.id, todoId: event.todoItem.id)
          .then((value) => {
                emit(state.copyWith(
                    status: Status.success,
                    todos: state.todoItems
                        .where((element) => element.id != event.todoItem.id)
                        .toList()))
              });
    });
  }
}
