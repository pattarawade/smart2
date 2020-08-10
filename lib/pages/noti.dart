// import 'dart:ffi';

// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class Notica extends StatefulWidget {
//   Notica({Key key}) : super(key: key);

//   @override
//   _NoticaState createState() => _NoticaState();
// }

// class _NoticaState extends State<Notica> {
//   final databaseReference = FirebaseDatabase.instance.reference();
//   double water;

//   @override
//   void initState() {
//     databaseReference
//         .reference()
//         .child('data')
//         .once()
//         .then((DataSnapshot snapshot) {
//       double water = snapshot.value['waterlevel'] + 0.0;

//       Noti
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: child,
//     );
//   }
// }
