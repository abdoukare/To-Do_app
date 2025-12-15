# Week 4 Task - Flutter Todo Application

A feature-rich Flutter todo/task management application that helps users organize and manage their tasks with categorization by time periods (Today, Tomorrow, This Week, Next Week, etc.).

## 📋 Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Architecture](#architecture)
- [Installation & Setup](#installation--setup)
- [Dependencies](#dependencies)
- [Usage](#usage)
- [File Descriptions](#file-descriptions)
- [State Management](#state-management)
- [How It Works](#how-it-works)

---

## ✨ Features

### Task Management
- **Add New Tasks** - Create tasks with title, description, and deadline
- **View Tasks** - Organize and view tasks by categories
- **Mark as Complete** - Check off completed tasks
- **Multiple Categories** - Tasks are automatically categorized:
  - **Late** - Past due tasks
  - **Today** - Tasks due today
  - **Tomorrow** - Tasks due tomorrow
  - **This Week** - Tasks due within the current week
  - **Next Week** - Tasks due in the next week
  - **This Month** - Tasks due this month
  - **Later** - All other tasks

### UI/UX
- **Tabbed Navigation** - Easy switching between different task views
- **All Tasks View** - See all tasks categorized together
- **Individual Category Views** - Dedicated views for each time period
- **Interactive Calendar** - Calendar picker for selecting task deadlines
- **Responsive Design** - Works on various screen sizes
- **Real-time Updates** - UI updates automatically when tasks change

---

## 📁 Project Structure

```
week4_task/
├── lib/
│   ├── main.dart                 # Entry point with Provider setup
│   ├── model/
│   │   └── Task.dart             # Task data model
│   ├── provider/
│   │   └── TaskModel.dart        # State management (ChangeNotifier)
│   ├── library/
│   │   └── globals.dart          # Global constants and category names
│   ├── view/
│   │   ├── ListTasksView.dart    # Main tasks list view with tabs
│   │   └── AddTasksView.dart     # Add new task form view
│   └── widget/
│       ├── ListTask.dart         # Single category task list widget
│       └── ListTaskAll.dart      # All tasks combined widget
├── pubspec.yaml                  # Dependencies and project configuration
└── README.md                      # This file
```

---

## 🏗️ Architecture

This project follows the **Provider Pattern** for state management and **MVVM-like architecture**:

```
main.dart (Entry Point with MultiProvider)
    ↓
TaskModel (ChangeNotifier - State Manager)
    ↓
Views (ListTasksView, AddTasksView)
    ↓
Widgets (ListTask, ListTaskAll - Consumers)
```

### Architecture Benefits:
- **Separation of Concerns** - Logic separated from UI
- **Reactive Updates** - UI automatically updates when data changes
- **Easy Testing** - State management is isolated
- **Scalability** - Easy to add new features

---

## 🚀 Installation & Setup

### Prerequisites
- Flutter SDK (^3.9.2)
- Dart SDK
- Android Studio / Xcode (for emulator)
- Git

### Steps

1. **Clone the Project**
   ```bash
   git clone <repository-url>
   cd week4_task
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the Application**
   ```bash
   flutter run
   ```

4. **Build for Production**
   ```bash
   # Android
   flutter build apk

   # iOS
   flutter build ios

   # Web
   flutter build web
   ```

---

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| **flutter** | SDK | Flutter framework |
| **provider** | ^6.1.5+1 | State management |
| **table_calendar** | ^3.2.0 | Interactive calendar widget |
| **dart_date** | ^1.5.3 | Date utility functions |
| **cupertino_icons** | ^1.0.8 | iOS-style icons |

### Why These Dependencies?
- **Provider**: Lightweight, efficient state management
- **Table Calendar**: Beautiful, customizable calendar for deadline selection
- **Dart Date**: Simplifies date comparisons and calculations

---

## 💡 Usage

### Creating a New Task

1. Tap the **blue floating action button** (+) at the bottom right
2. Fill in the task details:
   - **Title** - Task name
   - **Description** - Task details
   - **Deadline** - Select from calendar
3. Tap **Add** to save the task
4. Task automatically categorizes based on deadline

### Viewing Tasks

**All Tasks Tab:**
- Shows all tasks organized by category
- Each category displays its tasks
- Empty categories are not shown

**Category Tabs (Today, Tomorrow, This Week, Next Week):**
- Shows only tasks for that specific time period
- Checkbox to mark tasks as complete
- Task deadline displayed below title

### Marking Tasks Complete

1. Navigate to the task's category
2. Tap the **checkbox** next to the task
3. Task status updates immediately

---

## 📄 File Descriptions

### `main.dart`
**Entry point of the application**
- Sets up MultiProvider with TaskModel
- Configures routes:
  - Home: `ListTasksView`
  - `listTasks` route: Tasks list
  - `addTasks` route: Add task form
- Uses Material Design theme

### `model/Task.dart`
**Task data model**
```dart
class Task {
  String title;           // Task name
  bool status;            // Completion status
  String description;     // Task details
  DateTime deadline;      // Due date/time
}
```

### `provider/TaskModel.dart`
**State management & business logic**
- `_todotasks` - Map storing tasks by category
- `todotasks` (getter) - Provides access to tasks
- `add(Task)` - Adds new task and auto-categorizes
- `markDone(index, key)` - Marks task as complete
- `guessTodoKeyFromDate(deadline)` - Categorizes task by deadline
- `countTaskByDate(datetime)` - Counts tasks for a date

### `library/globals.dart`
**Global constants and configuration**
- Category keys: `late`, `today`, `tomorrow`, `thisWeek`, `nextWeek`, `thisMonth`, `later`
- `TaskCategoryNames` - Maps category keys to display names
- Color definitions for Material Design

### `view/ListTasksView.dart`
**Main tasks list view**
- **TabBar with 5 tabs**: All, Today, Tomorrow, This Week, Next Week
- **TabBarView** - Content area for each tab
- **Floating Action Button** - Navigate to add task screen
- Uses `ListTaskAllwidget` for "All" tab
- Uses `ListTaskwidget` for category tabs

### `view/AddTasksView.dart`
**Add new task form**
- **Calendar Picker** - Select task deadline
- **Form Fields**:
  - Title (required)
  - Description (not-required)
- **Validation** - Ensures fields are filled for title only
- **Submit Button** - Creates task and returns to list

### `widget/ListTask.dart`
**Single category task list widget**
- **Consumer** pattern - Listens to TaskModel changes
- Displays tasks for a specific category
- **CheckboxListTile** - Shows task with checkbox
- Shows task title and deadline
- Handles task completion

### `widget/ListTaskAll.dart`
**All tasks combined widget**
- **Nested ListView** - Categories with tasks inside
- Shows category header (Late, Today, Tomorrow, etc.)
- Lists all tasks in each category
- Empty categories are hidden with `isNotEmpty` check
- Supports task completion

---

## 🔄 State Management

### Provider Pattern Implementation

```dart
// In main.dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (context) => Taskmodel()
    )
  ],
  child: MyApp()
)
```

### Consuming State in Widgets

```dart
Consumer<Taskmodel>(
  builder: (context, model, child) {
    // Access model.todotasks
    // UI rebuilds when model notifies listeners
  }
)
```

### Updating State

```dart
// When task is added or marked complete
model.notifyListeners(); // Triggers rebuilds
```

---

## 🎯 How It Works

### Task Flow

1. **User creates task** → AddTasksView
2. **Task submitted** → TaskModel.add()
3. **Auto-categorization** → guessTodoKeyFromDate()
4. **Task stored** → _todotasks map
5. **Listeners notified** → notifyListeners()
6. **UI updates** → Consumers rebuild

### Category Logic

The app automatically categorizes tasks based on their deadline:

```
if deadline is past  → "Late"
else if today        → "Today"
else if tomorrow     → "Tomorrow"
else if this week    → "This Week"
else if next week    → "Next Week"
else if this month   → "This Month"
else                 → "Later"
```

Uses `dart_date` package for date comparisons:
- `deadline.isPast`
- `deadline.isToday`
- `deadline.isTomorrow`
- `deadline.getWeek`
- `deadline.isThisMonth`

### Task Completion

- Tapping checkbox triggers `model.markDone(index, category)`
- Status changes from false to true
- `notifyListeners()` triggers UI update
- Completed tasks show checked checkbox

---

## 👤 Author

Created as a learning project for Flutter week 4 task.

---

## 📝 Notes

- Tasks are auto-categorized based on deadline
- All tasks are stored in memory (not persisted)
- UI updates in real-time using Provider pattern
- Calendar uses week view in task creation form
- Empty task categories are not displayed in "All" view

---
