import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/app_bloc.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/data/models/todo_item_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: BlocProvider.of<AppBloc>(context)),
          BlocProvider.value(value: BlocProvider.of<TaskCubit>(context)),
        ],
        child: const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.select((AppState state) => state.user);
    // final task = context.select((TaskState state) => state.task);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: const AddTaskFLoatButton(),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: const Center(
          child: Text('Home'),
        ),
      ),
    );
  }
}

class AddTaskFLoatButton extends StatelessWidget {
  const AddTaskFLoatButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final task = context.select((TaskState state) => state.task);
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Add New Task'),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _TaskField(),
                      SizedBox(height: 20),
                      _AddTaskButton()
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        context
                            .read<AppBloc>()
                            .add(AppTodoItemAdded(TodoItem(task: "Hello")));
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ));
      },
      child: const Icon(Icons.add),
    );
  }
}

class _AddTaskButton extends StatelessWidget {
  const _AddTaskButton();

  @override
  Widget build(BuildContext context) {
    final task = context.select((AppState state) => state.user);
    print(task);
    return ElevatedButton(
        onPressed: () {
          context
              .read<AppBloc>()
              .add(AppTodoItemAdded(TodoItem(task: "task")));
          Navigator.of(context).pop();
        },
        child: const Text("Add"));
  }
}

class _TaskField extends StatelessWidget {
  const _TaskField();

  @override
  Widget build(BuildContext context) {
    // final task = context.select((TaskState state) => state.task);
    return TextFormField(
      // initialValue: task,
      decoration: const InputDecoration(
        labelText: "Task",
        hintText: 'Enter your task',
      ),
      onChanged: (value) {
        context.read<TaskCubit>().updateTask(value);
      },
    );
  }
}
