import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:ffi';

class Showdata extends StatefulWidget {
  @override
  _ShowdataState createState() => _ShowdataState();
}

class _ShowdataState extends State<Showdata> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child('readdata');
    await databaseReference.once().then((DataSnapshot snap) {
    //   setState(() {
    //    Soil = snap.value['Soil'];
    //    hum = snap.value['hum'];
    //    lux = snap.value['lux'];
    //    temp = snap.value['temp'];
    //    water = snap.value['water'];
    //  });
      print('data = ${snap.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Text ('ked'),
      
    );
  }
}
