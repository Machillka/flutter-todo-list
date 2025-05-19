import 'package:flutter/material.dart';
import '../utilities/todoitem.dart';

class TodoListMainPage extends StatefulWidget {
  const TodoListMainPage({super.key});

  @override
  State<TodoListMainPage> createState() => _TodoListMainPageState();
}

class _TodoListMainPageState extends State<TodoListMainPage> {
  final List<TodoItem> _todoItems = [];
  final TextEditingController _textEditingController = TextEditingController();

  void _addTodoItem(String title) {
    if (title.isEmpty) return;
    setState(() {
      _todoItems.add(TodoItem(title, false));
    });
    _textEditingController.clear();
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoItems[index].isDone = !_todoItems[index].isDone;
    });
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _todoAppBar(), body: _todoBody());
  }

  AppBar _todoAppBar() {
    return AppBar(title: Text('Todo List'));
  }

  Widget _todoBody() {
    return Column(
      children: [_inputSection(), Expanded(child: _todoListView())],
    );
  }

  Widget _inputSection() {
    return Padding(
      padding: const EdgeInsets.all(0.8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: "Input new Todo List Item",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
                )
              ),
              onSubmitted: _addTodoItem,
            ),
          ),
          IconButton(
            onPressed: () {
              _addTodoItem(_textEditingController.text);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _todoListView() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        final todoItem = _todoItems[index];
        return ListTile(
          leading: Checkbox(
            value: todoItem.isDone,
            onChanged: (value) {
              _toggleTodoItem(index);
            },
          ),
          title: Text(
            todoItem.title ?? '',
            style: TextStyle(
              decoration:
                  todoItem.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              _deleteTodoItem(index);
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
