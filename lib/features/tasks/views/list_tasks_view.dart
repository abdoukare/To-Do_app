import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week4_task/shared/constants/app_constants.dart';
import 'package:week4_task/features/tasks/controllers/task_controller.dart';
import 'package:week4_task/features/tasks/views/widgets/task_list_widget.dart';
import 'package:week4_task/features/tasks/views/widgets/all_tasks_widget.dart';

class ListTasksView extends StatelessWidget {
  ListTasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final TaskController taskController = Get.put(TaskController());
    
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Tasks'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Today'),
              Tab(text: 'Tomorrow'),
              Tab(text: 'This Week'),
              Tab(text: 'Next Week'),
            ],
          ),
        ),
        body: Obx(() {
          // Show loading indicator
          if (taskController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return TabBarView(
            children: [
              // All tasks
              AllTasksWidget(),
              
              // Today
              TaskListWidget(category: TaskCategories.today),
              
              // Tomorrow
              TaskListWidget(category: TaskCategories.tomorrow),
              
              // This Week
              TaskListWidget(category: TaskCategories.thisWeek),
              
              // Next Week
              TaskListWidget(category: TaskCategories.nextWeek),
            ],
          );
        }),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.toNamed('/addTask'); // ← GetX navigation
          },
        ),
      ),
    );
  }
}
