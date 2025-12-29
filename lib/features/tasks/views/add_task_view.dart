import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';
import 'package:week4_task/shared/models/task.dart';
import 'package:week4_task/features/tasks/controllers/task_controller.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key}) : super(key: key);
  @override
  _AddTaskViewState createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  // observables variabls
  final TaskController taskController = Get.find();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  final _titleController =
      TextEditingController(); // hada y7taj a memory space , 3la biha drna dispose to clear up the memory leaks
  final _descriptionController = TextEditingController();
  final _uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                // Calendar with Obx to react to changes
                GetBuilder<TaskController>(
                  builder: (controller) => TableCalendar(
                    calendarFormat: CalendarFormat.week,
                    firstDay: DateTime.utc(2025, 1, 1),
                    lastDay: DateTime.utc(2050, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, datetime, events) {
                        final count = taskController.countTasksByDate(datetime);
                        return count > 0
                            ? Container(
                                width: 20,
                                height: 15,
                                decoration: BoxDecoration(
                                  color:
                                      Colors.primaries[count %
                                          Colors.primaries.length],
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Center(
                                  child: Text(
                                    count.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Container();
                      },
                    ),
                  ),
                ),

                // Title field
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    controller: _titleController,
                    maxLength: 100,
                    decoration: const InputDecoration(
                      hintText: "Enter task title",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),

                // Description field
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLength: 100,
                    minLines: 2,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Enter task description",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final newTask = Task(
              id: _uuid.v4(),
              title: _titleController.text,
              status: false,
              description: _descriptionController.text,
              deadline: _selectedDay,
            );

            await taskController.addTask(newTask);
            Get.back(); // ← GetX navigation (replaces Navigator.pop)
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
