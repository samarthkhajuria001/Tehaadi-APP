import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tehaadi/constants/colors.dart';
import 'package:tehaadi/main.dart';
import 'package:tehaadi/services/CRUDServices/cloud_firestore.dart';
import 'package:tehaadi/services/authServices/auth_serviced.dart';

class TaskCard extends StatefulWidget {
  final Map<String, dynamic> task;
  final int index;
  const TaskCard({super.key, required this.task, required this.index});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  int a = 0;
  int timer = 0;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    bool isEven = widget.index % 2 == 0;
    Color color = Colors.orange;
    final int priority = widget.task['priority'];
    if (priority == 0) {
      color = Colors.green;
    } else if (priority == 2) {
      color = Colors.red;
    }
    if (timer == 0) {
      setState(() {
        isChecked = widget.task['isDone'];
      });
    }

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) async {
        await CloudFirestoreServices().deleteTask(
            taskId: widget.task['taskId'],
            userId: AuthServices.firebase().currentUser!.uid);
      },
      background: Container(
        color: Colors.red,
        alignment: AlignmentDirectional.centerStart,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Icon(Icons.delete),
      ),
      child: Container(
        height: 80,
        width: double.infinity,
        color: isEven ? Colors.white : oddTileColor,
        child: ListTile(
          title: Text(
            widget.task['title'],
            maxLines: 1,
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            widget.task['description'],
            maxLines: 1,
          ),
          trailing: Icon(
            Icons.flag,
            color: color,
          ),
          leading: Checkbox(
            checkColor: Colors.white,
            value: isChecked,
            fillColor: MaterialStateProperty.resolveWith(
                (states) => secondaryBackgroundColor),
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
                CloudFirestoreServices().doneToggle(
                    taskId: widget.task['taskId'],
                    userId: AuthServices.firebase().currentUser!.uid,
                    value: isChecked);
              });
            },
          ),
          onTap: () {
            Navigator.of(context).pushNamed(editTaskScreen, arguments: {
              'task': widget.task,
            });
          },
        ),
      ),
    );
  }
}
