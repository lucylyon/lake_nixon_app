import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Objects/Group.dart';
import 'package:final_project/Pages/GroupPage.dart';
import 'package:final_project/Pages/CalendarPage.dart';
import 'package:final_project/Pages/LoginPage.dart';
import 'package:final_project/Pages/MasterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../Objects/AppState.dart';

import '../Objects/Globals.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    // FIX
    for (Group g in oldGroups) {
      createGroup(g);
    }
    getSavedEvents();
    super.initState();
  }

  Future<void> groupPagePush() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GroupPage(title: "List of groups"),
      ),
    );
  }

  Future<void> masterCalendar(Group group) async {
    //print("Chat");
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MasterPage(),
      ),
    );
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> logoutScreenPush() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

// should probably delete this
  Future<void> getSavedEvents() async {
    CollectionReference schedules =
        FirebaseFirestore.instance.collection("schedules");
    final snapshot = await schedules.get();
    if (snapshot.size > 0) {
      List<QueryDocumentSnapshot<Object?>> data = snapshot.docs;
      data.forEach((element) {
        var event = element.data() as Map;
        Map apps = event["appointments"];

        apps.forEach((key, value) {
          for (var _app in value) {
            var app = _app["appointment"];
            var test = app[2];
            String valueString = test.split('(0x')[1].split(')')[0];
            int value = int.parse(valueString, radix: 16);
            Color color = new Color(value);
            Appointment tmp = Appointment(
                startTime: app[0].toDate(),
                endTime: app[1].toDate(),
                color: color,
                startTimeZone: app[3],
                endTimeZone: app[4],
                notes: app[5],
                isAllDay: app[6],
                subject: app[7],
                resourceIds: app[8],
                recurrenceRule: app[9]);
            //var group = indexGroups(key);
            //  events[group]!.add(tmp);
          }
        });
      });
    } else {
      print('No data available.2');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Action Page",
            style: TextStyle(
                //check here later --- can't insert nixonbrown for some reason?
                color: Color.fromRGBO(137, 116, 73, 1),
                fontFamily: 'Fruit'),
          ),
          backgroundColor: nixonblue,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Lake Nixon Admin',
                      style: TextStyle(
                          //nixonbrown
                          color: Color.fromRGBO(137, 116, 73, 1),
                          fontFamily: 'Fruit',
                          fontSize: 30),
                    )),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 80,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(nixongreen)),
                        child: const Text("Groups",
                            style:
                                TextStyle(fontSize: 40, fontFamily: 'Fruit')),
                        onPressed: () {
                          groupPagePush();
                        },
                      ),
                    )),
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(nixongreen)),
                    child: const Text("Master Calendar",
                        style: TextStyle(fontSize: 40, fontFamily: 'Fruit')),
                    onPressed: () {
                      masterCalendar(const Group(
                          name: "Admin", color: Color(0xFFFFFFFF), age: 99999));
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(nixonbrown)),
                    child: const Text(
                      "Logout",
                      style: TextStyle(fontFamily: 'Fruit', fontSize: 30),
                    ),
                    onPressed: () {
                      logout();
                      logoutScreenPush();
                    },
                  ),
                ),
              ],
            )));
  }
}
