import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:week4_task/shared/constants/app_constants.dart';
import 'package:week4_task/features/tasks/controllers/task_controller.dart';

class TaskListWidget extends StatelessWidget {
  final String category;
  const TaskListWidget({Key? key, required this.category}): super(key: key);
  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    return Obx(() {
      final tasks = taskController.tasks[category] ?? [];

      if (tasks.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.task_alt, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No tasks for ${TaskCategoryNames.names[category]}',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          final dateFormat = DateFormat('MMM dd, yyyy - HH:mm');

          return CheckboxListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.status ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(dateFormat.format(task.deadline)),
            value: task.status,
            onChanged: (bool? value) {
              if (value == true) {
                taskController.markTaskAsDone(index, category);
              }
            },
          );
        },
      );
    });
  }
}
