import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'Group.dart';

Color nixonblue = const Color.fromRGBO(165, 223, 249, 1);
Color nixonyellow = const Color.fromRGBO(255, 248, 153, 1);
Color nixonbrown = const Color.fromRGBO(137, 116, 73, 1);
Color nixongreen = const Color.fromRGBO(81, 146, 78, 1);

FirebaseFirestore db = FirebaseFirestore.instance;

// Map<Group, List<Appointment>> events = {};

var assignments = {};

List<Group> oldGroups = <Group>[
  const Group(name: "Chipmunks", color: Color.fromRGBO(15, 134, 68, 1), age: 1),
  const Group(
      name: "Hummingbirds", color: Color.fromRGBO(139, 31, 169, 1), age: 1),
  const Group(name: "Tadpoles", color: Color.fromRGBO(210, 1, 0, 1), age: 1),
  const Group(name: "Sparrows", color: Color.fromRGBO(93, 173, 226, 1), age: 1),
  const Group(
      name: "Salamanders", color: Color.fromRGBO(220, 118, 51, 1), age: 1),
  const Group(name: "Robins", color: Color.fromRGBO(222, 182, 241, 1), age: 1),
  const Group(name: "Minks", color: Color.fromRGBO(144, 148, 151, 1), age: 3),
  const Group(name: "Otters", color: Color.fromRGBO(17, 120, 100, 1), age: 3),
  const Group(name: "Raccoons", color: Color.fromRGBO(46, 64, 83, 1), age: 3),
  const Group(
      name: "Kingfishers", color: Color.fromRGBO(244, 208, 63, 1), age: 3),
  const Group(
      name: "Squirrels", color: Color.fromRGBO(234, 69, 225, 1), age: 3),
  const Group(
      name: "Blue Jays", color: Color.fromRGBO(36, 113, 163, 1), age: 3),
  const Group(name: "Deer", color: Color.fromRGBO(80, 64, 64, 1), age: 5),
  const Group(name: "Crows", color: Color.fromRGBO(28, 40, 51, 1), age: 5),
  const Group(name: "Bears", color: Color.fromRGBO(96, 234, 122, 1), age: 5),
  const Group(name: "Foxes", color: Color.fromRGBO(211, 84, 0, 1), age: 5),
  const Group(name: "Herons", color: Color.fromRGBO(69, 108, 234, 1), age: 5),
  const Group(name: "Wolves", color: Color.fromRGBO(86, 101, 115, 1), age: 5),
  const Group(
      name: "Copperheads", color: Color.fromRGBO(214, 137, 16, 1), age: 6),
  const Group(
      name: "Timber Rattlers", color: Color.fromRGBO(171, 235, 198, 1), age: 8),
  const Group(name: "Admin", color: Color.fromARGB(255, 0, 0, 0), age: 9999)
];

// will probably be changed/deleted. used for getSavedEvents
// Group? indexGroups(String name) {
//   int count = 0;
//   int index = -1;
//   Group? group;
//   events.forEach((key, value) {
//     if (key.name == name) {
//       index = count;
//       group = key;
//     }
//     count++;
//   });
//   return group;
//}

//will probably  need to be changed;
// void createGroup(Group group) {
//   if (events.containsKey(group)) {
//   } else {
//     events[group] = <Appointment>[];
//     assignments[group] = <Group>[];
//   }
// }
