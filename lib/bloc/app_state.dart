part of 'app_bloc.dart';

enum AuthStatus {
  uninitialized,
  authenticated,
  unauthenticated,
}

enum Status {
  initial,
  loading,
  success,
  failure,
}

class AppState extends Equatable {
  const AppState({
    required this.authStatus,
    this.status,
    this.user = User.empty,
    this.todoItems = const [],
    this.error,
  });

  final AuthStatus authStatus;
  final Status? status;
  final User user;
  final List<TodoItem> todoItems;
  final Object? error;

  @override
  List<Object> get props => [
        authStatus,
        status ?? Status.initial,
        user,
        todoItems,
        error ?? '',
      ];

  AppState copyWith(
      {required Status status, List<TodoItem>? todos, Object? error}) {
    return AppState(
      authStatus: authStatus,
      status: status,
      user: user,
      todoItems: todos ?? todoItems,
      error: error ?? error,
    );
  }
}

final class AppInitial extends AppState {
  const AppInitial() : super(authStatus: AuthStatus.uninitialized);
}
