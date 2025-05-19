import 'package:flutter/material.dart';
// import 'pages/mainpage.dart';
import 'presenter/todopresenter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(primaryColor: Colors.blue),
      // home: TodoListMainPage(),
      home: TodoScreen(),
    );
  }
}
