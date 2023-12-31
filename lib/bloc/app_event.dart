part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

final class AppStarted extends AppEvent {
  const AppStarted();
}

final class AppLoggedIn extends AppEvent {
  final User user;
  const AppLoggedIn(this.user);

  @override
  List<Object> get props => [user];
}

final class AppLoggedOut extends AppEvent {
  const AppLoggedOut();
}

final class AppTodoItemsRequested extends AppEvent {
  final String user;
  const AppTodoItemsRequested(
    this.user,
  );
}

final class AppTodoItemAdded extends AppEvent {
  final TodoItem todoItem;
  const AppTodoItemAdded(this.todoItem);

  @override
  List<Object> get props => [todoItem];
}

final class AppTodoItemDeleted extends AppEvent {
  final TodoItem todoItem;
  const AppTodoItemDeleted(this.todoItem);

  @override
  List<Object> get props => [todoItem];
}
