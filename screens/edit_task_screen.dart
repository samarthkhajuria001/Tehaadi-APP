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

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late int count;
  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
    count = 0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  List<String> list = ['low', 'medium', 'high'];
  int priority = 0;
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    Map<String, dynamic> taskData = arg['task'];
    _titleController.text = taskData['title'];
    _descriptionController.text = taskData['description'];

    if (count == 0) {
      setState(() {
        count = count + 1;
        priority = taskData['priority'];
        isDone = taskData['isDone'];
      });
    }

    void selectioncallback(int? value) {
      setState(() {
        priority = value ?? 0;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryBackgroundColor,
        title: const Text("Edit task"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                if (_titleController.text.isEmpty) {
                  showSnackBar(context, 'Title cannot be empty');
                  return;
                }
                models_task.Task task = models_task.Task(
                  dateAdded: DateTime.now().toIso8601String(),
                  title: _titleController.text,
                  description: _descriptionController.text,
                  isDone: isDone,
                  priority: priority,
                  taskId: taskData['taskId'],
                );
                try {
                  await CloudFirestoreServices().addNewOrEditTask(
                      task: task,
                      userId: AuthServices.firebase().currentUser!.uid);
                  Navigator.of(context).pop();
                } on UnableToCreateTaskException catch (err) {
                  showSnackBar(context, 'unable to create task');
                }
              },
              icon: Icon(Icons.check))
        ],
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
            decoration: const InputDecoration(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropDownMenuWidget(
                list: list,
                callback: selectioncallback,
                initialPriority: priority,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .5,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          isDone ? secondaryBackgroundColor : Colors.red)),
                  onPressed: () async {
                    print('buttonclicked');

                    setState(() {
                      isDone = !isDone;
                    });
                  },
                  child: Text(isDone ? 'Done' : 'Pending'),
                ),
              ),
            ],
          )
        ]),
      )),
    );
  }
}

class DropDownMenuWidget extends StatefulWidget {
  final List<String> list;
  final void Function(int?) callback;
  final int initialPriority;
  const DropDownMenuWidget(
      {super.key,
      required this.list,
      required this.callback,
      required this.initialPriority});

  @override
  State<DropDownMenuWidget> createState() =>
      _DropDownMenuWidgetState(initialPriority);
}

class _DropDownMenuWidgetState extends State<DropDownMenuWidget> {
  final int initDropDownvalue;
  int? dropDownvalue;
  _DropDownMenuWidgetState(this.initDropDownvalue) {
    dropDownvalue = initDropDownvalue;
  }

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
    Color color = Colors.green;
    if (index == 1) {
      color = Colors.orange;
    } else if (index == 2) {
      color = Colors.red;
    }
    return TextStyle(color: color, fontWeight: FontWeight.w600);
  }
}
