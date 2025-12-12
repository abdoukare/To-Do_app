import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week4_task/provider/TaskModel.dart';
import 'package:week4_task/library/globals.dart' as globals;

class ListTaskwidget extends StatelessWidget {
  const ListTaskwidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Taskmodel>(
      // hna rana ncosumiw f data li f provider
      builder: (context, model, child) {
        return ListView.builder(
          itemCount: model.todotasks[globals.today]!.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 89, 178, 219),
                  border: Border.all(color: Color.fromARGB(255, 89, 178, 219)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CheckboxListTile(
                  title: Text(model.todotasks[globals.today]![index].title),
                  subtitle: Text(
                    model.todotasks[globals.today]![index].deadline.toString(),
                  ),
                  value: model
                      .todotasks[globals.today]![index]
                      .status, // strate ta3 check box
                  onChanged: (bool? value) {
                    // ki ndiro check l checkbox lazm nditectiw changes li sraw
                    model.markDone(index, globals.today);
                    print(model.todotasks[globals.today]![index].status);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
