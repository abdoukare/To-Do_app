import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week4_task/provider/TaskModel.dart';
import 'package:week4_task/view/AddTasksView.dart';
import 'package:week4_task/view/ListTasksView.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Taskmodel())],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      home: ListTasksView(),
      routes: {"listTasks": (context) => ListTasksView(),
	  "addTasks": (context) => AddTasksView(),
	  },
    );
  }
}
