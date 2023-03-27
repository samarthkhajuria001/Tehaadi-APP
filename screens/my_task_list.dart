import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tehaadi/services/CRUDServices/cloud_firestore.dart';

import '../utils/taskCard.dart';

class MyTaskListScreen extends StatefulWidget {
  const MyTaskListScreen({super.key});

  @override
  State<MyTaskListScreen> createState() => _MyTaskListScreenState();
}

class _MyTaskListScreenState extends State<MyTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: CloudFirestoreServices().allTasksStream,
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        task: snapshot.data!.docs[index].data(),
                        index: index,
                      );
                    });
              } else {
                return const Center(child: Text('some error occured'));
              }

            default:
              print('default state');
              return Center(child: Text('nothing to show'));
          }
        });
  }
}
