import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:week4_task/library/globals.dart' as globals;
import 'package:week4_task/model/Task.dart';
import 'package:week4_task/provider/TaskModel.dart';

class AddTasksView extends StatefulWidget {
  const AddTasksView({Key? key}) : super(key: key);

  @override
  State<AddTasksView> createState() => _AddTasksViewState();
}

class _AddTasksViewState extends State<AddTasksView> {
  DateTime _selectedDay = DateTime.now();

  DateTime _focusedDay = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Taskmodel>(
      // hna rana ncosumiw f data li f provider
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text('add task')),
          body: SingleChildScrollView(
            child: Form(
              // Build a Form widget using the _formKey created above.
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: <Widget>[
                    // Add TextFormFields and ElevatedButton here.
                    TableCalendar(
                      calendarFormat: CalendarFormat.week,
                      firstDay: DateTime.utc(2025, 1, 1),
                      lastDay: DateTime.utc(2050, 12, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay =
                              focusedDay; // update `_focusedDay` here as well
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, datetime, events) {
							// a condition where a specefic day = 0 dont show 0 in calendar
                          return model.countTaskByDate(datetime) > 0
                              ? Container(
                                  width: 20,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.primaries[model.countTaskByDate(
                                          datetime,
                                        )],
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      model
                                          .countTaskByDate(datetime)
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        // hada champ ta3 title
                        // The validator receives the text that the user has entered.
                        controller: _titleController,
                        maxLength: 100,
                        decoration: InputDecoration(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        // hada ta3 description
                        // The validator receives the text that the user has entered.
                        /*
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                            man7tajoch description tkon required field machi lazm 
                          },*/
                        controller: _descriptionController,
                        maxLength: 100,
                        minLines: 2,
                        maxLines: 5,
                        decoration: InputDecoration(
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
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.redAccent,
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
            child: Icon(Icons.done),
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                Task _newTask = Task(
                  _titleController.text,
                  false,
                  _descriptionController.text,
                  _focusedDay,
                );
                model.add(_newTask);
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
                Navigator.pushReplacementNamed(context, 'listTasks');
              }
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // when our widget is removed and will never build again
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
