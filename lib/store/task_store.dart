import 'package:flutter_reordablelistview/entity/task.dart';
import 'package:mobx/mobx.dart';

part 'task_store.g.dart';

class TaskStore = _TaskStoreBase with _$TaskStore;

abstract class _TaskStoreBase with Store {
  @observable
  ObservableList<Task> tasks = List<Task>().asObservable();

  _TaskStoreBase() {
    _createTaskList();
  }

  void _createTaskList() {
    for (int i = 0; i <= 20; i++) {
      _insertTask(Task("Tarefa $i", description: "Descrição da tarefa $i"), i);
    }
  }

  void resetTaskList() {
    tasks.clear();
    _createTaskList();
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex--;
    }

    final Task item = _removeTaskAt(oldIndex);
    _insertTask(item, newIndex);
  }

  @action
  Task _removeTaskAt(int index) {
    return tasks.removeAt(index);
  }

  @action
  void _insertTask(Task task, int index) {
    tasks.insert(index, task);
  }
}
