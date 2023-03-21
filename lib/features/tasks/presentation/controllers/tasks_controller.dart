import 'package:riverpod/riverpod.dart';
import '../../domain/domain.dart';

final tasksControllerProvider =
    StateNotifierProvider.autoDispose<TasksController, AsyncValue<List<Task>>>(
        (ref) {
  return TasksController(ref);
});

class TasksController extends StateNotifier<AsyncValue<List<Task>>> {
  StateNotifierProviderRef ref;
  TasksController(this.ref) : super(const AsyncValue.loading()) {
    getTasks();
  }

  void addTask(String title) async {
    state = const AsyncLoading();

    final addTask = await ref.read(addTaskUseCaseProvider.future);

    var task = Task(title: title);

    var response = await addTask(AddTaskParams(task: task));
    await response.fold((failure) {
      state = AsyncError(failure.message, StackTrace.current);
    }, (success) async {
      await getTasks();
    });
  }

  Future<void> getTasks() async {
    state = const AsyncLoading();

    final getTasks = await ref.read(getTasksUseCaseProvider.future);

    var response = await getTasks();

    response.fold((failure) {
      state = AsyncError(failure.message, StackTrace.current);
    }, (tasks) {
      state = AsyncData(tasks);
    });
  }

  void deleteTask(Task task) async {
    final deleteTask = await ref.read(deleteTaskUseCaseProvider.future);

    var response = await deleteTask(DeleteTaskParams(task: task));

    await response.fold((failure) {
      state = AsyncError(failure.message, StackTrace.current);
    }, (_) async {
      await getTasks();
    });
  }

  void toggle(Task task) async {
    var updateTask = await ref.read(updateTaskUseCaseProvider.future);

    var response = await updateTask(
      UpdateTaskParams(
          task: task.copyWith(
        isDone: !task.isDone,
      )),
    );

    response.fold((failure) {
      state = AsyncError(failure.message, StackTrace.current);
    }, (_) {
      getTasks();
    });
  }
}