import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week4_task/features/tasks/views/list_tasks_view.dart';
import 'package:week4_task/features/tasks/views/add_task_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // ← Changed from MaterialApp to GetMaterialApp
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [  // ← GetX routing (replaces routes)
        GetPage(name: '/', page: () =>  ListTasksView()),
        GetPage(name: '/addTask', page: () => const AddTaskView()),
      ],
    );
  }
}