import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week4_task/provider/TaskModel.dart';
import 'package:week4_task/widget/ListTask.dart';

class ListTasksView extends StatefulWidget {
  const ListTasksView({Key? key}) : super(key: key);

  @override
  _ListTasksViewState createState() => _ListTasksViewState();
}

class _ListTasksViewState extends State<ListTasksView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('List tasks'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "All"),
              Tab(text: "Today"),
              Tab(text: "Tomorrow"),
              Tab(text: "This week"),
              Tab(text: "Next week"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListTaskwidget(),
            ListTaskwidget(),
            ListTaskwidget(),
            ListTaskwidget(),
            ListTaskwidget(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          onPressed: () {
            Navigator.pushNamed(context, 'addTasks');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
