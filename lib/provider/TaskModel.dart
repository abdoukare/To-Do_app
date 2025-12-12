import 'package:flutter/material.dart';
import 'package:week4_task/model/Task.dart';
import 'package:week4_task/library/globals.dart' as globals;
import 'package:dart_date/dart_date.dart';
/*
 @ todo model n7tajoh f les interfaces ta3na 

 */

class Taskmodel extends ChangeNotifier {
  final Map<String, List<Task>> _todotasks = {
    globals.late: [
      Task(
        "Task 1",
        false,
        "Create Provider",
        DateTime.now().add(Duration(days: 1)),
      ),
    ],
    globals.today: [
      Task(
        "Today Task 1",
        false,
        "Create Provider",
        DateTime.now().add(Duration(days: 1)),
      ),
      Task(
        "Today Task 2 ",
        false,
        "Create Provider",
        DateTime.now().add(Duration(days: 1)),
      ),
    ],
    globals.tomorrow: [
      Task(
        "Tomorrow Task 1",
        false,
        "Create Provider",
        DateTime.now().add(Duration(days: 1)),
      ),
    ],
    globals.thisWeek: [
      Task(
        " thisWeek Task 1",
        false,
        "Create Provider",
        DateTime.now().add(Duration(days: 1)),
      ),
    ],
    globals.nextWeek: [
      Task(
        "nextWeek Task 1",
        false,
        "Create Provider",
        DateTime.now().add(Duration(days: 1)),
      ),
    ],
    globals.thisMonth: [
      Task(
        "Task 1",
        false,
        "Create Provider",
        DateTime.now().add(Duration(days: 1)),
      ),
    ],
    globals.later: [
      Task(
        "Task 1",
        false,
        "Create Provider",
        DateTime.now().add(Duration(days: 1)),
      ),
    ],
  };
  Map<String, List<Task>> get todotasks => _todotasks;
  void add(Task _task) {
    String _key = guessTodoKeyFromDate(_task.deadline);
    if (_todotasks.containsKey(_key)) {
      _todotasks[_key]!.add(_task);
    }
    notifyListeners();
  }

  int countTaskByDate(DateTime _datetime) {
    String _key = guessTodoKeyFromDate(_datetime);
    if (_todotasks.containsKey(_key)) {
      _todotasks[_key]!
          .where(
            (task) =>
                task.deadline.day == _datetime.day &&
                task.deadline.month == _datetime.month &&
                task.deadline.year == _datetime.year,
          )
          .length;
    }
    return 0;
  }

  void markDone(int index, String key) {
    _todotasks[key]![index].status = true;
    notifyListeners();
  }

  String guessTodoKeyFromDate(DateTime deadline) {
    if (deadline.isPast && !deadline.isToday) {
      return globals.late;
    } else if (deadline.isToday) {
      return globals.today;
    } else if (deadline.isTomorrow) {
      return globals.tomorrow;
    } else if (deadline.getWeek == DateTime.now().getWeek &&
        deadline.year == DateTime.now().year) {
      return globals.thisWeek;
    } else if (deadline.getWeek == DateTime.now().getWeek + 1 &&
        deadline.year == DateTime.now().year) {
      return globals.nextWeek;
    } else if (deadline.isThisMonth) {
      return globals.later;
    }
    return globals.later;
  }
}
