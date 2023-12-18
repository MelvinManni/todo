part of 'task_cubit.dart';

enum TaskStatus { initial, submitting, success, failure }

class TaskState extends Equatable {
  const TaskState({
    required this.task,
    required this.status, 
    this.error,
  });
  final String task;
  final TaskStatus status;
  final Object? error;

  @override
  List<Object> get props => [task, status, error ?? ''];
}

final class TaskInitial extends TaskState {
  const TaskInitial() : super(task: '', status: TaskStatus.initial);

}
