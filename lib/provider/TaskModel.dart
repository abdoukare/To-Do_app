import 'package:flutter/material.dart';
import 'package:week4_task/model/Task.dart';
/*
 @ todo model n7tajoh f les interfaces ta3na 

 */

class Taskmodel extends ChangeNotifier {
  final List<Task> _todotasks = [
    Task(
      "Task 1",
      false,
      "Create Provider",
      DateTime.now().add(Duration(days: 1)),
    ),
    Task(
      "Task 1",
      false,
      "Create Provider",
      DateTime.now().subtract(Duration(days: 1)),
    ),
    Task(
      "Task 1",
      false,
      "Create Provider",
      DateTime.now().add(Duration(days: 3)),
    ),
    Task(
      "Task 4",
      false,
      "Create Provider",
      DateTime.now().add(Duration(days: 4)),
    ),
  ];

  List<Task> get todotasks => _todotasks;
  void add(Task _task) {
    _todotasks.add(_task);
    notifyListeners();
  }
  void markDone(int index, bool _status) {
    _todotasks[index].status = _status;
    notifyListeners();
  }
}