import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/data/models/todo_item_model.dart';
import 'package:todo/data/repository/repository.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TodoRepository _todoRepository;
  TaskCubit({
    required TodoRepository todoRepository,
  })  : _todoRepository = todoRepository,
        super(const TaskInitial());

  void updateTask(String task) =>
      emit(TaskState(task: task, status: TaskStatus.initial));

  Future<TodoItem?> addTask({
    required String userId,
    required String task,
  }) async {
    if (task.isEmpty || state.status == TaskStatus.submitting) return null;
    emit(TaskState(task: task, status: TaskStatus.submitting));
    try {
      final todoItem = await _todoRepository.add(userId: userId, task: task);
      emit(const TaskState(task: '', status: TaskStatus.success,));
      return todoItem;
    } catch (e) {
      emit(TaskState(task: task, status: TaskStatus.error));
    }
    return null;
  }
}
