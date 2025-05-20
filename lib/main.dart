import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:todo_list/presenter/todopresenter.dart';
// import 'pages/mainpage.dart';
// import 'presenter/todopresenter.dart';
import 'view/todolistview.dart';
import 'viewmodel/todolistviewmodel.dart';

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Todo List',
//       theme: ThemeData(primaryColor: Colors.blue),
//       // home: TodoListMainPage(),
//       home: TodoScreen(),
//     );
//   }
// }

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoItemViewModel(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Todo List MVVM Version", home: TodoListScreen());
  }
}
