part of 'task_cubit.dart';

enum TaskStatus { initial, submitting, success, error }

class TaskState extends Equatable {
  const TaskState({
    required this.task,
    required this.status,
  });
  final String task;
  final TaskStatus status;

  @override
  List<Object> get props => [task];
}

final class TaskInitial extends TaskState {
  const TaskInitial() : super(task: '', status: TaskStatus.initial);
}
