// 单个代办任务信息
class TodoTaskInformation {
  String id;
  String title;
  bool isCompleted;

  TodoTaskInformation({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}

// 管理所有的待办任务
class TasksManager {
  List<TodoTaskInformation> _tasks = [];
  List<TodoTaskInformation> getTasks() => _tasks;

  void addTask(String title) {
    _tasks.add(
      TodoTaskInformation(id: DateTime.now().toString(), title: title),
    );
  }

  void deletaTask(int index) {
    if (index < 0 || index >= _tasks.length) {
      throw RangeError("Index out of range");
    }
    _tasks.removeAt(index);
  }

  void toggleTaskCompletion(int index) {
    if (index < 0 || index >= _tasks.length) {
      throw RangeError("Index out of range");
    }
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
  }

    // 拖拽排序更新任务顺序
  void reorderTasks(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final TodoTaskInformation item = _tasks.removeAt(oldIndex);
    _tasks.insert(newIndex, item);
  }
}

abstract class TodoView {
  void showTasks(List<TodoTaskInformation> tasks);
}
