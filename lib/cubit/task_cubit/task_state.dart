part of 'task_cubit.dart';

class TaskState extends Equatable {
  const TaskState(this.task);
  final String task;

  @override
  List<Object> get props => [task];
}

final class TaskInitial extends TaskState {
  const TaskInitial() : super('');
}
