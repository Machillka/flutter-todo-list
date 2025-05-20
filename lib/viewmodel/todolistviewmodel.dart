import 'package:flutter/material.dart';
import '../model/todomodel.dart';

class TodoItemViewModel extends ChangeNotifier {
  List<TodoItem> _todos = [];

  List<TodoItem> get todos => _todos;

  void addTodo(String title) {
    _todos.add(TodoItem(id: DateTime.now().toString(), title: title));
    notifyListeners();
  }

  void toggleTodo(String id) {
    _todos = _todos.map((todo) {
      if (todo.id == id) {
        return TodoItem(id: todo.id, title: todo.title, isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
    notifyListeners();
  }

  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
