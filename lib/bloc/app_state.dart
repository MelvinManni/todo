part of 'app_bloc.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

enum Status {
  initial,
  loading,
  success,
  failure,
}

sealed class AppState extends Equatable {
  const AppState({
    required this.authStatus,
    this.status,
    this.user,
    this.todoItems = const [],
  });

  final AuthStatus authStatus;
  final Status? status;
  final User? user;
  final List<TodoItem> todoItems;

  @override
  List<Object> get props => [
        authStatus,
        status ?? Status.initial,
        user ?? const User(),
        todoItems,
      ];
}

final class AppInitial extends AppState {
  const AppInitial() : super(authStatus: AuthStatus.unauthenticated);
}
