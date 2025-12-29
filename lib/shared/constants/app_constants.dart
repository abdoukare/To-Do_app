/// Task category constants for organizing tasks
class TaskCategories {
  static const String late = 'late';
  static const String today = 'today';
  static const String tomorrow = 'tomorrow';
  static const String thisWeek = 'this_week';
  static const String nextWeek = 'next_week';
  static const String thisMonth = 'this_month';
  static const String later = 'later';
}

/// Display names for task categories
class TaskCategoryNames {
  static const Map<String, String> names = {
    TaskCategories.late: 'Late',
    TaskCategories.today: 'Today',
    TaskCategories.tomorrow: 'Tomorrow',
    TaskCategories.thisWeek: 'This Week',
    TaskCategories.nextWeek: 'Next Week',
    TaskCategories.thisMonth: 'This Month',
    TaskCategories.later: 'Later',
  };
}

/// SharedPreferences storage keys
class StorageKeys {
  static const String tasksKey = 'tasks_key';
}
