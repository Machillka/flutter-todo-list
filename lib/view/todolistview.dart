import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/todolistviewmodel.dart';

class TodoListScreen extends StatelessWidget {
  TodoListScreen({super.key});
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TodoItemViewModel todoViewModel = Provider.of<TodoItemViewModel>(
      context,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("TodoList MVVM Version")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: todoViewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = todoViewModel.todos[index];
                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration:
                          todo.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (_) => todoViewModel.toggleTodo(todo.id),
                  ),
                  onLongPress: () => todoViewModel.removeTodo(todo.id),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                icon: Icon(Icons.add),
                hintText: "Add new task",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              onSubmitted: (value) {
                todoViewModel.addTodo(value);
                _textEditingController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
