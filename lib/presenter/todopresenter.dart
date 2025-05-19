import 'package:flutter/material.dart';
import '../model/todomodel.dart';

class TodoPresenter {
  final TasksManager tasksManager;
  final TodoView view;

  TodoPresenter(this.tasksManager, this.view);

  // 表示重新加载task列表
  void loadTasks() {
    view.showTasks(tasksManager.getTasks());
  }

  void addTask(String title) {
    tasksManager.addTask(title);
    loadTasks();
  }

  void toggleTaskCompletion(int index) {
    tasksManager.toggleTaskCompletion(index);
    loadTasks();
  }
}

// TodoView 实现
class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> implements TodoView {
  late TodoPresenter presenter;
  List<TodoTaskInformation> tasks = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    presenter = TodoPresenter(TasksManager(), this);
    presenter.loadTasks();
  }

  @override
  void showTasks(List<TodoTaskInformation> updatedTasks) {
    setState(() {
      tasks = updatedTasks;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: TextField(
            controller: _textController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Enter Task Title",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _textController.clear();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String title = _textController.text.trim();
                if (title.isNotEmpty) {
                  presenter.addTask(title);
                }
                _textController.clear();
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final item = tasks.removeAt(oldIndex);
            tasks.insert(newIndex, item);
            presenter.tasksManager.reorderTasks(oldIndex, newIndex);
          });
        },
        children: [
          for (int i = 0; i < tasks.length; i++)
            ListTile(
              key: ValueKey(tasks[i].id),
              title: Text(
                tasks[i].title,
                style: TextStyle(
                  decoration: tasks[i].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                ),),
              trailing: Checkbox(
                value: tasks[i].isCompleted,
                onChanged: (_) {
                  presenter.toggleTaskCompletion(i);
                },
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
