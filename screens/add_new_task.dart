import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tehaadi/constants/colors.dart';
import 'package:tehaadi/screens/drawer_screen.dart';
import 'package:tehaadi/models/task.dart' as models_task;
import 'package:tehaadi/services/CRUDServices/crud_exceptions.dart';
import 'package:tehaadi/services/authServices/auth_serviced.dart';
import 'package:tehaadi/utils/utils.dart';
import 'package:uuid/uuid.dart';

import '../services/CRUDServices/cloud_firestore.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  List<String> list = ['low', 'medium', 'high'];
  int priority = 0;
  @override
  Widget build(BuildContext context) {
    void selectioncallback(int? value) {
      setState(() {
        priority = value ?? 0;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryBackgroundColor,
        title: const Text("Add new task"),
        centerTitle: true,
        actions: [IconButton(onPressed: () async {}, icon: Icon(Icons.check))],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              label: Text(
                'Title',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          TextFormField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              label: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Description',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropDownMenuWidget(
                  list: list,
                  callback: selectioncallback,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * .5,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_titleController.text.isEmpty) {
                            showSnackBar(context, 'Title cannot be empty');
                            return;
                          }
                          models_task.Task task = models_task.Task(
                            dateAdded: DateTime.now().toIso8601String(),
                            title: _titleController.text,
                            description: _descriptionController.text,
                            isDone: false,
                            priority: priority,
                            taskId: const Uuid().v4(),
                          );
                          try {
                            await CloudFirestoreServices().addNewOrEditTask(
                                task: task,
                                userId:
                                    AuthServices.firebase().currentUser!.uid);
                            Navigator.of(context).pop();
                          } on UnableToCreateTaskException catch (err) {
                            showSnackBar(context, 'unable to create task');
                          }
                        },
                        child: const Text('Add'))),
              ],
            ),
          )
        ]),
      )),
    );
  }
}

class DropDownMenuWidget extends StatefulWidget {
  final List<String> list;
  final void Function(int?) callback;
  const DropDownMenuWidget(
      {super.key, required this.list, required this.callback});

  @override
  State<DropDownMenuWidget> createState() => _DropDownMenuWidgetState();
}

class _DropDownMenuWidgetState extends State<DropDownMenuWidget> {
  int? dropDownvalue = 0;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: dropDownvalue,
        items: widget.list.map<DropdownMenuItem<int>>((value) {
          return DropdownMenuItem<int>(
            child: Text(
              value,
              style: priorityTextStyle(widget.list.indexOf(value)),
            ),
            value: widget.list.indexOf(value),
          );
        }).toList(),
        onChanged: (int? value) {
          setState(() {
            widget.callback(value);
            dropDownvalue = value;
          });
        });
  }

  TextStyle priorityTextStyle(int index) {
    Color color = Colors.black;
    if (index == 1) {
      color = Colors.green;
    } else if (index == 2) {
      color = Colors.red;
    }
    return TextStyle(color: color);
  }
}
