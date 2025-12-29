import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:week4_task/shared/constants/app_constants.dart';
import 'package:week4_task/features/tasks/controllers/task_controller.dart';

class AllTasksWidget extends StatelessWidget {
  const AllTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    return Obx(() {
      final allTasks = taskController.tasks;
      final dateFormat = DateFormat('MMM dd, yyyy - HH:mm');

      return ListView(
        children: TaskCategoryNames.names.entries.map((entry) {
          final category = entry.key;
          final categoryName = entry.value;
          final tasks = allTasks[category] ?? [];

          if (tasks.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  categoryName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...tasks.asMap().entries.map((taskEntry) {
                final index = taskEntry.key;
                final task = taskEntry.value;

                return CheckboxListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.status
                          ? TextDecoration.lineThrough
                          : null,
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
              }).toList(),
              const Divider(),
            ],
          );
        }).toList(),
      );
    });
  }
}
