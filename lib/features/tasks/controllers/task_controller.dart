import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_date/dart_date.dart';
import 'package:week4_task/shared/models/task.dart';
import 'package:week4_task/shared/constants/app_constants.dart';

class TaskController extends GetxController {
  // observalble variables
  var tasks = <String, List<Task>>{}.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializedCategories();
    loadTasks();
  }

  // Initialize empty categoriz
  void _initializedCategories() {
    tasks.value = {
      TaskCategories.late: [],
      TaskCategories.today: [],
      TaskCategories.tomorrow: [],
      TaskCategories.thisWeek: [],
      TaskCategories.nextWeek: [],
      TaskCategories.thisMonth: [],
      TaskCategories.later: [],
    };
  }

  // Load tasks from SharedPreferences
  Future<void> loadTasks() async {
    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? tasksJson = prefs.getString('tasks');
      if (tasksJson != null) {
        final Map<String, dynamic> decoded = json.decode(tasksJson);
        final Map<String, List<Task>> loadedTasks = {};
        decoded.forEach((category, tasksList) {
          loadedTasks[category] = (tasksList as List)
              .map((tasksJson) => Task.fromJson(tasksJson))
              .toList(); // convert each json string to a map with
        });
        tasks.value = loadedTasks; // update observables
      }
    } catch (error) {
      print('Error loading tasks: $error');
      Get.snackbar(
        'Error',
        'Failed to load tasks.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false; // updating obersvables
  }

  // save tasks to sharedpreferences
  Future _saveTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final Map<String, dynamic> taskToSave = {};
      tasks.forEach((category, taskList) {
        taskToSave[category] = taskList.map((task) => task.toJson()).toList();
      });
      final String encoded = json.encode(taskToSave);
      await prefs.setString('tasks', encoded);
    } catch (error) {
      print('Error saving tasks: $error');
      Get.snackbar(
        'Error',
        'Failed to save tasks.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future addTask(Task task) async {
    final category = _getCategoryFromDate(task.deadline);
    if (tasks.containsKey(category)) {
      tasks[category]!.add(task);
      tasks.refresh(); // getx observable refresh
      await _saveTasks();
      Get.snackbar(
        'Task Added',
        'Task added successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future markTaskAsDone(int index, String category) async {
    if (tasks.containsKey(category) && index < tasks[category]!.length) {
      tasks[category]![index] = tasks[category]![index].copyWith(status: true);
      tasks.refresh();
      await _saveTasks();
    }
  }

  int countTasksByDate(DateTime date) {
    final category = _getCategoryFromDate(date);
    if (tasks.containsKey(category)) {
      return tasks[category]!
          .where(
            (task) =>
                task.deadline.day == date.day &&
                task.deadline.month == date.month &&
                task.deadline.year == date.year,
          )
          .length;
    }

    return 0;
  }

  // delete tasks
  Future deleteTask(int index, String category) async {
    if (tasks.containsKey(category) && index < tasks[category]!.length) {
      tasks[category]!.removeAt(index);
      tasks.refresh();
      await _saveTasks();
      Get.snackbar(
        'Task Deleted',
        'Task deleted successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Determine category from deadline
  String _getCategoryFromDate(DateTime deadline) {
    if (deadline.isPast && !deadline.isToday) {
      return TaskCategories.late;
    } else if (deadline.isToday) {
      return TaskCategories.today;
    } else if (deadline.isTomorrow) {
      return TaskCategories.tomorrow;
    } else if (deadline.getWeek == DateTime.now().getWeek &&
        deadline.year == DateTime.now().year) {
      return TaskCategories.thisWeek;
    } else if (deadline.getWeek == DateTime.now().getWeek + 1 &&
        deadline.year == DateTime.now().year) {
      return TaskCategories.nextWeek;
    } else if (deadline.isThisMonth) {
      return TaskCategories.thisMonth;
    }
    return TaskCategories.later;
  }
}
