import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Objects/Event.dart';
import 'package:final_project/Objects/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../firebase_options.dart';
import 'Group.dart';

// Color nixonblue = const Color.fromRGBO(165, 223, 249, 1);
// Color nixonyellow = const Color.fromRGBO(255, 248, 153, 1);
// Color nixonbrown = const Color.fromRGBO(137, 116, 73, 1);
// Color nixongreen = const Color.fromRGBO(81, 146, 78, 1);

class AppState extends ChangeNotifier {
  Color nixonblue = const Color.fromRGBO(165, 223, 249, 1);
  Color nixonyellow = const Color.fromRGBO(255, 248, 153, 1);
  Color nixonbrown = const Color.fromRGBO(137, 116, 73, 1);
  Color nixongreen = const Color.fromRGBO(81, 146, 78, 1);

  List<Event> _events = [];
  List<Event> get events8 => _events;

  // List<Event> events2 = [event1, event2, event3, event4, event5];

  AppState() {
    init();
  }

  bool firstSnapshot = true;
  StreamSubscription<QuerySnapshot>? eventSubscription;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    // FirebaseUIAuth.configureProviders([
    //   EmailAuthProvider(),
    // ]);

    FirebaseAuth.instance.userChanges().listen(
      (user) {
        eventSubscription?.cancel(); //WHY?
        print("starting to listen");
        eventSubscription = FirebaseFirestore.instance
            .collection('eventsListed') //GV had .doc(user.uid); document ref
            .snapshots()
            .listen((snapshot) {
          print("in snapshot");
          // _events = [];
          // snapshot.docs.forEach((document) {
          //   _events.add(Event(
          //     title: document.data()['title'],
          //     desc: document.data()['desc'],
          //     time: document.data()['time'],
          //     date: document.data()['date'],
          //   ));
        });
        // print(snapshot.docChanges.toString()); //prints changes
        firstSnapshot = false;
        notifyListeners();
      },
      onError: (error) {
        print(error);
      },
    );

    notifyListeners();
  }

// from globals
  int indexEvents(String name) {
    int count = 0;
    for (Event element in _events) {
      if (element.name == name) {
        return count;
      }
      count++;
    }
    return -1;
  }

  // from userCalendar / calendar
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
            print(app[6]);
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
            var group = indexGroups(key);
            events[group]!.add(tmp);
          }
        });
      });
    } else {
      print('No data available.');
    }
  }

// from userCalendar
  List<DropdownMenuItem<String>> firebaseEvents = []; // goal delete this
  Future<void> getEvents() async {
    CollectionReference events =
        FirebaseFirestore.instance.collection("events");
    final snapshot = await events.get();
    if (snapshot.size > 0) {
      List<QueryDocumentSnapshot<Object?>> data = snapshot.docs;
      data.forEach((element) {
        var event = element.data() as Map;
        var tmp = Event(
            name: event["name"],
            ageMin: event["ageMin"],
            groupMax: event["groupMax"]);
        events.add(tmp);

        firebaseEvents.add(
            DropdownMenuItem(value: event["name"], child: Text(event["name"])));
      });
    } else {
      print('No data available.');
    }
    print(events);
  }

  Group? indexGroups(String name) {
    int count = 0;
    int index = -1;
    Group? group;
    events.forEach((key, value) {
      if (key.name == name) {
        index = count;
        group = key;
      }
      count++;
    });
    return group;
  }
}
