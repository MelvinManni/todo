import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/app_bloc.dart';
import 'package:todo/cubit/cubit.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AppBloc>().add(const AppLoggedOut());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: const AddTaskFLoatButton(),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error.toString()),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const _TaskListBuilder(),
        ),
      ),
    );
  }
}

class _TaskListBuilder extends StatelessWidget {
  const _TaskListBuilder();

  @override
  Widget build(BuildContext context) {
    final todoItems = context.select((AppBloc bloc) => bloc.state.todoItems);
    final status = context.select((AppBloc bloc) => bloc.state.status);
    if (status == Status.loading) {
      return const Center(
        child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              color: Colors.blue,
            )),
      );
    } else if (todoItems.isNotEmpty) {
      return ListView.builder(
          itemCount: todoItems.length,
          itemBuilder: (context, index) {
            final item = todoItems[index];
            return ListTile(
                title: Text(item.task),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('Delete Task'),
                              content: const Text(
                                  'Are you sure you want to delete this task?'),
                              actions: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<AppBloc>()
                                          .add(AppTodoItemDeleted(item));
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No')),
                              ],
                            ));
                  },
                ));
          });
    } else {
      return const Center(
        child: Text('No Tasks'),
      );
    }
  }
}

class AddTaskFLoatButton extends StatelessWidget {
  const AddTaskFLoatButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Cancel',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const _AddTaskButton()
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
    final task = context.select((TaskCubit cubit) => cubit.state.task);
    final status = context.select((TaskCubit cubit) => cubit.state.status);
    final userId = context.select((AppBloc bloc) => bloc.state.user.id);

    return TextButton(
        onPressed: () {
          context
              .read<TaskCubit>()
              .addTask(userId: userId, task: task)
              .then((value) {
            if (value != null) {
              context.read<AppBloc>().add(AppTodoItemAdded(value));
              Navigator.of(context).pop();
            }
          });
        },
        child: Text(status == TaskStatus.submitting ? "Submitting..." : "Add"));
  }
}

class _TaskField extends StatelessWidget {
  const _TaskField();

  @override
  Widget build(BuildContext context) {
    final task = context.select((TaskCubit cubit) => cubit.state.task);
    return TextFormField(
      initialValue: task,
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
