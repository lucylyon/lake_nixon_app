import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Objects/AppState.dart';
import '../Objects/Globals.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Objects/Event.dart';
import 'package:final_project/Objects/Group.dart';
import 'package:final_project/Objects/LakeNixonEvent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../Appointment Editor/AppointmentEditor.dart';

class TestPage extends StatefulWidget {
  TestPage({super.key, required this.title});

  final String title;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("List of Groups",
                style: TextStyle(
                    //check here later --- can't insert nixonbrown for some reason?
                    color: Color.fromRGBO(137, 116, 73, 1),
                    fontFamily: 'Fruit')),
            backgroundColor: nixonblue,
          ),
          body: Container(
            child: Text('please work'),
          )
          // body: Container(
          //     padding: const EdgeInsets.fromLTRB(10, 20, 40, 0),
          //     child: ListView.builder(
          //       shrinkWrap: true,
          //       itemCount: appState.groups.length,
          //       itemBuilder: (context, index) {
          //         return Card(
          //             child: ListTile(
          //           title: Text(appState.groups[index].name.toString()),
          //         ));
          //       },
          //     ))
          );
    });
  }
}
